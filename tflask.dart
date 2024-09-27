import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prédiction de Prix de Maison'),
        ),
        body: PredictionForm(),
      ),
    );
  }
}

class PredictionForm extends StatefulWidget {
  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final TextEditingController _surfaceController = TextEditingController();
  final TextEditingController _piecesController = TextEditingController();
  final TextEditingController _chambreController = TextEditingController();
  final TextEditingController _sdbController = TextEditingController();
  final TextEditingController _etatController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _quartierController = TextEditingController();

  String? _prediction;

  // Fonction pour envoyer la requête POST à l'API Flask
  Future<void> _getPrediction() async {
    // final url = Uri.parse('http://127.0.0.1:5000/predict');
    final url = Uri.parse('https://flask-api-4-2xia.onrender.com/predict');
    // bon lien : https://flask-api-4-2xia.onrender.com/predict

    final Map<String, dynamic> houseData = {
      'surface': int.parse(_surfaceController.text),
      'pieces': int.parse(_piecesController.text),
      'chambre': int.parse(_chambreController.text),
      'sdb': int.parse(_sdbController.text),
      'etat': _etatController.text,
      'ville': _villeController.text,
      'quartier': _quartierController.text
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(houseData),
      );

      final responseData = jsonDecode(response.body);

      setState(() {
        _prediction = responseData['prediction'].toString();
      });
    } catch (error) {
      print('Erreur : $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _surfaceController,
            decoration: InputDecoration(labelText: 'Surface (m²)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _piecesController,
            decoration: InputDecoration(labelText: 'Nombre de pièces'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _chambreController,
            decoration: InputDecoration(labelText: 'Nombre de chambres'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _sdbController,
            decoration: InputDecoration(labelText: 'Nombre de salles de bain'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _etatController,
            decoration: InputDecoration(labelText: 'État de la maison'),
          ),
          TextField(
            controller: _villeController,
            decoration: InputDecoration(labelText: 'Ville'),
          ),
          TextField(
            controller: _quartierController,
            decoration: InputDecoration(labelText: 'Quartier'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getPrediction,
            child: Text('Obtenir Prédiction'),
          ),
          SizedBox(height: 20),
          if (_prediction != null)
            Text(
              'Prédiction: $_prediction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
