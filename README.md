# jQuery.WinEnterWatcher

Let this do something when specified element comes into the window.

## Demos

* [basic](http://takazudo.github.io/jQuery.WinEnterWatcher/demos/1/)
* [with social button](http://takazudo.github.io/jQuery.WinEnterWatcher/demos/2/)

## Usage

```js
$(function() {
  var $el = $('#element');
  var watcher = new $.WinEnterWatcher($el);
  watcher.on('enter', function() {
    console.log('entered into the window!'); // will be fired when this element comes into the window
  });
  watcher.start();
});
```

see demos about options

## Depends

* [EveEve](https://github.com/Takazudo/EveEve)
* jQuery 1.9.1 (>=1.5.1)

## Browsers

IE6+ and other new browsers.  

## How to build

git clone, then `git submodule init`, `git submodule update`.  
Then, `grunt` to build or `grunt watch` to watch coffee file's change.

## License

Copyright (c) 2013 "Takazudo" Takeshi Takatsudo  
Licensed under the MIT license.

## Build

Use

 * [CoffeeScript][coffeescript]
 * [grunt][grunt]

[coffeescript]: http://coffeescript.org "CoffeeScript"
[grunt]: http://gruntjs.com "grunt"
