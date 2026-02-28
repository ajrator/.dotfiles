#!/usr/bin/env bash

set -e

root=$(cd "$(dirname "$0")" && pwd)

link() {
    local src="$root/$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    echo "Linking: $src -> $dst"
    ln -sf "$src" "$dst"
}

link "editor/init.vim"   "$HOME/.config/nvim/init.vim"
link "mux/tmux.conf"     "$HOME/.tmux.conf"
link "mux/tmuxline.conf" "$HOME/.tmuxline.conf"
link "shell/zshrc"       "$HOME/.zshrc"
