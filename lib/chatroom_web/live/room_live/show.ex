defmodule ChatroomWeb.RoomLive.Show do
  use ChatroomWeb, :live_view

  alias Chatroom.Chat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    room = Chat.get_room!(id)
    messages = Chat.list_messages_for_room(room.id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:room, Chat.get_room!(id))
     |> assign(:messages, messages)}
  end

  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"
end
