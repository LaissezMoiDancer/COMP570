#!/bin/bash

DATA=~/COMP570/data/clean_dialog.csv
OUT=Line_percentages.csv

# total spoken lines = all CSV records minus the header
TOTAL=$(( $(csvtool height "$DATA") - 1 ))

echo "pony_name,total_line_count,percent_all_lines" > "$OUT"

for pony in "Twilight Sparkle" "Rarity" "Pinkie Pie" "Rainbow Dash" "Fluttershy"; do
  count=$(csvtool col 3 "$DATA" | tr -d '\r' | grep -cx "$pony")
  pct=$(awk -v c="$count" -v t="$TOTAL" 'BEGIN { printf "%.2f", 100 * c / t }')
  echo "$pony,$count,$pct" >> "$OUT"
done

cat "$OUT"