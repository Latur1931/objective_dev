function ConfigurationError() {
  var e = Error.apply(this, arguments);
  var _this = this;
  var _arguments = arguments;
  Object.defineProperty(this, 'message', {value: e.message});
  Object.defineProperty(this, 'name', {value: 'ConfigurationError'});
  Object.defineProperty(this, 'stack', {get: function() {return e.stack}});
  Object.keys(arguments[1] || {}).forEach(function(key) {
    Object.defineProperty(_this, key, {
      enumerable: true,
      get: function(){return _arguments[1][key]}
    });
  });
  return this;
}

ConfigurationError.prototype = Error.prototype;
ConfigurationError.prototype.constructor = ConfigurationError;

module.exports = ConfigurationError;
