package civo

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
)

#Image: docker.#Pull & {
	source: "nixery.dev/civo/bash"
}

#CLI: docker.#Run & {
	_image: #Image
	input:  _image.output
	env: {
		CIVO_API_KEY_NAME: string | *"dagger"
		CIVO_API_KEY:      dagger.#Secret
	}
	command: {
		name: "civo"
		args: ["apikey", "save", "--load-from-env"]
	}
}

#Regions: {
	apiKey: dagger.#Secret
	docker.#Run & {
		_image: #CLI & {
			env: CIVO_API_KEY: apiKey
		}
		input:  _image.output
		always: true
		command: {
			name: "civo"
			args: ["region", "ls"]
		}
	}
}

#Sizes: {
	apiKey: dagger.#Secret
	docker.#Run & {
		_image: #CLI & {
			env: CIVO_API_KEY: apiKey
		}
		input:  _image.output
		always: true
		command: {
			name: "civo"
			args: ["size", "ls"]
		}
	}
}
