# Direct Message File Sharing (DMFS)

Specification and Information for DMFS, a way to send all kinds of files over [Twitter](https://twitter.com) Direct Messages.

## Idea

Since Twitter recently increased the direct message character limit to 10,000 we thought about sending small files with it.

## How it works

Assuming there are 2 people (let's call them Alice and Bob) using [DMFS-clients](#available-clients). Alice wants to send Bob a small image (`test.png`) over DMFS.

1. Alice starts up the DMFS client and selects the file (in this case `test.png`) she wants to send to Bob.
2. The DMFS client reads the filename and the content of the file (the bytestream)
3. The bytestream will be encoded to Base64 and the [DMFS message](#message) will be assembled
4. Alice sends the message with the DMFS client to Bob _(should happen automated if selected earlier)_
5. Bob, also running a DMFS client, receives the message and his client accepts it, because of the valid format.
6. The DMFS client decodes the bytestream from the message and writes it to the filename given in the message (`test.png`) on disk.

### Specification

#### Message

```
!!DMFS{"fn":"file.png","pt":0,"ct":"iVBORw0KGgoAAAANSUhEUgAAAFAAAAAwCAYA5f33AAAACXAAAOw..."}
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

## Contribute

### Protocol Specification

If you have any ideas to improve this document or want to discuss about given things, open an [issue](https://github.com/Nightbug/dmfs/issues)!

### Clients

If you wrote a client/plugin to use DMFS, tell us about it (using an issue/pull request) and we will add it to the list!

#### Available Clients

None yet :(

## License

This project uses the `AGPLv3` license.