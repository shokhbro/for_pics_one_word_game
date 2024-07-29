class Question {
  final List<String> imagePath;
  final List<String> letters;
  final List<String> shuffledLetters;
  final String correctAnswer;

  Question({
    required this.imagePath,
    required this.letters,
    required this.shuffledLetters,
    required this.correctAnswer,
  });
}
