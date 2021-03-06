// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  var InitialSequenceValue, Writer, assertPowerOfTwo,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  InitialSequenceValue = -1;

  Writer = (function() {
    function Writer(written, upstream, capacity) {
      this.written = written;
      this.upstream = upstream;
      this.capacity = capacity;
      this.await = __bind(this.await, this);
      this.reserve = __bind(this.reserve, this);
      assertPowerOfTwo(this.capacity);
      this.previous = InitialSequenceValue;
      this.gate = InitialSequenceValue;
    }

    Writer.prototype.reserve = function(count) {
      this.previous += count;
      while (this.previous - this.capacity > this.gate) {
        this.gate = this.upstream.read(0);
      }
      return this.previous;
    };

    Writer.prototype.await = function(next) {
      var _results;
      _results = [];
      while ((next - this.capacity) > this.gate) {
        _results.push(this.gate = this.upstream.read(0));
      }
      return _results;
    };

    return Writer;

  })();

  assertPowerOfTwo = function(n) {
    if (n & (n - 1) !== 0) {
      throw new Error('The ring capacity must be a power of two, e.g. 2, 4, 8, 16, 32, 64, etc.');
    }
  };

  module.exports = Writer;

}).call(this);
