defmodule TimeManagementWeb.ClockView do
  use TimeManagementWeb, :view
  alias TimeManagementWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      status: clock.status,
      time: clock.time}
  end
end
