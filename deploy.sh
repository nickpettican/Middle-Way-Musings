#! /bin/bash

set -e

while [ $# -gt 0 ]; do
  case "$1" in
    -m|-message|--message)
      message="$2"
      ;;
    *)
      printf "******************************\n"
      printf "* Error: Invalid argument $1.*\n"
      printf "******************************\n"
      exit 1
  esac
  shift
  shift
done

if [ -z "$message" ]; then
    echo -e "Please provide a message as -m 'Example message'\n"
    exit 1
fi

echo -e "Updating submodule\n"

git submodule update --init --recursive

echo -e "Building site for production\n"

hugo -t paper --minify --environment production

echo -e "Pushing to production repo\n"
echo -e "Using message '$message'\n"

cd public/
git add .
git commit -m "$message"
git push origin main
cd ..

echo -e "Successfully deployed to production repo.\n"
echo -e "Updating parent repo\n"

git add .
git commit -m "Deploy with message '$message'"
git push origin main
echo -e "Successfully updated parent repo.\n"
