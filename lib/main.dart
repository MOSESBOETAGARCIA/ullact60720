import 'package:flutter/material.dart';

void main() => runApp(const BarbaslocasApp());

// La contraseña que me pediste
const String _adminPassword = "Admin123!";

class BarbaslocasApp extends StatelessWidget {
  const BarbaslocasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barbaslocas Peluca',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 1. PANTALLA DE LOGIN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  void _showAdminDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final passController = TextEditingController();
        return AlertDialog(
          title: const Text("Acceso Admin", style: TextStyle(color: Colors.red)),
          content: TextField(
            controller: passController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Contraseña"),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cerrar")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                if (passController.text == _adminPassword) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("¡Entraste como Admin!")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error: Mal password")));
                }
              },
              child: const Text("Validar", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Iniciar Sesión", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _input("Correo", Icons.email, _emailController, false),
                  const SizedBox(height: 15),
                  _input("Contraseña", Icons.lock, TextEditingController(), true),
                  const SizedBox(height: 20),
                  _botonAzul("Entrar", () => print("Login")),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const RegisterScreen())),
                    child: const Text("¿No tienes cuenta? Crear Cuenta"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const RecoverScreen())),
                    child: const Text("Olvidó contraseña"),
                  ),
                  const SizedBox(height: 30),
                  // BOTÓN ADMIN ROJO
                  ElevatedButton(
                    onPressed: _showAdminDialog,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                    child: const Text("¿Eres Admin?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 60, bottom: 30),
        decoration: const BoxDecoration(color: Color(0xFFB3E5FC), borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
        child: const Center(child: Text("Barbaslocas Peluca", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent))),
      );
}

// ==========================================
// 2. PANTALLA DE REGISTRO (FUNCIONAL)
// ==========================================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameC = TextEditingController();
  final passC = TextEditingController();
  final confirmC = TextEditingController();

  void _registrar() {
    if (nameC.text.isEmpty || passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Llena todos los campos")));
    } else if (passC.text != confirmC.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Las contraseñas no coinciden")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text("¡Bienvenido ${nameC.text}!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFB3E5FC), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("Crear Cuenta", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _input("Nombre", Icons.person, nameC, false),
            const SizedBox(height: 10),
            _input("Correo", Icons.email, TextEditingController(), false),
            const SizedBox(height: 10),
            _input("Contraseña", Icons.lock, passC, true),
            const SizedBox(height: 10),
            _input("Confirmar Contraseña", Icons.lock_outline, confirmC, true),
            const SizedBox(height: 30),
            _botonAzul("Registrarse", _registrar),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. PANTALLA RECUPERAR (NO FUNCIONAL)
// ==========================================
class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFB3E5FC), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("Recuperar Contraseña", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _input("Correo de recuperación", Icons.email, TextEditingController(), false),
            const SizedBox(height: 20),
            _botonAzul("Enviar Código", () => print("Enviado")),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// COMPONENTES REUTILIZABLES
// ==========================================
Widget _input(String label, IconData icon, TextEditingController controller, bool pass) {
  return TextField(
    controller: controller,
    obscureText: pass,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
    ),
  );
}

Widget _botonAzul(String text, VoidCallback accion) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: accion,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
    ),
  );
}