#!/bin/bash

rm "./$1" 2>/dev/null
zip -r "./$1" lovely/ assets/ debugplus README.md *.txt docs/ smods.json
