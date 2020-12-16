#!/bin/bash
# execute with bash!
cd ..
shopt -s extglob
eval 'rm -rv !("hugo"|*.sh)'
cd hugo
hugo
cd public
mv * ../../
cd ../
