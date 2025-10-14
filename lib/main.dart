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
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizCompleted ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_currentQuestionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Câu hỏi ${_currentQuestionIndex + 1}/${_questions.length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          question.questionText,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ...question.options.asMap().entries.map((entry) {
          int index = entry.key;
          String option = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ElevatedButton(
              onPressed: () => _answerQuestion(index),
              child: Text('${String.fromCharCode(65 + index)}. $option'),
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

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Kết quả',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Điểm số: $_score/$totalQuestions',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Câu đúng: $correctAnswers',
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
          Text(
            'Câu sai: $incorrectAnswers',
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _resetQuiz,
            child: const Text('Làm lại'),
          ),
        ],
      ),
    );
  }
}