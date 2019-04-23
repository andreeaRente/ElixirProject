      defmodule SpotifyExample do

        #Agent care va pastra credentialele

        #Agentul este pornit cu o structura goala
        use Agent

        def start_link do
          Agent.start_link(fn -> %Spotify.Credentials{} end, name: CredStore)
        end

        defp get_creds, do: Agent.get(CredStore, &(&1))

        defp put_creds(creds), do: Agent.update(CredStore, fn(_) -> creds end)

        #link pentru autorizare (conform documentatiei)
        def auth_url, do: Spotify.Authorization.url

        #Preluarea datelor din callback
        def authenticate(params) do
          creds = get_creds()
          {:ok, new_creds} = Spotify.Authentication.authenticate(creds, params)
          put_creds(new_creds) #functia update care va fi implementata pentru a salva credentialele
        end

        #accesarea API Spotify cu noile credentiale
        def track(id) do
          credentials = get_creds()
          {:ok, track} = Track.get_track(credentials, id)# functia get
          track
        end
      end
