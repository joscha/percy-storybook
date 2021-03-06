#!/bin/bash

set -ev

SUITE=$1

error() {
  echo "error: $*" >&2
  exit 1
}

link () {
  pushd ../../packages/$1
  yarn link
  popd
  yarn link @percy-io/$1
}

if [ "$SUITE" = "react-percy-storybook" ]; then
  # If Percy is enabled, and there's a PERCY_TOKEN supplied (it's not on community PRs),
  # take snapshots of the react-percy-storybook integration tests's stories.
  if [[ "$PERCY_ENABLE" != "0" && -n "$PERCY_TOKEN" ]] ; then
    cd integration-tests/react-percy-storybook
    link react-percy-storybook
    yarn storybook:percy
  elif [[ "$PERCY_ENABLE" != "0" && "$TRAVIS" != true ]] ; then
    # This is local, when invoking yarn test:integration react-percy-storybook w/o PERCY_TOKEN
    error "No PERCY_TOKEN given"
  fi
else
  cat <<EOF
Valid targets are:
* react-percy-storybook
* react-percy
* create-react-app
EOF
fi
