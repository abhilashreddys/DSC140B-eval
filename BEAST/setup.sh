# git clone https://github.com/vinusankars/BEAST.git
# cd BEAST/
# mkdir data
# get https://raw.githubusercontent.com/llm-attacks/llm-attacks/refs/heads/main/data/advbench/harmful_behaviors.csv
# mv harmful_behaviors.csv data/
# pip install transformers datasets protobuf tiktoken blobfile sentencepiece accelerate
# https://raw.githubusercontent.com/huggingface/transformers/refs/heads/main/src/transformers/models/llama/convert_llama_weights_to_hf.py

python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='vicuna7b' --log=1 --target=1 --begin=0 --end=100
python ar_evaluate.py --model="vicuna" --total_steps=40 --file_name="data/vicuna_k1=15_k2=15_length=40_0_100_ngram=1.pkl"

# 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
# export HF_TOKEN = "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"
# mkdir temp
# wget https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh
# bash script.deb.sh
# apt-get install -y git-lfs
# rm script.deb.sh
# git clone https://huggingface.co/meta-llama/Llama-2-7b
# python convert_llama_weights_to_hf.py --input_dir "Llama-2-7b" --model_size 7B --output_dir temp
# python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='llama2' --log=1 --target=1 --begin=0 --end=100
# python ar_evaluate.py --model="llama2" --total_steps=40 --file_name="data/llama2_k1=15_k2=15_length=40_0_100_ngram=1.pkl"