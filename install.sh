#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root. Re-run with 'sudo $0'"
    exit
fi

function add_sources {
    sudo add-apt-repository universe
}

function install_requirements {
    apt update
    apt install -y \
    openssl \
    libpcre3 \
    libpcre3-dev \
    libssl-dev \
    ffmpeg \
    nginx \
    libnginx-mod-stream \
    libnginx-mod-rtmp \
    stunnel4
    sudo systemctl enable nginx.service # make sure nginx is enabled
    sudo systemctl enable stunnel4.service # make sure stunnel4 is enabled
    systemctl enable systemd-networkd-wait-online.service # makes sure we have an IP before starting network dependant services
}

function copy_config {
    mkdir -p /usr/share/nginx/modules-available /etc/stunnel/conf.d
    cp -R etc /
    cp -R usr /
    ln -s /usr/share/nginx/modules-available/rtmp-restreamer.conf /etc/nginx/modules-enabled/50-rtmp-restreamer.conf
}

function restart_services {
    systemctl restart stunnel4; systemctl status stunnel4;
    systemctl restart nginx; systemctl status nginx;
}

echo "WARNING!: This script will do the following:"
echo "1. Add 'universe' source to apt"
echo "2. Install openssl, libpcre3, libpcre3-dev, libssl-dev, ffmpeg, nginx, libnginx-mod-stream, libnginx-mod-rtmp, and stunnerl4"
echo "3. Add configs for nginx rtmp restreaming"
echo "4. Replace configs for stunnel4"
echo "5. Restart nginx and stunnel4 services"
echo "##########################################"
read -p "Are you sure you would like to proceed? [yes/no]: " r

rl=$(echo $r | tr "[:upper:]" "[:lower:]")

if [ "$rl" != "yes" ]; then 
    echo "ABORTING!"
    exit
fi

add_sources
install_requirements
copy_config
restart_services
