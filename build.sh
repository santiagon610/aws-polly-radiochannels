#!/usr/bin/env bash

set -ex

SOURCE_FILE="${PWD}/channels.txt"
AWS_POLLY_FORMAT="ogg_vorbis"
AWS_POLLY_EXTENSION="ogg"
AWS_VOICE_ID="Joanna"
OUTPUT_PATH="${PWD}/output"

while read -r LINE; do
  echo "Creating prompt for ${LINE}..."
  aws polly synthesize-speech \
  --text-type ssml \
  --text "<speak>${LINE}</speak>" \
  --output-format "${AWS_POLLY_FORMAT}" \
  --voice-id ${AWS_VOICE_ID} \
  "${OUTPUT_PATH}/${LINE}.${AWS_POLLY_EXTENSION}"
  echo "Converting to WAV..."
  sox "${OUTPUT_PATH}/${LINE}.${AWS_POLLY_EXTENSION}" -r 16 -b 8 -c 1 "${OUTPUT_PATH}/${LINE}.wav"
  echo "Done"
  echo ""
done < "${SOURCE_FILE}"