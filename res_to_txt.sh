#!/bin/bash
cat "$1" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" | tee -a "$2"
