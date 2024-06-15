#!/bin/bash

# Declare helper functions
exist() {
	command -v "$1" >/dev/null 2>&1
}

log() {
	printf "\033[33;34m [%s] %s\n" "$(date)" "$1"
}

is_arm64() {
	local -r arch="$(uname -m)"
	test "${arch}" = "arm64" || test "${arch}" = "aarch64"
}

ask_sudo() {
  log "running this script would need 'sudo' permission."
  echo ""
  sudo -v
  # keep sudo permission fresh
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

ensure_command_line_tools() {
	if ! xcode-select -p >/dev/null 2>&1 || ! test -f "$(xcode-select -p)/usr/bin/git"; then
		echo "installing command line tools"
		xcode-select --install
	fi

	if is_arm64; then
		if ! arch -x86_64 /usr/bin/true 2>/dev/null; then
			echo "installing rosetta"
			/usr/sbin/softwareupdate --install-rosetta --agree-to-license
		fi
	fi
}

ensure_homebrew() {
	if ! exist brew; then
		echo "installing homebrew"
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	if is_arm64; then
		local homebrew_bin="/opt/homebrew/bin"
		if ! cat /etc/paths | grep -q "${homebrew_bin}"; then
			echo "setting up homebrew binary path for gui apps"
			echo -e "${homebrew_bin}\n$(cat /etc/paths)" | sudo tee /etc/paths >/dev/null
		fi
	fi
}

ask_sudo
ensure_command_line_tools
ensure_homebrew
