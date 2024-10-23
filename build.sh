#!/bin/bash

domains_file="domains.list"
ipv4_ips_file="ips.ipv4.list"
ipv6_ips_file="ips.ipv6.list"
combined_file="combined.list"
source_file="sources.list"

while IFS= read -r url; do
    curl -s "$url" >> "$combined_file"
done < "$source_file"

sort -u "$combined_file" -o "$combined_file"

grep -E '^[^0-9].*' "$combined_file" > "$ipv4_ips_file"

grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|::([0-9a-fA-F]{1,4}:){0,6}[0-9a-fA-F]{1,4}' "$combined_file" > "$ipv6_ips_file"

rm "$combined_file"
