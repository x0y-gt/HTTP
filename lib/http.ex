defmodule HTTP do
  @moduledoc """
  Documentation for HTTP.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HTTP.hello
      :world

  """
  def parse_request(msg) do
  #msg = "GET /?hub.mode=subscribe&hub.challenge=384124817&hub.verify_token=233 HTTP/1.1\r\nHost: 77d35e98.ngrok.io\r\nAccept: */*\r\nAccept-Encoding: deflate,gzip\r\nUser-Agent: facebookexternalhit/1.1\r\nX-Forwarded-Proto: https\r\nX-Forwarded-For: 2a03:2880:20:cff8:face:b00c:0:1\r\n\r\n"
    req = HTTP.Parser.parse(msg)
    #IO.inspect res
  end
end
