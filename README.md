# **ChipSeq pipeline**

## **Description**
ChIP-seq is a method used to analyze protein interactions with DNA. ChIP-seq combines chromatin immunoprecipitation (ChIP) with DNA sequencing (seq) to infer the possible binding sites of DNA-associated proteins.

This pipeline takes as entry a genome, two samples - chip (study group) and input (control group) - and a series of parameters, and returns a list of targetted genes in '.txt' format, as well as a chart with peaks in '.xls' and four '.bed' files.

## **Installation and dependencies**

1. Clone or download the repository. To download specific parts, you can get into your console and download using `wget <link url>`
2. For the file.zip files, use `unzip <file.zip>`
3. For a proper usage of this pipeline, you will need to install some dependencies (see section below).
4. Once you've installed all the dependencies below, you can jump to the example section if you want to perform an example with the data set providen.

### **You will need to install:**

- [Bowtie](https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.2.2) - Bowtie is an ultrafast, memory-efficient short read aligner. It aligns short DNA sequences (reads) to the human genome at a rate of over 25 million 35-bp reads per hour. Bowtie indexes the genome with an FM index to keep its memory footprint small: typically about 2.2 GB for the human genome (2.9 GB for paired-end).

- [Macs](https://github.com/taoliu/MACS) - MACS, or Model-based Analysis of ChIP-Seq, is used for capturing the enriched regions of sequence reads. It takes the influence of genome complexity into consideration, and improves the spatial resolution of binding sites through combining the information of both sequencing tag position and orientation.

- [PeakAnnotator](https://www.ebi.ac.uk/research/bertone/software) - Assist in annotation of genome-wide signal enrichment peaks derived from experimental results. PeakAnnotator couples a modified version of the nested containment list (NCList) algorithm to a binary search for determining functional elements proximal to peak loci. It integrates three subroutines: Nearest Downstream Gene (NDG), Transcription Start Site (TSS) and Overlap Data Sets (ODS). The software is a part of the PeakAnalyzer software.

- [R and Rscript](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html) - R is an open source free software environment for statistical computing and graphics. Rscript is the R package that is offered for scripting front-end for R, to be used in #! scripts and other scripting applications.

- [SGE](http://genomics.princeton.edu/support/grids/sge.shtml) - SGE, Sun Grid Engine, is an open source distributed computing management system. It is through SGE commands that jobs are submitted, monitored, deleted, and otherwise managed. In order for SGE to work properly, the SGE_ROOT environment variable must be set appropriately for the cluster you are using.

#### Additional preanalysis

Additionally, we recommend you to ensure your samples have enough quality before submitting a job with this pipeline. This step is not mandatory, but we highly encourage you to run an analysis of your samples using software like FastQC:

- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) - FastQC gives general quality metrics about your reads. It provides information about the quality score distribution across your reads, the per base sequence content (%T/A/G/C). You get information about adapter contamination and other overrepresented sequences.

## **Usage**

We recommend using BASH to run this pipeline.

`bash <chipseq_pipeline> <params.txt>`

The following is a list of files provided with your ChIP-Seq analysis using this pipeline - once you used the raw unprocessed gzipped FASTQ files:

- Mapped SAM files
- MACS2 generated analysis output files
- Peak annotations


## **Params:**

The 'params.txt' file is the only parameter the chipseq-pipeline main script takes, and it contains key information for the good performance of the process. It should look like this:

```
working_directory: <location where the main folder is going to be created> 
main_folder:  <main folder name>
genome_folder: <location of the fasta file containing the genome>
annotation_folder: <location of the '.gtf' file containing the genome annotation>
installation_folder: <location of the chipseq pipeline main script and the rest of scripts>
chip_location: <location of the fastq file - chip sample (study sample)>
input_location: <location of the fastq file - input sample (control sample)>
```

## **Example**

We have provided an example data set with this pipeline. The example tools can be found in the example_data folder. In there, there's:

- A formatted file params.txt named example_params.txt
- A subfolder named prr5_samples, containing:
  - Annotation genome, zipped in the annotation folder. The file format is .gtf
  - Genome, zipped in the genome folder. The file format is .fa
  - Samples folder, containing chip and input samples, zipped in their respective folders. Those file format is .fq
  
At this point, there are 2 options:

- Personalize the example_params.txt so that it fits your needs.
- Extract all the files in the following route: `/home/<user>/chipseq_pipeline/`. Move the example_params.txt document from the example_data folder to the route mentioned before. Move the prr5_samples folder to `/home/<user>/` so that you can access `/home/<user>/prr5_samples`. Once you've done this, open example_params.txt with a text editor and replace the tag <user> with your username. Finally, go to the route where the scripts area and run:

`bash chipseq_pipeline example_params.txt`

A folder called temp will be used (`/home/<user>/temp`), so **ensure you have previously created that folder**. Your results will be located into /home/<user>/temp/prr5_samples/results.
