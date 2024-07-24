## ATAC-seq Data Analysis Pipeline with Snakemake

### Overview
This pipeline is designed for the analysis of ATAC-seq (Assay for Transposase-Accessible Chromatin using sequencing) data. It automates the process from raw data processing to the identification of accessible chromatin regions, peak calling, and downstream analysis. Built with Snakemake, this pipeline ensures reproducibility and scalability, accommodating datasets ranging from a few samples to large-scale projects.

This pipeline was created to facilitate learning using data from the ENCODE database, specifically dataset ID [ENCSR956DNB](https://www.encodeproject.org/experiments/ENCSR956DNB/).

### Features
- **Quality Control**: Utilizes tools like FastQC and MultiQC for quality assessment of raw sequencing data.
- **Alignment**: Aligns reads to the reference genome using Bowtie2 or BWA.
- **Peak Calling**: Identifies regions of increased accessibility using MACS2.
- **Visualization**: Visualization of Peaks and alignement using IGV.

### Installation

#### Prerequisites
- Conda/Miniconda (recommended for managing environments)
- Snakemake
- Python 3.x
- Singularity (for containerized tool usage) 

#### Setting Up the Environment
1. **Install Miniconda (if not already installed):**
   - Follow the [Miniconda Installation Guide](https://docs.conda.io/en/latest/miniconda.html).

2. **Clone this repository:**
   ```sh
   git clone https://github.com/yourusername/atac-seq-pipeline.git
   cd atac-seq-pipeline
   ```

### Configuration
The pipeline is configured using a `config.yaml` file. Here is the provided example configuration:
```yaml
fastqc_dir: "/home/ubuntu/ATAC-seq-peak-calling/Results/fastqc"
multiqc_dir: "/home/ubuntu/ATAC-seq-peak-calling/Results/multiqc"
trim_dir: "/home/ubuntu/ATAC-seq-peak-calling/Results/trim_reads"
samples:
  sample1:
    pair1: "ENCFF370VYU.fastq.gz"
    pair2: "ENCFF272LNY.fastq.gz"
```

### Snakemake Workflow
The main Snakemake workflow is divided into several rules for different stages of the analysis. The key Snakefiles include:

- `data_download_QC`: Handles data download and quality control.
- `trim_and_filter`: Trims and filters raw reads.
- `alignment_and_filter_alignment`: Aligns reads to the reference genome and filters alignments.
- `peak-calling`: Performs peak calling using MACS2.

### Running the Pipeline
To run the pipeline, execute the following command:
```sh
snakemake --use-singularity --cores <number_of_cores> -snakefile <files_mentions_in_workflow>
```
#### Note
Replace <number_of_cores> with the number of CPU cores you wish to allocate. Also, make sure to run the command from the directory containing the Snakefile or provide the full path to the Snakefile's directory.

### Output
The pipeline generates several output directories as specified in the `config.yaml` file:
- `qc/`: Quality control reports from FastQC and MultiQC are stored in the directory specified by `fastqc_dir` and `multiqc_dir`.
- `alignment/`: Aligned reads in BAM format are stored in the directory specified by `align_dir`.
- `peaks/`: Peak calling results from MACS2 are stored in the directory specified by `peak_dir`.
- `trim_reads/`: Trimmed reads are stored in the directory specified by `trim_dir`.
- `filter_align_reads/`: Filtered aligned reads are stored in the directory specified by `filter_dir`.

### Visuslization 
![image](https://github.com/user-attachments/assets/04716a2d-484a-48c0-9872-154ca7971427)


### Contribution
Contributions are welcome! Please submit a pull request or open an issue to discuss changes.

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```
