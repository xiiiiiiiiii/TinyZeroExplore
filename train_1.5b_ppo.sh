#!/bin/bash
# alias python='/home/weiji/anaconda3/envs/zero/bin/python'
# alias python3='/home/weiji/anaconda3/envs/zero/bin/python3'
# alias pip='/home/weiji/anaconda3/envs/zero/bin/pip'

ray stop --force && ray start --head --num-gpus=1 --port=6379

# On worker node.
# ray stop --force && ray start --num-gpus=1 --address='[driver_ip]:6379' --block
# ray stop --force && ray start --num-gpus=1 --address='10.19.17.144:6379' --block

export RAY_ADDRESS=10.19.17.144:6379
export N_GPUS=2
export CUDA_VISIBLE_DEVICES=2,3
export BASE_MODEL=model/Qwen2.5-1.5B
export DATA_DIR=data/countdown
export ROLLOUT_TP_SIZE=2
export EXPERIMENT_NAME=countdown-qwen2.5-1.5b
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero_a100_ppo.sh