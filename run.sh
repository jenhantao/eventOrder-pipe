# Figures out the order of events given Homer peak files. 

### inputs ###
### options and arguments ###
# -p <#> (p value threshold for filtering peaks for each family member, default=0.05 (lower tail))
# -m <#> (distance used for merging peaks, default=100)
# -f <#> (percentile threshold for selecting family members of interest)
# -o <newDir> (output directory, default=~/output)
# -v (produce extra visualizations)
# after options, list all peak files of interest
### ###

#! /bin/bash

# set default options
peakDirPath=$1 # path to directory containing input peak files
mergeDistance=0 # distance used to overlap peaks; an overlap distance file will be created if you want to customize this distance for each peak file
outputDir=~/output # path to output directory; will be created if it doesn't exist
visual=false

# parse the input
OPTIND=1
while getopts "p:m:f:o:v" option ; do # set $o to the next passed option
        case "$option" in  
        m)  
                mergeDistance=$OPTARG
        ;;  
        o)  
                outputDir=$OPTARG
        ;;  
        v)  
                visual=true
        ;;  
        esac
done

# create overlap distance file


# merge peaks using Homer


# create transition matrix


# create visualizations
# maybe graphviz to show markov chain?


# run simulations with transition matrix to determine most likely order of events


