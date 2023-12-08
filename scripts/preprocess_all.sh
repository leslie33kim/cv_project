# Copyright (c) Meta Platforms, Inc. and affiliates.
DATA_DIR=data/pre_trained

SCENES=(frames_vid1 frames_vid2 frames_vid3 frames_vid4 frames_vid5 frames_vid6 frames_vid7
 frames_vid8 frames_vid9 frames_vid10)

for (( JOB_COMPLETION_INDEX=0; JOB_COMPLETION_INDEX<${#SCENES[@]}; JOB_COMPLETION_INDEX++ )) 
do
    SCENE_DIR=${DATA_DIR}/${SCENES[$JOB_COMPLETION_INDEX]}
    echo "Preprocessing $SCENE_DIR"

    python scripts/run_flow.py --data_dir ${SCENE_DIR}
    python DPT/run_monodepth.py --input_path ${SCENE_DIR}/images --output_path ${SCENE_DIR}/depth --model_type dpt_large
done
