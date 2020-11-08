#!/usr/bin/env bash
while true; do
lualatex --interaction=nonstopmode --halt-on-error --shell-escape userguide
read -p "Press [enter] to compile again"
done

