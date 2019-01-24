#!/usr/bin/env bash
owner=$1
repository=$2

if [[ -z "$TRAVIS_TAG" ]]; then
    echo "Commit has no tag. Skipping build"
    exit 1
fi
response_code=$(curl -s -o  /dev/null -w "%{http_code}" "https://api.github.com/repos/${owner}/${repository}/releases/tags/${TRAVIS_TAG}")
if [[ $response_code -ne "200" ]]; then
    echo "Tag does not have an associated release. Skipping build"
    exit 2
fi
master_branch_info=$(curl https://api.github.com/repos/${owner}/${repository}/git/refs/heads/master)
latest_master_commit=$(python bin/get_sha.py "$master_branch_info")
if [[ $latest_master_commit != $TRAVIS_COMMIT ]]; then
    echo "Commit ${TRAVIS_COMMIT} is not the latest change in master. Skipping build"
    exit 3
fi
