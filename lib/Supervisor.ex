defmodule Spotify.Supervisor do
	
  use Supervisor
 

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Spotify, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
