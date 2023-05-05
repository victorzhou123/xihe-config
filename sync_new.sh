#!/bin/bash

# root dir
local_config_root_path="/Users/victor/code/config/xihe-config"
infra_root_path="/Users/victor/code/config/infra-mindspore/applications/xihe-new"


# define header
header1="apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap
data:
  config.yaml: |
"

header2="---
apiVersion: v1
kind: ConfigMap
metadata:
  name: server-configmap
  namespace: xihe-new
data:
  config.yaml: |
"

header3="---
apiVersion: v1
kind: ConfigMap
metadata:
  name: async-server-configmap
  namespace: xihe-new
data:
  config.yaml: |
"

# sync function
sync () {
    if [ $1 == "xihe-server" ]; then
        header=${header2}
    elif [ $1 == "async-server" ]; then
        header=${header3}
    else
        header=${header1}
    fi

	content=$(cat ${local_config_root_path}/$1/$1.yaml)
	content="${header}${content}"

	echo "$content" > "${infra_root_path}/$1/configmap.yaml"
}

# run sync
sync "message-server"
sync "internal-server"
sync "xihe-server"
sync "inference-evaluate"
sync "async-server"