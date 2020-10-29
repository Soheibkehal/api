defmodule TimeManagement.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :avatar, :string
      add :email, :string
      add :fname, :string
      add :lname, :string
      add :password, :string
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role_id])
  end
end
