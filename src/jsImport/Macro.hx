package jsImport;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context.*;


using haxe.io.Path;
using StringTools;
using sys.io.File;
using sys.FileSystem;

class Macro {
  static final META = ':js.import';
  static function init() {
    onGenerate(types -> {
      var lines = [];

      for (t in types)
        switch t {
          case TInst(_.get() => cl = _.meta.extract(META) => meta, _) if (meta.length > 0):

            if (!cl.isExtern)
              error('@$META can only be used on extern classes', meta[0].pos);

            var id =
              if (cl.isPrivate) cl.module.replace('.', '_') + '__' + cl.name;
              else cl.pack.concat([cl.name]).join('_');

            cl.meta.remove(':native');
            cl.meta.add(':native', [macro $v{id}], (macro null).pos);

            switch meta {
              case [{ params: [macro @star $v{(v:String)}] }]:
                lines.push('import * as $id from "$v";');
              case [{ params: [macro @default $v{(v:String)}] }]:
                lines.push('import $id from "$v";');
              case [{ params: [macro $v{(v:String)}] }]:
                lines.push('import { $id } from "$v";');
              case [{ params: [macro $v{(v:String)}, macro $v{(exportName:String)}] }]:
                lines.push('import { $exportName } from "$v";');
              case [{ pos: pos }]:
                error('@$META requires a string parameter, optionally preceded by an identifier', pos);
              default:
                error('Duplicate @$META', meta[0].pos);
            }
          default:
        }

      var tmp = Compiler.getOutput().directory() + '/tmp${Std.random(1 << 29)}.js';
      tmp.saveContent(lines.join('\n'));
      Compiler.includeFile(tmp);
      onAfterGenerate(tmp.deleteFile);
    });
  }
}
#end
