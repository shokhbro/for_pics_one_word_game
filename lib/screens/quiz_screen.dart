import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_game/controller/game_controller.dart';

class QuizScreen extends StatelessWidget {
  final GameController _gameController = Get.put(GameController());

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final currentQuestion = _gameController
              .questions[_gameController.currentQuestionIndex.value];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: DecorationImage(
                          image: AssetImage(currentQuestion.imagePath[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          _gameController.currentQuestionIndex.value = index;
                          _gameController.userAnswer.value = '';
                        },
                      ),
                    );
                  },
                ),
              ),
              _buildAnswerBoxes(currentQuestion.correctAnswer),
              const SizedBox(height: 40),
              _buildLetterButtons(currentQuestion.shuffledLetters),
              const SizedBox(height: 50),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: _gameController.checkAnswer,
                  child: const Icon(Icons.check),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnswerBoxes(String correctAnswer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        correctAnswer.length,
        (index) => Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 3),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              _gameController.userAnswer.value.length > index
                  ? _gameController.userAnswer.value[index]
                  : '',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLetterButtons(List<String> letters) {
    return Wrap(
      spacing: 10,
      children: letters.map((letter) {
        return ElevatedButton(
          onPressed: () => _gameController.updateUserAnswer(letter),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              // Adjust the radius here
            ),
            minimumSize: const Size(55, 50),
          ),
          child: Text(letter),
        );
      }).toList(),
    );
  }
}
