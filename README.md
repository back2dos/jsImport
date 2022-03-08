# jsImport - use ES6 imports in Haxe

With `-lib jsImport` you can decorate any extern class with `@:js.import` like so:

- `@:js.import(@star './some/path.js') extern class Foo {}` becomes `import * as Foo from './some/path.js'`
- `@:js.import(@default './some/path.js') extern class Foo {}` becomes `import Foo from './some/path.js'`
- `@:js.import('./some/path.js') extern class Foo {}` becomes `import { Foo } from './some/path.js'`
- - `@:js.import('./some/path.js', 'SomeName') extern class Foo {}` becomes `import { SomeName } from './some/path.js'`
