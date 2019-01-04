#!/bin/bash

COMMAND=${COMMAND:-"w2 run -p 8080 -z /data/ssl"}
PROJECT_NAME=${PROJECT_NAME:-"nohost"}
ADMIN_NAME=${ADMIN_NAME:-"admin"}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-"admin123"}
GUEST_NAME=${GUEST_NAME:-"guest"}
GUEST_PASSWORD=${GUEST_PASSWORD:-"guest"}
HOST=${HOST:-""}
LOG_FLAG=${LOG_FLAG:-"false"}
GUEST_FLAG=${GUEST_FLAG:-"true"}

while getopts "n:u:p:h:e:ld" OPT; do
    case $OPT in
        n)
            PROJECT_NAME=$OPTARG;;
        u)
            ADMIN_NAME=$OPTARG;;
        p)
            ADMIN_PASSWORD=$OPTARG;;
        h)
            HOST_CONFIG="-L nohost=$OPTARG";;
        e)
            EXTRA_DATA=$OPTARG;;
        l)
            LOG_FLAG="true";;
        d)
            GUEST_FLAG="false";;
    esac
done


if [ "${GUEST_FLAG}" == "true" ]; then
    EXTRA_DATA="%7B%22nohost%22%3A%7B%22guestName%22%3A%22$GUEST_NAME%22%2C%22guestPassword%22%3A%22$GUEST_PASSWORD%22%7D%7D"
else
    EXTRA_DATA="%7B%7D"
fi

if [ "${PROJECT_NAME}" != "nohost" ]; then
    sed -i "s/Nohost/$PROJECT_NAME/g" /usr/local/lib/node_modules/whistle.nohost/public/*.html
    sed -i "s/nohost环境/$PROJECT_NAME环境/g" /usr/local/lib/node_modules/whistle.nohost/public/js/capture.js
fi

COMMAND_STR="$COMMAND -n $ADMIN_NAME -w $ADMIN_PASSWORD $HOST_CONFIG -e $EXTRA_DATA"

if [ "${LOG_FLAG}" == "true" ]; then
    echo -e "\033[32m$COMMAND_STR\033[0m"
fi

$COMMAND_STR
