FROM ghcr.io/conradludgate/spotify-auth-proxy

COPY startup-mgmt.sh /usr/local/bin/startup-mgmt.sh

RUN echo "hi mom, we're on Railway!" \
    apk add bash coreutils dumb-init \
    chmod +x /usr/local/bin/startup-mgmt.sh

ENTRYPOINT ["dumb-init"]
CMD ["/usr/local/bin/startup-mgmt.sh"]