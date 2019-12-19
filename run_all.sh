#!/bin/bash

#Copyright University College London 2019
#Author: Alexander Whitehead, Institute of Nuclear Medicine, UCL
#For internal research only.

run_xcat()
{
    SAMPPAR=$(echo $1 | rev | cut -d'/' -f1 | rev) #xcat executable
    SAMPPARPATH=${1//$SAMPPAR/} #path to xcat directory
    
    RUNXCATPATH=${2}
    XCATPATH=${3}
    
    echo -e '\n' $RUNXCATPATH $XCATPATH $SAMPPARPATH$SAMPPAR $SAMPPARPATH '\n'
    
    $RUNXCATPATH $XCATPATH $SAMPPARPATH$SAMPPAR $SAMPPARPATH
}

run_lesion()
{
    RUNLESIONPATH=${1/"./"/$(pwd)"/"}
    STIRPATH=${2/"./"/$(pwd)"/"}
    FINDPATH=${3/"./"/$(pwd)"/"}
    
    echo -e '\n' $RUNLESIONPATH $STIRPATH $FINDPATH '\n'
    
    $RUNLESIONPATH $STIRPATH $FINDPATH
}

main()
{
    #create full paths
    RUNXCATPATH=${1/"./"/$(pwd)"/"}
    XCATPATH=${2/"./"/$(pwd)"/"}
    RUNLESIONPATH=${3/"./"/$(pwd)"/"}
    STIRPATH=${4/"./"/$(pwd)"/"}
    FINDPATH=${5/"./"/$(pwd)"/"}
    
    echo -e $RUNXCATPATH "\n"
    echo -e $XCATPATH "\n"
    echo -e $RUNLESIONPATH "\n"
    echo -e $STIRPATH "\n"
    echo -e $FINDPATH "\n"
    
    export -f run_xcat
    
    echo -e "RUNNING AT PATH: " $FINDPATH '\n'
    
    find $FINDPATH -name "*.samp.par" | parallel --dryrun --ungroup 'run_xcat {}' $RUNXCATPATH $XCATPATH
    
    read -p "Press any key to coninue..."
    
    find $FINDPATH -name "*.samp.par" | parallel --ungroup 'run_xcat {}' $RUNXCATPATH $XCATPATH
    
    run_lesion $RUNLESIONPATH $STIRPATH $FINDPATH
    
    exit 0
}

#start
main "$@"
