#!/bin/bash

echo "Starting tailscale proxy..."
tailscaled --state=/app/tailscale.state \
    --tun=userspace-networking \
    --socket=/app/tailscale.sock &
until tailscale --socket=/app/tailscale.sock \
    up \
    --advertise-routes=fd12::/16 \
    --authkey=$TAILSCALE_AUTHKEY \
    --advertise-exit-node
do
    echo "Waiting for auth..."
    sleep 5
done
echo "Tailscale proxy started."

# Sleep indefinitely
for (( ; ; ))
do
    sleep 500
done