import os
import subprocess

#set fps rate 
def extract_frames(video_path, output_folder, fps=30):
    # Extract the video name without extension
    video_name = os.path.splitext(os.path.basename(video_path))[0]
    # Create a subdirectory for each video(frame#_video-name)
    output_folder_video = os.path.join(output_folder, f'frames_{video_name}')
    print(f"Creating directory: {output_folder_video}")
    # Create an 'images' subdirectory inside each video folder
    output_folder_images = os.path.join(output_folder_video, 'images')
    print(f"Creating directory: {output_folder_images}")
    os.makedirs(output_folder_images, exist_ok=True)
    # Define the output pattern for frames
    output_pattern = os.path.join(output_folder_images, 'frame_%04d.jpg')

    # FFmpeg command to extract frames with specified fps
    command = [
        'ffmpeg',
        '-i', video_path,
        '-vf', f'fps={fps}',
        output_pattern
    ]

    # Run the FFmpeg command
    subprocess.run(command)

def process_videos(input_folder, output_folder, fps=30):
    if not os.path.exists(input_folder):
        print(f"Error: Input directory '{input_folder}' does not exist.")
        return

    # Iterate through each file in the input folder
    for filename in os.listdir(input_folder):
        if filename.endswith(('.mp4')):
            video_path = os.path.join(input_folder, filename)
            # Call the extract_frames function for each video
            extract_frames(video_path, output_folder, fps)

if __name__ == "__main__":
    input_folder = 'input_vids'
    output_folder = 'pre_trained'
    fps = 30  # Adjust fps rate
    process_videos(input_folder, output_folder, fps)
