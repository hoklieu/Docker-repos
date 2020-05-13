1. The entrypoint is an unfinished template, the general use is serving as an entrypoint for a flask application which lies in the docker container env and needs access to some other services (most like) lying behind the proxy (that's configured using --dns when starting docker container, see the options in the `Makefile`)


2. The Dockerfiile.flask may be a template for a container holding flask.
