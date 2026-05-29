# SoapyAudio Builder

To build SoapyAudio, SoapySDR, rtaudio and Hamlib requires several steps that are documented in multiple places. This `Dockerfile` clones the four source repositories, then builds them. After the build completes, it creates a file called `/src/installed.tgz` that contains all the artefacts from the build.

You can use the `build.sh` script to build and then extract the build artefacts. This requires that you have `docker` installed.

The four repositories used are:

* https://github.com/Hamlib/Hamlib.git
* https://github.com/thestk/rtaudio.git
* https://github.com/pothosware/SoapySDR.git
* https://github.com/FallingAnvils/SoapyAudio.git

# Note

The SoapyAudio repository is currently a forked version from the original available at the link below, because it does not (yet) support rtaudio > 5.1.0, or hamlib > 4.2 - I suspect that this will revert once available patches have been merged. I note that the fork looks like it has appropriate patches and merges, but the Kittens Clause applies.

* https://github.com/pothosware/SoapyAudio.git

# Tests

This `Dockerfile` was tested on the following system:

* Debian 13.4 - amd64


# Kittens Clause

* This isn't feature complete and probably kills kittens.
* If you break it, you get to keep both parts.
* Feel free to get in touch, but if you want to fix something or suggest a feature, please create an issue or supply a patch.
* Enjoy!


# Author

Onno VK6FLAB, 2026
