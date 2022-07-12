#!/bin/bash

echo "+ detecting Operating system"
os=$(uname -o)


#clone repo
tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
cd $tmp_dir
git clone git@github.com:vologue/vo-nvim.git

# install Plug (Plugin manager)
mkdir -p ~/.local/share/nvim/site/autoload/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# Linux requires pacman to be setup and mac needs brew
echo "+ installing nvim"
if [[ "$os"="GNU/Linux" ]]; then
    pacman -Sy neovim
    mkdir -p ~/.config/nvim
    mv vo-nvim/config/init.vim  ~/.config/nvim
elif [[ "$os"="Darwin" ]]; then
    brew install nvim
    mkdir -p ~/AppData/Local/nvim
    mv vo-nvim/config/init.vim ~/AppData/Local/nvim
else
    echo "${os} not suported."


rm -rf $tmp_dir

echo "run nvim +PlugInstall to install the plugins and compelete the setup."

