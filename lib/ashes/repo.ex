defmodule Ashes.Repo do
  use Ecto.Repo,
    otp_app: :ashes,
    adapter: Ecto.Adapters.Postgres
end
