#!/bin/sh

set -e

sudo docker run --rm -it -v ${PWD}/export:/tmp --network host mssql-scripter "$@"
