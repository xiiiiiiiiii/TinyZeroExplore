export N_GPUS=1
export CUDA_VISIBLE_DEVICES=0

ray stop --force && ray start --head --num-gpus=2 --port=6379

export BASE_MODEL=Qwen/Qwen2.5-1.5B
export DATA_DIR=data/countdown
export ROLLOUT_TP_SIZE=1
export EXPERIMENT_NAME=countdown-qwen2.5-1.5b
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero_a100_ppo.sh
