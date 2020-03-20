#!/usr/bin/env bash

replace_project_name () {
  PROJECT_NAME=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  PROJECT_NAME_CAMEL_CASE=$(tr '[:lower:]' '[:upper:]' <<< ${PROJECT_NAME:0:1})${PROJECT_NAME:1}

  mv ./nectar-cli ./"$PROJECT_NAME-cli"
  cd ./"$PROJECT_NAME-cli" || return

  find . -type f -name "*.*" -print0 | xargs -0 sed -i '' -e "s/nectar/$PROJECT_NAME/g"
  find . -type f -name "*.*" -print0 | xargs -0 sed -i '' -e "s/Nectar/$PROJECT_NAME_CAMEL_CASE/g"

  git init
  npm i
}

main () {
  git clone git@github.com:oleh-polishchuk/nectar-cli.git

  cd nectar-cli && rm -rf ./.git && cd ../

  if [ -n "$1" ]; then
    replace_project_name "$1"
  else
    replace_project_name "react"
  fi
}

main $1
