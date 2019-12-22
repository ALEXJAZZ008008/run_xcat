#!/bin/bash

#Copyright University College London 2019
#Author: Alexander Whitehead, Institute of Nuclear Medicine, UCL
#For internal research only.

sum()
{
    SUMCURRENTDIRECTORY=$(pwd)
    
    ACTPREFIX=$(echo $1 | rev | cut -d'/' -f1 | rev)
    ACTPATH=${1//$ACTPREFIX/}
    
    FORACTPATH=$ACTPATH"/"$ACTPREFIX
    
    STIR=${2}
    LESIONPATH=${3}
    OUTPUTPATH=${4}
    
    LESIONACTPATH=$LESIONPATH"/"$ACTPREFIX
    OUTPUTACTPATH=$OUTPUTPATH"/"$ACTPREFIX
    
    if [ $(echo $ACTPREFIX | cut -d'.' -f2) == "hv" ]
    then
        echo $STIR $OUTPUTACTPATH $FORACTPATH $LESIONACTPATH '\n'
        
        $STIR $OUTPUTACTPATH $FORACTPATH $LESIONACTPATH
    fi
}

phantom_directory()
{
    PHANTOMDIRECTORYCURRENTDIRECTORY=$(pwd)
    
    PHANTOMPREFIX=$(echo $1 | rev | cut -d'/' -f1 | rev)
    PHANTOMPATH=${1//$PHANTOMPREFIX/}
    
    FINDPHANTOMPATH=$PHANTOMPATH"/"$PHANTOMPREFIX
    
    STIR=${2}
    
    PREFIX=${PHANTOMPREFIX//"_phantom"/}
    LESIONPATH=$PHANTOMPATH"/"$PREFIX"_lesion"
    OUTPUTPATH=$PHANTOMPATH"/"$PREFIX"_sum"
    
    rm -rf $OUTPUTPATH
    mkdir $OUTPUTPATH
    
    export -f sum
    
    find $FINDPHANTOMPATH -name *act* | parallel --dryrun --ungroup --progress 'sum {}' $STIR $LESIONPATH $OUTPUTPATH
    find $FINDPHANTOMPATH -name *act* | parallel --ungroup --progress 'sum {}' $STIR $LESIONPATH $OUTPUTPATH
    
    find $FINDPHANTOMPATH -name *atn* | parallel --dryrun --ungroup --progress 'sum {}' $STIR $LESIONPATH $OUTPUTPATH
    find $FINDPHANTOMPATH -name *atn* | parallel --ungroup --progress 'sum {}' $STIR $LESIONPATH $OUTPUTPATH
}

main()
{
    STIR=${1}
    FINDPATH=${2/"./"/$(pwd)"/"}
    
    export -f phantom_directory
    export -f sum
    
    find $FINDPATH -name *phantom | parallel --dryrun --ungroup --progress 'phantom_directory {}' $STIR
    find $FINDPATH -name *phantom | parallel --ungroup --progress 'phantom_directory {}' $STIR
    
    exit 0
}

#start
main "$@"
