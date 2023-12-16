class Person {
  String name;
  double height;
  double weight;
  late double bmi;

  Person({
    required this.name,
    required this.height,
    required this.weight,
  }) {
    calculateBMI();
  }

  void calculateBMI() {
    if (height > 0 && weight > 0) {
      bmi = weight / ((height / 100) * (height / 100));
    } else {
      bmi = 0.0;
    }
  }

  void updateBMI() {
    calculateBMI();
  }
}