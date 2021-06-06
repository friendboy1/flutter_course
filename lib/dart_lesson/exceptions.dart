import 'dart:io';

void main() {
  var list = ["a", "b", "c", 7];
  for (var i = 0; i < list.length; i++) {}
  for (var element in list) {}
  try {
    say(list);
  } on ProcessException catch (exception) {
    print("Something went wrong: $exception");
  } catch (exception) {
    print(exception);
  } finally {
    print("Free resources");
  }
}

void say(final List strings) {
  strings.forEach((element) {
    if (element is String) {
      print(element);
    } else {
      throw ProcessException("I want only strings", []);
    }
  });
}
