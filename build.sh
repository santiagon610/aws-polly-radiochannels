#!/usr/bin/env bash

set -ex

SOURCE_FILE="${PWD}/channels.txt"
AWS_POLLY_FORMAT="ogg_vorbis"
AWS_POLLY_EXTENSION="ogg"
AWS_VOICE_ID="Joanna"
OUTPUT_PATH="${PWD}/output"

while read -r LINE; do
  DESTINATION_FILE_NAME="${LINE// /_}"
  echo "Creating prompt for ${LINE}..."
  aws polly synthesize-speech \
  --text-type ssml \
  --text "<speak>${LINE}</speak>" \
  --output-format "${AWS_POLLY_FORMAT}" \
  --voice-id ${AWS_VOICE_ID} \
  "${OUTPUT_PATH}/ogg/${DESTINATION_FILE_NAME}.${AWS_POLLY_EXTENSION}"
done < "${SOURCE_FILE}"

for f in "${OUTPUT_PATH}"/ogg/*.ogg; do
  echo "Converting ${f} to WAV..."
  sox "${f}" \
    --endian little \
    --rate 8k \
    --bits 16 \
    --channels 1 \
    "${OUTPUT_PATH}/wav/$(basename -s .ogg "$f").wav"
done
