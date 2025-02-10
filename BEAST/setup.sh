wget https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh
bash script.deb.sh
apt-get update
apt-get install -y git-lfs
apt-get install -y git wget curl
apt-get install -y tmux
rm script.deb.sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
yes | bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
cd ~
source miniconda3/bin/activate
conda init --all
yes | conda create -n "env140" python=3.10
conda activate env140
pip install transformers datasets protobuf tiktoken blobfile sentencepiece accelerate

git clone https://github.com/vinusankars/BEAST.git
cd BEAST/
mkdir data
wget https://raw.githubusercontent.com/llm-attacks/llm-attacks/refs/heads/main/data/advbench/harmful_behaviors.csv
mv harmful_behaviors.csv data/
wget https://raw.githubusercontent.com/huggingface/transformers/refs/heads/main/src/transformers/models/llama/convert_llama_weights_to_hf.py

python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='vicuna7b' --log=1 --target=1 --begin=0 --end=100 --budget=60
python ar_evaluate.py --model="vicuna" --total_steps=40 --file_name="data/data60/vicuna_k1=15_k2=15_length=40_0_100_ngram=1.pkl"
python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='vicuna7b' --log=1 --target=1 --begin=0 --end=100 --budget=120
python ar_evaluate.py --model="vicuna" --total_steps=40 --file_name="data/data120/vicuna_k1=15_k2=15_length=40_0_100_ngram=1.pkl"

# mkdir temp
# git clone https://huggingface.co/meta-llama/Llama-2-7b
# python convert_llama_weights_to_hf.py --input_dir "Llama-2-7b" --model_size 7B --llama_version 2 --output_dir temp
python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='llama2chat' --log=1 --target=1 --begin=0 --end=100 --budget=60
python ar_evaluate.py --model="llama2chat" --total_steps=40 --file_name="data/data60/llama2chat_k1=15_k2=15_length=40_0_100_ngram=1.pkl" --budget=60
python ar_self_attack.py --k1=15 --k2=15 --length=40 --model='llama2chat' --log=1 --target=1 --begin=0 --end=100 --budget=120
python ar_evaluate.py --model="llama2chat" --total_steps=40 --file_name="data/data120/llama2chat_k1=15_k2=15_length=40_0_100_ngram=1.pkl" --budget=120