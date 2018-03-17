defmodule HTTP.Parser do
  alias HTTP.Request

  # API
  def parse(msg) do
    if is_binary(msg) do
      request = %Request{message: msg}
      request = request |> split_http_message |> request_line |> request_headers |> request_body
      {:ok, request}
    else
      {:error, "Invalid message"}
    end
  end

  # PRIVATE

  defp split_http_message(%Request{} = request) do
    {msg_head, body} = case String.split(request.message, "\r\n\r\n") do
      [msg_head] ->
        {msg_head, nil}
      [msg_head | body] ->
        {msg_head, body}
    end
    [request_line | headers] = String.split(msg_head, "\r\n")
    # must use put_in for multilevel maps
    request = put_in(request.metadata.request_line, request_line)
    request = put_in(request.metadata.headers, headers)
    put_in(request.metadata.body, body)
  end

  defp request_line(%Request{} = request) do
    [method, uri, version] = request.metadata.request_line |> String.split
    if Enum.member?(Request.methods, method) do
      %{request | method: method, uri: uri, version: version}
    else
      raise "Invalid method #{method}"
    end
  end

  defp request_headers(%Request{} = request) do
    headers = Enum.map request.metadata.headers, fn(header) ->
      if String.trim(header) != "" do
        case String.split(header, ":", parts: 2) do
          [key, value] ->
            {String.to_atom(key), String.trim(value)}
          _ ->
            raise "Invalid header #{header}"
        end
      else
        nil
      end
    end
    headers = Enum.filter(headers, fn h -> h != nil end)

    %{request | headers: headers}
  end

  defp request_body(%Request{} = request) do
    # Verify if it's json|xml, etcc...
    request
  end
end
