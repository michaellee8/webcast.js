Webcast.Socket = ({url, mime, info}) ->
  socket = new WebSocket url, "webcast"

  socket.mime = mime
  socket.info = info

  hello =
    mime: mime

  for key, value of info
    hello[key] = value

  send = socket.send
  socket.send = null

  socket.addEventListener "open", ->
    send.call socket, JSON.stringify(
      type: "hello"
      data: hello
    )

  # This method takes Blob, ArrayBuffer or any TypedArray

  socket.sendData = (data) ->
    return unless socket.isOpen()

    return unless data?

    if data.length? and data.buffer?
      data = data.buffer.slice data.byteOffset, data.length*data.BYTES_PER_ELEMENT

    send.call socket, data

  socket.sendMetadata = (metadata) ->
    return unless socket.isOpen()

    send.call socket, JSON.stringify(
      type: "metadata"
      data: metadata
    )

  socket.isOpen = ->
    socket.readyState == WebSocket.OPEN

  socket
