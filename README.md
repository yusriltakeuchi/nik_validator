
# nik_validator

NIK Validator is a package to converting Indonesian Identity Card Number into useful informations.
You just call the function .parse and input NIK number in the parameter, then you will get the informations, without internet connection (offline)

[![GitHub issues](https://img.shields.io/github/issues/yusriltakeuchi/nik_validator.svg)](https://github.com/yusriltakeuchi/nik_validator/issues/)&nbsp;  [![GitHub pull-requests](https://img.shields.io/github/issues-pr/yusriltakeuchi/nik_validator.svg)](https://GitHub.com/yusriltakeuchi/nik_validator/pull/)&nbsp; [![Example](https://img.shields.io/badge/Example-Ex-success)](https://pub.dev/packages/nik_validator/example)&nbsp; [![Star](https://img.shields.io/github/stars/yusriltakeuchi/nik_validator?style=social)](https://github.com/yusriltakeuchi/nik_validator/star)&nbsp; [![Get the library](https://img.shields.io/badge/Get%20library-pub-blue)](https://pub.dev/packages/nik_validator)

<img src="https://i.ibb.co/B4716Rt/IMG-20210220-184403.jpg" height="480px">

# Example Code:
```dart
NIKModel result = await NIKValidator.instance.parse(nik: nik);
/// When nik is valid
if (result.valid) {
  print("NIK: ${result.nik}");
  print("UNIQUE CODE: ${result.uniqueCode}");
  print("GENDER: ${result.gender}");
  print("BORNDATE: ${result.bornDate}");
  print("AGE: ${result.age}");
  print("NEXT BIRTHDAY: ${result.nextBirthday}");
  print("ZODIAC: ${result.zodiac}");
  print("PROVINCE: ${result.province}");
  print("CITY: ${result.city}");
  print("SUBDISTRICT: ${result.subdistrict}");
  print("POSTAL CODE: ${result.postalCode}");
}
```

# About Me
Visit my website : [leeyurani.com](https://leeyurani.com)
Follow my Github : [![GitHub followers](https://img.shields.io/github/followers/yusriltakeuchi.svg?style=social&label=Follow&maxAge=2592000)](https://github.com/yusriltakeuchi?tab=followers)
