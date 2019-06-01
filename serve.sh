#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error. Expected usage: ./serve.sh YOUR_IP_ADDR PORT_TO_SERVE_ON"
    exit 1
fi

jupyter notebook --ip $1 --port $2

