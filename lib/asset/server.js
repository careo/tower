var Server, exports;
Server = function() {};
Server.prototype.call = function(req, res, next) {
  var asset, start_time;
  start_time = new Date();
  return (asset = this.findAsset(req.path));
};
Server.prototype.forbiddenRequest = function(req) {
  return false;
};
Server.prototype.findAsset = function(path) {};
exports = (module.exports = function() {
  return function(req, res, next) {
    return new Server.call(req, res, next);
  };
});