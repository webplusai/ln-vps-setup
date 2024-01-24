sudo wget https://raw.githubusercontent.com/webplusai/ln-vps-setup/main/resolved.conf -P /etc/systemd
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo reboot --force
