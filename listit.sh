#! /bin/bash

touch ./directories.list
ls ./ > directories.list
cat ./directories.list | head -n 3

echo "Enter the number(x) :"
read x
echo $x

for i in `seq $x` 
do
cat ./directories.list | head -n 3
done
