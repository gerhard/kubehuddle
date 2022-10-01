package civo

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
)

#Domain: {
	create: {
		apiKey: dagger.#Secret
		fqdn:   string
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input: _image.output
			command: {
				name: "civo"
				args: [
					"domain", "create", fqdn,
				]
			}
		}
	}
	record: {
		apiKey: dagger.#Secret
		fqdn:   string
		record: string
		value:  string
		type:   string | "A" | "CNAME" | "TXT" | "SRV" | "MX"
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input: _image.output
			command: {
				name: "civo"
				args: [
					"domain", "record", "create", fqdn,
					"--name", record,
					"--value", value,
					"--type", type,
				]
			}
		}
	}
}
