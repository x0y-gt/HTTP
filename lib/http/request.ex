defmodule HTTP.Request do

  @enforce_keys :message
  defstruct message: nil, metadata: %{request_line: nil, headers: nil, body: nil}, method: "GET", uri: nil, version: "HTTP1.1", headers: [], body: nil

  def methods do
    ["OPTIONS", "GET", "HEAD", "POST", "PUT", "DELETE", "TRACE", "CONNECT"]
  end

  def set(req, key, value) do
    Map.put(req, key, value)
  end
end
