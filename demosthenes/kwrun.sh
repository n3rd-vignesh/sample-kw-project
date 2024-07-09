#!/bin/sh

# Just in case so that we get expected behaviour in development environment
unset REP_HOME REP_CONFIG REP_MODE

KW_WORKDIR=$1

# Default to local server if not set
if [ x"$KW_SERVER_URL" = "x" ]
then
    KW_SERVER_URL="http://localhost:8080"
fi

# Try to get a working directory to put object files and tables to
if [ x"$KW_WORKDIR" = "x" ]
then
    KW_WORKDIR=`pwd`"/demosthenes_build";
fi

# create a working directory if necessary
if [ ! -d $KW_WORKDIR ]
then
    mkdir -p $KW_WORKDIR || exit;
fi
KW_WORKDIR=`cd $KW_WORKDIR; pwd`;

echo "Using '$KW_WORKDIR' as working directory";

if [ "x$KWROOT" = "x" ]
then
    startname=`basename "$0"`
    startdir=`dirname "$0"`
    startdir=`cd "$startdir"; pwd`
    sampledir=`dirname "$startdir"`
    KWROOT=`dirname "$sampledir"`
    if [ ! -x $KWROOT/bin/kwinject ]
    then
        echo "Start script from inside installation or use 'KWROOT=<installation root> ./kwrun.sh'";
        exit;
    fi
    
fi

if [ ! -x "$KWROOT/bin/kwadmin" ]
then
    echo "kwrun.sh must be run from within server installation. Exiting."
    exit 1
fi

if [ "x"$KW_NO_SERVERS = "x" ]
then
    echo "Recreating project 'demosthenes'"
    $KWROOT/bin/kwadmin --url $KW_SERVER_URL delete-project demosthenes
    $KWROOT/bin/kwadmin --url $KW_SERVER_URL create-project demosthenes
fi

echo "Building source base revisions ... "

revision_build() { 
 bnum=$1

 table_dir=$KW_WORKDIR/kwtables$bnum
 out_dir=$KW_WORKDIR/out$bnum
 src_dir=$startdir/revisions/rev$bnum

 rm -rf $table_dir

if [ "x"$KW_NO_KWINJECT != "x" ]
then
 echo "Creating kwinject log from template"
 cat $startdir/kwinject.template.txt | sed -e "s!@SRC@!$startdir!g" | sed -e "s!@NUM@!$bnum!g" |sed -e "s!@OUTDIR@!$out_dir!g" > $KW_WORKDIR/kwinject$bnum.out
else
 echo "Running kwinject from scratch ... ";
 make -C $startdir -f demosthenes.make clean OUTDIR=$out_dir
 $KWROOT/bin/kwinject -o $KW_WORKDIR/kwinject$bnum.out make -C $startdir -f demosthenes.make OUTDIR=$out_dir SRCDIR=$src_dir
fi

 echo "Running kwbuildproject (see log in $table_dir/build.log)... ";
 $KWROOT/bin/kwbuildproject --url $KW_SERVER_URL/demosthenes --tables-directory $table_dir $KW_WORKDIR/kwinject$bnum.out
 echo "Running kwadmin load (see log in $table_dir/build.log)... ";
 $KWROOT/bin/kwadmin --url $KW_SERVER_URL load demosthenes $table_dir $lic_opt
}

for i in 0 1 2 3 4
do
    revision_build $i
done
