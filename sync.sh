#!/bin/bash

# root dir
local_config_root_path="/Users/victor/code/config/xihe-config"
infra_root_path="/Users/victor/code/config/infra-mindspore/applications/xihe-test-v2"


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
  namespace: xihe-test-v2
data:
  config.yaml: |
"

# sync function
sync () {
    if [ $1 == "xihe-server" ]
    then
        header=${header2}
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
sync "xihe-async"