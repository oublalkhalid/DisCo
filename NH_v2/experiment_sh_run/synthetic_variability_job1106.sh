#!/bin/bash -l
#####################
# job-array example #
#####################
#SBATCH --output=/tsi/data_education/Ladjal/koublal/experiences/Multimodels/Multimodal_nlayer_4_all%j.out
#SBATCH --error=/tsi/data_education/Ladjal/koublal/experiences/Multimodels/Multimodal_nlayer_4_all%j.err
#SBATCH --job-name=HVAE
#SBATCH --time=1-00:00:00
#SBATCH --gpus=1 # nombre de GPU réservés par nœud (ici 8 soit tous les GPU)
#SBATCH --nodes=1 # nombre total de nœuds (N à définir)
#SBATCH --mem=256G
#SBATCH --partition=A100
#SBATCH --cpus-per-task=21 # nombre de cœurs par tache (donc 8x3 = 24 cœurs soit tous les cœurs)
export TF_ENABLE_ONEDNN_OPTS=0
export CUDA_LAUNCH_BLOCKING=1
#set -x
cd /tsi/data_education/Ladjal/koublal/open-source/NH_v2/
find . | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf
# # Please @rasim use srun in ids cluster to avoid swap issues (here python just to test)
python main.py \
--root_path /tsi/data_education/Ladjal/koublal/open-source/NH_v2 \
--data_option 'Synthetic_Variability' \
--data_path /tsi/data_education/Ladjal/koublal/open-source/IDNet/DATA/synth_DC2/alldata_ex_DC2.mat \
--data_path_extract /tsi/data_education/Ladjal/koublal/open-source/IDNet/DATA/synth_DC2/extracted_bundles.mat \
--percentage 0.05 \
--input_dim 1 \
--endmembers_dim 5 \
--abundance_dim 5 \
--channels 162 \
--hidden_size 32 \
--embedding_dimension 128 \
--diff_steps 100 \
--dropout_rate 0.1 \
--beta_schedule 'linear' \
--beta_start 0.0 \
--beta_end 0.1 \
--alpha_min 0.4 \
--dir_prior 0.3 \
--n_componenet 3 \
--use_gpu True \
--batch_size 32 \
--without_diffusion True \
--train_epochs 100 \
--patience 100
#--debuglogger True \
#### HERE OTHER PARAMS TO CHECK
# python main.py \
# --root_path /tsi/data_education/Ladjal/koublal/open-source/NH_v2 \
# --data_path /tsi/data_education/Ladjal/koublal/open-source/NH_v2/data_load/ETTh1.csv \
# --data_option 'Synthetic_Variability' \
# --checkpoints './checkpoints/' \
# --arch_instance 'res_mbconv' \
# --channels 162 \
# --channels 162 \
# --percentage 0.02 \
# --endmembers_dim 5 \
# --input_dim 1 \
# --hidden_size 32 \
# --embedding_dimension 128 \
# --diff_steps 2 \
# --dropout_rate 0.1 \
# --beta_schedule 'linear' \
# --beta_start 0.0 \
# --beta_end 0.01 \
# --scale 0.1 \
# --psi 0.5 \
# --lambda1 1.0 \
# --gamma 0.01 \
# --mult 1 \
# --num_layers 2 \
# --num_channels_enc 32 \
# --channel_mult 2 \
# --num_preprocess_blocks 1 \
# --num_preprocess_cells 3 \
# --groups_per_scale 2 \
# --num_postprocess_blocks 1 \
# --num_postprocess_cells 2 \
# --num_channels_dec 32 \
# --num_latent_per_group 8 \
# --res_dist False \
# --without_diffusion True \
# --num_workers 0 \
# --patience 10 \
# --itr 1 \
# --dim -1 \
# 
# --batch_size 256 \
# --learning_rate 0.001 \
# --weight_decay 0.0200 \
# --loss_type 'kl' \
# --use_gpu True \
# --gpu 0 \
# --devices '0'
# #--use_multi_gpu \
