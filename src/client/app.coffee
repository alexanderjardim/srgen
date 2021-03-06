#= require ./priority
#= require ../common/character
#= require ../common/creation
#= require ../common/data/core
#= require ../common/data/text

core = @core
text = @text

base = angular.module 'srgen.base', []
base.service 'core', ->
  core
base.service 'text', ->
  text

main = angular.module 'srgen.main', ['srgen.base', 'srgen.priority', 'ui.bootstrap']

main.controller 'MainController', [ '$rootScope', '$location', 'core', 'text', ($rootScope, $location, core, text) ->
  $rootScope.getNavClass = (path) ->
    if $location.path().lastIndexOf(path, 0) == 0
      'active'
    else
      ''
  $rootScope.core = core
  $rootScope.text = text
]

main.controller 'DebugController', [ '$scope', ($scope) ->
  $scope.dump = (obj) ->
    console.dir obj
  $scope.dumpScope = ->
    console.dir $scope.$parent
]

main.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', {
    templateUrl: 'partials/viewWelcome.jade'
  }
  $routeProvider.when '/character', {
    templateUrl: 'partials/viewCharacter.jade'
    controller: 'PriorityCreationController'
  }
  $routeProvider.otherwise redirectTo: '/'
]

angular.bootstrap document, ['srgen.main']