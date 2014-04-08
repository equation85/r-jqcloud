var jqcloudOutputBinding = new Shiny.OutputBinding();

$.extend(jqcloudOutputBinding, {
  find: function(scope) {
    return $(scope).find('.jqcloud-output');
  },
  renderValue: function(el, data) {
    var $el = $(el);
    $el.jQCloud(data.wordOptions, data.cloudOptions);
  }
});

Shiny.outputBindings.register(jqcloudOutputBinding, 'equation.jqcloudOutputBinding');
