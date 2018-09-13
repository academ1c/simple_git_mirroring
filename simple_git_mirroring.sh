#!/bin/bash

MAIN_DIR="/tmp"
UPSTREAM=$1
MYREPO=$2

howusage() {
  echo "Usage:"
  echo "$0 <upstream-remote> <target-remote>"
  echo ""
  echo "$0 upstream origin"
  exit 1
}

if [ -z "$UPSTREAM" ]
then
  echo "Missing upstream remote name."
  howusage
fi

if [ -z "$MYREPO" ]
then
  echo "Missing target remote name."
  howusage
fi


UPSTREAM_DIR=`echo $UPSTREAM | sed 's/://g' | sed 's/\//_/g' | sed 's/\./_/g'`
mkdir -p $MAIN_DIR/$UPSTREAM_DIR
cd $MAIN_DIR/$UPSTREAM_DIR

git clone $UPSTREAM . &> /dev/null && git remote remove origin

git remote add upstream $UPSTREAM &>/dev/null
git remote add origin $MYREPO &>/dev/null


# Create sync_branch - this branch only for temporary purposes
git checkout -b sync_branch &>/dev/null

# Remove all local branches
git branch -a | grep -v -E "origin|remote|sync_branch" | xargs git branch -D

# Refetch all or new created branches from upstream repo
git fetch upstream

# Track all fetched branches
for brname in `git branch -r | grep upstream | grep -v master | grep -v HEAD | sed -e 's/.*\///g'`; do git branch --track $brname  upstream/$brname; done

# Push all branches and tags to our repo ($MYREPO)
git push --all $MYREPO
git push --tags $MYREPO

