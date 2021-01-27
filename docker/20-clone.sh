#!/bin/bash

abort=false

if [[ -z "$GIT_URL" ]]; then
  echo "GIT_URL is not set. Aborting..."
  exit 1
fi

if [[ -z "$GIT_USER" ]]; then
  echo "GIT_USER is not set. Aborting..."
  exit 1
fi

if [[ -z "$GIT_REVISION" ]]; then
  echo "GIT_USER is not set. Aborting..."
  exit 1
fi

git config credential.https://github.com.username $GIT_USER

git clone --depth=1 --branch $GIT_REVISION $GIT_URL /app-git

composer1 install -d /app-git
mv /app /app-old
mv /app-git /app

ls /app
