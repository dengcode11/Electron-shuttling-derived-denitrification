Dengm 2024-Extracellular electron transfer derived denitrification in lake
1. Scripts for bioinformatics analysis
2. Data for plotting Figures 1-4 and Figure 6. All the figures are created by Graphpad Prism 9.0.0 and Adobe illustrator CC 6
3. Sequences for phylogenetic trees of nosZ

# 1.1 The contributions of different environmental factors to denitrification potential

## Installation

R        (v4.0.4) (https://www.r-project.org/) 

R-studio (v2023.09.0+463)   (https://posit.co/products/open-source/rstudio/) # IDE for R

### Required packages
MASS     (v7.3-56) 

lmtest   (v0.9-40)

car      (v3.1-3)

ggplot2  (v3.5.1)

### Usage
For detailed guidance and functional comments on the code, please refer to the file named "Multiple Linear regression Model.R", where we have added detailed comments to each line of code.

### Main procedures for analysis
1. Data Preparation
2. Model Selection using AIC
3. Model Evaluation
4. Model Comparison
5. Variable Importance Analysis


# 1.2 16S Analysis Project

## Installation

This project uses Conda for package management. 
Please ensure you have Miniconda or Anaconda installed on your system.

## Installing Miniconda

### Download and install Miniconda:
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

### Initialize Conda:
After installation, close and reopen your terminal to initialize Conda.
Alternatively, you can initialize it manually by running:
```bash
source ~/.bashrc
```

## Creating a Conda Environment
### Create a new Conda environment (optional but recommended):
```bash
conda create -n my_16s_env python=3.8
```

### Activate the Conda environment:
```bash
conda activate my_16s_env
```

## Required Packages
For the installation method, please refer to the following URL.
```bash
qiime2 (v2024.5) (https://amplicon-docs.qiime2.org/)
```

#### Additional Notes
 QIIME 2: The core QIIME 2 framework.
 q2-dada2: For denoising paired-end sequences.
 q2-feature-classifier: For taxonomic classification.
 biom-format: For converting BIOM format files.

## Usage
For detailed guidance and functional comments on the code, please refer to the file named "16S_analysis.txt", where we have added detailed comments to each line of code.

### Main procedures for analysis
 1. Import the sequence data
 2. Perform paired-end sequence denoising
 3. Export the QIIME artifact file
 4. Convert the BIOM format feature table:
 5. Perform taxonomic classification:
 6. Export the QIIME artifact file:

#### Notes 
Ensure that all input files (e.g., manifest.txt, paired-end-demux.qza, rep-seqs-dn.qza, silva-138-99-nb-classifier.qza) are correctly placed in the specified directories.

Adjust the paths in the commands as needed based on your project structure. 


# 1.3 Metagenomic Analysis Project

## Required Packages
For the installation method, please refer to the following URL.

fastp (v0.23.4) (https://github.com/OpenGene/fastp)

MEGAHIT (v1.2.9) (https://github.com/voutcn/megahit)

Bowtie2 (v2.5.1) (https://github.com/BenLangmead/bowtie2)

samtools (v1.19) (https://github.com/samtools/samtools)

MetaBAT2 (v2.15) (https://bitbucket.org/berkeleylab/metabat)

dRep (v3.4.0) (https://github.com/MrOlm/drep)

CheckM (v1.2.2) (https://github.com/Ecogenomics/CheckM)

GTDB-Tk (v2.4.0) (https://github.com/Ecogenomics/GTDBTk)

CoverM (v0.6.1) (https://github.com/wwood/CoverM)

Prodigal (v2.6.3) (https://github.com/hyattpd/Prodigal)

HMMER (v3.4) (https://github.com/EddyRivasLab/hmmer)

bbmap (v39.01) (https://github.com/BioInfoTools/BBMap)

Muscle (v5.1) (https://github.com/rcedgar/muscle)

trimAl (v1.4.1) (https://github.com/inab/trimal)

IQ-TREE (v2.3.1) (https://github.com/iqtree/iqtree2)

METABOLIC (v4.0) (https://github.com/AnantharamanLab/METABOLIC) 


## Usage
After installing the required packages, you can run the metagenomic analysis code as described in the file named "Metagenomic_analysis.txt". For detailed guidance and functional comments on the code, please refer to the file named "Metagenomic_analysis.txt".

### Main procedures for analysis
 1. Quality control
 2. Metagenomic Assembly
 3. Aligning sequencing data to a reference genome
 4. Processing SAM/BAM files
 5. Metagenomic binning
 6. Metagenomic dereplication
 7. Evaluating the quality of metagenomic bins
 8. Metagenomic classification
 9. Calculating genome coverage
 10. Metagenomic functional annotation
 11. Performing gene prediction on contigs
 12. Performing functional search on the predicted protein sequences
 13. Extracting sequences with specific IDs from a nucleic acid sequence file
 14. Build an index for the extracted gene sequence file
 15. Calculate the RPKM values of the alignment results
 16. Phylogenetic tree analysis

#### Notes
 Ensure that all input files (e.g., Rawreads_1.fq.gz, Rawreads_2.fq.gz, final.contigs.fa, Gene.hmm) are correctly placed in the specified directories. 

 Adjust the paths in the commands as needed based on your project structure. 

