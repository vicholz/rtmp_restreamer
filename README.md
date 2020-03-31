# NGINX RTMP Restreamer

The script and config files in this repo were created to make it easier to install and configure a RTMP restreamer or stream splitter. It allows one incoming stream to be pushed out to multiple streaming services.

## Requirements
1. Raspberry Pi (or another device running Linux).
1. Root/sudo access on the device.
1. Internet connection.
1. One or more account with a streaming service.
1. Streaming keys for your streaming accounts.

## Installation
1. Download this repo as a zip file onto your device.
1. Unzip the file on the device (unzip rtmp_restreamer-master.zip).
1. Edit rtmp_restreamer-master/usr/share/nginx/modules-available/rtmp-restreamer.conf and add your stream keys and any other streaming destinations with 'push' commands (see lines 16-17 for an example)
1. **OPTIONAL:** To enable authentication edit rtmp_restreamer-master/usr/share/nginx/modules-available/rtmp-restreamer-auth.conf, then run 'ln -s /usr/share/nginx/modules-available/rtmp-restreamer-auth.conf /etc/nginx/modules-enabled/50-rtmp-restreamer-auth.conf' after running 'install.sh'.
1. Run ./install.sh

## Usage
1. Get find the IP of your device that is running the newly installed NGINX server.
1. Setup OBX/XSplit to stream to that IP_ADDRESS/live for live streams or IP_ADDRESS/test for test streams.
1. Start your stream.
