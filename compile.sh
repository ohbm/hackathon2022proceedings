#!/usr/bin/env bash

declare -A job
job=( [0]=main [1]=main_trackchanges [2]=main_linenum [3]=main_linenum_trackchanges [4]=main_textonly [5]=main_textonly_trackchanges
)
n_job=${#job[@]}
let n_job--

rm -rf out
mkdir out
mkdir -p ./compiled

for i in $(seq 0 ${n_job})
do
echo $i ${job[$i]}
pdflatex -interaction=nonstopmode -output-directory=./out --jobname=${job[$i]} "\gdef\condition{${i}} \input main.tex"
biber --input-directory=./out --output-directory=./out ${job[$i]}.bcf
pdflatex -interaction=nonstopmode -output-directory=./out --jobname=${job[$i]} "\gdef\condition{${i}} \input main.tex"
mv ./out/${job[$i]}.pdf ./compiled/${job[$i]}.pdf
done

rm out/*
