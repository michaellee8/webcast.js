class Webcast.Recorder
  mime: "audio/ogg"

  constructor: ({@channels}) ->
    @info =
      audio:
        channels: @channels
        encoder:  "MediaRecorder"

  start: (stream, cb) ->
    @recorder = new MediaRecorder stream

    # TODO: setOptions!
    
    @recorder.ondataavailable = (e) =>
      cb e.data if e.data.size > 0

    @recorder.start 100

  close: (cb) ->
    @recorder.stop()
    @recorder = null
    cb()
