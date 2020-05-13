#!/bin/sh

# socat TCP-LISTEN:port
# listens on <port> TCP service and accepts a TCP/IP connection.
# , fork: after establishing a connection, handles its channel in a child process and keeps the parent process attempting to produce more connections.
# , reuseaddr: allows other sockets to bind to an address even if parts of it are already in use by socat(don't block)
# TCP:<host>:<port>
socat TCP-LISTEN: <port>,fork, reuseaddr TCP:<host>:<port> &

#export ENV_VAR=<>

export FLASK_APP=api.app:app
#other necessary exports of the envs

# in the react front end, add proxy from 3000 to 5000, and let flask run at 5000.
# in this way, react frontend would be able to route request to port 5000 where flask runs.
flask run --host=0.0.0.0 --port=5000 &

exec "$@"
