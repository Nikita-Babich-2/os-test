#!/bin/bash
cat << EOF
<!DOCTYPE html>
<html>

<body>
EOF

LIST=0

while IFS= read LINE
do

if echo "$LINE" | grep '^ - .*' > /dev/null
then
  if [ "$LIST" = 0 ]
  then
    echo "<ol>"
    LIST=1
  fi
else
  if [ "$LIST" = 1 ]
  then
    echo "</ol>"
    LIST=0
  fi
fi

LINE=$(echo "$LINE" | sed 's@<\(https[^>]*\)>@<a href="\1">\1</a>@g')
LINE=$(echo "$LINE" | sed 's@^ - \(.*\)$@<li>\1</li>@g')


echo $LINE
done



echo "</body>"
echo "</html>"
