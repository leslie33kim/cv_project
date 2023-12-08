# Copyright (c) Meta Platforms, Inc. and affiliates.
DATA_DIR=data
EXP=logs
N_GPU=1

DATA_PREFIX=pre_trained
SCENES=(frames_vid1 frames_vid2 frames_vid3 frames_vid4 frames_vid5 frames_vid6 frames_vid7
 frames_vid8 frames_vid9 frames_vid10)
FOVS=(59 89 69 59 69 69 69 69 85 73)

for (( JOB_COMPLETION_INDEX=0; JOB_COMPLETION_INDEX<${#SCENES[@]}; JOB_COMPLETION_INDEX++ )) 
do
    GPU_ID=$(expr $JOB_COMPLETION_INDEX % $N_GPU)
    SCENE=${DATA_PREFIX}/${SCENES[$JOB_COMPLETION_INDEX]}
    FOV=${FOVS[$JOB_COMPLETION_INDEX]}
    echo "$SCENE on GPU $GPU_ID with FoV $FOV"

    SCENE_DIR=${DATA_DIR}/${SCENE}
    LOG_DIR=${DATA_DIR}/${EXP}/${SCENE}
    mkdir -p ${LOG_DIR}

    nohup python -u localTensoRF/train.py --datadir ${SCENE_DIR} --logdir ${LOG_DIR} --fov ${FOV} --device cuda:$GPU_ID > ${LOG_DIR}/logs.out &
done
