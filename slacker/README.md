Slacker
=======

this is a tiny command-line utility for pushing messages to slack.

Usage
=====

Create a slack token at https//:api.slack.com/web

put it in ~/.slack/tokens/mycoolslack where mycoolslack is the name of your slakc.

Run
```
slacker mwotton mycoolslack automated_alerts "deployed `git log -1 --format='%h'` to production"
```

or something similar.


This will probably be pushed to hackage when https://hackage.haskell.org/package/slack builds with a modern stack resolver and i can delete the vendored dep.
