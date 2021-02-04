#!/bin/bash

find . -name "*.env" -exec ansible-vault encrypt --vault-password-file=vault_secret {} \;
find . -name "*.env" -exec chmod g+rw {} \;
