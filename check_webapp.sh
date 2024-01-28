#!/bin/bash

# Developer: Asman Mirza
# Email: rambo007.am@gmail.com
# Date: 29 January, 2024

URL="http://wlsohs:7001/console"
FLAG_FILE="/home/opc/oracle/down.flag"

if curl --output /dev/null --silent --head --fail "$URL"; then
    # Remove flag file if it exists
    [ -f "$FLAG_FILE" ] && rm "$FLAG_FILE"
else
    # Create flag file if it doesn't exist
    [ ! -f "$FLAG_FILE" ] && touch "$FLAG_FILE"
fi

# crontab -e
# */5 * * * * /usr/local/bin/check_webapp.sh
