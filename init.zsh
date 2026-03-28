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
# Function: p6df::modules::anthropic::mcp::server::add(name, command, [args...])
#
#  Args:
#	name - MCP server name
#	command - command to run the server
#	OPTIONAL args - command arguments
#
#  Environment:	 HOME
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
# Function: str str = p6df::modules::anthropic::prompt::mod()
#
#  Returns:
#	str - str
#
#  Environment:	 ANTHROPIC_API_KEY P6_DFZ_PROFILE_ANTHROPIC
#>
######################################################################
p6df::modules::anthropic::prompt::mod() {
  local str=""
  local profile="$P6_DFZ_PROFILE_ANTHROPIC"

  if p6_string_blank_NOT "$profile"; then
    str="anthropic:\t  ${profile}:"
    if p6_string_blank_NOT "$ANTHROPIC_API_KEY"; then
      str=$(p6_string_append "$str" "api" " ")
    fi
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6df::modules::anthropic::profile::on(profile, code)
#
#  Args:
#	profile -
#	code - shell code block (export ANTHROPIC_API_KEY=...)
#
#  Environment:	 ANTHROPIC_API_KEY P6_DFZ_PROFILE_ANTHROPIC
#>
######################################################################
p6df::modules::anthropic::profile::on() {
  local profile="$1"
  local code="$2"

  p6_run_code "$code"

  p6_env_export "P6_DFZ_PROFILE_ANTHROPIC" "$profile"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::anthropic::profile::off(code)
#
#  Args:
#	code - shell code block previously passed to profile::on
#
#  Environment:	 ANTHROPIC_API_KEY P6_DFZ_PROFILE_ANTHROPIC
#>
######################################################################
p6df::modules::anthropic::profile::off() {
  local code="$1"

  p6_env_unset_from_code "$code"
  p6_env_export_un P6_DFZ_PROFILE_ANTHROPIC

  p6_return_void
}
