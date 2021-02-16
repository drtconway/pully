# pully - a utility for in silico pulldowns

`pully` is a utility for performing a simple *in silico* pulldown
of paired sequence reads. A typical use case is processing a full
set of paired end reads to capture those pairs that come from a
certain region.

## Quick start

Pully is supplied with a Docker image making it easy to run:

```
$ docker run -it -v ${PWD}:/data dockanomics/pully:latest bash
root@3e8b0080f33f:/data# pully exons --regions chr22 --sample 0.01 -o few.fasta GRCh38.primary_assembly.genome.fa gencode.v35.primary_assembly.annotation.gtf
root@3e8b0080f33f:/data# pully filter -e 0.3 -c 5 -g GRCh38.primary_assembly.genome.fa -o few-filtered.fasta few.fasta
root@3e8b0080f33f:/data# pully read-pairs few-filtered.fasta x_ SRR13319535_{1,2}.fastq.gz
```
