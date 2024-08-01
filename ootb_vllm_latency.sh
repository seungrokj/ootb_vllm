#!/usr/bin/bash

#Usage: 

while getopts m:g:d: flag
do
    case "${flag}" in
        m) model=${OPTARG};;
        g) numgpu=${OPTARG};;
        d) datatype=${OPTARG};;
    esac
done
echo "MODEL: $model ";

export HIP_FORCE_DEV_KERNARG=1
export VLLM_USE_TRITON_FLASH_ATTN=0
export VLLM_USE_ROCM_CUSTOM_PAGED_ATTN=1

MODEL_NAME=$model
if [[ "$MODEL_NAME" == *"llama3_8b"* ]]; then
    MODEL_ID="NousResearch/Meta-Llama-3-8B"
fi

dtype=$datatype
TP=$numgpu

BATCH_SIZE_SP="8 32"
PROMPT_LEN_SP="128 2048"
NEW_TOKENS_SP=128
REPORT_DIR="reports_${dtype}"
TOOL="/app/vllm/benchmarks/benchmark_latency.py"

mkdir -p $REPORT_DIR

for bat in $BATCH_SIZE_SP;
do
    for inp in $PROMPT_LEN_SP;
    do
        for out in $NEW_TOKENS_SP;
        do
           echo "[INFO] LATENCY"
           if [ $TP -eq 1 ]; then
           echo $MODEL_NAME $bat $TP $inp $out
           python3 $TOOL --model $MODEL_NAME --batch-size $bat -tp $TP --input-len $inp --output-len $out --num-iters-warmup 5 --num-iters 5 --trust-remote-code --dtype $dtype --enforce-eager --csv ${REPORT_DIR}/${MODEL_NAME}_latency_${dtype}.csv
           else
           echo $MODEL_NAME $bat $TP $inp $out
           torchrun --standalone --nnodes 1 --nproc-per-node $TP $TOOL --model $MODEL_NAME --batch-size $bat -tp $TP --input-len $inp --output-len $out --num-iters-warmup 5 --num-iters 5 --trust-remote-code --dtype $dtype --csv ${REPORT_DIR}/${MODEL_NAME}_latency_${dtype}..csv
           fi
        done
    done
done
