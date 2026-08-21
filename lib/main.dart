import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const ParaMiNinaApp());
}

class ParaMiNinaApp extends StatelessWidget {
  const ParaMiNinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Para mi niña ❤️',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63),
        ),
      ),
      home: const InicioPage(),
    );
  }
}

// ============================================================
// COLORES
// ============================================================

const Color rosa = Color(0xFFE91E63);
const Color rosaClaro = Color(0xFFFFE4EC);
const Color rojo = Color(0xFFC2185B);
const Color fondo = Color(0xFFFFF7FA);

// ============================================================
// CORAZONES FLOTANTES
// ============================================================

class CorazonesFlotantes extends StatefulWidget {
  const CorazonesFlotantes({super.key});

  @override
  State<CorazonesFlotantes> createState() => _CorazonesFlotantesState();
}

class _CorazonesFlotantesState extends State<CorazonesFlotantes>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(12, (index) {
              final progress =
                  (controller.value + index / 12) % 1.0;

              final left =
                  (index * 73.0) % MediaQuery.of(context).size.width;

              return Positioned(
                left: left,
                bottom: -40 + progress * 700,
                child: Opacity(
                  opacity: 0.12 + (1 - progress) * 0.3,
                  child: Transform.rotate(
                    angle: progress * 0.5,
                    child: const Icon(
                      Icons.favorite,
                      color: rosa,
                      size: 22,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// ============================================================
// INICIO
// ============================================================

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void abrirRegalo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AppPrincipal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Stack(
        children: [
          const CorazonesFlotantes(),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Para alguien muy especial...',
                    style: TextStyle(
                      fontSize: 19,
                      color: rojo,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 35),

                  ScaleTransition(
                    scale: scaleAnimation,
                    child: GestureDetector(
                      onTap: abrirRegalo,
                      child: Container(
                        width: 190,
                        height: 170,
                        decoration: BoxDecoration(
                          color: rosa,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: rosa.withOpacity(0.35),
                              blurRadius: 25,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 170,
                              color: Colors.white.withOpacity(0.85),
                            ),
                            Container(
                              width: 190,
                              height: 30,
                              color: Colors.white.withOpacity(0.85),
                            ),
                            const Icon(
                              Icons.card_giftcard,
                              color: Colors.white,
                              size: 75,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Tengo algo preparado para ti...',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: rojo,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Ábrelo, mi niña ❤️',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 35),

                  ElevatedButton.icon(
                    onPressed: abrirRegalo,
                    icon: const Icon(Icons.favorite),
                    label: const Text(
                      'Abrir mi regalo',
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: rosa,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// APP PRINCIPAL
// ============================================================

class AppPrincipal extends StatefulWidget {
  const AppPrincipal({super.key});

  @override
  State<AppPrincipal> createState() => _AppPrincipalState();
}

class _AppPrincipalState extends State<AppPrincipal> {
  int pagina = 0;

  final List<Widget> paginas = const [
    CumpleanosPage(),
    CartaPage(),
    HistoriaPage(),
    RazonesPage(),
    AbreCuandoPage(),
    MusicaPage(),
    RecuerdosPage(),
    SorpresaPage(),
  ];

  final List<String> titulos = [
    'Cumpleaños',
    'Carta',
    'Nuestra historia',
    'Razones',
    'Abre cuando...',
    'Música',
    'Recuerdos',
    'Sorpresa',
  ];

  final List<IconData> iconos = [
    Icons.cake,
    Icons.mail,
    Icons.auto_stories,
    Icons.favorite,
    Icons.mark_email_unread,
    Icons.music_note,
    Icons.photo_library,
    Icons.card_giftcard,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,

      appBar: AppBar(
        backgroundColor: rosa,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          titulos[pagina],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 55,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    rosa,
                    rojo,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      color: rosa,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Para mi niña ❤️',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Teresita',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: titulos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      iconos[index],
                      color: pagina == index
                          ? rosa
                          : Colors.grey[700],
                    ),
                    title: Text(
                      titulos[index],
                      style: TextStyle(
                        color: pagina == index
                            ? rosa
                            : Colors.black87,
                        fontWeight: pagina == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: pagina == index,
                    selectedTileColor: rosaClaro,
                    onTap: () {
                      setState(() {
                        pagina = index;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Hecho con mucho amor ❤️',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          const CorazonesFlotantes(),
          paginas[pagina],
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagina > 3 ? 0 : pagina,
        selectedItemColor: rosa,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pagina = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Carta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Historia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Razones',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CUENTA REGRESIVA / CUMPLEAÑOS
// ============================================================

class CumpleanosPage extends StatefulWidget {
  const CumpleanosPage({super.key});

  @override
  State<CumpleanosPage> createState() => _CumpleanosPageState();
}

class _CumpleanosPageState extends State<CumpleanosPage> {
  late Timer timer;
  Duration restante = Duration.zero;

  @override
  void initState() {
    super.initState();
    actualizar();

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => actualizar(),
    );
  }

  void actualizar() {
    final ahora = DateTime.now();
    DateTime cumple = DateTime(
      ahora.year,
      8,
      22,
      0,
      0,
      0,
    );

    if (ahora.isAfter(cumple.add(const Duration(days: 1)))) {
      cumple = DateTime(
        ahora.year + 1,
        8,
        22,
      );
    }

    setState(() {
      restante = cumple.difference(ahora);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final esCumple = DateTime.now().month == 8 &&
        DateTime.now().day == 22;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          const SizedBox(height: 20),

          Text(
            esCumple
                ? '🎉 ¡FELIZ CUMPLEAÑOS! 🎉'
                : 'Falta poquito... ❤️',
            style: const TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: rojo,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          const Text(
            'Teresita',
            style: TextStyle(
              fontSize: 25,
              color: rosa,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  rosa,
                  rojo,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: rosa.withOpacity(0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.cake,
                  color: Colors.white,
                  size: 65,
                ),

                const SizedBox(height: 15),

                const Text(
                  '22 DE AGOSTO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Hoy celebramos tus 19 años ❤️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          if (!esCumple)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                contador(
                  restante.inDays,
                  'Días',
                ),
                contador(
                  restante.inHours % 24,
                  'Horas',
                ),
                contador(
                  restante.inMinutes % 60,
                  'Min',
                ),
                contador(
                  restante.inSeconds % 60,
                  'Seg',
                ),
              ],
            ),

          const SizedBox(height: 30),

          const Text(
            'Mi niña, deseo que este nuevo año de tu vida esté lleno de momentos bonitos, sonrisas y sueños cumplidos. ❤️',
            style: TextStyle(
              fontSize: 18,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget contador(int numero, String texto) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: rosa.withOpacity(0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$numero',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: rosa,
            ),
          ),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CARTA
// ============================================================

class CartaPage extends StatelessWidget {
  const CartaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.pink.shade100,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.mail,
                color: rosa,
                size: 55,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Para mi niña, Teresita ❤️',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: rojo,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Mi niña:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Hoy quería hacer algo diferente para ti. Algo que pudiera guardar algunos de los sentimientos que muchas veces no sé cómo explicar con palabras.',
              style: TextStyle(
                fontSize: 17,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Quiero que sepas que eres una persona muy especial para mí. Me gusta compartir momentos contigo, reír contigo y simplemente saber que estás ahí.',
              style: TextStyle(
                fontSize: 17,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Espero que tus 19 años estén llenos de cosas bonitas, nuevas experiencias, metas cumplidas y muchísimas razones para sonreír.',
              style: TextStyle(
                fontSize: 17,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Feliz cumpleaños, Teresita. ❤️',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: rojo,
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Con mucho cariño,\npara mi niña ❤️',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// NUESTRA HISTORIA
// ============================================================

class HistoriaPage extends StatefulWidget {
  const HistoriaPage({super.key});

  @override
  State<HistoriaPage> createState() => _HistoriaPageState();
}

class _HistoriaPageState extends State<HistoriaPage> {
  final DateTime inicioRelacion = DateTime(2024, 12, 18);

  String tiempoJuntos() {
    final ahora = DateTime.now();

    int anios = ahora.year - inicioRelacion.year;
    int meses = ahora.month - inicioRelacion.month;
    int dias = ahora.day - inicioRelacion.day;

    if (dias < 0) {
      meses--;

      final mesAnterior = DateTime(
        ahora.year,
        ahora.month,
        0,
      );

      dias += mesAnterior.day;
    }

    if (meses < 0) {
      anios--;
      meses += 12;
    }

    return '$anios años, $meses meses y $dias días';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'Nuestra historia ✨',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: rojo,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                rosa,
                rojo,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: rosa.withOpacity(0.3),
                blurRadius: 18,
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 55,
              ),

              const SizedBox(height: 12),

              const Text(
                'Nuestra historia comenzó',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                '18 de diciembre de 2024 ❤️',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              Text(
                tiempoJuntos(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 5),

              const Text(
                'y seguimos contando... ❤️',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        historiaItem(
          '❤️',
          'El comienzo',
          'Nos conocimos en la prepa y comenzamos a hablar durante el último semestre. Todo empezó con una carta y con un sentimiento que yo ya tenía, aunque por miedo todavía no me animaba a acercarme a ti.',
        ),

        historiaItem(
          '✨',
          'Cuando me di cuenta',
          'Recuerdo ese día en que llegaste al salón muy hermosa. Fue uno de esos momentos en los que simplemente pensé: wow. Aunque ya me gustabas, ese día sentí todavía más claro lo que sentía por ti.',
        ),

        historiaItem(
          '🥺',
          'Cuando me extrañaste',
          'También me di cuenta de que algo estaba cambiando cuando me fui de viaje y tú me extrañabas mucho. Fue bonito saber que mi ausencia también se sentía de tu lado.',
        ),

        historiaItem(
          '🎄',
          '18 de diciembre de 2024',
          'Ese día comenzó oficialmente nuestra historia. Desde entonces hemos compartido momentos que quiero guardar para siempre, desde los juegos hasta Navidad y Año Nuevo.',
        ),

        historiaItem(
          '💞',
          'El día que te pedí ser mi novia',
          'Ese momento siempre va a tener un lugar especial en mi corazón. Fue el comienzo de algo que para mí significa muchísimo y que me hace muy feliz.',
        ),

        historiaItem(
          '👀',
          'Lo que amo de ti',
          'Tus ojos, tu sonrisa, tu boca, tus manos, tu pelo, tu forma de ser y cada pequeño detalle que te hace ser tú. Me encantas completa, tal como eres.',
        ),

        historiaItem(
          '❤️',
          'Lo que siento por ti',
          'Siento cariño, orgullo, amor y muchísima felicidad de tenerte conmigo. Me haces sentir afortunado de poder compartir una parte de mi vida contigo.',
        ),

        historiaItem(
          '🌸',
          'Lo que quiero que recuerdes',
          'Quiero que nunca olvides cuánto te amo y lo importante que eres para mí. Esta aplicación es solamente una pequeña forma de guardar algunos de todos los sentimientos que tengo por ti.',
        ),

        const SizedBox(height: 15),

        const Text(
          'Y esta historia todavía tiene muchísimos capítulos por escribir... ❤️',
          style: TextStyle(
            fontSize: 19,
            fontStyle: FontStyle.italic,
            color: rojo,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget historiaItem(
      String emoji,
      String titulo,
      String texto,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 35,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: rojo,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    texto,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context, dynamic momentos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 40),
      child: Column(
        children: [
          // ======================================================
          // ENCABEZADO
          // ======================================================

          const Icon(
            Icons.auto_stories,
            color: rosa,
            size: 55,
          ),

          const SizedBox(height: 12),

          const Text(
            'Nuestra historia ✨',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: rojo,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          const Text(
            'Una historia que comenzó sin saber todo lo bonito que vendría después... ❤️',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // ======================================================
          // LÍNEA DEL TIEMPO
          // ======================================================

          ...List.generate(
            momentos.length,
                (index) => _MomentoHistoria(
              momento: momentos[index],
              numero: index + 1,
              ultimo: index == momentos.length - 1,
            ),
          ),

          const SizedBox(height: 15),

          // ======================================================
          // FINAL
          // ======================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  rosa,
                  rojo,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: rosa.withOpacity(0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: const Column(
              children: [
                Text(
                  '🌸',
                  style: TextStyle(fontSize: 40),
                ),

                SizedBox(height: 10),

                Text(
                  'Y nuestra historia continúa...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),

                Text(
                  'Nuestra historia comenzó en la prepa, con una carta y una persona que tenía miedo de decir lo que sentía.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),

                Text(
                  'Después llegó el 18 de diciembre de 2025.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),

                Text(
                  'Y desde entonces hemos ido escribiendo nuestra propia historia, un recuerdo a la vez.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                Text(
                  'Esta historia apenas comienza. ❤️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 18),

                Text(
                  'Te amo muchísimo, mi niña. ❤️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


// ============================================================
// TARJETA DE CADA MOMENTO
// ============================================================

class _MomentoHistoria extends StatelessWidget {
  final Map<String, dynamic> momento;
  final int numero;
  final bool ultimo;

  const _MomentoHistoria({
    required this.momento,
    required this.numero,
    required this.ultimo,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ====================================================
          // LÍNEA Y CÍRCULO
          // ====================================================

          SizedBox(
            width: 55,
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: rosa,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: rosa.withOpacity(0.25),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(
                    momento['icono'],
                    color: Colors.white,
                    size: 23,
                  ),
                ),

                if (!ultimo)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      color: rosaClaro,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ====================================================
          // TARJETA
          // ====================================================

          Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      title: Text(
                        momento['titulo'],
                        style: const TextStyle(
                          color: rojo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        momento['texto'],
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.6,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cerrar ❤️',
                            style: TextStyle(
                              color: rosa,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 18,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: rosa.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: rosaClaro,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // Fecha
                    Text(
                      momento['fecha'],
                      style: const TextStyle(
                        color: rosa,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Título
                    Text(
                      momento['titulo'],
                      style: const TextStyle(
                        color: rojo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Texto
                    Text(
                      momento['texto'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Text(
                          'Toca para leer ❤️',
                          style: TextStyle(
                            color: rosa,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                          color: rosa,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RAZONES
// ============================================================

class RazonesPage extends StatelessWidget {
  const RazonesPage({super.key});

  final List<String> razones = const [
    'Porque haces especiales hasta los momentos más sencillos. ❤️',
    'Porque me encanta compartir tiempo contigo. 🌸',
    'Porque tienes una manera única de hacerme sonreír. 😊',
    'Porque eres alguien muy importante para mí. 💕',
    'Porque contigo puedo crear recuerdos que quiero conservar. 📸',
    'Porque simplemente eres tú. ❤️',
    'Y podría seguir escribiendo razones durante muchísimo tiempo... ✨',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const Text(
          'Razones por las que eres especial ❤️',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: rojo,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 25),

        ...razones.asMap().entries.map(
              (entry) {
            return Card(
              margin: const EdgeInsets.only(
                bottom: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: rosaClaro,
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: rojo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// ABRE CUANDO
// ============================================================

class AbreCuandoPage extends StatefulWidget {
  const AbreCuandoPage({super.key});

  @override
  State<AbreCuandoPage> createState() => _AbreCuandoPageState();
}

class _AbreCuandoPageState extends State<AbreCuandoPage> {
  final Random random = Random();

  final Map<String, List<String>> frases = {
    // ========================================================
    // 1. CUANDO ESTES TRISTE
    // ========================================================

    '💗 Cuando estés triste': [
      'Respira poquito a poquito. Todo va a estar bien. ❤️',
      'No tienes que estar bien todo el tiempo. También puedes descansar. 🌸',
      'Los días difíciles también terminan. 💗',
      'Ojalá pudiera darte un abrazo enorme ahora mismo. 🫂',
      'Recuerda que eres mucho más que un momento triste. ❤️',
      'No estás sola en lo que sientes. 💕',
      'Tómate tu tiempo, no tienes que solucionar todo hoy. 🌷',
      'Espero que pronto vuelva esa hermosa sonrisa tuya. ❤️',
      'Un día malo no significa una vida mala. 💗',
      'Recuerda todas las cosas difíciles que ya has logrado superar. 🌸',
      'Ten paciencia contigo misma. ❤️',
      'No tienes que fingir que todo está bien. 💕',
      'A veces descansar también es avanzar. 🌷',
      'Todo pasa poco a poco. ❤️',
      'Tu corazón merece tranquilidad. 💗',
      'No olvides lo fuerte que eres. 🌸',
      'Mañana será una nueva oportunidad. ❤️',
      'No permitas que un momento difícil defina tu día completo. 💕',
      'Respira, descansa y vuelve a intentarlo cuando puedas. 🌷',
      'Tu sonrisa volverá. Dale tiempo. ❤️',
      'No tienes que poder con todo al mismo tiempo. 💗',
      'Espero que encuentres una pequeña razón para sonreír hoy. 🌸',
      'Los momentos difíciles no duran para siempre. ❤️',
      'Recuerda cuidar de ti. 💕',
      'No estás obligada a sonreír siempre. 🌷',
      'Todo puede mejorar poquito a poquito. ❤️',
      'Tú puedes superar este momento. 💗',
      'Nunca olvides cuánto vales. 🌸',
      'Tu historia todavía tiene muchos capítulos bonitos. ❤️',
      'No dejes que la tristeza esconda todo lo bonito que hay en ti. 💕',
      'Hoy puedes descansar. 🌷',
      'No tienes que tener todas las respuestas ahora. ❤️',
      'Sé paciente contigo. 💗',
      'Hay días para avanzar y días para respirar. 🌸',
      'Tu bienestar también importa. ❤️',
      'Nunca tengas miedo de comenzar otra vez. 💕',
      'Espero que pronto llegue algo bonito a tu día. 🌷',
      'No estás sola. ❤️',
      'Tu corazón merece cosas bonitas. 💗',
      'No olvides todas las razones que tienes para seguir sonriendo. 🌸',
      'Un momento triste no cambia quién eres. ❤️',
      'Tómate un descanso si lo necesitas. 💕',
      'Todo se irá acomodando con el tiempo. 🌷',
      'Confía poquito a poquito en que vendrán días mejores. ❤️',
      'No dejes que un mal día te haga olvidar todos los buenos. 💗',
      'Eres una persona increíble incluso en tus días difíciles. 🌸',
      'Espero que esta pequeña frase te acompañe. ❤️',
      'No tienes que apresurarte. 💕',
      'Tu corazón también necesita descansar. 🌷',
      'Sigue paso a paso. ❤️',
      'Todo sentimiento cambia con el tiempo. 💗',
      'Recuerda que mañana puede ser diferente. 🌸',
      'No olvides tus sueños. ❤️',
      'Todavía quedan muchas cosas bonitas por vivir. 💕',
      'Dale tiempo a tu corazón. 🌷',
      'Tú puedes con esto. ❤️',
      'No estás sola en tus momentos difíciles. 💗',
      'Espero que hoy encuentres un poquito de paz. 🌸',
      'No dejes de creer en ti. ❤️',
      'A veces solamente necesitamos respirar. 💕',
      'No tienes que demostrar nada. 🌷',
      'Tu corazón merece calma. ❤️',
      'Todo va a mejorar poco a poco. 💗',
      'Recuerda todas tus pequeñas victorias. 🌸',
      'Nunca olvides lo especial que eres. ❤️',
      'No permitas que un momento triste borre tus recuerdos bonitos. 💕',
      'Hoy puedes ir despacio. 🌷',
      'Descansa todo lo que necesites. ❤️',
      'Mañana puedes volver a intentarlo. 💗',
      'No estás definida por tus problemas. 🌸',
      'Siempre hay una nueva oportunidad. ❤️',
      'Espero que pronto encuentres una razón para sonreír. 💕',
      'Tu sonrisa volverá cuando estés lista. 🌷',
      'No olvides ser amable contigo. ❤️',
      'Tienes mucho por delante. 💗',
      'Los momentos malos pasan. 🌸',
      'Tu historia no termina en un día difícil. ❤️',
      'No tienes que cargar con todo. 💕',
      'Pedir ayuda también está bien. 🌷',
      'Recuerda que eres importante. ❤️',
      'Tu corazón merece amor y tranquilidad. 💗',
      'No pierdas la esperanza. 🌸',
      'Hay cosas bonitas esperando por ti. ❤️',
      'Todo estará mejor poco a poco. 💕',
      'No olvides respirar. 🌷',
      'Tú eres capaz. ❤️',
      'Ten paciencia con tu proceso. 💗',
      'Un día complicado no cambia todo lo bonito de tu vida. 🌸',
      'Recuerda que también tienes derecho a descansar. ❤️',
      'Espero que esta frase te dé un poquito de calma. 💕',
      'No estás sola. 🌷',
      'Sigue adelante cuando estés lista. ❤️',
      'Todavía quedan muchísimos momentos bonitos. 💗',
      'Nunca olvides que eres especial. 🌸',
      'Todo va a ir tomando forma. ❤️',
      'Confía en ti. 💕',
      'Y si hoy no puedes sonreír, simplemente descansa. 🌷',
      'Mañana será otra oportunidad. ❤️',
      'Tú puedes. 💗',
    ],

    // ========================================================
    // 2. CUANDO ESTES FELIZ
    // ========================================================

    '😊 Cuando estés feliz': [
      '¡Disfruta muchísimo este momento! ❤️',
      'Qué bonito saber que estás feliz. 🌸',
      'Guarda esta sonrisa para siempre. 😊',
      'La felicidad también está en las pequeñas cosas. 💗',
      'Hoy es un día perfecto para crear recuerdos. ❤️',
      'Nunca tengas miedo de disfrutar las cosas buenas. 💕',
      'Sonríe todo lo que puedas. 🌷',
      'Que esta felicidad dure muchísimo. ❤️',
      'Disfruta cada segundo. 💗',
      'Qué bonito verte sonreír. 🌸',
      'Guarda este momento en tu corazón. ❤️',
      'Hoy toca disfrutar. 💕',
      'Espero que tengas muchísimos días así. 🌷',
      'Tu felicidad también me hace feliz. ❤️',
      'Nunca olvides este momento. 💗',
      'Haz muchas memorias bonitas hoy. 🌸',
      'Disfruta sin pensar demasiado en mañana. ❤️',
      'Que esta sonrisa nunca desaparezca. 💕',
      'Hoy merece ser recordado. 🌷',
      'Sonríe, mi niña. ❤️',
      'Qué bonito es saber que estás bien. 💗',
      'Celebra tus pequeñas victorias. 🌸',
      'Disfruta lo que tienes hoy. ❤️',
      'Que este momento se quede contigo. 💕',
      'La felicidad merece celebrarse. 🌷',
      'Hoy tienes una razón más para sonreír. ❤️',
      'Disfruta cada pequeño detalle. 💗',
      'Nunca dejes de buscar momentos felices. 🌸',
      'Qué bonito que estés viviendo algo especial. ❤️',
      'Hoy todo parece un poquito más bonito. 💕',
      'Sonríe mucho. 🌷',
      'Guarda esta alegría. ❤️',
      'Espero que esta felicidad se multiplique. 💗',
      'Disfruta el presente. 🌸',
      'Hoy es para ser feliz. ❤️',
      'Haz que este momento sea inolvidable. 💕',
      'Nunca escondas una sonrisa. 🌷',
      'Qué bonito tener motivos para celebrar. ❤️',
      'Tu sonrisa es preciosa. 💗',
      'Disfruta muchísimo este día. 🌸',
      'Que nunca te falten razones para sonreír. ❤️',
      'Hoy puede convertirse en uno de tus días favoritos. 💕',
      'Vive este momento al máximo. 🌷',
      'Quédate con lo bonito de hoy. ❤️',
      'La felicidad también se encuentra en momentos sencillos. 💗',
      'Espero que sigas sonriendo mucho. 🌸',
      'Hoy toca disfrutar la vida. ❤️',
      'Guarda este recuerdo. 💕',
      'Sonríe y disfruta. 🌷',
      'Que bonito saber que estás feliz. ❤️',
      'Nunca dejes de celebrar tus logros. 💗',
      'Disfruta cada minuto. 🌸',
      'Hoy tienes permiso de ser muy feliz. ❤️',
      'Que esta alegría te acompañe mucho tiempo. 💕',
      'Nunca olvides esta sensación. 🌷',
      'Tu felicidad importa muchísimo. ❤️',
      'Hoy todo puede parecer mágico. 💗',
      'Haz algo que te haga todavía más feliz. 🌸',
      'Disfruta las pequeñas cosas. ❤️',
      'Quédate con esta sonrisa. 💕',
      'Hoy merece una sonrisa enorme. 🌷',
      'Que bonito es verte disfrutar. ❤️',
      'Nunca dejes pasar un momento feliz. 💗',
      'Espero que este día sea inolvidable. 🌸',
      'Celebra cada cosa buena. ❤️',
      'Hoy puede ser un recuerdo precioso. 💕',
      'Disfruta todo lo bonito. 🌷',
      'Sonríe sin miedo. ❤️',
      'Que nunca te falten días así. 💗',
      'La felicidad te queda bonita. 🌸',
      'Hoy es un buen día para agradecer. ❤️',
      'Disfruta cada segundo. 💕',
      'Espero que esta alegría dure mucho. 🌷',
      'Nunca dejes de perseguir lo que te hace feliz. ❤️',
      'Qué bonito tener algo que celebrar. 💗',
      'Guarda esta alegría en tu corazón. 🌸',
      'Hoy toca sonreír muchísimo. ❤️',
      'Disfruta de este momento. 💕',
      'Que cada minuto tenga algo bonito. 🌷',
      'Espero que tengas muchos días así. ❤️',
      'Sonríe, porque hoy tienes motivos. 💗',
      'Qué bonito verte feliz. 🌸',
      'Nunca olvides disfrutar el presente. ❤️',
      'Hoy todo parece estar en su lugar. 💕',
      'Disfruta sin preocupaciones. 🌷',
      'Que esta felicidad sea solamente el comienzo. ❤️',
      'Celebra lo que has conseguido. 💗',
      'Tu sonrisa ilumina tus momentos bonitos. 🌸',
      'Hoy es un día para recordar. ❤️',
      'Vive el momento. 💕',
      'Disfruta muchísimo. 🌷',
      'Que bonito es estar feliz. ❤️',
      'Nunca dejes de sonreír. 💗',
      'Espero que este día te deje un recuerdo precioso. 🌸',
      'Guarda este momento. ❤️',
      'Hoy toca ser feliz. 💕',
      'Disfruta, mi niña. 🌷',
    ],

    // ========================================================
    // 3. CUANDO ME EXTRAÑES
    // ========================================================

    '🥺 Cuando me extrañes': [
      'Recuerda todos nuestros momentos bonitos. ❤️',
      'Piensa en alguna de nuestras sonrisas. 💕',
      'Todavía nos quedan muchísimos momentos por vivir. 🌸',
      'Mira nuestras fotos y recuerda lo bonito. 📸',
      'Recuerda cuando empezamos a hablar. ❤️',
      'Piensa en nuestra primera etapa juntos. 💗',
      'Recuerda aquel 18 de diciembre. 🌷',
      'Piensa en los juegos a los que fuimos. ❤️',
      'Recuerda Navidad y Año Nuevo. 💕',
      'Nuestra historia todavía tiene muchos capítulos. 🌸',
      'Cuando me extrañes, recuerda que nuestros momentos siguen contigo. ❤️',
      'Piensa en nuestras risas. 💗',
      'Recuerda nuestras conversaciones. 🌷',
      'Todavía tenemos muchas historias por crear. ❤️',
      'Mira esta aplicación y recuerda por qué la hice. 💕',
      'Recuerda cómo empezó todo. 🌸',
      'Piensa en aquella primera carta. ❤️',
      'Recuerda nuestros primeros momentos. 💗',
      'Todavía quedan muchas aventuras. 🌷',
      'Piensa en alguna de nuestras bromas. ❤️',
      'Recuerda nuestras sonrisas. 💕',
      'Hay muchos recuerdos que todavía podemos crear. 🌸',
      'Piensa en los días que pasamos juntos. ❤️',
      'Recuerda cuando decidimos estar juntos. 💗',
      'Nuestra historia apenas está comenzando. 🌷',
      'Piensa en todos nuestros momentos especiales. ❤️',
      'Recuerda nuestras primeras conversaciones. 💕',
      'Mira una foto y sonríe. 🌸',
      'Todavía nos esperan muchos recuerdos. ❤️',
      'Piensa en todo lo que hemos vivido. 💗',
      'Recuerda cómo poco a poco nos acercamos. 🌷',
      'Nuestra historia comenzó con pequeños detalles. ❤️',
      'Recuerda aquella primera mirada. 💕',
      'Piensa en las veces que nos hemos reído. 🌸',
      'Todavía tenemos muchísimo por vivir. ❤️',
      'Recuerda cada momento bonito. 💗',
      'Piensa en nuestros días juntos. 🌷',
      'Cuando me extrañes, recuerda que también pienso en ti. ❤️',
      'Nuestra historia está llena de momentos especiales. 💕',
      'Recuerda nuestras aventuras. 🌸',
      'Piensa en nuestros recuerdos favoritos. ❤️',
      'Todavía quedan muchas fotos por tomar. 💗',
      'Muchos lugares por conocer. 🌷',
      'Muchas risas por compartir. ❤️',
      'Muchas historias por contar. 💕',
      'Muchos momentos por vivir. 🌸',
      'Recuerda nuestro primer diciembre. ❤️',
      'Piensa en aquella Navidad. 💗',
      'Recuerda nuestro Año Nuevo. 🌷',
      'Piensa en todo lo que ha cambiado desde que nos conocimos. ❤️',
      'Todavía tenemos muchas experiencias pendientes. 💕',
      'Recuerda lo bonito que fue encontrarnos. 🌸',
      'Piensa en aquella carta que empezó tantas cosas. ❤️',
      'Recuerda cuando todavía nos daba pena hablar. 💗',
      'Piensa en cómo empezamos a conocernos. 🌷',
      'Nuestra historia sigue escribiéndose. ❤️',
      'Recuerda todo lo que hemos compartido. 💕',
      'Piensa en nuestras conversaciones favoritas. 🌸',
      'Todavía quedan muchísimas páginas por escribir. ❤️',
      'Recuerda nuestras pequeñas aventuras. 💗',
      'Piensa en nuestras risas. 🌷',
      'Mira alguna de nuestras fotos. ❤️',
      'Recuerda lo bonito que fue aquel comienzo. 💕',
      'Todavía habrá muchas fechas para recordar. 🌸',
      'Piensa en todo lo que nos hace sonreír. ❤️',
      'Recuerda nuestros momentos favoritos. 💗',
      'Nuestra historia todavía tiene mucho por contar. 🌷',
      'Cuando me extrañes, vuelve a leer nuestra historia. ❤️',
      'Piensa en aquel día que empezamos. 💕',
      'Recuerda nuestras primeras salidas. 🌸',
      'Piensa en nuestros primeros momentos. ❤️',
      'Todavía nos esperan muchos días bonitos. 💗',
      'Recuerda todo lo que hemos construido. 🌷',
      'Piensa en nuestras mejores conversaciones. ❤️',
      'Nuestra historia está llena de pequeños detalles. 💕',
      'Recuerda cada sonrisa. 🌸',
      'Todavía quedan muchas aventuras pendientes. ❤️',
      'Piensa en nuestros momentos favoritos. 💗',
      'Recuerda que esto apenas comienza. 🌷',
      'Mira una foto nuestra y sonríe. ❤️',
      'Piensa en todo lo bonito que hemos vivido. 💕',
      'Recuerda cómo empezó nuestra historia. 🌸',
      'Todavía quedan muchísimos momentos. ❤️',
      'Piensa en lo bonito que fue conocernos. 💗',
      'Recuerda nuestras primeras conversaciones. 🌷',
      'Nuestra historia continúa. ❤️',
      'Piensa en todos nuestros recuerdos. 💕',
      'Recuerda nuestros días especiales. 🌸',
      'Todavía nos queda muchísimo por vivir. ❤️',
      'Piensa en todas nuestras sonrisas. 💗',
      'Recuerda nuestras aventuras. 🌷',
      'Cuando me extrañes, recuerda todo lo bonito. ❤️',
      'Nuestra historia sigue creciendo. 💕',
      'Piensa en el día que comenzamos. 🌸',
      'Recuerda aquel diciembre. ❤️',
      'Todavía tenemos mucho por escribir. 💗',
      'Y cuando me extrañes, recuerda que te quiero muchísimo. ❤️',
    ],

    // ========================================================
    // 4. CUANDO NO PUEDAS DORMIR
    // ========================================================

    '🌙 Cuando no puedas dormir': [
      'Cierra los ojos y respira lentamente. 🌙',
      'Deja que tu mente descanse poquito a poquito. ❤️',
      'Imagina un lugar tranquilo y bonito. 🌸',
      'Olvida por un momento todo lo que tienes pendiente. 💗',
      'Hoy ya hiciste suficiente. Ahora toca descansar. 🌙',
      'Respira profundo y relaja tus pensamientos. ❤️',
      'Mañana será otro día. 🌷',
      'No tienes que resolver nada esta noche. 💕',
      'Piensa en un recuerdo bonito. 🌸',
      'Cierra los ojos y escucha tu respiración. ❤️',
      'Deja que los pensamientos pasen sin preocuparte por ellos. 🌙',
      'Tu único trabajo ahora es descansar. 💗',
      'Mañana podrás continuar con todo. 🌷',
      'No necesitas pensar en todo al mismo tiempo. ❤️',
      'Imagina que estás en un lugar completamente tranquilo. 💕',
      'Relaja tus hombros y respira. 🌸',
      'Deja que este día termine. ❤️',
      'No tengas prisa por dormir. 🌙',
      'Simplemente descansa. 💗',
      'Piensa en algo que te haga sonreír. 🌷',
      'Recuerda un momento bonito que hayamos vivido. ❤️',
      'Deja que tus pensamientos se hagan más tranquilos. 💕',
      'La noche también puede ser un momento de paz. 🌸',
      'Respira lentamente. ❤️',
      'Cierra los ojos y descansa. 🌙',
      'No pienses en mañana todavía. 💗',
      'Ahora solamente importa que estés tranquila. 🌷',
      'Imagina un cielo lleno de estrellas. ❤️',
      'Deja que tu mente descanse. 💕',
      'Todo puede esperar hasta mañana. 🌸',
      'Esta noche es para descansar. ❤️',
      'Respira y suelta poquito a poquito. 🌙',
      'No necesitas tener todas las respuestas. 💗',
      'Mañana tendrás tiempo para pensar. 🌷',
      'Piensa en algo bonito. ❤️',
      'Recuerda una sonrisa que te guste. 💕',
      'Deja atrás las preocupaciones por unas horas. 🌸',
      'Tu mente también merece descansar. ❤️',
      'No te apresures. 🌙',
      'Todo estará ahí mañana. 💗',
      'Ahora puedes simplemente cerrar los ojos. 🌷',
      'Respira despacio. ❤️',
      'Deja que la noche sea tranquila. 💕',
      'Imagina un lugar donde te sientas cómoda. 🌸',
      'Descansa tus pensamientos. ❤️',
      'No necesitas solucionar nada ahora. 🌙',
      'Mañana es una nueva oportunidad. 💗',
      'Esta noche puede ser tranquila. 🌷',
      'Piensa en algo que te haga feliz. ❤️',
      'Recuerda nuestros momentos bonitos. 💕',
      'Deja que tus pensamientos pasen. 🌸',
      'Respira profundamente. ❤️',
      'Relájate poquito a poquito. 🌙',
      'No hay ninguna prisa. 💗',
      'Puedes dejar todo para mañana. 🌷',
      'Ahora toca descansar. ❤️',
      'Cierra tus ojos y relájate. 💕',
      'Piensa en un lugar tranquilo. 🌸',
      'Que esta noche sea tranquila para ti. ❤️',
      'Deja que el sueño llegue cuando tenga que llegar. 🌙',
      'No te preocupes si todavía no puedes dormir. 💗',
      'Simplemente descansa. 🌷',
      'Mañana podrás continuar. ❤️',
      'Respira y suelta las preocupaciones. 💕',
      'Piensa en una cosa bonita de tu día. 🌸',
      'Deja que la noche te calme. ❤️',
      'No necesitas pensar en todo. 🌙',
      'Descansa tu mente. 💗',
      'Todo puede esperar. 🌷',
      'Cierra los ojos lentamente. ❤️',
      'Respira una vez más. 💕',
      'Imagina un cielo lleno de estrellas. 🌸',
      'Que tengas una noche tranquila. ❤️',
      'No tengas miedo de dejar tus pensamientos descansar. 🌙',
      'Mañana será otra oportunidad. 💗',
      'Ahora solamente descansa. 🌷',
      'Piensa en algo bonito antes de dormir. ❤️',
      'Recuerda que mañana habrá nuevas oportunidades. 💕',
      'Deja que la noche pase tranquilamente. 🌸',
      'No necesitas hacer nada ahora. ❤️',
      'Descansa, mi niña. 🌙',
      'Todo estará bien. 💗',
      'Respira despacio. 🌷',
      'Cierra los ojos. ❤️',
      'Deja que tu mente se calme. 💕',
      'Esta noche es para descansar. 🌸',
      'No pienses demasiado. ❤️',
      'Mañana será un nuevo comienzo. 🌙',
      'Relájate. 💗',
      'Descansa todo lo que puedas. 🌷',
      'Piensa en algo que te haga sonreír. ❤️',
      'Que tus sueños sean bonitos. 💕',
      'Buenas noches, mi niña. 🌸',
      'Descansa mucho. ❤️',
      'Espero que despiertes con una sonrisa. 🌙',
      'Ahora cierra los ojos y descansa. 💗',
    ],

    // ========================================================
    // 5. CUANDO ESTES ENOJADA CONMIGO
    // ========================================================

    '😤 Cuando estés enojada conmigo': [
      'Si estás enojada conmigo, primero quiero que sepas que respeto lo que sientes. ❤️',
      'No quiero que te quedes con algo que te haga sentir mal. 💗',
      'Si hice algo que te lastimó, quiero escucharte. 🌸',
      'No quiero ganar una discusión, quiero entenderte. ❤️',
      'Tus sentimientos también importan. 💕',
      'Si necesitas tiempo para tranquilizarte, tómalo. 🌷',
      'No quiero minimizar lo que sientes. ❤️',
      'Quiero aprender de mis errores. 💗',
      'Si me equivoqué, quiero reconocerlo. 🌸',
      'No quiero que un enojo borre todos nuestros momentos bonitos. ❤️',
      'Cuando estés lista, podemos hablar. 💕',
      'Quiero escucharte de verdad. 🌷',
      'No tienes que fingir que no estás enojada. ❤️',
      'Prefiero que me digas cómo te sientes. 💗',
      'Quiero entender tu punto de vista. 🌸',
      'Si te lastimé, lo siento. ❤️',
      'No quiero que te sientas ignorada. 💕',
      'Tu opinión importa para mí. 🌷',
      'Podemos hablarlo con calma. ❤️',
      'No quiero pelear contigo. 💗',
      'Quiero encontrar una solución contigo. 🌸',
      'Si necesitas espacio, lo respeto. ❤️',
      'Cuando quieras hablar, te escucharé. 💕',
      'No quiero que te guardes las cosas. 🌷',
      'Me importa cómo te sientes. ❤️',
      'Si cometí un error, quiero aprender de él. 💗',
      'No quiero tener la razón a costa de tu tranquilidad. 🌸',
      'Quiero que podamos hablar sin lastimarnos. ❤️',
      'Tu enojo no cambia lo importante que eres para mí. 💕',
      'Prefiero arreglar las cosas que dejar que crezcan. 🌷',
      'Quiero entenderte mejor. ❤️',
      'Si hice algo mal, puedo reconocerlo. 💗',
      'No quiero que terminemos una conversación lastimados. 🌸',
      'Quiero cuidar lo que tenemos. ❤️',
      'Hablemos cuando ambos estemos tranquilos. 💕',
      'No quiero ignorar lo que pasó. 🌷',
      'Quiero escucharte sin interrumpirte. ❤️',
      'Tu forma de sentir también es válida. 💗',
      'No quiero que te sientas sola con tu enojo. 🌸',
      'Podemos solucionar las cosas hablando. ❤️',
      'Me importa nuestra relación. 💕',
      'No quiero repetir un error que te haya lastimado. 🌷',
      'Quiero hacerlo mejor. ❤️',
      'Si necesitas tiempo, está bien. 💗',
      'Cuando estés preparada, hablamos. 🌸',
      'No quiero que una discusión nos aleje. ❤️',
      'Quiero cuidar nuestros momentos. 💕',
      'No estoy aquí para competir contigo. 🌷',
      'Estoy aquí para entenderte. ❤️',
      'Si me equivoqué, quiero mejorar. 💗',
      'No quiero que te sientas incomprendida. 🌸',
      'Quiero escuchar lo que tengas que decir. ❤️',
      'Tus sentimientos tienen importancia. 💕',
      'No quiero que tengas miedo de decirme lo que piensas. 🌷',
      'Podemos hablarlo con cariño. ❤️',
      'No quiero que el orgullo nos impida arreglar algo. 💗',
      'Quiero encontrar una solución contigo. 🌸',
      'Si necesitas respirar antes de hablar, hazlo. ❤️',
      'No quiero empeorar las cosas. 💕',
      'Quiero que podamos resolver nuestros problemas. 🌷',
      'Me importa que estés bien. ❤️',
      'No quiero que un momento difícil defina nuestra historia. 💗',
      'Quiero aprender a escucharte mejor. 🌸',
      'Si te hice sentir mal, lo siento. ❤️',
      'No quiero ignorar tus sentimientos. 💕',
      'Prefiero hablar con calma. 🌷',
      'Quiero que podamos entendernos. ❤️',
      'No quiero tener una pelea contigo. 💗',
      'Quiero que volvamos a estar tranquilos. 🌸',
      'Cuando quieras hablar, aquí estaré. ❤️',
      'No tienes que resolverlo inmediatamente. 💕',
      'Podemos tomar un descanso y después hablar. 🌷',
      'Quiero hacer las cosas mejor. ❤️',
      'Me importa mucho lo que piensas. 💗',
      'No quiero que te quedes con algo guardado. 🌸',
      'Quiero escucharte con atención. ❤️',
      'Si cometí un error, quiero reconocerlo. 💕',
      'No quiero que el orgullo gane. 🌷',
      'Quiero cuidar nuestra relación. ❤️',
      'Podemos aprender de esto. 💗',
      'Quiero que te sientas escuchada. 🌸',
      'No quiero hacerte sentir mal. ❤️',
      'Me importa solucionar las cosas. 💕',
      'Cuando estés lista, hablamos. 🌷',
      'No quiero que una discusión borre todo lo bonito. ❤️',
      'Quiero seguir construyendo cosas bonitas contigo. 💗',
      'Si te lastimé, perdóname. 🌸',
      'Quiero mejorar. ❤️',
      'No quiero que estés triste por algo que hice. 💕',
      'Quiero escucharte. 🌷',
      'Tus sentimientos importan. ❤️',
      'Podemos arreglarlo juntos. 💗',
      'No quiero pelear contigo. 🌸',
      'Quiero que estemos bien. ❤️',
      'Te quiero y también quiero aprender a quererte mejor. 💕',
    ],

    // ========================================================
    // 6. CUANDO QUIERAS SABER QUE TE AMO
    // ========================================================

    '❤️ Cuando quieras saber que te amo': [
      'Te amo porque eres tú. ❤️',
      'Te amo por todos los momentos que compartimos. 💕',
      'Te amo por las sonrisas que hemos vivido juntos. 🌸',
      'Te amo por la persona que eres. ❤️',
      'Te amo porque contigo puedo ser yo mismo. 💗',
      'Te amo por cada pequeño detalle tuyo. 🌷',
      'Te amo por cómo haces especiales los momentos sencillos. ❤️',
      'Te amo por nuestras conversaciones. 💕',
      'Te amo por nuestras risas. 🌸',
      'Te amo por todos nuestros recuerdos. ❤️',
      'Te amo porque eres alguien muy importante para mí. 💗',
      'Te amo porque me haces feliz. 🌷',
      'Te amo por tu forma de ser. ❤️',
      'Te amo por tu sonrisa. 💕',
      'Te amo por tu mirada. 🌸',
      'Te amo por tus manos. ❤️',
      'Te amo por tu cabello. 💗',
      'Te amo por cada pequeño detalle de ti. 🌷',
      'Te amo por cómo haces que un día normal sea especial. ❤️',
      'Te amo por nuestras aventuras. 💕',
      'Te amo por nuestras historias. 🌸',
      'Te amo por todo lo que hemos construido. ❤️',
      'Te amo por lo que somos juntos. 💗',
      'Te amo porque me haces sentir acompañado. 🌷',
      'Te amo por tu manera de hacerme sonreír. ❤️',
      'Te amo porque eres parte de mis recuerdos favoritos. 💕',
      'Te amo porque contigo tengo momentos que quiero guardar para siempre. 🌸',
      'Te amo por cada conversación. ❤️',
      'Te amo por cada risa. 💗',
      'Te amo por cada abrazo. 🌷',
      'Te amo por cada mirada. ❤️',
      'Te amo por cada momento juntos. 💕',
      'Te amo porque contigo quiero seguir creando recuerdos. 🌸',
      'Te amo porque eres especial para mí. ❤️',
      'Te amo porque mi vida tiene momentos más bonitos contigo. 💗',
      'Te amo por todo lo que hemos vivido desde diciembre. 🌷',
      'Te amo por aquel comienzo tan inesperado. ❤️',
      'Te amo por aquella carta que cambió tantas cosas. 💕',
      'Te amo por cómo poco a poco nos acercamos. 🌸',
      'Te amo por nuestra historia. ❤️',
      'Te amo por nuestro presente. 💗',
      'Te amo por todo lo que todavía podemos vivir. 🌷',
      'Te amo por cada recuerdo que hemos creado. ❤️',
      'Te amo por cada momento que me haces sonreír. 💕',
      'Te amo porque contigo puedo imaginar muchos momentos bonitos. 🌸',
      'Te amo porque eres una persona increíble. ❤️',
      'Te amo porque haces que mis días tengan momentos especiales. 💗',
      'Te amo por tus detalles. 🌷',
      'Te amo por tus palabras. ❤️',
      'Te amo por tus gestos. 💕',
      'Te amo por tu manera de mirar. 🌸',
      'Te amo por tu forma de hacerme sentir querido. ❤️',
      'Te amo porque me importas muchísimo. 💗',
      'Te amo porque quiero verte feliz. 🌷',
      'Te amo porque tu sonrisa me alegra. ❤️',
      'Te amo porque disfruto estar contigo. 💕',
      'Te amo porque disfruto hablar contigo. 🌸',
      'Te amo porque disfruto nuestros momentos sencillos. ❤️',
      'Te amo porque eres parte de mi vida. 💗',
      'Te amo porque quiero seguir aprendiendo de ti. 🌷',
      'Te amo porque quiero seguir compartiendo contigo. ❤️',
      'Te amo porque quiero seguir creando recuerdos. 💕',
      'Te amo porque cada día descubro algo bonito de ti. 🌸',
      'Te amo porque eres alguien que quiero cuidar. ❤️',
      'Te amo porque me haces sentir felicidad. 💗',
      'Te amo por todo lo que eres. 🌷',
      'Te amo por todo lo que hemos sido. ❤️',
      'Te amo por todo lo que todavía podemos ser. 💕',
      'Te amo por cada pequeño momento. 🌸',
      'Te amo por nuestras bromas. ❤️',
      'Te amo por nuestras aventuras. 💗',
      'Te amo por nuestros recuerdos. 🌷',
      'Te amo porque eres parte de mis días favoritos. ❤️',
      'Te amo porque quiero seguir compartiendo días contigo. 💕',
      'Te amo porque contigo puedo reír. 🌸',
      'Te amo porque contigo puedo hablar. ❤️',
      'Te amo porque contigo puedo crear recuerdos. 💗',
      'Te amo porque haces que los días sean diferentes. 🌷',
      'Te amo porque simplemente eres tú. ❤️',
      'Te amo por tu forma de ser. 💕',
      'Te amo por tu manera de sonreír. 🌸',
      'Te amo por cómo haces que me sienta. ❤️',
      'Te amo porque eres especial para mí. 💗',
      'Te amo porque quiero verte cumplir tus sueños. 🌷',
      'Te amo porque quiero celebrar tus alegrías. ❤️',
      'Te amo porque quiero acompañarte en tus momentos difíciles. 💕',
      'Te amo porque quiero seguir conociéndote. 🌸',
      'Te amo porque nuestra historia me importa. ❤️',
      'Te amo porque nuestros recuerdos me hacen sonreír. 💗',
      'Te amo porque me encanta compartir contigo. 🌷',
      'Te amo porque eres mi niña. ❤️',
      'Te amo muchísimo. 💕',
      'Te amo más de lo que muchas veces sé explicar con palabras. 🌸',
      'Te amo por todo lo que eres y por todo lo bonito que hemos vivido. ❤️',
      'Y si alguna vez dudas, vuelve a abrir esta sección. 💗',
      'Porque sí, mi niña: te amo. ❤️',
      'Te amo hoy, y quiero seguir creando momentos bonitos contigo. 🌷',
      'Nunca olvides que te amo muchísimo. ❤️',
    ],
  };

  // Frases que ya salieron para evitar repeticiones.
  final Map<String, List<int>> frasesUsadas = {};

  String obtenerFrase(String categoria) {
    final lista = frases[categoria]!;

    frasesUsadas.putIfAbsent(categoria, () => []);

    // Cuando se hayan mostrado las 100,
    // se permite comenzar nuevamente.
    if (frasesUsadas[categoria]!.length >= lista.length) {
      frasesUsadas[categoria]!.clear();
    }

    int indice;

    do {
      indice = random.nextInt(lista.length);
    } while (frasesUsadas[categoria]!.contains(indice));

    frasesUsadas[categoria]!.add(indice);

    return lista[indice];
  }

  void mostrarFrase(String categoria) {
    final frase = obtenerFrase(categoria);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            categoria,
            style: const TextStyle(
              color: rojo,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            frase,
            style: const TextStyle(
              fontSize: 18,
              height: 1.6,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cerrar ❤️',
                style: TextStyle(
                  color: rosa,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData obtenerIcono(String categoria) {
    if (categoria.contains('triste')) {
      return Icons.sentiment_dissatisfied;
    }

    if (categoria.contains('feliz')) {
      return Icons.sentiment_very_satisfied;
    }

    if (categoria.contains('extrañes')) {
      return Icons.favorite_border;
    }

    if (categoria.contains('dormir')) {
      return Icons.nightlight_round;
    }

    if (categoria.contains('enojada')) {
      return Icons.sentiment_dissatisfied_outlined;
    }

    return Icons.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        const SizedBox(height: 10),

        const Text(
          'Abre cuando... 💭',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: rojo,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        const Text(
          'Elige cómo te sientes ❤️',
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        ...frases.keys.map(
              (categoria) {
            return Card(
              margin: const EdgeInsets.only(bottom: 18),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  mostrarFrase(categoria);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: rosaClaro,
                        child: Icon(
                          obtenerIcono(categoria),
                          color: rosa,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Text(
                          categoria,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: rojo,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: rosa,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        const Text(
          'Cada vez que abras una sección encontrarás una frase diferente. ❤️',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}

// ============================================================
// MÚSICA
// ============================================================

class MusicaPage extends StatefulWidget {
  const MusicaPage({super.key});

  @override
  State<MusicaPage> createState() => _MusicaPageState();
}

class _MusicaPageState extends State<MusicaPage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();

  bool reproduciendo = false;
  Duration posicion = Duration.zero;
  Duration duracion = Duration.zero;

  late AnimationController animacion;

  @override
  void initState() {
    super.initState();

    animacion = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    player.onDurationChanged.listen((d) {
      if (mounted) {
        setState(() {
          duracion = d;
        });
      }
    });

    player.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          posicion = p;
        });
      }
    });

    player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          reproduciendo = state == PlayerState.playing;
        });

        if (state == PlayerState.playing) {
          animacion.repeat();
        } else {
          animacion.stop();
        }
      }
    });

    player.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          reproduciendo = false;
          posicion = Duration.zero;
        });

        animacion.reset();
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    animacion.dispose();
    super.dispose();
  }

  Future<void> reproducir() async {
    try {
      if (reproduciendo) {
        await player.pause();
      } else {
        await player.play(
          AssetSource('musico,poetayloco.mp3'),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo reproducir la canción: $e',
          ),
          backgroundColor: rojo,
        ),
      );
    }
  }

  Future<void> reiniciar() async {
    await player.seek(Duration.zero);
  }

  String tiempo(Duration tiempo) {
    String dos(int numero) =>
        numero.toString().padLeft(2, '0');

    final minutos = tiempo.inMinutes;
    final segundos = tiempo.inSeconds % 60;

    return '$minutos:${dos(segundos)}';
  }

  @override
  Widget build(BuildContext context) {
    final maximo = duracion.inMilliseconds > 0
        ? duracion.inMilliseconds.toDouble()
        : 1.0;

    final valor = posicion.inMilliseconds
        .clamp(0, maximo.toInt())
        .toDouble();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          const SizedBox(height: 15),

          const Text(
            'Nuestra canción 🎵',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: rojo,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          const Text(
            'Una canción que quiero compartir contigo ❤️',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // DISCO ANIMADO
          RotationTransition(
            turns: animacion,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    rosa,
                    rojo,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: rosa.withOpacity(0.35),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black87,
                  border: Border.all(
                    color: Colors.white24,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 75,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // NOMBRE
          const Text(
            'Músico, Poeta y Loco',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: rojo,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),

          const Text(
            'Sergio Vega "El Shaka"',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          // BARRA DE PROGRESO
          Slider(
            value: valor,
            min: 0,
            max: maximo,
            activeColor: rosa,
            inactiveColor: rosaClaro,
            onChanged: duracion.inMilliseconds == 0
                ? null
                : (valorNuevo) async {
              await player.seek(
                Duration(
                  milliseconds: valorNuevo.toInt(),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tiempo(posicion),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  tiempo(duracion),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // CONTROLES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: reiniciar,
                icon: const Icon(
                  Icons.replay,
                  size: 30,
                ),
                color: rojo,
              ),

              const SizedBox(width: 15),

              GestureDetector(
                onTap: reproducir,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        rosa,
                        rojo,
                      ],
                    ),
                  ),
                  child: Icon(
                    reproduciendo
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
              ),

              const SizedBox(width: 15),

              IconButton(
                onPressed: () async {
                  await player.stop();

                  if (mounted) {
                    setState(() {
                      posicion = Duration.zero;
                    });
                  }
                },
                icon: const Icon(
                  Icons.stop,
                  size: 30,
                ),
                color: rojo,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // MENSAJE
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: rosaClaro,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: rosa.withOpacity(0.12),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: rosa,
                  size: 40,
                ),

                SizedBox(height: 15),

                Text(
                  'Para Teresita ❤️',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: rojo,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Porque hay canciones que simplemente se sienten diferentes cuando las compartes con alguien especial. 🎵❤️',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),

                Text(
                  'Espero que cada vez que la escuches recuerdes este pequeño detalle. ❤️',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            '🎵 ❤️ 🎵 ❤️ 🎵',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RECUERDOS
// ============================================================

class RecuerdosPage extends StatelessWidget {
  const RecuerdosPage({super.key});

  final List<String> fotos = const [
    'assets/imagenes/img1.jpeg',
    'assets/imagenes/img2.jpeg',
    'assets/imagenes/img3.jpeg',
    'assets/imagenes/img4.jpeg',
    'assets/imagenes/img5.jpeg',
  ];

  final List<String> textos = const [
    'Un momento que quiero guardar para siempre ❤️',
    'Uno de tantos recuerdos bonitos contigo 🌸',
    'Porque cada momento contigo es especial 💕',
    'Un recuerdo más de nosotros ✨',
    'Y los que todavía nos faltan por vivir... ❤️',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),

          const Text(
            'Nuestros recuerdos 📸',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: rojo,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          const Text(
            'Cada foto guarda un momento que significa algo para mí ❤️',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 25),

          ...List.generate(
            fotos.length,
                (index) => Container(
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: rosa.withOpacity(0.18),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // ==================================================
                    // FOTO
                    // ==================================================

                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: rosaClaro,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          fotos[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ==================================================
                    // TEXTO DE LA FOTO
                    // ==================================================

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        textos[index],
                        style: const TextStyle(
                          fontSize: 17,
                          color: rojo,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ==================================================
                    // NUMERACIÓN
                    // ==================================================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: rosa,
                          size: 20,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '${index + 1} / ${fotos.length}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.favorite,
                          color: rosa,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ==========================================================
          // MENSAJE FINAL
          // ==========================================================

          const Text(
            'Y todavía nos quedan muchísimos recuerdos por crear... ❤️',
            style: TextStyle(
              fontSize: 19,
              color: rojo,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ============================================================
// SORPRESA FINAL
// ============================================================

class SorpresaPage extends StatefulWidget {
  const SorpresaPage({super.key});

  @override
  State<SorpresaPage> createState() => _SorpresaPageState();
}

class _SorpresaPageState extends State<SorpresaPage>
    with SingleTickerProviderStateMixin {
  bool abierta = false;

  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    scale = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void abrir() {
    setState(() {
      abierta = true;
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Text(
              'Llegaste hasta el final... 🎁',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: rojo,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            if (!abierta) ...[
              const Text(
                'Pero todavía queda una última sorpresa.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              GestureDetector(
                onTap: abrir,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: rosa,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: rosa.withOpacity(0.35),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Toca el regalo ❤️',
                style: TextStyle(
                  fontSize: 20,
                  color: rojo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            if (abierta)
              ScaleTransition(
                scale: scale,
                child: Column(
                  children: [
                    const Text(
                      '🎉 ❤️ 🎂 ❤️ 🎉',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            rosa,
                            rojo,
                          ],
                        ),
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 70,
                          ),

                          SizedBox(height: 20),

                          Text(
                            'Teresita ❤️',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(
                            'Feliz cumpleaños, mi niña.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 20),

                          Text(
                            'Espero que nunca olvides lo especial que eres y que este pequeño detalle te recuerde cuánto significas para mí.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 25),

                          Text(
                            '❤️ 19 años ❤️',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(
                            'Con cariño, para mi niña.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      '✨ Fin... por ahora ✨',
                      style: TextStyle(
                        fontSize: 20,
                        color: rojo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}