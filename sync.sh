#!/bin/bash

# root dir
local_config_root_path="/Users/victor/code/config/xihe-config"
infra_root_path="/Users/victor/code/config/infra-mindspore/applications/xihe-test-v2"


# define header
header="apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap
data:
  config.yaml: |
"

sync () {
	content=$(cat ${local_config_root_path}/$1/$1.yaml)
	content="${header}${content}"

	echo "$content" > "${infra_root_path}/$1/configmap.yaml"
}

sync "message-server"
sync "internal-server"
sync "xihe-server"
sync "xihe-async"