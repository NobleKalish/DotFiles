#!/usr/bin/env bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

apt update
apt install -y vim build-essential curl
mkdir installs && cd installs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./installs/google-chrome-stable_current_amd64.deb
cd ../ && rm -rf ./installs
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
ln -s ~/dotfiles/.vimrc ~/.vimrc
