import 'package:collection/collection.dart';

void main() {
  Environment env = Environment.development;

  final a = 1; // присваивается только один раз
  const b = 1; // присваивается только один раз и сразу
  const c = 1; // присваивается только один раз и сразу

  String? sayRawString = r"\n\n\n"; // сырая строка
  late String lateinitString;
  var textVar = "text var"; // рекомендуется для локальных переменных
  Object textObject = "text object"; // так лучше не делать
  dynamic textDynamic = "Тип в рантайме узнаём, legacy"; // так лучше не делать

  int integer = 1;
  double doubleValue = 2;

  num integer2 = 1;
  num doubleValue2 = 2.0;

  print(env);
  print("${textVar.runtimeType}: $textVar");
  print("${textObject.runtimeType}: $textObject");
  print("${textDynamic.runtimeType}: $textDynamic");
  print("Константы ссылаются на одну ячейку памяти: ${identical(b, c)}");
  print(sayRawString);
  print(integer.toString() + " is num: ${integer is num}");
  print(integer2);
  print(doubleValue);
  print(doubleValue2);
  print("Округление с отбрасыванием: ${5 ~/ 2}");
  print("Округление: ${2.9.round()}");
  print("Округление с отбрасыванием: ${2.9.toInt()}");
  print("Округление вверх в double: ${2.9.ceilToDouble()}");
  print("Округление вниз в double: ${2.9.floorToDouble()}");

  print(A().notStaticValue);
  print(A.staticValue);

  // Коллекции
  List list = const [1, 2, 3];
  List<String> list2 = ["a", "b", "c"];
  var list3 = <String>["1", "2"]; // рекомендуется
  var list4 = <String>[
    "0",
    ...list3,
    if (true) "3",
    for (var letter in list2) "$letter!"
  ];
  var list5 = <String>["1", "2"];
  print(list + list2);
  print(list4);
  print(list3.equals(list5));

  var ourSet = <String>{"a", "b"};
  var ourMap = <int, String>{1: "a", 2: "b", 3: "c"};
  ourMap[7] = "!";

  sum((first, second) => first + second);
}

enum Environment { development, production }

class A {
  static int staticValue = 1;
  int notStaticValue = 2;
}

void goToVacation(final String destination,
    [final bool takeSunGlasses = true]) {
  print("Let's go to $destination and take sunglasses: $takeSunGlasses");
}

void goToVacation2(final String somebody,
        {required final String destination,
        final bool takeSunGlasses = true,
        final String? nameOfYourPet}) =>
    print(
        "$somebody, let's go to $destination and take sunglasses: $takeSunGlasses with pet: $nameOfYourPet");

void sum(int Function(int, int) sumFunc) {
  print("Result of sum: ${sumFunc(1, 2)}");
}

void sum2(int sumFunc(int first, int second)) {
  print("Result of sum: ${sumFunc(1, 2)}");
}

typedef SumFunc = int Function(int first, int second);
