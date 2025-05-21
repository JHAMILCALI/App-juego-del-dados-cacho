# 🎲 Juego de Dados Cacho en Flutter

Este proyecto es una implementación del tradicional juego de dados "Cacho" usando Flutter. El juego es por turnos entre dos jugadores. Cada jugador lanza 5 dados hasta un máximo de 20 veces. Gana quien acumule **50 puntos o más** primero, o quien tenga más puntos tras los 20 lanzamientos.

---

## 📱 Características

- 🎯 2 jugadores, turnos alternados.
- 🎲 Lanzamiento de 5 dados.
- 🏁 Máximo de 20 lanzamientos por jugador.
- 🥇 Gana quien llegue primero a 50 puntos o quien tenga más puntos al final.
- 🧠 Detección automática de combinaciones:
  - DORMIDA (5 iguales) → 50 pts
  - PÓKER (4 iguales) → 40 pts
  - FUL (3 iguales + 2 iguales) → 30 pts
  - ESCALERA (1-5 o 2-6) → 25 pts
  - Sin combinación → 0 pts

---

---

## 🚀 Cómo Ejecutar

1. Clona el repositorio:

   ```bash
   git clone https://github.com/tu_usuario/juego-dados-cacho.git
   cd juego-dados-cacho
   ```
Asegúrate de tener Flutter instalado:
```bash
flutter doctor
```
Ejecuta en modo debug:
```bash
flutter run
```

(Opcional) Agrega las imágenes de dados en la carpeta assets/images/ y configúralas en pubspec.yaml:


flutter:
  - assets:
    - assets/images/1.png
    - assets/images/2.png
    - assets/images/3.png
    - assets/images/4.png
    - assets/images/5.png
    - assets/images/6.png

🧠 Lógica del Juego
Turnos alternados: después de cada lanzamiento, cambia el jugador.

Final anticipado: si un jugador llega a 50 puntos en cualquier momento, el juego termina.

Final por intentos: si ambos jugadores completan 20 lanzamientos sin llegar a 50, gana quien tenga más puntos.

Mensaje en pantalla: muestra combinaciones, puntuación y turnos.

🔧 Funciones principales
lanzarDados()
Genera 5 valores aleatorios (1-6)

Calcula combinaciones y asigna puntos

Cambia turno o finaliza el juego según reglas

verificarCombinacion(List<int> dados)
Devuelve combinación especial, puntos y si gana el juego

reset()
Reinicia el juego y todas las variables

📜 Licencia
Este proyecto es de código abierto y se comparte con fines educativos.

👤 Autor

- Jhamil Calixto Mamani Quea

- Elizabeth Suzaño Condori