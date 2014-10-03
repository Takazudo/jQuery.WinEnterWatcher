do ($ = jQuery) ->

  EveEve = window.EveEve
  $win = $(window)
  ns = {}

  # ============================================================
  # throttle / debounce from underscore.js
  # http://documentcloud.github.com/underscore/

  ns.limit = (func, wait, debounce) ->
    timeout = null
    return ->
      context = this
      args = arguments
      throttler = ->
        timeout = null
        func.apply context, args

      clearTimeout timeout if debounce
      timeout = setTimeout(throttler, wait) if debounce or not timeout

  ns.throttle = (func, wait) ->
    return ns.limit func, wait, false

  ns.debounce = (func, wait) ->
    return ns.limit func, wait, true

  # ============================================================
  # window utils

  ns.isAboveTheWindow = ($el, options) ->
    defaults =
      threshold: 0
    if $el.length > 1
      $.error "2 or more elements were thrown."
      return false
    o = $.extend {}, defaults, options
    return $win.scrollTop() >= $el.offset().top + o.threshold + $el.innerHeight()

  ns.isBelowTheWindow = ($el, options) ->
    defaults =
      threshold: 0
    if $el.size() > 1
      $.error "2 or more elements were thrown."
      return false
    o = $.extend {}, defaults, options
    return $win.height() + $win.scrollTop() <= $el.offset().top - o.threshold

  ns.isInWindow = ($el) ->
    return not (ns.isAboveTheWindow $el) and not (ns.isBelowTheWindow $el)

  # ============================================================
  # WinWatcher

  class ns.WinWatcher extends EveEve
    eventNames = 'resize scroll orientationchange'
    constructor: ->
      $win.bind eventNames, =>
        @trigger 'resize'

  # put instance under namespace
  ns.winWatcher = new ns.WinWatcher

  # ============================================================
  # Watcher

  class ns.Watcher extends EveEve

    @defaults =
      threshold: 0
      throttle_millisec: 200
    
    constructor: (@el, options) ->
      @$el = $(@el)
      @done = false
      @options = $.extend {}, ns.Watcher.defaults, options
      
    start: ->
      @_watchResize()
      @check()

    check: ->
      if @done
        return
      if ns.isInWindow @$el
        @done = true
        data =
          watcher: this
          el: @$el
        @trigger 'enter', data
        @_unwatchResize()
      
    dstroy: ->
      @_unwatchResize()
        
    # private
    
    _watchResize: ->
      @_resizeHandler = ns.throttle (=> @check()), @options.throttle_millisec
      ns.winWatcher.on 'resize', @_resizeHandler

    _unwatchResize: ->
      ns.winWatcher.off 'resize', @_resizeHandler
      
  # ============================================================
  # globalify

  $.WinEnterWatcherNs = ns
  $.WinEnterWatcher = ns.Watcher

