# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import os
import irc
import strformat

when isMainModule:
  let user = getEnv("BOT_USER")
  let channel = getEnv("BOT_CHANNEL")
  let password = getEnv("BOT_TOKEN")
  let client = newIrc("irc.chat.twitch.tv", user = user,
                      serverPass = password,
                      joinChans = @["#"&channel])
  client.connect()
  while true:
    var event: IrcEvent
    if client.poll(event):
      case event.typ
        of EvConnected:
          discard
        of EvDisconnected, EvTimeout:
          break
        of EvMsg:
          if event.cmd != MPrivMsg:
            discard

          if event.text == "!hola":
            client.privmsg(event.origin, fmt"Hola buenas, @{event.nick}")
