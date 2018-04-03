# Registrator

Service registry bridge for Docker forked from [gliderlabs/registrator](https://github.com/gliderlabs/registrator).
  
[![GitHub release](https://img.shields.io/github/release/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
[![Docker Automated buil](https://img.shields.io/docker/automated/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
[![Docker Stars](https://img.shields.io/docker/stars/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
[![Docker Pulls](https://img.shields.io/docker/pulls/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
[![license](https://img.shields.io/github/license/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
  
  
  
Registrator automatically registers and deregisters services for any Docker
container by inspecting containers as they come online. Registrator
supports pluggable service registries, which currently includes
[Consul](http://www.consul.io/), [etcd](https://github.com/coreos/etcd) and
[SkyDNS 2](https://github.com/skynetservices/skydns/).

Full documentation available at http://gliderlabs.com/registrator

## Getting Registrator

Get the latest release, master, or any version of Registrator via [Docker Hub](https://registry.hub.docker.com/u/olafnorge/golang-registrator/):

	$ docker pull olafnorge/golang-registrator:latest

Latest tag always points to the latest release. There is also a `:master` tag
and version tags to pin to specific releases.

## Using Registrator

The quickest way to see Registrator in action is our
[Quickstart](https://gliderlabs.com/registrator/latest/user/quickstart)
tutorial. Otherwise, jump to the [Run
Reference](https://gliderlabs.com/registrator/latest/user/run) in the User
Guide. Typically, running Registrator looks like this:

    $ docker run -d \
        --cap-drop=all \
        --name=registrator \
        --read-only \
        --security-opt=no-new-privileges \
        --user="registrator:$(getent group docker | awk -F':' '{print $3}')" \
	    --volume=/etc/localtime:/etc/localtime:ro \
	    --volume=/etc/timezone:/etc/timezone:ro \
        --volume=/var/run/docker.sock:/tmp/docker.sock \
        olafnorge/golang-registrator:latest \
        consul://localhost:8500

## CLI Options
```
Usage of /bin/registrator:
  /bin/registrator [options] <registry URI>

  -cleanup=false: Remove dangling services
  -deregister="always": Deregister exited services "always" or "on-success"
  -internal=false: Use internal ports instead of published ones
  -ip="": IP for ports mapped to the host
  -resync=0: Frequency with which services are resynchronized
  -retry-attempts=0: Max retry attempts to establish a connection with the backend. Use -1 for infinite retries
  -retry-interval=2000: Interval (in millisecond) between retry-attempts.
  -tags="": Append tags for all registered services
  -ttl=0: TTL for services (default is no expiry)
  -ttl-refresh=0: Frequency with which service TTLs are refreshed
```

## Contributing

Pull requests are welcome! We recommend getting feedback before starting by
opening a [GitHub issue](https://github.com/olafnorge/golang-registrator/issues).

## License

[![license](https://img.shields.io/github/license/olafnorge/golang-registrator.svg)](https://hub.docker.com/r/olafnorge/golang-registrator/)
