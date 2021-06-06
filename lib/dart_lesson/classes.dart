void main() {
  var animal = Human("Joe", 2);
  var alien = Alien(firstName: "Valentin", lastName: "Sorokin");
  var myPoint = const MyPoint.origin()..printPoint()..printPoint();
  print("${animal.name} ${animal._age}");
  print("${alien.name} ${alien.age}");
}

class Human {
  final String name;
  int _age; // приватная переменная в пределах файла

  Human(this.name, this._age);

  set age(final int newAge) => _age = newAge;
}

class Alien {
  final String name;
  final int age;

  Alien({
    required final String firstName,
    required final String lastName,
    this.age = 2,
  }) : name = "$firstName  $lastName";


}

class Point {
  final double _x;
  final double _y;

  Point(this._x, this._y) {
    print("Created");
  }

  const Point.origin()
      : _x = 0,
        _y = 0;

  // из одного конструктора вызываем другой
  Point.originX(final int y) : this(0, y.toDouble());

  double get x => _x;
  double get y => _y;

  Point operator +(final Point newPoint) {
    return Point(x + newPoint.x, y + newPoint.y);
  }
}

class MyPoint extends Point {
  // наследование конструкторов по умолчанию отсутствует
  const MyPoint.origin() : super.origin();
  void printPoint() {
    print("Point: ${this.x}:${this.y}");
  }
}

class Pet {
  const Pet();

  factory Pet.adopt(final Prefernce prefernce) {
    if (prefernce == Prefernce.needFriendship) {
      return Dog();
    }
    return Cat();
  }
}

class Cat extends Pet {}

class Dog extends Pet {}

enum Prefernce { needFriendship, needCuteness }

class Singleton {
  static Singleton? _instance;

  const Singleton._(); // приватный конструктор снаружи файла

  factory Singleton.getInstance() {
    return _instance ??= Singleton._();
  }
}

mixin Flying on A {
  void fly() {
    print("I am flying");
  }
}

abstract class A {
  void method1();
  void method2() {}
}

class B extends A with Flying {
  @override
  void method1() {}
}

class C implements A {
  @override
  void method1() {}

  @override
  void method2() {}
}


