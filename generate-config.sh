#!/bin/sh

# Check if required environment variables are set
if [ -z "$BLACKBOX_TOKEN" ]; then
  echo "ERROR: BLACKBOX_TOKEN environment variable is not set."
  exit 1
fi

if [ -z "$YOU_COOKIE" ]; then
  echo "ERROR: YOU_COOKIE environment variable is not set."
  exit 1
fi

if [ -z "$BING_SCOPE_ID" ]; then
  echo "ERROR: BING_SCOPE_ID environment variable is not set."
  exit 1
fi

if [ -z "$BING_ID_TOKEN" ]; then
  echo "ERROR: BING_ID_TOKEN environment variable is not set."
  exit 1
fi

if [ -z "$BING_COOKIE" ]; then
  echo "ERROR: BING_COOKIE environment variable is not set."
  exit 1
fi

# Generate the config.yaml file
cat <<EOF > /app/config.yaml
server:
  port: 8080
  debug: true
blackbox:
  token: '${BLACKBOX_TOKEN}'
you:
  custom: true
  task: false
  cookies:
    - '${YOU_COOKIE}'
bing:
  proxied: true
  cookies:
    - scopeId: '${BING_SCOPE_ID}'
      idToken: '${BING_ID_TOKEN}'
      cookie: '${BING_COOKIE}'
EOF

echo "Config file generated successfully."
