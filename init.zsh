# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::anthropic::deps()
#
#>
######################################################################
p6df::modules::anthropic::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::anthropic::mcp::server::add(name, command, ...)
#
#  Args:
#	name -
#	command -
#	... - 
#
#  Environment:	 ARGS HOME
#>
######################################################################
p6df::modules::anthropic::mcp::server::add() {
  local name="$1"
  local command="$2"
  shift 2

  local settings="$HOME/.claude/settings.json"

  p6_dir_mk "$HOME/.claude"

  local config='{}'
  if p6_file_exists "$settings"; then
    config=$(p6_json_from_file "$settings")
  fi

  local new_config
  new_config=$(p6_echo "$config" | p6_json_eval \
    --arg name "$name" \
    --arg cmd "$command" \
    '.mcpServers[$name] = {"command": $cmd, "args": $ARGS.positional}' \
    --args "$@")

  p6_file_write "$settings" "$new_config"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::anthropic::env::init()
#
#>
######################################################################
p6df::modules::anthropic::env::init() {
  local _module="$1"
  local _dir="$2"

  # p6_env_export "ANTHROPIC_API_KEY"                     "${ANTHROPIC_API_KEY:-}"                     # API key sent as X-Api-Key header
  # p6_env_export "ANTHROPIC_AUTH_TOKEN"                  "${ANTHROPIC_AUTH_TOKEN:-}"                  # Custom Authorization: Bearer value
  # p6_env_export "ANTHROPIC_BASE_URL"                    "${ANTHROPIC_BASE_URL:-}"                    # Override Anthropic API base URL
  # p6_env_export "ANTHROPIC_MODEL"                       "${ANTHROPIC_MODEL:-}"                       # Override default model

  # Optional (not changed)
  # p6_env_export "ANTHROPIC_CUSTOM_HEADERS"              "${ANTHROPIC_CUSTOM_HEADERS:-}"              # Custom headers (Name: Value, newline-separated)
  # p6_env_export "ANTHROPIC_FOUNDRY_API_KEY"             "${ANTHROPIC_FOUNDRY_API_KEY:-}"             # Microsoft Foundry auth key
  # p6_env_export "ANTHROPIC_FOUNDRY_BASE_URL"            "${ANTHROPIC_FOUNDRY_BASE_URL:-}"            # Microsoft Foundry base URL
  # p6_env_export "CLAUDE_CODE_CLIENT_CERT"               "${CLAUDE_CODE_CLIENT_CERT:-}"               # Path to client cert for mTLS
  # p6_env_export "CLAUDE_CODE_CLIENT_KEY"                "${CLAUDE_CODE_CLIENT_KEY:-}"                # Path to client private key for mTLS
  # p6_env_export "CLAUDE_CODE_CLIENT_KEY_PASSPHRASE"     "${CLAUDE_CODE_CLIENT_KEY_PASSPHRASE:-}"     # Passphrase for encrypted client key
  # p6_env_export "ANTHROPIC_BEDROCK_BASE_URL"            "${ANTHROPIC_BEDROCK_BASE_URL:-}"            # Bedrock proxy URL
  # p6_env_export "ANTHROPIC_UNIX_SOCKET"                 "${ANTHROPIC_UNIX_SOCKET:-}"                 # Unix socket path for API connections
  # p6_env_export "API_TIMEOUT_MS"                        "${API_TIMEOUT_MS:-}"                        # Request timeout in milliseconds
  # p6_env_export "CLAUDE_CODE_USE_BEDROCK"               "${CLAUDE_CODE_USE_BEDROCK:-}"               # Enable Amazon Bedrock (1)
  # p6_env_export "CLAUDE_CODE_USE_VERTEX"                "${CLAUDE_CODE_USE_VERTEX:-}"                # Enable Google Vertex AI (1)
  # p6_env_export "CLAUDE_CODE_SKIP_BEDROCK_AUTH"         "${CLAUDE_CODE_SKIP_BEDROCK_AUTH:-}"         # Skip AWS auth for Bedrock
  # p6_env_export "CLAUDE_CODE_SKIP_VERTEX_AUTH"          "${CLAUDE_CODE_SKIP_VERTEX_AUTH:-}"          # Skip Google auth for Vertex
  # p6_env_export "ANTHROPIC_DEFAULT_HAIKU_MODEL"         "${ANTHROPIC_DEFAULT_HAIKU_MODEL:-}"         # Model to use for haiku alias
  # p6_env_export "ANTHROPIC_DEFAULT_SONNET_MODEL"        "${ANTHROPIC_DEFAULT_SONNET_MODEL:-}"        # Model to use for sonnet alias
  # p6_env_export "ANTHROPIC_DEFAULT_OPUS_MODEL"          "${ANTHROPIC_DEFAULT_OPUS_MODEL:-}"          # Model to use for opus alias
  # p6_env_export "ANTHROPIC_CUSTOM_MODEL_OPTION"         "${ANTHROPIC_CUSTOM_MODEL_OPTION:-}"         # Custom model ID for the picker
  # p6_env_export "ANTHROPIC_CUSTOM_MODEL_OPTION_NAME"    "${ANTHROPIC_CUSTOM_MODEL_OPTION_NAME:-}"    # Display name for custom model
  # p6_env_export "ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION" "${ANTHROPIC_CUSTOM_MODEL_OPTION_DESCRIPTION:-}" # Description for custom model
  # p6_env_export "HTTP_PROXY"                            "${HTTP_PROXY:-}"                            # HTTP proxy server
  # p6_env_export "HTTPS_PROXY"                           "${HTTPS_PROXY:-}"                           # HTTPS proxy server
  # p6_env_export "CLAUDE_CODE_ENABLE_TELEMETRY"          "${CLAUDE_CODE_ENABLE_TELEMETRY:-}"          # Enable OpenTelemetry (1)
  # p6_env_export "OTEL_METRICS_EXPORTER"                 "${OTEL_METRICS_EXPORTER:-}"                 # OTEL metrics exporter (e.g. otlp)
  # p6_env_export "CLAUDE_CODE_ACCOUNT_TAGGED_ID"         "${CLAUDE_CODE_ACCOUNT_TAGGED_ID:-}"         # Tagged account ID for OTEL metrics
  # p6_env_export "CLAUDE_CODE_USER_EMAIL"                "${CLAUDE_CODE_USER_EMAIL:-}"                # User email for OTEL (requires CLAUDE_CODE_ACCOUNT_TAGGED_ID)
  # p6_env_export "CLAUDE_CODE_ORGANIZATION_UUID"         "${CLAUDE_CODE_ORGANIZATION_UUID:-}"         # Org UUID for OTEL (requires CLAUDE_CODE_ACCOUNT_TAGGED_ID)
  # p6_env_export "CLAUDE_CODE_API_KEY_HELPER_TTL_MS"     "${CLAUDE_CODE_API_KEY_HELPER_TTL_MS:-}"     # Refresh interval for apiKeyHelper credentials

  p6_return_void
}

######################################################################
#<
#
# Function: words anthropic $ANTHROPIC_API_KEY = p6df::modules::anthropic::profile::mod()
#
#  Returns:
#	words - anthropic $ANTHROPIC_API_KEY
#
#  Environment:	 ANTHROPIC_API_KEY
#>
######################################################################
p6df::modules::anthropic::profile::mod() {

  p6_return_words 'anthropic' '$ANTHROPIC_API_KEY'
}
