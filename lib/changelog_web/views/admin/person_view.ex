defmodule ChangelogWeb.Admin.PersonView do
  use ChangelogWeb, :admin_view

  alias Changelog.Person
  alias ChangelogWeb.PersonView
  alias ChangelogWeb.Admin.{EpisodeView, EpisodeRequestView, FeedView, MembershipView, NewsItemView, NewsItemCommentView, SharedView}

  def avatar_url(person), do: PersonView.avatar_url(person)

  def is_subscribed(person, thing), do: PersonView.is_subscribed(person, thing)

  def list_of_links(person) do
    [
      %{value: person.email, icon: "envelope", url: "mailto:#{person.email}", title: "Email"},
      %{
        value: person.twitter_handle,
        icon: "twitter",
        url: SharedHelpers.twitter_url(person.twitter_handle),
        title: "On Twitter"
      },
      %{
        value: person.github_handle,
        icon: "github",
        url: SharedHelpers.github_url(person.github_handle),
        title: "On GitHub"
      },
      %{
        value: person.linkedin_handle,
        icon: "linkedin",
        url: SharedHelpers.linkedin_url(person.linkedin_handle),
        title: "On LinkedIn"
      },
      %{value: person.website, icon: "share", url: person.website, title: "Website"}
    ]
    |> Enum.reject(fn x -> x.value == nil end)
    |> Enum.map(fn x ->
      ~s{<a href="#{x.url}" title="#{x.title}" class="ui icon button" target="_blank"><i class="#{x.icon} icon"></i></a>}
    end)
    |> Enum.join("")
  end

  def plusplus_label(person) do
    if person.active_membership do
    link(to: ~p"/admin/memberships/#{person.active_membership}/edit") do
      content_tag(:span, "++", class: "ui tiny blue label")
    end
    end
  end
end
