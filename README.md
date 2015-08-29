# Direct Message File Sharing (DMFS)

Send files over Twitter direct messages

## Idea

Since Twitter recently increased the direct message character limit to 10,000 we thought about sending small files with it.

### Execution

DMFS is using Twitter direct messages to send files to other users, which can receive the files if they also run the supplied client.

A DMFS-message is looking like this:

```
!!DMFS{"fn":"file.png","pt":0,"ct":"iVBORw0KGgoAAAANSUhEUgAAAFAAAAAwCAYAAACG5f33AAAACXBIWXMAAA7D\nAAAOw..."}
```

It consists of following parts:

* **`!!DMFS`:** This identifies the direct message as DMFS message **(all other direct messages will be ignored)**
* a JSON-object containing:
  * **`fn`:** the filename
  * **`pt`:** the part ID of the file (if it is included, DMFS will look for followup DMs and merge the bytestreams together)
  * **`ct`:** the file content, basically just a bytestream converted to Base64 (we don't expect Twitter to allow raw bytes to be sent in DMs)

_Using `pt` the files can also be split, allowing a certainly bigger filesize, but much bigger isn't advised due to Twitter rate limits etc._

If the client receives a valid DMFS message it will simply write the decoded content (`ct`) into a file with the supplied filename (`fn`)

## Proof of Concept

Currently, besides this being an idea, we also wrote a small Proof of Concept which you can find in [`poc/`](https://github.com/Nightbug/dmfs/tree/master/poc) in this repository, if you want to set it up, read the [README](https://github.com/Nightbug/dmfs/blob/master/poc/README) supplied with it.

## Requirements

 - Ruby 2.0.0+
 - Bundler

## Install Gems

	$ bundle install

## License

This project uses the `AGPLv3` license.