#!/bin/bash

for seed in 42 40 44
do
#python -m torch.distributed.launch \
#        --nproc_per_node=1 \
#        --master_port='29501' \
#        --use_env main.py \
#        cifar100_hideprompt_5e \
#        --model vit_base_patch16_224_dino \
#        --original_model vit_base_patch16_224_dino \
#        --batch-size 24 \
#        --epochs 20 \
#        --data-path /scratch/a_parashar.iitr/RCSPrompt/datasets/  \
#        --lr 0.0005 \
#        --ca_lr 0.005 \
#        --crct_epochs 30 \
#        --seed $seed \
#        --train_inference_task_only \
#        --output_dir ./output/cifar100_dino_multi_centroid_mlp_2_seed$seed

python -m torch.distributed.launch \
        --nproc_per_node=1 \
        --master_port='29506' \
        --use_env main.py \
        cifar100_hideprompt_5e \
        --model vit_base_patch16_224_dino \
        --original_model vit_base_patch16_224_dino \
        --batch-size 24 \
        --epochs 20 \
        --data-path /scratch/a_parashar.iitr/RCSPrompt/datasets/  \
        --ca_lr 0.005 \
        --crct_epochs 30 \
        --seed $seed \
        --prompt_momentum 0.1 \
        --reg 0.1 \
        --length 5 \
        --trained_original_model ./output/cifar100_dino_multi_centroid_mlp_2_seed$seed \
        --larger_prompt_lr \
        --output_dir ./output/cifar100_dino_pe_seed$seed
done
