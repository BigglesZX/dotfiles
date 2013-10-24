#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master

# symlinks
ln -s .gitconfig ~/.gitconfig

# append source line to existing .bashrc unless already present
if [ -f ~/.bashrc && grep -Fxq "# dotfiles bashrc goodies" ~/.bashrc ]
then
    # found
    echo ".bashrc is already hooked up"
else
    # not found
    echo "hooking up .bashrc..."
    echo "# dotfiles bashrc goodies" >> ~/.bashrc
    echo "source $(dirname '${BASH_SOURCE}')/.bashrc" >> ~/.bashrc
fi
