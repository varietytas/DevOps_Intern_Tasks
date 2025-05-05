#!/bin/bash
ansible-playbook -i inventory.yaml playbook.yaml

# With stdout and stderr of each task executed
# ansible-playbook -v -i inventory.yaml playbook.yaml
