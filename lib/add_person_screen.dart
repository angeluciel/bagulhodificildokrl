import 'package:flutter/material.dart';
import 'person.dart';

class AddPersonScreen extends StatefulWidget {
  final Person? person;

  AddPersonScreen({this.person});

  @override
  _AddPersonScreenState createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.person != null) {
      nameController.text = widget.person!.name;
      heightController.text = widget.person!.height.toString();
      weightController.text = widget.person!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Altura'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Peso'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _savePerson(context);
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  void _savePerson(BuildContext context) {
  final name = nameController.text;
  final height = double.tryParse(heightController.text) ?? 0.0;
  final weight = double.tryParse(weightController.text) ?? 0.0;

  if (name.isNotEmpty && height > 0 && weight > 0) {
    final person = Person(name: name, height: height, weight: weight);
    person.updateBMI(); // Certifica-se de que o BMI é calculado corretamente.
    Navigator.pop(context, person);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Por favor, preencha todos os campos corretamente.'),
      ),
    );
  }
}
}