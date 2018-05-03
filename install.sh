#!/bin/bash

# Setup Asana personal token
echo "Please follow the tutorial to create a personal token"
echo "https://asana.com/guide/help/api/api#gl-access-tokens"
echo "Please enter the token below (it will put your token in ~/.asana_token):"

read token

echo "export ASANA_TOKEN=$token" > ~/.asana_token
if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
   # assume Zsh
   echo "source ~/.asana_token" >> ~/.zprofile
elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
   # assume Bash
   asana_source='source ~/.asana_token'
   if [ -z "`cat ~/.bash_profile | grep \"$asana_source\"`" ]; then
       echo "$asana_source" >> ~/.bash_profile
       source ~/.asana_token
   fi
else
   # asume something else
   echo "Can't reconize the shell you like, please add 'source ~/.asana_token' to your shell profile manually."
fi

# Setup git hooks path
git config core.hooksPath ./.github-asana/.githooks

# Checking pip3 exist or not
if command -v pip3 > /dev/null; then
    echo "Already installed pip3"
else
    if command -v brew > /dev/null; then
        echo "Install python3 from Homebrew"
        brew install python
    else
        echo "No Homebrew, please install python3 manually before execute this install.sh"
        exit 1
    fi
fi

if [ -n "`pip3 freeze | grep 'asana=='`" ]; then
    echo "Already installed python asana module"
else
    # Install python asana module via pip3
    echo "Install python asana module via pip3"
    pip3 install asana
fi

echo "Success"
