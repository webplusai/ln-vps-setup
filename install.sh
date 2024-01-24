# Download VNC password
wget -O ~/.vnc/passwd https://raw.githubusercontent.com/webplusai/ln-vps-setup/main/passwd

# Download VNC config
wget -O ~/.vnc/xstartup https://raw.githubusercontent.com/webplusai/ln-vps-setup/main/xstartup

# Compress RAM
#! /bin/bash
sudo tee /usr/local/bin/rampak.sh << EOF > /dev/null
#! /bin/bash
modprobe zram
sleep 1
zramctl --find --size=768M
mkswap /dev/zram0
swapon /dev/zram0
EOF
sudo chmod +x /usr/local/bin/rampak.sh
sudo tee /etc/systemd/system/rampak.service << EOF > /dev/null
[Unit]
Description=RAM Compression
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/rampak.sh
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable rampak.service

# Increase Swap
sudo swapoff -a
sudo dd if=/dev/zero of=/swapfile bs=64M count=64
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile swap swap sw 0 0" >> /etc/fstab

# Install VNC
sudo apt update
sudo apt install -y xserver-xorg-core
sudo apt install -y tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer
sudo apt install -y ubuntu-gnome-desktop
sudo systemctl start gdm
sudo systemctl enable gdm

