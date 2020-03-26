#!/usr/bin/env bash

root=$(pwd)

declare -A destinations

destinations=(
    ["editor/init.vim"]="$HOME/.config/nvim/init.vim"
    ["editor/ideavimrc"]="$HOME/.ideavimrc"
    ["mux/tmux.conf"]="$HOME/.tmux.conf"
    ["mux/tmuxline.conf"]="$HOME/.tmuxline.conf"
    ["shell/zshrc"]="$HOME/.zshrc"
)

set -e

for key in ${!destinations[@]}; do
    echo $ZSH_CUSTOM
    master="$root/$key"
    symbolic="${destinations[${key}]}"
    echo 'Linking:' ${master} '->' ${symbolic}
    ln -s ${master} ${symbolic}
done
