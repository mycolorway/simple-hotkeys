
describe 'Simple hotkeys', ->

  hotkeys = null

  beforeEach ->
    hotkeys = simple.hotkeys el: document

  afterEach ->
    hotkeys.destroy()

  it "should inherit from SimpleModule", ->
    expect(hotkeys instanceof SimpleModule).toBe(true)

  it "normalize keyid", ->
    clazz = hotkeys.constructor
    expect clazz.normalize "SHIFT+A"
      .toBe "shift_a"
    expect clazz.normalize "ctrl  + alt+ left"
      .toBe "alt_ctrl_left"
    expect clazz.normalize "ctrl  + alt+ escape"
      .toBe "alt_ctrl_esc"
    expect clazz.normalize "Cmd+ shift+a"
      .toBe "meta_shift_a"
    expect clazz.normalize "Windows + alt+ a"
      .toBe "alt_meta_a"

  it "bind a hotkey", ->
    hotkeys.bind "ctrl + b", handler = jasmine.createSpy 'handler'
    hotkeys.el.trigger keydownEvent = $.Event 'keydown', which: 66, ctrlKey: true
    expect handler
      .toHaveBeenCalledWith keydownEvent

  it "unbind a hotkey", ->
    hotkeys
      .bind "ctrl + b", handler = jasmine.createSpy 'handler'
      .unbind "ctrl + b"
    hotkeys.el.trigger keydownEvent = $.Event 'keydown', which: 66, ctrlKey: true
    expect handler
      .not.toHaveBeenCalledWith keydownEvent
