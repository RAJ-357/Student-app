// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1B1C1E)),
      home: const HomePage(),
    );
  }
}

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) {
      return const TextStyle(
        color: Colors.orangeAccent,
        //decoration: TextDecoration.lineThrough
      );
    }

    return const TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFD83457),
        child: Text(todo.name[0].toUpperCase()),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1E32),
      appBar: AppBar(
          backgroundColor : const Color(0xFF252A30),
          title: const Text("TO-DO List",style: TextStyle(color: Color(0xFFD5E4F7),fontSize: 25))
      ),
      body: ListView(

        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1E32),
          title: const Text('Add a new item to your List',style: TextStyle(color: Colors.yellow,fontSize: 25)),
          content: TextField(
            controller: _textFieldController,
            style: const TextStyle(color: Colors.cyanAccent,fontSize: 25),
            decoration: const InputDecoration(hintText: 'New Item',hintStyle: TextStyle(color: Colors.purple,fontSize: 15)),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: const BorderSide(color: Color(0xFF4D4F5C)),
                      )
                  )
              ),
              child: const Text('+',style : TextStyle(fontSize: 25)),
              onPressed: () {
                if(_textFieldController.text.isNotEmpty){
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }
}


int d = 7;
int h = 7;
int m = 7;
int s = 7;


class MyTimer extends StatefulWidget {
  const MyTimer({Key? key}) : super(key: key);
  @override
  State<MyTimer> createState() => _MyTimer();
}
class _MyTimer extends State<MyTimer> {

  void Reset() {
    setState(() {
      d = 0;
      h = 0;
      m = 0;
      s = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF282828),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  height: 100,
                  width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimerCountdown(
                          format: CountDownTimerFormat.daysHoursMinutesSeconds,
                          endTime: DateTime.now().add(
                            Duration(
                              days: d,
                              hours: h,
                              minutes: m,
                              seconds: s,
                            ),
                          ),
                          onEnd: () {
                            //print("Timer finished");
                          },
                          timeTextStyle: const TextStyle(
                            color: Color(0xFFC8FFEC),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          colonsTextStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                          descriptionTextStyle: const TextStyle(
                            color: Color(0xFFFFEC80),
                            fontSize: 18,
                          ),
                          spacerWidth: 20,
                          daysDescription: "Days",
                          hoursDescription: "Hours",
                          minutesDescription: "Minutes",
                          secondsDescription: "Seconds",
                        ),
                      ],
                    ),

                ),
                const SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                  )
                              )
                          ),
                          onPressed: () => {
                            Navigator.push( context, MaterialPageRoute( builder: (context) => const SetTimer()), ).then((value) => setState(() {})),
                          },
                          child: const Text('Set',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    ),
                    /*Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () => {
                            //print(d+h+m+s),
                          },
                          child: const Text('START',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    ),*/
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                  )
                              )
                          ),
                          onPressed: () => {
                            Reset(),
                          },
                          child: const Text('Reset',style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height:30),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF1D1E32),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  height: 370,
                  width: 350,
                  child : const TodoList(),
                ),
              ],
            ),
          ),
        ),
      );
    }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.calendar_today,
      size: 150,
    ),
    MyTimer(),
    Icon(
      Icons.library_music_sharp,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor : const Color(0xFF252A30),
        title: const Text("HOME",style: TextStyle(color: Color(0xFFD5E4F7),fontSize: 25)),
      ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF252A30),
          //selectedFontSize: 20,
          selectedIconTheme: const IconThemeData(color: Color(0xFFD5E4F7), size: 35),
          selectedItemColor: Colors.white70,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_sharp),
              label: 'Music',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),

      body: IndexedStack(
        alignment: Alignment.center,
        index: _selectedIndex,
        children: _pages,
      )
    );
  }
}

class SetTimer extends StatefulWidget {
  const SetTimer({Key? key}) : super(key: key);

  @override
  State<SetTimer> createState() => _SetTimer();
}
class _SetTimer extends State<SetTimer> {

  void increase_day() {
    setState(() {
      d++;
    });
  }

  void decrease_day() {
    setState(() {
      d--;
    });
  }

  void increase_hours() {
    setState(() {
      h++;
    });
  }

  void decrease_hours() {
    setState(() {
      h--;
    });
  }

  void increase_minutes() {
    setState(() {
      m++;
    });
  }

  void decrease_minutes() {
    setState(() {
      m--;
    });
  }

  void increase_seconds() {
    setState(() {
      s++;
    });
  }

  void decrease_seconds() {
    setState(() {
      s--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF424242),
        title: const Text("SET TIMER", style: TextStyle(fontSize: 25)),
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFFD83457),
        child: InkWell(
          onTap: () {
            Navigator.push( context, MaterialPageRoute( builder: (context) => const HomePage()), ).then((value) => setState(() {}));
          },
          child: const SizedBox(
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                'GO BACK',
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
          ),
        ),
      ),
        body: Center(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF1D1E32),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Text("DAYS",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 45)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$d",textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 75)),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    increase_day()
                                  },
                                  child: const Text('+',style: TextStyle(fontSize: 45)),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    decrease_day()
                                  },
                                  child: const Text('-',style: TextStyle(fontSize: 45)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF1D1E32),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Text("HOURS",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 45)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$h",textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 75)),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    increase_hours()
                                  },
                                  child: const Text('+',style: TextStyle(fontSize: 45)),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    decrease_hours()
                                  },
                                  child: const Text('-',style: TextStyle(fontSize: 45)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF1D1E32),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Text("MINUTES",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 37)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$m",textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 75)),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    increase_minutes()
                                  },
                                  child: const Text('+',style: TextStyle(fontSize: 45)),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    decrease_minutes()
                                  },
                                  child: const Text('-',style: TextStyle(fontSize: 45)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF1D1E32),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Text("SECONDS",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 37)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$s",textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 75)),

                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    increase_seconds()
                                  },
                                  child: const Text('+',style: TextStyle(fontSize: 45)),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4D4F5C)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            //side: const BorderSide(color: Color(0xFF4D4F5C)),
                                          )
                                      )
                                  ),
                                  onPressed: () => {
                                    decrease_seconds()
                                  },
                                  child: const Text('-',style: TextStyle(fontSize: 45)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),

        );
  }
}


