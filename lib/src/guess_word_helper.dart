import 'dart:math';

class GuessWordHelper {
  var _allowedWords = [
    'Elevant',
    'Tiiger',
    'Kass',
    'Koer',
    'Hobune',
    'Hiir',
    'Kaelkirjak',
    'Piison',
    'Lammas',
    'Kits',
    'Lehm',
    'Rebane',
    'Hunt',
    'Pruunkaru',
    'Konn',
    'Hüljes',
    'Orav',
    'Kobras',
    'Rästik',
    'Metskits',
    'Siil',
    'Hirv',
    'Sisalik',
    'Ilves',
    'Jänes',
    'Mäger',
    'Metssiga',
    'Põder',
    'Nahkhiir',
    'Põlluhiir',
    'Siga',
    'Kana',
    'Kukk',
    'Rott',
    'Part',
    'Küülik',
    'Kalkun',
    'Hani',
    'Lõvi',
    'Sebra'
  ];

  String generateRandomWord() {
    var randomGenerator = Random();
    var randomIndex = randomGenerator.nextInt(_allowedWords.length);

    return _allowedWords[randomIndex].toUpperCase();
  }  
}