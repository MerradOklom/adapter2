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
  model:
    - 'blackbox/GPT-4o'
    - 'blackbox/Gemini-PRO'
    - 'blackbox/Claude-Sonnet-3.5'
lmsys:
  token: |
    {
      "gemini-2.0-flash-exp": [106, 156]
    }
  model:
    - 'gemini-2.0-flash-exp'
you:
  custom: true
  task: false
  model:
    - 'you/gpt_4'
    - 'you/gpt_4o'
    - 'you/gpt_4o_mini'
    - 'you/gpt_4_turbo'
    - 'you/openai_o1'
    - 'you/openai_o1_mini'
    - 'you/claude_2'
    - 'you/claude_3_haiku'
    - 'you/claude_3_sonnet'
    - 'you/claude_3_5_sonnet'
    - 'you/claude_3_opus'
    - 'you/gemini_pro'
    - 'you/gemini_1_5_pro'
    - 'you/gemini_1_5_flash'
  cookies:
    - '${YOU_COOKIE}'
bing:
  proxied: false
  cookies:
    - scopeId: '${BING_SCOPE_ID}'
      idToken: '${BING_ID_TOKEN}'
      cookie: '${BING_COOKIE}'
EOF

echo "Config file generated successfully."
