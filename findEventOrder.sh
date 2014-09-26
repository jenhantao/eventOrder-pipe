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
mergeDistance=0 # distance used to overlap peaks; an overlap distance file will be created if you want to customize this distance for each peak file
outputDir=~/output # path to output directory; will be created if it doesn't exist
visual=false

# parse the input
OPTIND=1
while getopts "m:o:v" option ; do # set $o to the next passed option
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

echo "Beginning to filter peaks with the following options"
echo "### ###"
echo "merge distance: $mergeDistance"
echo "outputDir: $outputDir"
echo "visual: $visual"
echo "### ###"

shift $(($OPTIND - 1))
inputDir=$1 # path to directory with peak files

# if the root output directory doesn't exist, create it
if [ ! -d $outputDir ]
then
        echo "creating output directory"
        mkdir $outputDir
fi


declare -A factorNameMapping # dictionary for creating factor name mapping

for dir in $inputDir/*/
do
	outDir="$outputDir/$(basename $dir)"
	if [ ! -d $outDir ]
	then
		echo "creating output directory"
		mkdir $outDir
	fi

	# extend peaks for merging
	echo "extending peaks"
	for path in $dir/*_peaks.tsv
	do
		basePath=$(basename $path)
		basePath=${basePath%_peaks.tsv}
		factorNameMapping["$basePath"]=$basePath

		# iterate through each peak file and modify the start and the end
		outPath=$path
		outPath=${outPath%_peaks.tsv}
		outPath=${outPath##*/}_ext.tsv
		echo "python extendPeaks.py $path ${outDir}/${outPath} $mergeDistance"
		python ~/code/ap1_pipe/extendPeaks.py $path ${outDir}/${outPath} $mergeDistance
	done

	# merge peaks using Homer
	echo "calculating initial merged regions"

	# create group summary files

done

# if factor nameMapping doesn't exist, create it
if [ ! -f $outputDir/factorNameMapping.tsv ]
then
	counter=1
	touch $outputDir/factorNameMapping.tsv
fi
for key in "${!factorNameMapping[@]}"
do
	echo -e "$key\t${factorNameMapping[$key]}" >> $outputDir/factorNameMapping.tsv
done


# create transition matrices


# cluster transition matrices


# run simulations



# create visualizations
# maybe graphviz to show markov chain?
# heatmap for visualizing transition matrix; label with rounded values http://stackoverflow.com/questions/25071968/heatmap-with-text-in-each-cell-with-matplotlibs-pyplot



# run simulations with transition matrix to determine most likely order of events


