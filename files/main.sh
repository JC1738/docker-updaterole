#!/bin/sh -x

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#

if [ -z "${role}" ]; then
    echo "ERROR: Role not set."
    exit 1
fi

if [ -z "${version}" ]; then
    echo "ERROR: Version not set."
    exit 1
fi

echo "Starting Update Role"

echo "All parameters have been provided..."

#download current role
knife role show ${role} -f json > temp.json

#update role json
underscore -i temp.json process "data.default_attributes.deploy.versionToDeploy='${version}';data;" -o new.json

#output it for logging
cat new.json

#upload new json
knife role from file new.json

#
# Finished operations
#
echo "Finished knife operations"
