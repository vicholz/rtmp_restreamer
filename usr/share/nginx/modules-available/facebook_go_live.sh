#!/bin/bash

#HOW TO GET AN ACCESS TOKEN (See https://sujipthapa.co/blog/generating-never-expiring-facebook-page-access-token)
#1. Register as a developer - https://developers.facebook.com/async/registration/dialog
#2. Create an APP - https://developers.facebook.com/apps
#3. Go to Facebook Graph API Explorer - https://developers.facebook.com/tools/explorer
#4. Add permissions: publish_video, manage_pages, publish_pages
#5. Select 'Generate User Token' from 'User or Page' drop down.
#6. Click Generate Access Token and follow prompts.
#7. Copy access token.
#8. Go to Graph API Explorer - https://developers.facebook.com/tools/explorer
#9. Change the endgpoint to '/me/accounts'
#10. Copy non-expiring token from response and enter into the ACCESS_TOKEN variable

ACCESS_TOKEN="TOKEN_GOES_HERE"

VIDEO_ID_FILE="/tmp/fb_live_stream_id"

function start {
echo -n "GOING LIVE..."
curl -s -X POST \
"https://graph.facebook.com/v6.0/me/live_videos?\
&status=LIVE_NOW\
&access_token=${ACCESS_TOKEN}" | jq -r ".id" > $VIDEO_ID_FILE
echo "DONE!"
}

function stop {
VIDEO_ID=$(cat $VIDEO_ID_FILE)
echo -n "ENDING LIVE VIDEO WITH ID ${VIDEO_ID}..."
curl -s -X POST \
"https://graph.facebook.com/${VIDEO_ID}\
?end_live_video=true\
&access_token=${ACCESS_TOKEN}" > /dev/null
echo "DONE!"
}

if [ "${1}" != "start" ] && [ "${1}" != "stop" ]; then
    echo "USAGE: facebook_go_live.sh [start|stop] [ACCESS_TOKEN - TO OVERRIDE ONE IN THIS FILE]"
fi

if [ -n "${2}" ]; then
    ACCESS_TOKEN="${2}"
fi

eval $1