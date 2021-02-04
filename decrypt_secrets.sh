#!/bin/bash

find . -name "*.env" -exec ansible-vault decrypt --vault-password-file=vault_secret {} \;
find . -name "*.env" -exec chmod g+rw {} \;
