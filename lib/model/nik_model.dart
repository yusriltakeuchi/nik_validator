
class NIKModel {
  String nik;
  String gender;
  String bornDate;
  String province;
  String city;
  String subdistrict;
  int uniqueCode;
  String postalCode;
  String age;
  int ageYear;
  int ageMonth;
  int ageDay;
  String nextBirthday;
  String zodiac;
  bool valid;

  NIKModel({
    this.nik, this.gender,
    this.bornDate, this.province,
    this.city, this.subdistrict,
    this.uniqueCode, this.postalCode,
    this.age, this.zodiac,
    this.valid, this.ageYear, 
    this.ageMonth, this.ageDay,
    this.nextBirthday
  });

  factory NIKModel.empty() => NIKModel(
    nik: "NOT FOUND" ?? " ",
    uniqueCode: 0,
    gender: " ",
    bornDate: " ",
    age: " ",
    ageYear: 0,
    ageMonth: 0,
    ageDay: 0,
    nextBirthday: " ",
    zodiac: " ",
    province: " ",
    city: " ",
    subdistrict: " ",
    postalCode: " ",
    valid:  false
  );
}