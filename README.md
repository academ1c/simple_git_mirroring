# Simple git mirroring

##### Example usage:
```shell
$ /path/to/simple_git_mirroring.sh [SRC_REPO] [DEST_REPO]

```

Also you can put this script to crontab.
##### Example crontask:

```shell
# Sync remote SRC_REPO wit our DEST_REPO every 30 minutes 
*/30 * * * * root  /path/to/simple_git_mirroring.sh [SRC_REPO] [DEST_REPO]
```
