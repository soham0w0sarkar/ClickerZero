#!/bin/bash

if [ -z "$1" ] ; then
    echo "Missing argument - filename!"
    exit 1
fi

output_name=$(echo "$1" | sed 's/.html//')
output_filename="page_${output_name}.h"

echo """#ifndef PAGE_${output_name^^}_H
#define PAGE_${output_name^^}_H

// This file was generated using xxd""" > $output_filename

# Gzip file and write to static array with proper naming and constness
gzip --best "$1" -c > "page_${output_name}"
xxd -i -u "page_${output_name}" \
| sed "s/page_${output_name}_html/page_${output_name}/g" \
| sed "s/unsigned char/const unsigned char/" \
| sed "s/unsigned int/const unsigned int/" \
>> $output_filename
rm "page_${output_name}"

echo -e "\n#endif" >> $output_filename

pages_location="../pages"
echo "Moving $output_filename to $pages_location/$output_filename"
mv $output_filename $pages_location/$output_filename
