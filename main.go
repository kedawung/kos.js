package main

import (
	"log"

	"github.com/kedawung/kos.js/server"
	"github.com/jpillora/opts"
)

var VERSION = "0.0.0-src" //set with ldflags

func main() {
	s := server.Server{
		Title:      "Click here to save on Ur Gdrive",
		Port:       2000,
		ConfigPath: "kos.js.json",
	}

	o := opts.New(&s)
	o.Version(VERSION)
	o.PkgRepo()
	o.LineWidth = 96
	o.Parse()

	if err := s.Run(VERSION); err != nil {
		log.Fatal(err)
	}
}
