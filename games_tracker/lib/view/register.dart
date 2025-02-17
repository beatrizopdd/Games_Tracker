import 'package:flutter/material.dart';
import 'package:games_tracker/controller/user_controller.dart';
import 'package:games_tracker/view/login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  bool isVisible = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        // Duração do SnackBar
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.redAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo do nome
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                controller: _nomeController,
              ),

              // Espaço
              const SizedBox(height: 10),

              // Campo do email
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                controller: _emailController,
              ),

              // Espaço
              const SizedBox(height: 10),

              // Campo da senha
              TextField(
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                controller: _senhaController,
              ),

              // Espaço
              const SizedBox(height: 20),

              // Botão de envio
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0x00000000),
                ),
                onPressed: () async {
                  int final_result = await UserController.cadastraUser(
                      _nomeController.text,
                      _emailController.text,
                      _senhaController.text);

                  if (final_result == -1) {
                    _showMessage("Este email já foi cadastrado!");
                  } else {
                    if (final_result != 0) {
                      _showMessage("Cadastro realizado com sucesso!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      _showMessage(
                          "Não foi possível realizar o cadastro, tente novamente.");
                    }
                  }
                  //APAGR ISSO TUDO!!! ISSO SÃO SÓ TESTES
                  //GameController.filtrodata(false);
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(color: Colors.black26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
