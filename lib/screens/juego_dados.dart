import 'dart:math';
import 'package:flutter/material.dart';

class JuegoDadosScreen extends StatefulWidget {
  const JuegoDadosScreen({super.key});

  @override
  State<JuegoDadosScreen> createState() => _JuegoDadosScreenState();
}

class _JuegoDadosScreenState extends State<JuegoDadosScreen> {
  List<int> dados = [1, 1, 1, 1, 1];
  int ptosJugador1 = 0;
  int ptosJugador2 = 0;
  int lanzamientosJugador1 = 0;
  int lanzamientosJugador2 = 0;
  int jugadorActual = 1; // 1 o 2
  String mensaje = "Jugador 1 comienza";
  bool juegoTerminado = false;
  String? combinacionAnterior;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 159, 235),
      appBar: AppBar(
        title: const Text("Juego de Dados Cacho"),
        backgroundColor: const Color.fromARGB(255, 55, 215, 199),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mostrar dados en forma horizontal (sin orden específico)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < dados.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                          'images/${dados[i]}.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Información de combinación
                if (combinacionAnterior != null)
                  Text(
                    "¡$combinacionAnterior!",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 242, 143, 31),
                    ),
                  ),

                const SizedBox(height: 20),

                // Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: juegoTerminado ? null : lanzarDados,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.teal, // Color de fondo del botón
                        foregroundColor: Colors.white, // Color del texto
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text("Lanzar Dados"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: reset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text("Reiniciar Juego"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Información del juego
                Text(mensaje, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text(
                  "Lanzamientos Jugador 1: $lanzamientosJugador1/20",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Lanzamientos Jugador 2: $lanzamientosJugador2/20",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  "Puntos Jugador 1: $ptosJugador1",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Puntos Jugador 2: $ptosJugador2",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (juegoTerminado) ...[
                  const SizedBox(height: 20),
                  Text(
                    ptosJugador1 > ptosJugador2
                        ? "¡Jugador 1 Gana!"
                        : ptosJugador2 > ptosJugador1
                        ? "¡Jugador 2 Gana!"
                        : "¡Empate!",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 87, 243, 93),
                    ),
                  ),
                ],

                const SizedBox(height: 30),
                // Reglas del juego
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reglas del Juego:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• Grande/Dormida (5 iguales): 50 pts (Gana el juego)",
                        ),
                        Text("• Poker (4 iguales): 40 pts"),
                        Text("• Ful (3 iguales + 2 iguales): 30 pts"),
                        Text("• Escalera (1-5 o 2-6): 25 pts"),
                        Text("• 3 lanzamientos por jugador"),
                        Text(
                          "• Los dados no necesitan estar ordenados para las combinaciones",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void lanzarDados() {
    if (juegoTerminado) return;

    setState(() {
      // Generar nuevos valores para los dados
      dados = List.generate(5, (index) => Random().nextInt(6) + 1);

      // Verificar combinaciones y calcular puntos
      final resultado = verificarCombinacion(dados);
      combinacionAnterior = resultado['combinacion'];
      int puntos = resultado['puntos'];
      bool ganaJuego = resultado['ganaJuego'];

      if (jugadorActual == 1) {
        if (lanzamientosJugador1 >= 20) return;
        ptosJugador1 += puntos;
        lanzamientosJugador1++;

        if (ganaJuego || ptosJugador1 >= 50) {
          juegoTerminado = true;
          mensaje = "¡Jugador 1 gana con $ptosJugador1 puntos!";
        } else if (lanzamientosJugador1 >= 20 && lanzamientosJugador2 >= 20) {
          juegoTerminado = true;
          mensaje = determinarGanadorFinal();
        } else {
          jugadorActual = 2;
          mensaje =
              "Jugador 1: ${puntos > 0 ? '+$puntos pts' : 'Sin combinación'}. Turno del Jugador 2";
        }
      } else {
        if (lanzamientosJugador2 >= 20) return;
        ptosJugador2 += puntos;
        lanzamientosJugador2++;

        if (ganaJuego || ptosJugador2 >= 50) {
          juegoTerminado = true;
          mensaje = "¡Jugador 2 gana con $ptosJugador2 puntos!";
        } else if (lanzamientosJugador1 >= 20 && lanzamientosJugador2 >= 20) {
          juegoTerminado = true;
          mensaje = determinarGanadorFinal();
        } else {
          jugadorActual = 1;
          mensaje =
              "Jugador 2: ${puntos > 0 ? '+$puntos pts' : 'Sin combinación'}. Turno del Jugador 1";
        }
      }
    });
  }

  Map<String, dynamic> verificarCombinacion(List<int> dadosOriginal) {
    // Hacer una copia para no modificar el original
    List<int> dados = List.from(dadosOriginal);
    dados.sort();

    // Contamos la frecuencia de cada número
    Map<int, int> frecuencias = {};
    for (int dado in dados) {
      frecuencias[dado] = (frecuencias[dado] ?? 0) + 1;
    }

    // Verificamos las combinaciones especiales
    if (frecuencias.length == 1) {
      // Todos iguales (Grande/Dormida)
      return {'combinacion': 'DORMIDA', 'puntos': 50, 'ganaJuego': true};
    } else if (frecuencias.values.any((count) => count == 4)) {
      // Poker
      return {'combinacion': 'POKER', 'puntos': 40, 'ganaJuego': false};
    } else if (frecuencias.values.any((count) => count == 3) &&
        frecuencias.values.any((count) => count == 2)) {
      // Ful
      return {'combinacion': 'FUL', 'puntos': 30, 'ganaJuego': false};
    } else if (verificarEscalera(dados)) {
      // Escalera
      return {'combinacion': 'ESCALERA', 'puntos': 25, 'ganaJuego': false};
    } else {
      // Si no hay combinación especial
      return {'combinacion': null, 'puntos': 0, 'ganaJuego': false};
    }
  }

  bool verificarEscalera(List<int> dados) {
    // Verificar escalera 1-5
    if (dados.toSet().containsAll([1, 2, 3, 4, 5])) {
      return true;
    }
    // Verificar escalera 2-6
    if (dados.toSet().containsAll([2, 3, 4, 5, 6])) {
      return true;
    }
    return false;
  }

  String determinarGanadorFinal() {
    if (ptosJugador1 > ptosJugador2) {
      return "¡Juego terminado! Jugador 1 gana con $ptosJugador1 puntos.";
    } else if (ptosJugador2 > ptosJugador1) {
      return "¡Juego terminado! Jugador 2 gana con $ptosJugador2 puntos.";
    } else {
      return "¡Juego terminado en empate!";
    }
  }

  void reset() {
    setState(() {
      dados = [1, 1, 1, 1, 1];
      ptosJugador1 = 0;
      ptosJugador2 = 0;
      lanzamientosJugador1 = 0;
      lanzamientosJugador2 = 0;
      jugadorActual = 1;
      mensaje = "Jugador 1 comienza";
      juegoTerminado = false;
      combinacionAnterior = null;
    });
  }
}
