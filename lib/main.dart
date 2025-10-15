import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const QuizPage(),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;

  final List<Question> _questions = [
    Question(
      questionText: 'Thủ đô của nước ta Việt Nam hiên nay tên là gì ấy nhỉ haha?',
      options: ['Hà Nội', 'TP.HCM', 'Đà Nẵng', 'Cần Thơ'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: '2 + 2 bằng bao nhiêu?',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Màu của bầu trời là gì?',
      options: ['Đỏ', 'Xanh', 'Vàng', 'Trắng'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Flutter là gì?',
      options: ['Ngôn ngữ lập trình', 'Framework', 'Hệ điều hành', 'Trình duyệt'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Năm 2023 là năm gì?',
      options: ['Mèo', 'Gà', 'Chó', 'Lợn'],
      correctAnswerIndex: 1,
    ),
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _quizCompleted ? _buildResult() : _buildQuestion(),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_currentQuestionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Câu hỏi ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                question.questionText,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ...question.options.asMap().entries.map((entry) {
          int index = entry.key;
          String option = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
              onPressed: () => _answerQuestion(index),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 3,
              ),
              child: Text(
                '${String.fromCharCode(65 + index)}. $option',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResult() {
    int totalQuestions = _questions.length;
    int correctAnswers = _score;
    int incorrectAnswers = totalQuestions - correctAnswers;
    double percentage = (correctAnswers / totalQuestions) * 100;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    percentage >= 70 ? Icons.emoji_events : Icons.sentiment_satisfied,
                    size: 64,
                    color: percentage >= 70 ? Colors.amber : Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kết quả',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: percentage >= 70 ? Colors.green : Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Điểm số: $_score/$totalQuestions',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        'Đúng: $correctAnswers',
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.cancel, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'Sai: $incorrectAnswers',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _resetQuiz,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Làm lại'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 3,
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