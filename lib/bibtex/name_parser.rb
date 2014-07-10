#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'strscan'

module BibTeX
  class NameParser < Racc::Parser

module_eval(<<'...end names.y/module_eval...', 'names.y', 94)

  @patterns = {
    :and => /,?\s+and\s+/io,
    :space => /\s+/o,
    :comma => /,/o,
    :lower => /[[:lower:]][^\s\{\}\d\\,]*/o,
    :upper => /[[:upper:]][^\s\{\}\d\\,]*/uo,
    :symbols => /(\d|\\.)+/o,
    :lbrace => /\{/o,
    :rbrace => /\}/o,
    :period => /./o,
    :braces => /[\{\}]/o
  }

  class << self
    attr_reader :patterns
  end

  def initialize(options = {})
    self.options.merge!(options)
  end

  def options
    @options ||= { :debug => ENV['DEBUG'] == true }
  end

  def parse(input)
    @yydebug = options[:debug]
    scan(input)
    do_parse
  end

  def next_token
    @stack.shift
  end

  def on_error(tid, val, vstack)
    BibTeX.log.error("Failed to parse BibTeX Name on value %s (%s) %s" % [val.inspect, token_to_str(tid) || '?', vstack.inspect])
  end

  def scan(input)
    @src = StringScanner.new(input)
    @brace_level = 0
    @stack = []
    @word = [:PWORD,'']
    do_scan
  end

  private

  def do_scan
    until @src.eos?
      case
      when @src.scan(NameParser.patterns[:and])
        push_word
        @stack.push([:AND,@src.matched])

      when @src.scan(NameParser.patterns[:space])
        push_word

      when @src.scan(NameParser.patterns[:comma])
        push_word
        @stack.push([:COMMA,@src.matched])

      when @src.scan(NameParser.patterns[:lower])
        is_lowercase
        @word[1] << @src.matched

      when @src.scan(NameParser.patterns[:upper])
        is_uppercase
        @word[1] << @src.matched

      when @src.scan(NameParser.patterns[:symbols])
        @word[1] << @src.matched

      when @src.scan(NameParser.patterns[:lbrace])
        @word[1] << @src.matched
        scan_literal

      when @src.scan(NameParser.patterns[:rbrace])
        error_unbalanced

      when @src.scan(NameParser.patterns[:period])
        @word[1] << @src.matched
      end
    end

    push_word
    @stack
  end

  def push_word
    unless @word[1].empty?
      @stack.push(@word)
      @word = [:PWORD,'']
    end
  end

  def is_lowercase
    @word[0] = :LWORD if @word[0] == :PWORD
  end

  def is_uppercase
    @word[0] = :UWORD if @word[0] == :PWORD
  end

  def scan_literal
    @brace_level = 1

    while @brace_level > 0
      @word[1] << @src.scan_until(NameParser.patterns[:braces]).to_s

      case @src.matched
      when '{'
        @brace_level += 1
      when '}'
        @brace_level -= 1
      else
        @brace_level = 0
        error_unbalanced
      end
    end
  end

  def error_unexpected
    @stack.push [:ERROR,@src.matched]
    BibTeX.log.warn("NameParser: unexpected token `#{@src.matched}' at position #{@src.pos}; brace level #{@brace_level}.")
  end

  def error_unbalanced
    @stack.push [:ERROR,'}']
    BibTeX.log.warn("NameParser: unbalanced braces at position #{@src.pos}; brace level #{@brace_level}.")
  end

# -*- racc -*-
...end names.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
   -15,   -27,   -15,   -29,    27,   -28,   -15,   -27,   -27,   -29,
   -15,   -28,    36,    24,   -27,    34,    33,    35,    21,    19,
    22,    10,    16,    11,    34,    33,    35,    34,    33,    35,
    10,     8,    11,    21,    28,    22,    34,    33,    35,    34,
    33,    35,    10,     8,    11,    21,    19,    22,    38,    23,
    13,    12 ]

racc_action_check = [
    19,    16,    19,    11,    18,    10,    19,    16,     8,    11,
     8,    10,    26,    12,     8,    32,    32,    32,     6,     6,
     6,     5,     5,     5,    36,    36,    36,    27,    27,    27,
    13,    13,    13,    20,    20,    20,    38,    38,    38,    23,
    23,    23,     0,     0,     0,    15,    15,    15,    30,     7,
     2,     1 ]

racc_action_pointer = [
    39,    51,    44,   nil,   nil,    18,    15,    47,     8,   nil,
     5,     3,    13,    27,   nil,    42,     1,   nil,     2,     0,
    30,   nil,   nil,    36,   nil,   nil,    10,    24,   nil,   nil,
    46,   nil,    12,   nil,   nil,   nil,    21,   nil,    33,   nil,
   nil,   nil ]

racc_action_default = [
    -1,   -30,    -2,    -3,    -5,   -16,   -30,   -30,   -12,   -19,
   -21,   -22,   -30,   -30,    -6,   -30,   -12,   -20,    -8,   -13,
   -16,   -21,   -22,   -25,    42,    -4,    -7,   -25,   -14,    -9,
   -17,   -23,   -26,   -27,   -28,   -29,   -25,   -10,   -25,   -24,
   -11,   -18 ]

racc_goto_table = [
     4,    17,     3,    20,    29,    14,    15,     2,    37,    18,
    41,     1,    20,     4,   nil,    25,    17,    40,    26,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    39 ]

racc_goto_check = [
     4,    10,     3,     5,     8,     4,     6,     2,     8,     7,
     9,     1,     5,     4,   nil,     3,    10,     8,     7,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,     4 ]

racc_goto_pointer = [
   nil,    11,     7,     2,     0,    -3,     1,     3,   -19,   -28,
    -4,   nil ]

racc_goto_default = [
   nil,   nil,   nil,   nil,    31,     5,     6,     7,   nil,    30,
     9,    32 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 9, :_reduce_1,
  1, 9, :_reduce_none,
  1, 10, :_reduce_3,
  3, 10, :_reduce_4,
  1, 11, :_reduce_5,
  2, 11, :_reduce_6,
  3, 11, :_reduce_7,
  2, 11, :_reduce_8,
  3, 11, :_reduce_9,
  4, 11, :_reduce_10,
  5, 11, :_reduce_11,
  1, 14, :_reduce_none,
  2, 14, :_reduce_13,
  3, 14, :_reduce_14,
  1, 15, :_reduce_none,
  1, 15, :_reduce_none,
  1, 16, :_reduce_17,
  3, 16, :_reduce_18,
  1, 13, :_reduce_none,
  2, 13, :_reduce_20,
  1, 18, :_reduce_none,
  1, 18, :_reduce_none,
  1, 19, :_reduce_none,
  2, 19, :_reduce_24,
  0, 17, :_reduce_none,
  1, 17, :_reduce_none,
  1, 12, :_reduce_none,
  1, 12, :_reduce_none,
  1, 12, :_reduce_none ]

racc_reduce_n = 30

racc_shift_n = 42

racc_token_table = {
  false => 0,
  :error => 1,
  :COMMA => 2,
  :UWORD => 3,
  :LWORD => 4,
  :PWORD => 5,
  :AND => 6,
  :ERROR => 7 }

racc_nt_base = 8

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "COMMA",
  "UWORD",
  "LWORD",
  "PWORD",
  "AND",
  "ERROR",
  "$start",
  "result",
  "names",
  "name",
  "word",
  "u_words",
  "von",
  "last",
  "first",
  "opt_words",
  "u_word",
  "words" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'names.y', 31)
  def _reduce_1(val, _values, result)
     result = [] 
    result
  end
.,.,

# reduce 2 omitted

module_eval(<<'.,.,', 'names.y', 33)
  def _reduce_3(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 34)
  def _reduce_4(val, _values, result)
     result << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 38)
  def _reduce_5(val, _values, result)
             result = Name.new(:last => val[0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 42)
  def _reduce_6(val, _values, result)
             result = Name.new(:first => val[0], :last => val[1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 46)
  def _reduce_7(val, _values, result)
             result = Name.new(:first => val[0], :von => val[1], :last => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 50)
  def _reduce_8(val, _values, result)
             result = Name.new(:von => val[0], :last => val[1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 54)
  def _reduce_9(val, _values, result)
             result = Name.new(:last => val[0], :jr => val[2][0], :first => val[2][1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 58)
  def _reduce_10(val, _values, result)
             result = Name.new(:von => val[0], :last => val[1], :jr => val[3][0], :first => val[3][1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 62)
  def _reduce_11(val, _values, result)
             result = Name.new(:von => val[0,2].join(' '), :last => val[2], :jr => val[4][0], :first => val[4][1])
       
    result
  end
.,.,

# reduce 12 omitted

module_eval(<<'.,.,', 'names.y', 67)
  def _reduce_13(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 68)
  def _reduce_14(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 15 omitted

# reduce 16 omitted

module_eval(<<'.,.,', 'names.y', 72)
  def _reduce_17(val, _values, result)
     result = [nil,val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'names.y', 73)
  def _reduce_18(val, _values, result)
     result = [val[0],val[2]] 
    result
  end
.,.,

# reduce 19 omitted

module_eval(<<'.,.,', 'names.y', 76)
  def _reduce_20(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 21 omitted

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'names.y', 81)
  def _reduce_24(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 25 omitted

# reduce 26 omitted

# reduce 27 omitted

# reduce 28 omitted

# reduce 29 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class NameParser
  end   # module BibTeX
