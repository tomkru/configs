#!/usr/bin/env bash

music=$(osascript ~/bin/spotify.scpt)
weather=$(~/bin/ansiweather -a false -u metric -l "Brno, CZ"  | cut -f1 -d "-" | sed 's/Current weather in //g' | sed 's/=> //' | sed 's/Brno //g')

if [[ ${#weather} -eq 1 ]]; then
    weather2=' Brno -'$(~/bin/ansiweather -a false -u metric -l "Brno, CZ" | cut -f2 -d "-")
else
    weather2=' Brno'$weather
fi;

if [[ $music ]]; then
  echo "$music |$weather2"
else
  echo "$weather"
fi;
