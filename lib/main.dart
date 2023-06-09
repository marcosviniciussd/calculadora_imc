import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = 'Informe seus dados!';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (kDebugMode) {
        print(imc);
      }
      if(imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      }
      else if(imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      }
      else if(imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
      }
      else if(imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      }
      else if(imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      }
      else if(imc > 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDADAD9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF577399),
        //backgroundColor: const Color(0xFF495867),
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Color(0xFFEDE6E3),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(
              Icons.refresh,
              color: Color(0xFFEDE6E3),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Color(0xFF495867),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                //cursorColor: Color(0xFF495867),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF495867),
                    ),
                  ),
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(
                    color: Color(0xFF495867),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF495867),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Insira seu peso!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                //cursorColor: Color(0xFF495867),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF495867),
                    ),
                  ),
                  labelText: 'Altura (Cm)',
                  labelStyle: TextStyle(
                    color: Color(0xFF495867),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF495867),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Insira sua altura!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      calculate();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF577399),
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      color: Color(0xFFEDE6E3),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF495867),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
