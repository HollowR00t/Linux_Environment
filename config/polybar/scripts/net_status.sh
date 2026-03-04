#!/bin/bash

if ip link show eno1 | grep -q "state UP" && nmcli device status | grep -q "eno1.*connected"; then
    ip=$(ip -4 addr show eno1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo " $ip"
else
    ip=$(ip -4 addr show dev wlo1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    essid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
    if [ -n "$essid" ]; then
        echo " $ip"
        #$essid($signal%)"
    else
        echo " no signal"
    fi
fi

