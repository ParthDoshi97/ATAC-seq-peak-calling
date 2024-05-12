# Snakefile for downloading data and performing quality checks using FastQC

# Rule to Download date from Encode Database
rule download_data:
    input:
        urls="files.txt"
    output:
        "download_complete.txt"
    shell:
        r"""
        mkdir -p DATA
        cat {input.urls} | xargs -n 1 -P 2 -I{{}} sh -c '
            filename=$(basename "{{}}")
            echo "Downloading $filename from {{}}..."
            curl -o "DATA/$filename" -J -L "{{}}" || echo "Failed to download {{}}!" >> download_errors.txt
        '
        touch {output}
        """

# Rule for performing quality control with FastQC
rule fastqc:
    input:
        # Uses wildcards to specify input files for FastQC
        expand("DATA/{filename}", filename=[line.strip().split('/')[-1] for line in open("files.txt").read().strip().split('\n') if line])
    output:
          html=expand("fastqc_reports/{filename}_fastqc.html", filename=[line.strip().split('/')[-1] for line in open("files.txt").read().strip().split('\n')])
    params:
        outdir="fastqc_reports"
    container:
         "doshiparth2219822/bioinformatics-tool:latest"
    shell:
        """
        mkdir -p {params.outdir}
        fastqc {input} --outdir {params.outdir}
        """

# Aggregate rule to ensure all analyses are run
rule all:
    input:
        expand("fastqc_reports/{filename}_fastqc.html", filename=[line.strip().split('/')[-1] for line in open("files.txt").read().strip().split('\n') if line])
