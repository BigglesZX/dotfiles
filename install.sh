#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master

# append source line to existing .bashrc unless already present
if [ -f ~/.bashrc ] && grep -Fxq "# dotfiles bashrc goodies" ~/.bashrc
then
    # found
    echo ".bashrc is already hooked up"
else
    # not found
    echo "hooking up .bashrc..."
    echo "" >> ~/.bashrc
    echo "# dotfiles bashrc goodies" >> ~/.bashrc
    echo "source `pwd`/.bashrc" >> ~/.bashrc
fi

# symlinks
cd ~
ln -s dotfiles/.gitconfig .gitconfig

# prompt for git user.name and user.email
read -p "Please enter your name for git config: " gitname
git config --global user.name "$gitname"
read -p "Please enter your email for git config: " gitemail
git config --global user.email $gitemail

echo "Dotfiles setup complete!"
