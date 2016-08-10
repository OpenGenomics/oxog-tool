cwlVersion: cwl:draft-3
class: CommandLineTool
baseCommand: [/bin/bash, /cga/fh/pcawg_pipeline/pipelines/run_oxog_new.bash]

hints:
  - class: DockerRequirement
    dockerPull: oxog:june2016

requirements:
  - class: InlineJavascriptRequirement

arguments:
   - valueFrom: $(runtime.tmpdir)
     position: 4
   - valueFrom: $(runtime.outdir)
     position: 5
   

inputs:
  - id: individual_id
    type: string
    inputBinding:
      position: 1
  - id: tumor_bam
    type: File
    inputBinding:
      position: 2
    secondaryFiles:
      - .bai
  - id: refdata
    type: File
    inputBinding:
      position: 3
  - id: oxoq_score
    type: float
    inputBinding:
      position: 6
  - id: vcfs
    type: { type: array, items: File }
    inputBinding:
      position: 7

outputs:
  - id: outtar
    type: File
    outputBinding:
      glob: $(inputs.individual_id + ".oxoG.tar.gz")
  - id: vcfs
    type: { type: array, items: File }
    outputBinding:
      glob: "*.vcf.gz"
  - id: callstats
    type: File
    outputBinding:
      glob: "*.call_stats.txt"
  - id: figures
    type: { type: array, items: File }
    outputBinding:
      glob: "*.png"

