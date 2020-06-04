#!/bin/bash

sudo apt update && sudo apt install libinput-tools xdotool ruby -y
sudo gem i fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
sudo gem update fusuma
mkdir -p ~/.config/fusuma
sudo gpasswd -a jr input
cp config.yml ~/.config/fusuma/config.yml
fusuma -d

