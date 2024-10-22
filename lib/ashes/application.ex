defmodule Ashes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AshesWeb.Telemetry,
      Ashes.Repo,
      {DNSCluster, query: Application.get_env(:ashes, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ashes.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ashes.Finch},
      # Start a worker by calling: Ashes.Worker.start_link(arg)
      # {Ashes.Worker, arg},
      # Start to serve requests, typically the last entry
      AshesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ashes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AshesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
