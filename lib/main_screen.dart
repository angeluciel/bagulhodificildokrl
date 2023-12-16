import 'package:flutter/material.dart';
import 'add_person_screen.dart';
import 'person.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Person> persons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pessoas'),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(persons[index].name),
            subtitle: Text('IMC: ${persons[index].bmi.toStringAsFixed(2)}'),
            onTap: () {
              _editPerson(context, index);
            },
            onLongPress: () {
              _deletePerson(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPerson(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addPerson(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPersonScreen()),
    );

    if (result != null) {
      setState(() {
        persons.add(result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pessoa adicionada com sucesso!'),
        ),
      );
    }
  }

  void _editPerson(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPersonScreen(person: persons[index]),
      ),
    );

    if (result != null) {
      setState(() {
        persons[index] = result;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pessoa editada com sucesso!'),
        ),
      );
    }
  }

  void _deletePerson(int index) {
    setState(() {
      persons.removeAt(index);
    });
  }
}