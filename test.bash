#!/usr/bin/env bash

VAR=true

if [ ${VAR} = true ]; then 
    echo "Hello World"
elif [ ${VAR} = false ]; then 
    echo "Goodbye World"
    exit 1
else
    echo "Something went wrong, you died"
    exit 1
fi
