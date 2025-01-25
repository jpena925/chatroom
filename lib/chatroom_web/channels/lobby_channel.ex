defmodule ChatroomWeb.LobbyChannel do
  use ChatroomWeb, :channel
  require Logger

  def join("lobby", _payload, socket) do
    Logger.info("Joined lobby channel")
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    Logger.info("Got message: #{inspect(payload)}")
    broadcast!(socket,"new_message", payload)
    {:noreply, socket}
  end
end
