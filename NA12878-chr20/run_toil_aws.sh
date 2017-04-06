#!/bin/bash
# Run Toil on AWS with autoscaling
set -eu -o pipefail

PROJECT=NA12878-platinum-chr20
LEADER_PRIVATE_IP=10.0.0.XX
JOB_STORE=aws:us-east-1:bcbio-NA12878-chr20-jobstore
NODE_TYPE=m4.4xlarge
SPOT_BID=0.8
MAX_NODES=2

cwltoil \
  --batchSystem=mesos --mesosMaster=$LEADER_PRIVATE_IP:5050 \
  --provisioner aws \
  --defaultPreemptable  --preemptableNodeType $NODE_TYPE:$SPOT_BID --maxPreemptableNodes $MAX_NODES \
  --nodeType $NODE_TYPE --maxNodes $MAX_NODES \
  --jobStore $JOB_STORE \
  $PROJECT-workflow/main-$PROJECT.cwl \
  $PROJECT-cwl-workflow/main-$PROJECT-samples.json
  
