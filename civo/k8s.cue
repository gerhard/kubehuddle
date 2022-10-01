package civo

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
	"universe.dagger.io/bash"
)

#K8s: {
	apps: {
		apiKey: dagger.#Secret
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input:  _image.output
			always: true
			command: {
				name: "civo"
				args: ["k8s", "applications", "ls"]
			}
		}
	}

	create: {
		apiKey:      dagger.#Secret
		clusterName: string
		apps:        string | *"metrics-server"
		cni:         string | *"cilium"
		size:        string | *"g4s.kube.small"
		nodes:       int | *1
		region:      string | *"LON1"
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input: _image.output
			command: {
				name: "civo"
				args: [
					"k8s", "create", clusterName,
					"--applications", apps,
					"--cni-plugin", cni,
					"--create-firewall",
					"--size", size,
					"--nodes=\(nodes)",
					"--region", region,
					"--wait",
					"--yes",
				]
			}
		}
	}

	info: {
		apiKey:      dagger.#Secret
		clusterName: string
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input:  _image.output
			always: true
			command: {
				name: "civo"
				args: [
					"k8s", "show", clusterName,
				]
			}
		}
	}

	config: {
		apiKey:      dagger.#Secret
		clusterName: string
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input:  _image.output
			always: true
			command: {
				name: "civo"
				args: [
					"k8s", "config", clusterName,
					"--save", "--overwrite",
					"--local-path=/k8s.yml",
				]
			}
			export: files: "/k8s.yml": string
		}
	}

	ip: {
		apiKey:      dagger.#Secret
		clusterName: string
		bash.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input:  _image.output
			always: true
			env: NAME:        clusterName
			script: contents: "civo k8s show $NAME --output=custom --fields=MasterIP > /public_ip.txt"
			export: files: "/public_ip.txt": string
		}
	}

	destroy: {
		apiKey:      dagger.#Secret
		clusterName: string
		docker.#Run & {
			_image: #CLI & {
				env: CIVO_API_KEY: apiKey
			}
			input: _image.output
			command: {
				name: "civo"
				args: [
					"k8s", "destroy", clusterName,
					"--yes",
				]
			}
		}
	}
}
