#!/bin/bash

sudo apt install software-properties-common -y

sudo add-apt-repository ppa:linrunner/tlp -y
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora -y
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo add-apt-repository ppa:unit193/encryption -y
sudo add-apt-repository ppa:remmina-ppa-team/remmina-next -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo add-apt-repository ppa:nilarimogard/webupd8 -y

#sudo bash -c 'echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list' && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

sudo bash -c 'echo "deb http://evgenykuznetsov.org/repo/ buster main" >> /etc/apt/sources.list' && wget -qO - https://raw.githubusercontent.com/nekr0z/matebook-applet/master/matebook-applet.key | sudo apt-key add -

sudo apt update
sudo apt upgrade -y

# lets install huawei-wmi drivers
# take a look for new verion https://github.com/aymanbagabas/Huawei-WMI/releases
wget -q https://github.com/aymanbagabas/Huawei-WMI/releases/download/v3.4/huawei-wmi-3.4-source-only.dkms.tar.gz && sudo dkms ldtarball --archive=huawei-wmi-3.4-source-only.dkms.tar.gz && sudo dkms autoinstall -m huawei-wmi/3.4 && sudo dkms install huawei-wmi/3.4

sudo apt install --install-recommended mc curl nano psensor woeusb openvpn veracrypt vlc qbittorrent remmina snapd tlp tlp-rdw thermald intel-microcode powertop bbswitch-dkms matebook-applet ansible -y
# sudo apt install balena-etcher-electron -y

sudo bash -c 'echo bbswitch >> /etc/modules'
sudo prime-select intel
sudo bash -c "echo 'options bbswitch load_state=0' >> /etc/modprobe.d/bbswitch.conf"

# start and config
sudo tlp start

# lets set pstate = True
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_pstate=enable"/g' /etc/default/grub

# lets install undervolting
# take a look for last version: https://github.com/lukechadwick/linux-intel-undervolt-gui/releases
curl -fsSL https://github.com/lukechadwick/linux-intel-undervolt-gui/releases/download/1.2.0/linux-intel-undervolt-gui_1.2.0_amd64.deb -o undervolt.deb && sudo apt install ./undervolt.deb -y

# lets install docker
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# some information
echo 'descrete graphics are turned off:' && lspci | grep VGA
echo 'check wifi drivers:' && dmesg | grep iwl

# lets clean up
rm undervolt.deb get-docker.sh huawei-wmi-3.4-source-only.dkms.tar.gz
sudo apt autoremove -y

sudo powertop --calibrate

