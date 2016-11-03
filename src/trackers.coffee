# Description:
#   Script for Hubot to post server count to tracking servers
#
# Commands:
#   None
#
# Configuration:
#   HUBOT_DISCORD_CARBON_TOKEN   - Carbonitex.net bot authentication
#   HUBOT_DISCORD_BOTS_WEB_USER  - bots.discord.pw user id for bot
#   HUBOT_DISCORD_BOTS_WEB_TOKEN - bots.discord.pw auth token
#   
# Notes:
# 

#Dependencies
request             = require 'request'

# Tracking for https://www.carbonitex.net/discord/bots
carbonToken         = process.env.HUBOT_DISCORD_CARBON_TOKEN

#Tracking for https://bots.discord.pw/#g=1
discordBotsWebUser  = process.env.HUBOT_DISCORD_BOTS_WEB_USER
discordBotsWebToken = process.env.HUBOT_DISCORD_BOTS_WEB_TOKEN

module.exports = (robot) ->  
  updateDiscordBotsWeb= ->
    if(discordBotsWebToken and discordBotsWebUser)
      robot.logger.debug 'Updating discord bots'
      robot.logger.debug "#{robot.name} is on #{robot.client.guilds.size} servers"
      requestBody = 
        method: 'POST'
        url: "https://bots.discord.pw/api/bots/#{discordBotsWebUser}/stats"
        headers:
          Authorization: discordBotsWebToken
        body:
          server_count: robot.client.guilds.size
        json: true

      request requestBody, (err, response, body) ->
        if !err and response.statusCode == 200
          robot.logger.debug body
        else if err
          robot.logger.error err
        else
          robot.logger.error 'discord.bots.pw : Bad request or other ' + response.body.error
          robot.logger.error requestBody
              
  updateCarbonitex= ->
   if(carbonToken)
     robot.logger.debug 'Updating Carbonitex'
     robot.logger.debug "#{robot.name} is on #{robot.client.guilds.size} servers"
     requestBody =
        url: 'https://www.carbonitex.net/discord/data/botdata.php'
        body:
          key: carbonToken
          servercount: robot.client.guilds.size
        json: true

     request requestBody, (err, response, body) ->
        if !err and response.statusCode == 200
          robot.logger.debug body
        else if err
          robot.logger.error err
        else
          robot.logger.error 'carbonitex.net : Bad request or other' + response.body

  updateTrackers= ->
    updateCarbonitex()
    updateDiscordBotsWeb()
    return
                
  setInterval updateTrackers, 600000