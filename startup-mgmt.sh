#!/bin/bash

echo "info: Remember to reauthorize this proxy on every deploy!"
echo
sleep 3

if [[ $SPOTIFY_PROXY_API_TOKEN != "" ]]; then
  echo "warning: Proxy API key was in SPOTIFY_PROXY_API_TOKEN instead of SPOTIFY_PROXY_API_KEY,"
  echo "warning: re-exporting value to correct one."
  export SPOTIFY_PROXY_API_KEY=$SPOTIFY_PROXY_API_TOKEN
  echo
fi
sleep 3

if [ $SPOTIFY_PROXY_API_KEY == "" ]; then
  echo "APIKey:   $SPOTIFY_PROXY_API_KEY"
else
  echo "warning: No defined proxy API key. This may break your terraform plan and"
  echo "warning: terraform apply invocations if future deploys happens. Please set them either"
  echo "warning: with your password manager's password generator, OpenSSL or Railway's built-in "
  echo "warning: secret generator to ensure stability."
fi
exec /bin/spotify_auth_proxy