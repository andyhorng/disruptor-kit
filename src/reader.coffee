'use strict'

class Reader
    constructor: (@read, @written, @upstream, @consumer) ->
        @ready = false

    start: =>
        @ready = true
        do @recieve

    stop: =>
        @ready = false

    receive: =>
        previous = @read.load()
        idling   = 0
        gating   = 0

        read = ->
            lower = previous + 1
            upper = @upstream.read(lower)

            if lower <= upper
                @consumer.consume(lower, upper)
                @read.store(upper)
                previous = upper
            else if lower <= (upper = @written.load())
                gating += 1
                idling = 0
            else if @ready
                idling += 1
                gating = 0

            setTimeout(read, 0)

        setTimeout(read, 0)

module.exports = Reader
