#!/bin/bash
#SBATCH -N 1
#SBATCH -p gpu
#SBATCH --gres=gpu:a100:4
#SBATCH --ntasks-per-node 128 
#SBATCH --time=01:00:00 
#SBATCH -A isc2023-aac 

DATA_DIR="/scratch/zt1/project/isc2023/shared/"

. /scratch/zt1/project/isc2023/shared/tutorial-venv/bin/activate

INSTALL_PATH="/scratch/zt1/project/isc2023/shared/installations"
export PATH="${PATH}:${INSTALL_PATH}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${INSTALL_PATH}/lib"

## Command for DDP
G_INTER=2
G_DATA=2

mpirun -np 4 python train_axonn_pipeline.py --num-layers 4 --hidden-size 2048 --data-dir ${DATA_DIR} --batch-size 32 --lr 0.001 --image-size 64 --G-inter ${G_INTER} --G-data ${G_DATA} --micro-batch-size 4 --checkpoint-activations
