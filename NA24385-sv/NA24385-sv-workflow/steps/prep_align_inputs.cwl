$namespaces:
  dx: https://www.dnanexus.com/cwl#
arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=single-single
- sentinel_outputs=process_alignment_rec:files;config__algorithm__quality_format;align_split
- sentinel_inputs=alignment_rec:record
baseCommand:
- bcbio_nextgen.py
- runfn
- prep_align_inputs
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-vc
  dockerPull: quay.io/bcbio/bcbio-vc
- class: ResourceRequirement
  coresMin: 8
  outdirMin: 20957
  ramMin: 30720
  tmpdirMin: 9967
- class: dx:InputResourceRequirement
  indirMin: 16297
- class: SoftwareRequirement
  packages:
  - package: grabix
    specs:
    - https://anaconda.org/bioconda/grabix
  - package: htslib
    specs:
    - https://anaconda.org/bioconda/htslib
  - package: biobambam
    specs:
    - https://anaconda.org/bioconda/biobambam
  - package: atropos;env
    specs:
    - https://anaconda.org/bioconda/atropos;env
    version:
    - python3
inputs:
- id: alignment_rec
  type:
    fields:
    - name: resources
      type: string
    - name: description
      type: string
    - name: config__algorithm__align_split_size
      type:
      - string
      - 'null'
      - boolean
    - name: files
      type:
        items: File
        type: array
    - name: config__algorithm__trim_reads
      type:
      - string
      - 'null'
      - boolean
    - name: reference__fasta__base
      type: File
    - name: config__algorithm__adapters
      type:
      - 'null'
      - string
      - items:
        - 'null'
        - string
        type: array
    - name: rgnames__lb
      type:
      - 'null'
      - string
    - name: rgnames__rg
      type: string
    - name: rgnames__lane
      type: string
    - name: config__algorithm__bam_clean
      type:
      - string
      - 'null'
      - boolean
    - name: config__algorithm__aligner
      type: string
    - name: reference__minimap2__indexes
      type:
      - 'null'
      - string
      - items:
        - 'null'
        - string
        type: array
    - name: rgnames__pl
      type: string
    - name: rgnames__pu
      type: string
    - name: config__algorithm__mark_duplicates
      type:
      - string
      - 'null'
      - boolean
    - name: analysis
      type: string
    - name: rgnames__sample
      type: string
    name: alignment_rec
    type: record
outputs:
- id: process_alignment_rec
  type:
    fields:
    - name: files
      type:
      - 'null'
      - items: File
        type: array
    - name: config__algorithm__quality_format
      type:
      - string
      - 'null'
    - name: align_split
      type:
      - string
      - 'null'
    name: process_alignment_rec
    type: record
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
