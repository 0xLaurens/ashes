defmodule AshesWeb.CountLive do
  use AshesWeb, :live_view



  def render(assigns) do
    ~H"""
    <h1 class="text-3xl font-bold">Counter</h1>
    <p>The count is: <%= @count %></p>
    <button class="rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80" phx-click="inc">Inc</button>
    <button class="rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80" phx-click="dec">dec</button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end


  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :count, &(&1+1))}
  end


  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :count, &(&1-1))}
  end

end