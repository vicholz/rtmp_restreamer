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
1. Unzip the file on the device (unzip FILENAME.zip).
1. Run ./install.sh
1. Edit /usr/share/nginx/modules-available/rtmp-restreamer.conf and add your stream keys and any other streaming destinations with 'push' commands (see lines 16-17 for an example)
2. **OPTIONAL:** Edit /usr/share/nginx/modules-available/rtmp-restreamer-auth.conf
3. Run the following command to restart NGINX after updating the config:
`
sudo systemctl restart nginx; systemctl status nginx;
`

## Usage
1. 