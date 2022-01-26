#!/bin/bash

uid=`date "+%Y%m%d%H%M%S"`
MAINDIR=`pwd`
ROOTDIR=$MAINDIR/..
RESULTSROOTDIR=$MAINDIR/..
ROOTNAME=emulandice
INSTANCENAME=$ROOTNAME$uid
INSTANCEDIR=$ROOTDIR/$INSTANCENAME
RESULTSDIR=$RESULTSROOTDIR/results-$uid

echo $INSTANCENAME
mkdir $INSTANCEDIR
mkdir $RESULTSDIR

cp -r $MAINDIR/NAMESPACE $MAINDIR/R $MAINDIR/README.md $MAINDIR/inst $MAINDIR/man $MAINDIR/*.sh $MAINDIR/steer $INSTANCEDIR
echo Package: $INSTANCENAME > $INSTANCEDIR/DESCRIPTION
cat $MAINDIR/template/DESCRIPTION.foot >> $INSTANCEDIR/DESCRIPTION

echo "#!/bin/bash

    Rscript -e \"install.packages('devtools',repos='https://cloud.r-project.org')\"
    Rscript -e \"devtools::install_deps('.')\"
    R CMD INSTALL --no-multiarch --with-keep.source .
    Rscript steer/steer.R
    R CMD REMOVE $INSTANCENAME" > $INSTANCEDIR/run.sh

echo "library($INSTANCENAME)
main(packagename=\"$INSTANCENAME\", dataset=\"FACTS\",N_temp=501L, outdir=\"$RESULTSDIR\") # do only 501 samples for year 2100
#main(packagename=\"$INSTANCENAME\", \"timeseries\", dataset=\"FACTS\", outdir=\"$RESULTSDIR\")" > $INSTANCEDIR/steer/steer.R

cat $MAINDIR/template/FACTS_CLIMATE_FORCING.csv.head > $INSTANCEDIR/inst/extdata/FACTS_CLIMATE_FORCING.csv
cat $MAINDIR/template/FACTS_CLIMATE_FORCING.csv.example >> $INSTANCEDIR/inst/extdata/FACTS_CLIMATE_FORCING.csv
