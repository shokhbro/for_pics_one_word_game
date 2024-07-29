import 'package:get/get.dart';
import 'package:word_game/models/question.dart';

class GameController extends GetxController {
  var questions = <Question>[];
  RxInt currentQuestionIndex = 0.obs;
  RxString userAnswer = ''.obs;
  RxInt correctAnswersCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  void _loadQuestions() {
    questions.addAll([
      Question(
        imagePath: [
          'assets/images/think1.png',
          'assets/images/think2.png',
          'assets/images/think3.png',
          'assets/images/think4.png',
        ],
        letters: ['T', 'H', 'I', 'N', 'K'],
        shuffledLetters: _shuffle(['T', 'H', 'I', 'N', 'K']),
        correctAnswer: 'THINK',
      ),
      Question(
        imagePath: [
          'assets/images/drink1.png',
          'assets/images/drink2.png',
          'assets/images/drink3.png',
          'assets/images/drink4.png',
        ],
        letters: ['D', 'R', 'I', 'N', 'K'],
        shuffledLetters: _shuffle(['D', 'R', 'I', 'N', 'K']),
        correctAnswer: 'DRINK',
      ),
      Question(
        imagePath: [
          'assets/images/sleep1.png',
          'assets/images/sleep2.png',
          'assets/images/sleep3.png',
          'assets/images/sleep4.png',
        ],
        letters: ['S', 'L', 'E', 'E', 'P'],
        shuffledLetters: _shuffle(['S', 'L', 'E', 'E', 'P']),
        correctAnswer: 'SLEEP',
      ),
      Question(
        imagePath: [
          'assets/images/hard1.png',
          'assets/images/hard2.png',
          'assets/images/hard3.png',
          'assets/images/hard4.png',
        ],
        letters: ['H', 'A', 'R', 'D'],
        shuffledLetters: _shuffle(['H', 'A', 'R', 'D']),
        correctAnswer: 'HARD',
      ),
    ]);
  }

  List<String> _shuffle(List<String> list) {
    list.shuffle();
    return list;
  }

  void checkAnswer() {
    final currentQuestion = questions[currentQuestionIndex.value];
    if (userAnswer.value.toUpperCase() == currentQuestion.correctAnswer) {
      correctAnswersCount.value++;
      Get.defaultDialog(
        title: 'Correct!',
        middleText: 'You guessed correctly!',
        onConfirm: () {
          _nextQuestion();
          Get.back();
        },
      );
    } else {
      Get.defaultDialog(
        title: 'Incorrect!',
        onConfirm: () {
          _nextQuestion();
          Get.back();
        },
      );
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      userAnswer.value = '';
    } else {
      Get.defaultDialog(
        title: 'Game Over!',
        middleText:
            'You got ${correctAnswersCount.value} out of ${questions.length} correct.',
        onConfirm: () => Get.back(),
      );
    }
  }

  void updateUserAnswer(String letter) {
    if (userAnswer.value.length <
        questions[currentQuestionIndex.value].correctAnswer.length) {
      userAnswer.value += letter;
    }
  }
}
