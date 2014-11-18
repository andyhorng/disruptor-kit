'use strict'

InitialSequenceValue = -1
cpuCacheLinePadding  = require('os').cpus().length - 1

class Cursor
    constructor: ->
        @sequence = InitialSequenceValue
        @padding  = new Array(cpuCacheLinePadding)

module.exports = Cursor
