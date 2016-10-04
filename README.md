# hubot-discord-trackers
Hubot Scripts for enabling Tracker setup for hubot-discord


## Configuration

Environment Variable | Description | Example
--- | --- | ---
`HUBOT_DISCORD_CARBON_TOKEN` | Carbonitex.net bot authentication | no example, it's a token
`HUBOT_DISCORD_BOTS_WEB_USER` |  bots.discord.pw user id for bot | same as above
`HUBOT_DISCORD_BOTS_WEB_TOKEN` |  bots.discord.pw auth token | same as above

## Installation

Install with NPM

```sh
$ npm install hubot-discord-trackers
```

Add to `external-scripts.json`

```json

[
  ...
  "hubot-discord-trackers",
  ...
]
```


## Notes

Hubot-Discord with a client object needs to be included for this to work properly. If, at any time, a change removes the `client` object from the robot, this will break.

