import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('task 1 completed');
}

Future task2() async {
  Duration fSeconds;
  fSeconds = Duration(seconds: 4);
  late String result;
  await Future.delayed(fSeconds, () {
    result = 'task 2 data';
    print('task 2 finished');
  });
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('task 3 completed with $task2Data');
}
