defmodule TimeManagementWeb.ClockController do
  use TimeManagementWeb, :controller

  alias TimeManagement.TimeManager
  alias TimeManagement.TimeManager.Clock

  action_fallback TimeManagementWeb.FallbackController

  def index(conn, _params) do
    clocks = TimeManager.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  ##CREATE
  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- TimeManager.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def create_by_user_id(conn, %{"clock" => clock_params, "user_id" => user_id}) do
  clocks_params_with_user_id = Map.put_new(clock_params, "user_id", user_id)
  with {:ok, %Clock{} = clock} <- TimeManager.create_clock_by_user_id(clocks_params_with_user_id) do
      conn
      |> put_status(:created)
      |> render("show.json", clock: clock)
    end
  end


  ##SHOW
  def show(conn, %{"id" => id}) do
    clock = TimeManager.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def show_by_user_id(conn, %{"user_id" => user_id}) do
    clock = TimeManager.get_clocks_by_user_id(user_id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = TimeManager.get_clock!(id)

    with {:ok, %Clock{} = clock} <- TimeManager.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = TimeManager.get_clock!(id)

    with {:ok, %Clock{}} <- TimeManager.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
