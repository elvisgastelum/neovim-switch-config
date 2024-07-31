_ns_help() {
	echo "Usage: ns [OPTIONS] [NEOVIM_ARGS]"
	echo "Opens Neovim with a config directory matching the pattern"
	echo ""
	echo "Options:"
	echo "  -h, --help              Display this help message"
	echo "  -v, --version           Display script version information"
	echo "  -s, --skip-selection    Skip selection of a config directory"
	echo ""
	echo "Config:"
	echo "NEOVIM_SWITCH_PATTERN - The pattern to search for configs (default *-nvim)"
	echo "NVIM_APPNAME - The name of the config to open (default $HOME/.config/nvim)"
	echo "NEOVIM_SWITCH_SKIP_SELECTION - Skip selection of a config directory (default false)"
	echo ""
	echo "Example:"
	echo "  ns -h"
	echo "  ns -v"
	echo "  ns --skip-selection"
	echo "  ns -s"
}

_ns_has_argument() {
	[[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

_ns_extract_argument() {
	echo "${2:-${1#*=}}"
}

# ns - Neovim Switch
#
# Opens Neovim with a config directory matching the pattern
ns() {
	local version="v0.1"

	local pattern="${NEOVIM_SWITCH_PATTERN:-*-nvim}"
	local base_dir="$HOME/.config"
	local default="${NVIM_APPNAME:-$HOME/.config/nvim}"
	local skip_selection="${NEOVIM_SWITCH_SKIP_SELECTION:-false}"
	local arguments=$@
	local arguments_to_pass=()

	while [ $# -gt 0 ]; do
		case $1 in
		-h | --help)
			# Display script help information
			_ns_help
			return
			;;
		-v | --version)
			# Display script version information
			echo $version
			return

			;;
		-s | --skip-selection)
			if ! _ns_has_argument $@; then
				skip_selection=true
			fi

			skip_selection=$(_ns_extract_argument $@)

			;;
		*)
			# Handle other options
			arguments_to_pass+=($1)
			;;
		esac
		shift # Remove the option from the arguments list
	done

	if [[ $skip_selection == false ]]; then

		local configs=$(fd --max-depth 1 --glob $pattern $base_dir)

		local number_of_configs=$(echo $configs | wc -l)

		if [[ $number_of_configs -eq 0 || -z $configs ]]; then
			echo "No configs found"
			echo "Please create a config directory matching $pattern in $base_dir"
			return
		fi

		if [[ $number_of_configs -eq 1 ]]; then
			NVIM_APPNAME=$(basename $configs) nvim ${arguments_to_pass[@]}
			return
		fi

		local config=$(echo $configs | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)

		# If I exit fzf without selecting a config, don't open Neovim
		[[ -z $config ]] && echo "No config selected" && return

		NVIM_APPNAME=$(basename $config) nvim ${arguments_to_pass[@]}
	else
		NVIM_APPNAME=$default nvim ${arguments_to_pass[@]}
	fi

}
