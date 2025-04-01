FROM ghcr.io/bincooo/chatgpt-adapter:latest

WORKDIR /app

# Add the script to dynamically generate the config.yaml file
COPY generate-config.sh /app/generate-config.sh
RUN chmod +x /app/generate-config.sh

# Entry point to generate config.yaml and start the server
ENTRYPOINT ["sh", "-c", "/app/generate-config.sh && exec $0 \"$@\""]

# Start the server with default arguments
CMD ["./server --port 8080"]
