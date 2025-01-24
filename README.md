# TinyZero
![image](cover.png)
This is a fork of veRL for reimplmenting [DeepSeek R1 Zero](https://github.com/deepseek-ai/DeepSeek-R1). You can refer to [original verl readme](OLD_README.md) for detailed information of veRL.

Twitter thread: https://x.com/jiayi_pirate/status/1882839370505621655

Full experiment log: https://wandb.ai/jiayipan/TinyZero

## Instalation
```
conda create -n zero python=3.9

pip install -r requirements.txt
pip install -e .

# quality of life
pip install IPython matplotlib
```

## Countdown task

### Run Training
```
conda activate zero
```

**Data Preparation**
```
python ./examples/data_preprocess/countdown.py --local_dir {path_to_your_dataset}
```

**Single GPU**
Works for model <= 1.5B. For Qwen2.5-0.5B base, we know it fails to learn reasoning.

```
export N_GPUS=1
export BASE_MODEL={path_to_your_model}
export DATA_DIR={path_to_your_dataset}
export EXPERIMENT_NAME=countdown-qwen2.5-0.5b
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero.sh
```

**3B model**
In this case, the base model is able to develop sophisticated reasoning skills.
```
export N_GPUS=2
export BASE_MODEL={path_to_your_model}
export DATA_DIR={path_to_your_dataset}
export ROLLOUT_TP_SIZE=2
export EXPERIMENT_NAME=countdown-qwen2.5-3b
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero.sh
```

**OpenLlama 7B model**
```
export N_GPUS=4
export EXPERIMENT_NAME=countdown-open_llama_7b
export BASE_MODEL={path_to_your_model}
export DATA_DIR={path_to_your_dataset}
export ROLLOUT_TP_SIZE=4
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero.sh
```

### Instruct Abaltion
We experiment with QWen-2.5-3B Instruct too.
**Data Preparation**
To follow chat template, we need to reprocess the data:
```
conda activate zero
python examples/data_preprocess/countdown.py --template_type=qwen-instruct --local_dir={path_to_your_dataset}
```

**Training**
```
export N_GPUS=2
export BASE_MODEL={path_to_your_model}
export DATA_DIR={path_to_your_dataset}
export ROLLOUT_TP_SIZE=2
export EXPERIMENT_NAME=countdown-qwen2.5-3b-instruct
export VLLM_ATTENTION_BACKEND=XFORMERS

bash ./scripts/train_tiny_zero.sh
```

## Acknowledge
* We run our experiments based on [veRL](https://github.com/volcengine/verl).
* We use Qwen2.5 series base model [Qwen2.5](https://github.com/QwenLM/Qwen2.5).
