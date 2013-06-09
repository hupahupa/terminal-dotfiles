#!/bin/bash

set -e


link_file() {

    source="$1"
    destination="$2"

    dest_dir="$(dirname "$destination")"
    mkdir -p "$dest_dir"

    stamp=terminal-dotfiles
    now=$(date +'%Y-%m-%d_%H-%M-%S')

    [[ -h "$destination" ]] && rm "$destination"
    [[ -e "$destination" ]] && mv "$destination" "$destination.$stamp-$now"
    ln -sv "$source" "$destination"
}


bin_dir="$(cd "$(dirname "$0")" && pwd)"


dotfiles="
    _bashrc
    _config/powerline/config.json
    _config/powerline/themes/shell/default_leftonly.json
    _dir_colors
    _fonts
    _fonts.conf.d
    _gemrc
    _gitconfig
    _my.cnf
    _profile
    _psqlrc
    _screenrc
    _shrc
    _tmux.conf
    _vim
    _vimrc
    _zshrc
"

for source in $dotfiles
do
    destination="$HOME/${source/_/.}"
    link_file "$bin_dir/$source" "$destination"
done
