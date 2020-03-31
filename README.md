# NGINX RTMP Restreamer

The script and config files in this repo were created to make it easier to install and configure a RTMP restreamer or stream splitter. It allows one incoming stream from OBS/XSplit to be pushed out to multiple streaming services like Facebook Live, Twitch, YouTube Live and other services using NGINX w/ the RTMP module, and stunnel4 (required for Facebook Live). It comes preconfigured to restream to Facebook Live and Youtube Live, you just need to add your keys.

## How it works
![Diagram](https://github.com/vicholz/rtmp_restreamer/raw/master/docs/restreamer.png "Diagram")

## Requirements
1. Raspberry Pi (or another device running Linux).
1. Root/sudo access on the device.
1. Internet connection.
1. One or more account with a streaming service.
1. Streaming keys for your streaming accounts.

## Installation
1. [Download this repo as a zip](https://github.com/vicholz/rtmp_restreamer/archive/master.zip) on your device.
1. Unzip the file on the device (unzip rtmp_restreamer-master.zip).
1. Edit/update ```rtmp_restreamer-master/usr/share/nginx/modules-available/rtmp-restreamer.conf``` and add your stream keys and any other streaming destinations with 'push' commands (see lines 16-17 for an example).
1. **OPTIONAL:** To enable authentication edit/update ```rtmp_restreamer-master/usr/share/nginx/modules-available/rtmp-restreamer-auth.conf``` with the password you wish to use (see line 12).
1. Run ```sudo ./install.sh``` - this will install required packages and copy the configuration files from the rtmp_restreamer-master directory to where they need to live on the device.
1. If you wish to enable authentication run the following commands on your device:
```
sudo ln -s /usr/share/nginx/modules-available/rtmp-restreamer-auth.conf /etc/nginx/modules-enabled/50-rtmp-restreamer-auth.conf
sudo systemctl restart nginx; systemctl status nginx
```

## Making changes to the configuration after installation
1. If you need to change your stream keys or add streaming destinations you can edit:
    ```/usr/share/nginx/modules-available/rtmp-restreamer.conf``` (line 16+)
1. If you enabled auth and you would like to change your passphrase or other settings you can edit:
    ```/usr/share/nginx/modules-available/rtmp-restreamer-auth.conf``` (line 12)
1. Additional configuration files can be found in the following locations:
    ```
    /etc/default/stunnel
    /etc/stunnel/stunnel.conf
    /etc/stunnel/conf.d/facebook-tunnel.conf
    ```
1. Run the following commands to restart nginx and/or stunnel4 after making changes:
   ```
   sudo systemctl restart nginx; systemctl status nginx
   sudo systemctl restart stunnel4; systemctl status stunnel4
   ```

## Usage
1. Find the IP of your device that is running the newly installed NGINX server.
1. Setup OBX/XSplit to stream to that IP_ADDRESS/live for live streams and/or IP_ADDRESS/test for test streams.
1. Start your stream.
