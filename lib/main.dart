import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCojlCZZsusP0DjKGQkuKhn5wWaWh_E20U",
      appId: "1:1072405782576:android:5a8d848cb1c38fc2428df5",
      messagingSenderId: "1072405782576",
      projectId: "quiz-648e9",
      databaseURL: "https://quiz-648e9-default-rtdb.firebaseio.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("questions");
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    DatabaseEvent event = await ref.once();
    Map<Object?, Object?>? data = event.snapshot.value as Map<Object?, Object?>?;

    if (data != null) {
      setState(() {
        questions = data.values
            .map((q) => Map<String, dynamic>.from(q as Map<Object?, dynamic>))
            .toList();
      });
    }
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      score++;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Quiz Finalizado!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text("Você acertou $score de ${questions.length} perguntas!", style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                });
              },
              child: Text("Reiniciar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  @override
@override
Widget build(BuildContext context) {
  if (questions.isEmpty) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.amber,
      title: Text("Quiz do Haas", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              questions[currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),

          // Options Buttons
          ...List.generate(
            (questions[currentQuestionIndex]['options'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
                .length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(index),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  child: Text(
                    questions[currentQuestionIndex]['options'][index].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text("Sua Pontuação: $score", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
}
