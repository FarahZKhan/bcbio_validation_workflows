arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=batch-parallel
- sentinel_outputs=vrn_file_region,region
- sentinel_inputs=batch_rec:record,region:var
baseCommand:
- bcbio_nextgen.py
- runfn
- variantcall_batch_region
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-vc
  dockerPull: quay.io/bcbio/bcbio-vc
- class: ResourceRequirement
  coresMin: 1
  outdirMin: 1024
  ramMin: 3072
- class: SoftwareRequirement
  packages:
  - package: bcftools
    specs:
    - https://anaconda.org/bioconda/bcftools
  - package: bedtools
    specs:
    - https://anaconda.org/bioconda/bedtools
  - package: freebayes
    specs:
    - https://anaconda.org/bioconda/freebayes
    version:
    - 1.1.0
  - package: gatk
    specs:
    - https://anaconda.org/bioconda/gatk
  - package: gatk4
    specs:
    - https://anaconda.org/bioconda/gatk4
  - package: gatk-framework
    specs:
    - https://anaconda.org/bioconda/gatk-framework
  - package: htslib
    specs:
    - https://anaconda.org/bioconda/htslib
  - package: picard
    specs:
    - https://anaconda.org/bioconda/picard
  - package: platypus-variant
    specs:
    - https://anaconda.org/bioconda/platypus-variant
  - package: pythonpy
    specs:
    - https://anaconda.org/bioconda/pythonpy
  - package: samtools
    specs:
    - https://anaconda.org/bioconda/samtools
  - package: vardict
    specs:
    - https://anaconda.org/bioconda/vardict
  - package: vardict-java
    specs:
    - https://anaconda.org/bioconda/vardict-java
  - package: varscan
    specs:
    - https://anaconda.org/bioconda/varscan
  - package: vcfanno
    specs:
    - https://anaconda.org/bioconda/vcfanno
  - package: vcflib
    specs:
    - https://anaconda.org/bioconda/vcflib
  - package: vt
    specs:
    - https://anaconda.org/bioconda/vt
  - package: r
    specs:
    - https://anaconda.org/bioconda/r
    version:
    - 3.2.2
  - package: perl
    specs:
    - https://anaconda.org/bioconda/perl
inputs:
- id: batch_rec
  type:
    items:
      fields:
      - name: description
        type: string
      - name: config__algorithm__validate
        type: File
      - name: reference__fasta__base
        type: File
      - name: config__algorithm__variantcaller
        type: string
      - name: config__algorithm__coverage_interval
        type: string
      - name: metadata__batch
        type: 'null'
      - name: config__algorithm__validate_regions
        type: File
      - name: genome_build
        type: string
      - name: metadata__phenotype
        type: string
      - name: config__algorithm__tools_off
        type:
          items: string
          type: array
      - name: genome_resources__variation__dbsnp
        type: File
      - name: genome_resources__variation__cosmic
        type: 'null'
      - name: reference__genome_context
        type:
          items: File
          type: array
      - name: analysis
        type: string
      - name: config__algorithm__tools_on
        type:
          items: string
          type: array
      - name: config__algorithm__variant_regions
        type: File
      - name: reference__rtg
        type: File
      - name: align_bam
        type: File
      - name: regions__sample_callable
        type: File
      - name: config__algorithm__callable_regions
        type: File
      name: batch_rec
      type: record
    type: array
- id: region_toolinput
  type: string
outputs:
- id: vrn_file_region
  secondaryFiles:
  - .tbi
  type: File
- id: region
  type: string
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
