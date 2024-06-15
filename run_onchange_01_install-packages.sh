#!/bin/bash

# Declare helper functions
exist() {
	command -v "$1" >/dev/null 2>&1
}

log() {
	printf "\033[33;34m [%s] %s\n" "$(date)" "$1"
}

ask_sudo() {
  log "running this script would need 'sudo' permission."
  echo ""

  sudo -v

  # keep sudo permission fresh
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}


exist brew || {
	log "brew not found. Breaking out..."
	exit 1
}

# Install Oh My Zsh
# https://ohmyz.sh/#install
install_oh_my_zsh() {
	if ! [ -d ~/.oh-my-zsh ]; then
		log "Installing Oh My Zsh"
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

		# Install zsh-autosuggestions
		# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null

		# Install zsh-syntax-highlighting
		# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null

		# Install zsh-history-substring-search plugin
		# https://github.com/zsh-users/zsh-history-substring-search
		git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

		# Install p10k
		# https://github.com/romkatv/powerlevel10k#homebrew
		brew install powerlevel10k --quiet
	fi
}

install_brew_packages() {
	local brewfile=''
	brew_bundle() {
		echo "$brewfile" | brew bundle --no-lock --verbose --no-upgrade --file=-
	}

	brewfile='
	tap "codecrafters-io/tap"
	tap "homebrew/bundle"
	tap "homebrew/cask-fonts"
	tap "jesseduffield/lazygit"
	# General-purpose data compression with high compression ratio
	brew "xz"
	# Cryptography and SSL/TLS Toolkit
	brew "openssl@3"
	# Manage your dotfiles across multiple diverse machines, securely
	brew "chezmoi"
	# Get a file from an HTTP, HTTPS or FTP server
	brew "curl"
	# General-purpose scripting language
	brew "php"
	# Dependency Manager for PHP
	brew "composer"
	# Platform built on V8 to build network applications
	brew "node"
	# Package acting as bridge between Node projects and their package managers
	brew "corepack"
	# GNU File, Shell, and Text utilities
	brew "coreutils"
	# Simple, fast and user-friendly alternative to find
	brew "fd"
	# Command-line fuzzy finder written in Go
	brew "fzf"
	# GitHub command-line tool
	brew "gh"
	# Idempotent command-line utility for managing your /etc/hosts file
	brew "hostess"
	# Improved top (interactive process viewer)
	brew "htop"
	# Open source relational database management system
	brew "mysql"
	# Ambitious Vim-fork focused on extensibility and agility
	brew "neovim"
	# Python version management
	brew "pyenv"
	# Pyenv plugin to manage virtualenv
	brew "pyenv-virtualenv"
	# Search tool like grep and The Silver Searcher
	brew "ripgrep"
	# Simplified and community-driven man pages
	brew "tldr"
	# Terminal multiplexer
	brew "tmux"
	# Display directories as trees (with optional color/HTML output)
	brew "tree"
	# Internet file retriever
	brew "wget"
	# CodeCrafters CLI
	brew "codecrafters-io/tap/codecrafters"
	# A simple terminal UI for git commands, written in Go
	brew "jesseduffield/lazygit/lazygit"
	# Cross platform SQL editor and database management app
	cask "beekeeper-studio"
	cask "font-fira-mono-nerd-font"
	cask "font-jetbrains-mono"
	cask "font-jetbrains-mono-nerd-font"
	cask "font-symbols-only-nerd-font"
	# PDF reader
	cask "foxitreader"
	# Laravel and PHP development environment manager
	cask "herd"
	# Terminal emulator as alternative to Apple Terminal app
	cask "iterm2"
	# GPU-based terminal emulator
	cask "kitty"
	# App to write, plan, collaborate, and get organised
	cask "notion"
	# Knowledge base that works on top of a local folder of plain text Markdown files
	cask "obsidian"
	# Collaboration platform for API development
	cask "postman"
	# Break time reminder app
	cask "stretchly"
	# Open-source code editor
	cask "visual-studio-code"
	# Multimedia player
	cask "vlc"
	vscode "astro-build.astro-vscode"
	vscode "batisteo.vscode-django"
	vscode "bierner.markdown-mermaid"
	vscode "bmewburn.vscode-intelephense-client"
	vscode "bradlc.vscode-tailwindcss"
	vscode "dbaeumer.vscode-eslint"
	vscode "devsense.composer-php-vscode"
	vscode "devsense.intelli-php-vscode"
	vscode "devsense.phptools-vscode"
	vscode "devsense.profiler-php-vscode"
	vscode "donjayamanne.python-environment-manager"
	vscode "donjayamanne.python-extension-pack"
	vscode "eamodio.gitlens"
	vscode "esbenp.prettier-vscode"
	vscode "github.copilot"
	vscode "github.copilot-chat"
	vscode "github.vscode-github-actions"
	vscode "github.vscode-pull-request-github"
	vscode "golang.go"
	vscode "jdinhlife.gruvbox"
	vscode "johnpapa.vscode-peacock"
	vscode "kevinrose.vsc-python-indent"
	vscode "mhutchie.git-graph"
	vscode "ms-azuretools.vscode-docker"
	vscode "ms-python.black-formatter"
	vscode "ms-python.debugpy"
	vscode "ms-python.isort"
	vscode "ms-python.mypy-type-checker"
	vscode "ms-python.python"
	vscode "ms-toolsai.jupyter"
	vscode "ms-toolsai.jupyter-keymap"
	vscode "ms-toolsai.jupyter-renderers"
	vscode "ms-toolsai.vscode-jupyter-cell-tags"
	vscode "ms-toolsai.vscode-jupyter-slideshow"
	vscode "ms-vscode-remote.remote-containers"
	vscode "ms-vscode-remote.remote-ssh"
	vscode "ms-vscode-remote.remote-ssh-edit"
	vscode "ms-vscode-remote.remote-wsl"
	vscode "ms-vscode-remote.vscode-remote-extensionpack"
	vscode "ms-vscode.cmake-tools"
	vscode "ms-vscode.cpptools"
	vscode "ms-vscode.cpptools-extension-pack"
	vscode "ms-vscode.cpptools-themes"
	vscode "ms-vscode.makefile-tools"
	vscode "ms-vscode.remote-explorer"
	vscode "ms-vscode.remote-server"
	vscode "njpwerner.autodocstring"
	vscode "onecentlin.laravel-blade"
	vscode "rangav.vscode-thunder-client"
	vscode "stivo.tailwind-fold"
	vscode "timonwong.shellcheck"
	vscode "twxs.cmake"
	vscode "visualstudioexptteam.intellicode-api-usage-examples"
	vscode "visualstudioexptteam.vscodeintellicode"
	vscode "vscodevim.vim"
	vscode "wholroyd.jinja"
	vscode "zhuangtongfa.material-theme"
	'

	brew_bundle
}

log "Running install-packages.sh..."
ask_sudo
install_oh_my_zsh
install_brew_packages
log "Done. Please restart your shell."
