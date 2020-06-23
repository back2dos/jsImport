package ;

class RunTests {

  static function main() {
    C1.bar();
    C2.bar();
    C3.bar();
    travix.Logger.println('it works');
    travix.Logger.exit(0); // make sure we exit properly, which is necessary on some targets, e.g. flash & (phantom)js
  }

}

@:js.import(@star 'glargh')
extern class C1 {
  static function bar():Void;
}

@:js.import(@default 'glargh')
extern class C2 {
  static function bar():Void;
}


@:js.import('glargh')
extern class C3 {
  static function bar():Void;
}