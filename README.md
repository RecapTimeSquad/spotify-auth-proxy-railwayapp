# Spotify Auth Proxy Railway Starter

> **:warning: You only connect one Spotiy account per server.** You may need separate environments pointing to same branch but different base URIs. If you need multi-user auth proxy, check out <https://github.com/conradludgate/oauth2-proxy>.

An @railwayapp starter for the Spotify Auth Proxy server as part of <https://learn.hashicorp.com/tutorials/terraform/spotify-playlist>, through we deploy the proxy.

## Project Information

* **Authors/Maintainers**: Andrei Jiroh Halili (<ajhalili2006@gmail.com>)
* **License**: MPL 2.0

## Usage

```tf
terraform {
  required_providers {
    spotify = {
      version = "~> 0.1.5"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  auth_server = "https://your-app-here.up.railway.app" # this is fine since URLs are public as long as don't leak the API keys or the auth links
  api_key = var.spotify_api_key
}
```

## Setting up your own auth proxy

**Before you proceed**: Complete the prerequsite part by creating an OAuth client in Spotify for Developers dashboard page [with these instructions](https://learn.hashicorp.com/tutorials/terraform/spotify-playlist#create-spotify-developer-app). Leave the redirect URIs unfilled for now.

### As an Railway starter

1. To get things started, press the Deploy on Railway button below[^3] and fill out `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` with your OAuth application's values. If you're managing playlists though Terraform on regular basis, we recommend setting `SPOTIFY_PROXY_API_KEY` variable to avoid hassles. [^1]

   [![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https%3A%2F%2Fgithub.com%2FRecapTimeSquad%2Fspotify-auth-proxy-railwayapp&envs=SPOTIFY_CLIENT_ID%2CSPOTIFY_CLIENT_SECRET%2CSPOTIFY_PROXY_API_KEY%2CPORT&optionalEnvs=SPOTIFY_PROXY_API_KEY&SPOTIFY_CLIENT_IDDesc=Spotify+OAuth+app+client+ID+for+bearer+token+generation&SPOTIFY_CLIENT_SECRETDesc=Spotify+OAuth+app+client+secret+for+bearer+token+generation&SPOTIFY_PROXY_API_KEYDesc=Since+the+server+handles+the+token+refreshes%2C+the+only+thing+you+worry+is+the+API+key+for+communicating+with+it+via+Terraform.+We+recommend+setting+this+to+ensure+stability%2C+as+it+will+generate+one+for+you+on+each+start.&PORTDesc=Please+do+not+change+this%2C+needed+to+avoid+Bad+Gateway+errors.&PORTDefault=27228&referralCode=recaptime.dev)

   Here's an example of how do we configure it from that screen:

   ![Demo of configurations, with the proxy API key being censored partially](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step1a.png)

2. After the starter is successfully deployed, you'll be redirected to the project dashboard. Navigate to **Deployments** -> **Domains** and copy the production deployment URL.
 by right-clicking and selecting copy URL
   ![Edited in MS Paint with shapes and text for proper doc/guidance.](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step2a.png)

   The next step will be use that URL you copied as `SPOTIFY_PROXY_BASE_URI`, since we ran our proxy in the cloud, not locally, minus the trailing slash.

   ![Setting the proxy base URI in Railway](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step2b.png)

3. Go back to Spotify for Developers dashboard of your OAuth client, hit **Edit Settings** and add your Railway deployment URL (hint: your `SPOTIFY_PROXY_BASE_URI`), suffixing with `spotify_callback` after the trailing slash, press **Add** and save.[^2]

   ![Setting the proxy base URI in Railway](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step3a.png)

4. For the moment of the truth, go back to your Railway project dashboard, select **Deployments** -> latest deploy. Click the Auth URL to start the OAuth flow.

   ![Latest deployment logs](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step4a.png)

   Scroll down and hit **Agree** to authorize your auth proxy to create, edit and manage playlists.

   ![OAuth prompt](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step4b.png)

   The auth proxy should response with `Authorization successful` after the redirection.
   ![OAuth prompt](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step4c.png)
   
   Now keep your API key secret and [continue the tutorial process](https://learn.hashicorp.com/tutorials/terraform/spotify-playlist#clone-example-repository). Happy Terraforming!

### Using the repositry template generation in GitHub

1. [Use this link](https://github.com/RecapTimeSquad/spotify-auth-proxy-railwayapp/generate) or press **Use this template** button in the main repository.
Give it an fresh repository slug of your choice r maybe try GitHub-generated ones and choose privacy setting. Hit **Create repository from template**.
Refresh at will.
2. [Sign up for Railway using your GitHub account](https://railway.app/?referralCode=recaptime.dev)[^3], then [start here using this link](https://railway.app/new/github).
Select the repository you just generated and fill up some variables.[^4]

   ![OAuth prompt](https://cdn.rtapp.tk/readme-assets/railwayapp-starters/spotify-auth-proxy/step1b.png)

3. Continue to step 2 in `As an Railway starter` section and happy Terraforming!

<!-- Footnotes -->
[^1]: Since the API Key is random on each invocation by default, this might break your Terraforming session on every deploy, so we recommend doing that.
[^2]: Remember that changing your `*.up.railway.app` subdomain might break the OAuth callback and token exchange processes, so don't forget to update your `SPOTIFY_PROXY_BASE_URI` and allowed callback URLs.
[^3]: **Affliate link notice**: By signing up to Railway using the link above for new users, you'll receive $5 credit to use at your dispoal. We'll only receive $5 on our side if [you upgraded to the Developer plan](https://railway.app/account/billing) and paid your first bill, irrespective of the bill amunt.
[^4]: The screenshot in this step uses `SPOTIFY_PROXY_API_TOKEN` instead of `SPOTIFY_PROXY_API_KEY` as variable name for the custom proxy API key. [We added some patches by creating an startup script here](https://github.com/RecapTimeSquad/spotify-auth-proxy-railwayapp/blob/main/startup-mgmt.sh) to handle this.
