FROM golang:1.23-alpine AS builder

WORKDIR /app
RUN apk add git make && git clone https://github.com/bincooo/chatgpt-adapter.git .
RUN make install
RUN make build-linux

FROM ubuntu:latest

WORKDIR /app
COPY --from=builder /app/bin/linux/server ./server

RUN apt update \
  && apt-get install -y curl unzip wget gnupg2

# Download binary file
RUN curl -JLO https://raw.githubusercontent.com/bincooo/chatgpt-adapter/refs/heads/hel/bin.zip

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable

RUN unzip bin.zip \
  && chmod +x server \
  && chmod +x bin/linux/helper

# Add the script to dynamically generate the config.yaml file
COPY generate-config.sh /app/generate-config.sh
RUN chmod +x /app/generate-config.sh

# Define runtime environment variables
ENV BLACKBOX_TOKEN="" \
    YOU_COOKIE="" \
    BING_SCOPE_ID="" \
    BING_ID_TOKEN="" \
    BING_COOKIE=""

# Entry point to generate config.yaml and start the server
ENTRYPOINT ["sh", "-c", "/app/generate-config.sh && exec $0 \"$@\""]

# Start the server with default arguments
CMD ["./server --port 8080"]
