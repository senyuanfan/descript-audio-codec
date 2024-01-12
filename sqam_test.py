import dac
import os
import torch
from audiotools import AudioSignal
import soundfile as sf

# Download a model
model_path = dac.utils.download(model_type="44khz")
model = dac.DAC.load(model_path)
model.to('cuda')

def encode_decode(inst):
    # Load audio signal file
    input_path = os.path.join('sqam', inst+'.wav')
    dac_path = os.path.join('sqam', inst+'_compressed.dac')
    output_path = os.path.join('sqam', inst+'_recovered.wav')
    
    signal = AudioSignal(input_path)
    # print(signal.audio_data.shape)

    # signal, fs = sf.read(input_path)
    # signal = torch.from_numpy(signal[: , 0]).float()

    # Encode audio signal as one long file
    # (may run out of GPU memory on long files)
    signal.to(model.device)

    # print(signal.audio_data[:, 0, :].shape)
    # only use the left channel if the input is stereo
    x = model.preprocess(signal.audio_data[:, 0, :].unsqueeze(dim=1), signal.sample_rate)
    # x = model.preprocess(signal, fs)
    # z, codes, latents, _, _ = model.encode(x)

    # # Decode audio signal
    # y = model.decode(z)

    # Alternatively, use the `compress` and `decompress` functions
    # to compress long files.

    signal = signal.cpu()
    x = model.compress(signal)

    # Save and load to and from disk
    x.save(dac_path)
    x = dac.DACFile.load(dac_path)

    # Decompress it back to an AudioSignal
    y = model.decompress(x)

    # Write to file
    y.write(output_path)

if __name__ == "__main__":
    insts = ['castanets', 'glockenspiel', 'harpsichord', 'oboe', 'quartet', 'spfe', 'spgm']
    # insts = ['castanets']
    for inst in insts:
        encode_decode(inst)
