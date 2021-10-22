#!/usr/bin/env bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

echo "Running apt update"
apt update

echo "Installing vim, build-essential, curl"
apt install -y vim build-essential curl
mkdir installs && cd installs

echo "Installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install ./installs/google-chrome-stable_current_amd64.deb || echo "Could not install chrome"

echo "Installing kitty"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin || echo "Could not install kitty"
[ -d "/path/to/dir" ] && mkdir ~/.local/bin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
cd ../ && rm -rf ./installs

echo "Setting git aliases"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

echo "Linking .vimrc"
ln -s ~/dotfiles/.vimrc ~/.vimrc
