#!/bin/bash

rm -f abi/*.json
mkdir -p abi

for file in $(find artifacts/contracts artifacts/@openzeppelin -name '*.json' | grep -v ".dbg.json$"); do
  echo Generate ABI for "${file}"
  jq ".abi" "${file}" > abi/"$(basename "${file}")"
done
