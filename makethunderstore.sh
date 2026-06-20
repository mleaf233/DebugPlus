#!/bin/bash

version=$(jq -r .version smods.json)
id=$(jq -r .id smods.json)
desc=$(jq -r .description smods.json)
echo $version $id $desc
tmp="$(mktemp -d)"
if ! [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Version number $version is not valid for thunderstore! Make sure you dropped the ~dev."
    exit 1
fi

echo $version
./makezip.sh thunderstore.zip

convert assets/1x/modicon.png -filter point -resize 256x256! "$tmp/icon.png"
jq --arg n "$id" \
    --arg v "$version" \
    --arg d "$desc" \
    '.name = $n | .version_number = $v | .description = $d' dev/manifest.json > "$tmp/manifest.json"
cp docs/changelog.md "$tmp/CHANGELOG.md"

zip -j thunderstore.zip $tmp/*

rm -rf "$tmp"

echo "Remember to update me with instructions once you do this"
echo "Remember to update the lovely version in the dependancies"
