'use strict'

InitialSequenceValue = -1

class Writer
    constructor: (@written, @upstream, @capacity) ->
        assertPowerOfTwo @capacity

        @previous = InitialSequenceValue
        @gate     = InitialSequenceValue

    reserve: (count) =>
        @previous += count
        @gate = @upstream.read(0) while @previous - @capacity > @gate
        @previous

    await: (next) =>
        @gate = @upstream.read(0) while (next - @capacity) > @gate

assertPowerOfTwo = (n) ->
    # Wikipedia entry: http://bit.ly/1krhaSB
    if n & (n - 1) != 0
        throw new Error 'The ring capacity must be a power of two, e.g. 2, 4, 8, 16, 32, 64, etc.'

module.exports = Writer
