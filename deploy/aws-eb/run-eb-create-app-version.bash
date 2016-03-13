#!/usr/bin/env bash

script_dir() {
    local source="${BASH_SOURCE[0]}"
    while [ -h "$source" ] ; do # resolve $SOURCE until the file is no longer a symlink
        local dir="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$( readlink "$source" )";
        # if $source was a relative symlink
        # we need to resolve it relative to the path where the symlink file was located
        [[ $source != /* ]] && source="$dir/$source"
    done
    printf "$( cd -P "$( dirname "$source" )" && pwd )"
}

SCRIPT_DIR=$( script_dir )

APP_VERSION=${APP_VERSION:-$( git describe --tags --long ) }
AUTH_API_VERSION=${AUTH_API_VERSION:-0.2.0-0-g2be72c4}

${SCRIPT_DIR}/eb-create-app-version.bash \
	--app-name $APP_NAME \
	--app-version $APP_VERSION \
        --auth-api-version $AUTH_API_VERSION \
        --s3bucket $APP_S3BUCKET