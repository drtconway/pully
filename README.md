# pully - a utility for in silico pulldowns

`pully` is a utility for performing a simple *in silico* pulldown
of paired sequence reads. A typical use case is processing a full
set of paired end reads to capture those pairs that come from a
certain region.

## Quick start

Pully is supplied with a Docker image making it easy to run:

```
$ docker run -it -v ${PWD}:/data dockanomics/pully:latest bash
root@3e8b0080f33f:/# cd data
root@3e8b0080f33f:/data# pully exons --regions chr22 --sample 0.01 -o few.fasta GRCh38.primary_assembly.genome.fa gencode.v35.primary_assembly.annotation.gtf
root@3e8b0080f33f:/data# pully filter -e 0.3 -c 5 -g GRCh38.primary_assembly.genome.fa -o few-filtered.fasta few.fasta
root@3e8b0080f33f:/data# pully read-pairs few-filtered.fasta x_ SRR13319535_{1,2}.fastq.gz
```

* The first command creates a FASTA file with exons from chromosome
  22, sampled to include just 1% of transcripts using the GRCh38
  (aka hg38) reference genome, and the Gencode (v35) annotation file,
  writing the output to `few.fasta`.

* The second command masks the FASTA file we created in the first
  step by k-merizing the sequences (with the default value of K=25)
  and masking low entropy k-mers (with < 0.3 bits/base), along
  with k-mers that occur more than 5 times across the reference
  genome. The masking process replaces the original bases with
  `N`s, so they will be ignored in the subsequent pulldown of
  read pairs. This file is written out to `few-filtered.fasta`.

* The final command does the actual pulldown, using the FASTA
  file from the previous step as bait sequences. The bait sequences
  are k-merized (again with the default value of K=25), and
  any read pairs that share at least 1 k-mer in common with the
  bait sequences are written out to the files `x_1.fastq` and
  `x_2.fastq`. The default suffix `.fastq` has been used, but
  this can be overridden. For example, adding the option
  `--suffix .fastq.gz` will cause the reads to be compressed,
  though this does run more slowly, because pully runs in
  single thread.
