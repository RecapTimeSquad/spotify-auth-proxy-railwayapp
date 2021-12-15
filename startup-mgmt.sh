#!/bin/bash

if [[ $SPOTIFY_PROXY_API_TOKEN != "" ]]; then
  echo "warning: Proxy API key was in SPOTIFY_PROXY_API_TOKEN instead of SPOTIFY_PROXY_API_KEY,"
  echo "warning: re-exporting value to correct one."
  export SPOTIFY_PROXY_API_KEY=$SPOTIFY_PROXY_API_TOKEN
fi
sleep 3

exec /bin/spotify_auth_proxy