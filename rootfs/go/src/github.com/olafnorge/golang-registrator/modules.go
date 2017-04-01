package main

import (
	_ "github.com/olafnorge/golang-registrator/consul"
	_ "github.com/olafnorge/golang-registrator/consulkv"
	_ "github.com/olafnorge/golang-registrator/etcd"
	_ "github.com/olafnorge/golang-registrator/skydns2"
	_ "github.com/olafnorge/golang-registrator/zookeeper"
)
