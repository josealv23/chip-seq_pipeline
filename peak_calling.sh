#$ -S /bin/bash
#$ -cwd
#$ -j yes
#$ -V

############################
### Parameters and input ###
############################

RES=$1
ANNO=$2
WD=$3
MAIN_FOLDER=$4
INS=$5


####################
### Peak calling ###
####################

# MACS2

cd $MAIN_FOLDER/results
macs2 callpeak -t ../samples/chip/chip.sam -c ../samples/input/input.sam -f SAM --outdir . -n peak

# PeakAnnotator

java -jar $INS/PeakAnnotator.jar -u NDG -g all -p peak_summits.bed -a $ANNO -o .

# Run R scriptn R

Rscript --vanilla $INS/target_genes.R peak_summits.overlap.bed peak_summits.ndg.bed peak_target_genes.txt
