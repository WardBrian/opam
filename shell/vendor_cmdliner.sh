#!/bin/sh

set -euo pipefail

cd src/core/cmdliner
rm -rf *.ml *.mli dune tool

git clone https://github.com/dbuenzli/cmdliner tmp-vendor
git -C tmp-vendor switch --detach v2.1.0

mv tmp-vendor/src/*.{ml,mli} .
mkdir -p tool
mv tmp-vendor/src/tool/*.ml tool/
rm -rf tmp-vendor

for f in patches/*.patch; do
  git apply "$f"
done
