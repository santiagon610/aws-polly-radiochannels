# Polly Radio Channel Annunciation Creator

## What is this?

This is a tool that programmatically creates channel name announcements for two-way radios. Though, I guess you could use it for elevators or anything else that need to create a number of canned messages through automation.

## How do I use it?

### Requirements

- A Linux system or similar environment (WSL, Docker container, whatever) that can run `bash` scripts.
- [Amazon Web Services](https://aws.amazon.com/) account with access to [Polly](https://aws.amazon.com/polly/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [SoX](http://sox.sourceforge.net/) (on my Fedora system, available via `dnf`)

### Getting Started

- [Sign up for an account at Amazon Web Services.](https://aws.amazon.com/free/) We'll be using their APIs and command line interface to generate the sythesized voice files. Most of what we're doing falls within their free tier, so there should be no cash coming out of your pocket for this.
- Make sure that you have an active AWS session by running `aws sts get-caller-identity`. You should get back, at minimum, a JSON document that shows your UserId, Account, and ARN.

  ```json
  {
    "UserId": "123456789012",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:root"
  }
  ```

  - If this does not render similar to above, or provide you with output that shows that you have a valid AWS session, stop here and [fix your AWS CLI credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

- Populate the [channels.txt](channels.txt) file with the prompts that you want generated.
- Run the [build.sh](build.sh) script to reach out to AWS and create your prompts.

## How does it work?

- The script looks at each line of the [channels.txt](channels.txt) file for its prompt name.
- On each line, the script calls [AWS Polly](https://aws.amazon.com/polly/) to generate the prompt as an Ogg Vorbis file, and downloads it into the [output OGG directory](output/ogg/).
- The script then calls [SOX](http://sox.sourceforge.net/) to convert the Ogg Vorbis files to a format compatible with most two-way radios and PBXes (16-bit WAV, 8000Hz, monaural, little endian), and then places those files into the [output WAV directory](output/wav/).

## I have the files, now what?

This is going to be radio-specific, but depending on your radio programming software, you will need to create a voice profile or configuration file. In that screen, you will upload and import your WAV files, and you can assign them to the individual channels, zones, functions, or the like.

## Supported Radios / Software

- Motorola APX CPS (tested on APX 8500)
- Kenwood KPG-D1N (tested on NX-5300 and NX-5800)
- Harris Radio Personality Manager (tested on XG-100P)
- Harris Radio Personality Manager 2 (tested on XL-200P)
