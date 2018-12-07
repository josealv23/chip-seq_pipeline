#$ -S /bin/bash
#$ -cwd
#$ -j yes
#$ -V

#############################
### Parameters and inputs ###
#############################

SAMPLE_DIR=$1
SAMPLE_FILE=$2
SAMPLE_TYPE=$3
MAIN_FOLDER=$4
WD=$5
INS=$6


#############################
### Workspace preparation ###
#############################

cd ${SAMPLE_DIR}
cp ${SAMPLE_FILE} ${SAMPLE_TYPE}.fq


#################################################################################
### Sample processing and checking if the rest of samples have been processed ###
#################################################################################

# Sample processing

bowtie -S -v 2 --best --strata -m1 ../../genome/index ${SAMPLE_TYPE}.fq > ${SAMPLE_TYPE}.sam

# Write in the blackboard

echo ${SAMPLE_TYPE} DONE >> ../../log/blackboard

# Check if all samples have been processed - if they have been processed, run peak calling script

SAMPLES_DONE=$(wc -l ../../log/blackboard | awk '{ print $1 }' )

if [ $SAMPLES_DONE -eq 2 ]
then
qsub -N peak_calling -o peak_calling ${INS}/peak_calling.sh ${MAIN_FOLDER}/results ${MAIN_FOLDER}/annotation/annotation.gtf $WD $MAIN_FOLDER $INS
fi
