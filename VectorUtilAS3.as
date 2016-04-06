public class VectorUtilAS3 {
  private var _vector:*;

  public static function of(vector:*):VectorUtilAS3 {
    var util:VectorUtilAS3 = new VectorUtilAS3;
    util._vector = vector;
    return util;
  }

  /**
   * 連想配列で指定されたすべてのプロパティと指定値を持つ要素をすべて返す
   * @param attributes 検索条件としたいプロパティ名と値を対にしたObjectのインスタンス
   * @return マッチしたすべての要素を返す。マッチしなかったときは空のリストを返す。
   */
  public function findBy(attributes:Object):* {
    return _vector.filter(function(element:Object, _index:int, _source:*):Boolean {
      for (var key:String in attributes) {
        var value:* = attributes[key];
        if (element[key] != value) {
          return false;
        }
      }
      return true;
    });
  }

  /**
   * 連想配列で指定されたすべてのプロパティと指定値を持つ要素を１つだけ返す
   * @param attributes 検索条件としたいプロパティ名と値を対にしたObjectのインスタンス
   * @return マッチした要素を返す。マッチしなかったときはnullを返す。
   */
  public function getOneBy(attributes:Object):Object {
    for each (var element:Object in _vector) {
      var found:Boolean = true;

      for (var key:String in attributes) {
        var value:* = attributes[key];
        if (element[key] != value) {
          found = false;
          break;
        }
      }

      if (found) {
        return element;
      }
    }
    return null;
  }

  /**
   * すべての要素が指定された条件を満たせば true を返す
   * @param property 要素のプロパティか条件となる関数を function (element:Object):Boolean の形で渡す
   * @return すべての要素が指定されたプロパティを持つか、関数の条件を満たせば true、それ以外は false を返す
   */
  public function all(property:Object):Boolean {
    return _vector.filter(function(element:Object, _index:int, _source:*):Boolean {
      return (property is Function) ? property(element) : element[property];
    }).length == _vector.length;
  };

  /**
   * いずれかの要素が指定された条件を満たせば true を返す
   * @param property 要素のプロパティか条件となる関数を function (element:Object):Boolean の形で渡す
   * @return いずれかの要素が指定されたプロパティを持つか、関数の条件を満たせば true、それ以外は false を返す
   */
  public function any(property:Object):Boolean {
    return _vector.filter(function(element:Object, _index:int, _source:*):Boolean {
      return (property is Function) ? property(element) : element[property];
    }).length != 0;
  };

  /**
   * 指定された条件にマッチする要素を一つだけ返す
   * @param condition function(element:*):Booleanを満たす関数を指定する
   * @return マッチした要素を返す。マッチしたものがなければnullを返す。
   */
  public function detect(condition:Function):Object {
    for each (var element:Object in _vector) {
      var matched:Boolean = condition(element);
      if (matched) {
        return element;
      }
    }
    return null;
  }

  /**
   * 配列内のnullを削除して新しい配列を返す
   * @return 要素にnullを含まない配列を返す。
   */
  public function compact():* {
    return _vector.filter(function(element:Object, _index:int, _source:*):Boolean {
      return element != null;
    });
  }
}
