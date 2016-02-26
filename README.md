# Team city dashboard based on dashing

This project contains a teamcity dashboard template based on the [teamcity-dashboard-template](https://github.com/nhsevidence/teamcity-dashboard-template).    

# Configuration

You need to provide environment variables for the following settings:
* TC_SERVER_URL (teamcity server url i.e 'http://yourteamcityserver/httpAuth/app/rest/')
* TC_USER (teamcity username)
* TC_PASSWORD (teamcity password)

# Running it up

Make sure to set the environment variables and configured your projects mentioned above.  To run the dashboard server up run this command in same directory as the docker-compose.yml file:

```
docker-compose up -d
```

Now go to localhost:8080/teamcity in your browser
