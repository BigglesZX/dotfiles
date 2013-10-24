#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master

# TODO: symlink files to home dir, except .bashrc

# TODO: append source line for .bashrc to actual ~/.bashrc
