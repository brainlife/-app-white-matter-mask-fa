#!/bin/bash

# top variables
fa=`jq -r '.fa' config.json`
thr=`jq -r '.thr' config.json`

# make directories
outdir="mask"
rawdir="raw"

[ ! -d ${outdir} ] && mkdir $outdir
[ ! -d ${rawdir} ] && mkdir $rawdir

# threshold fa image
[ ! -f fa_threshold.nii.gz ] && fslmaths ${fa} -thr ${thr} fa_threshold.nii.gz

# binarize threshold image
[ ! -f ${outdir}/mask.nii.gz ] && fslmaths fa_threshold.nii.gz -bin ${outdir}/mask.nii.gz

# final check
[ -f ${outdir}/mask.nii.gz ] && echo "complete" && mv *.nii.gz ${rawdir} && exit 0 || echo "something went wrong. check derivatives and logs" && exit 1
