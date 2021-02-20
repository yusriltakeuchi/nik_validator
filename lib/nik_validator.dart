library nik_validator;
import 'dart:convert';

import 'package:age/age.dart';
import 'package:flutter/services.dart';
import 'package:nik_validator/model/nik_model.dart';

class NIKValidator {

  /// Create instance class object
  static NIKValidator instance = NIKValidator();
  
  /// Get current year and get the last 2 digit numbers
  int _getCurrentYear() => int.parse(DateTime.now().year.toString().substring(2, 4));
  
  /// Get year in NIK
  int _getNIKYear(String nik) => int.parse(nik.substring(10, 12));

  /// Get date in NIK
  int _getNIKDate(String nik) => int.parse(nik.substring(6, 8));
  String _getNIKDateFull(String nik, bool isWoman) {
    int date = int.parse(nik.substring(6, 8));
    if (isWoman) {
      date -= 40;
    }
    return date > 10 ? date.toString() : "0$date";
  } 

  /// Get subdistrict split postalcode
  List<String> _getSubdistrictPostalCode(String nik, Map<String, dynamic> location) => location['kecamatan'][nik.substring(0, 6)].toString().toUpperCase().split(" -- "); 

  /// Get province in NIK
  String _getProvince(String nik, Map<String, dynamic> location) => location['provinsi'][nik.substring(0, 2)];

  /// Get city in NIK
  String _getCity(String nik, Map<String, dynamic> location) => location['kabkot'][nik.substring(0, 4)];

  /// Get NIK Gender
  String _getGender(int date) => date > 40 ? "PEREMPUAN" : "LAKI-LAKI";

  /// Get born month
  int _getBornMonth(String nik) => int.parse(nik.substring(8, 10)); 
  String _getBornMonthFull(String nik) => nik.substring(8, 10);

  /// Get born year
  String _getBornYear(int nikYear, int currentYear) => nikYear < currentYear ? "20${nikYear > 10 ? nikYear : '0' + nikYear.toString()}" : "19${nikYear > 10 ? nikYear : '0' + nikYear.toString()}";

  /// Get unique code in NIK
  String _getUniqueCode(String nik) => nik.substring(12, 16);

  /// Get age from nik
  AgeDuration _getAge(DateTime bornDate, DateTime now) => Age.dateDifference(fromDate: bornDate, toDate: now, includeToDate: false);

  /// Get next birthday
  AgeDuration _getNextBirthday(DateTime bornDate, DateTime now) => Age.dateDifference(fromDate: now, toDate: bornDate);

  /// Get Zodiac from bornDate and bornMonth
  String _getZodiac(int date, int month, bool isWoman) {

    if (isWoman)
      date -= 40;

    if ((month == 1 && date >= 20) || (month == 2 && date < 19))
      return "Aquarius";

    if ((month == 2 && date >= 19) || (month == 3 && date < 21))
      return "Pisces";

    if ((month == 3 && date >= 21) || (month == 4 && date < 20))
      return "Aries";

    if ((month == 4 && date >= 20) || (month == 5 && date < 21))
      return "Taurus";

    if ((month == 5 && date >= 21) || (month == 6 && date < 22))
      return "Gemini";
    
    if ((month == 6 && date >= 21) || (month == 7 && date < 23))
      return "Cancer";

    if ((month == 7 && date >= 23) || (month == 8 && date < 23))
      return "Leo";

    if ((month == 8 && date >= 23) || (month == 9 && date < 23))
      return "Virgo";

    if ((month == 9 && date >= 23) || (month == 10 && date < 24))
      return "Libra";

    if ((month == 10 && date >= 24) || (month == 11 && date < 23))
      return "Scorpio";

    if ((month == 11 && date >= 23) || (month == 12 && date < 22))
      return "Sagitarius";

    if ((month == 12 && date >= 22) || (month == 1 && date < 20))
      return "Capricorn";

    return "Zodiak tidak ditemukan";
  }

  /// Parsing Identity Card information from Indonesia
  /// by using unique number [nik]
  /// 
  /// You can get an information like address, city,
  /// gender, and others
  Future<NIKModel> parse({String nik}) async {
    Map<String, dynamic> location = await _getLocationAsset();

    /// Check NIK and make sure is correct
    if (_validate(nik, location)) {
      
      int currentYear = _getCurrentYear();
      int nikYear = _getNIKYear(nik);
      int nikDate = _getNIKDate(nik);
      String gender = _getGender(nikDate);

      String nikDateFull = _getNIKDateFull(nik, gender == "PEREMPUAN");

      List<String> subdistrictPostalCode = _getSubdistrictPostalCode(nik, location);
      String province = _getProvince(nik, location);
      String city = _getCity(nik, location);
      String subdistrict = subdistrictPostalCode[0];
      String postalCode = subdistrictPostalCode[1];

      int bornMonth = _getBornMonth(nik);
      String bornMonthFull = _getBornMonthFull(nik);
      String bornYear = _getBornYear(nikYear, currentYear);

      String uniqueCode = _getUniqueCode(nik); 
      String zodiac = _getZodiac(nikDate, bornMonth, gender == "PEREMPUAN");
      AgeDuration age = _getAge(DateTime.parse("$bornYear-$bornMonthFull-$nikDateFull"), DateTime.now());
      AgeDuration nextBirthday = _getNextBirthday(DateTime.parse("$bornYear-$bornMonthFull-$nikDateFull"), DateTime.now());

      return NIKModel(
        nik: nik ?? " ",
        uniqueCode: uniqueCode ?? " ",
        gender: gender ?? " ",
        bornDate: "$nikDateFull-$bornMonthFull-$bornYear" ?? " ",
        age: "${age.years} tahun, ${age.months} bulan, ${age.days} hari" ?? " ",
        ageYear: age.years ?? 0,
        ageMonth: age.months ?? 0,
        ageDay: age.days ?? 0,
        nextBirthday: "${nextBirthday.months} bulan ${nextBirthday.days} hari lagi" ?? " ",
        zodiac: zodiac ?? " ",
        province: province ?? " ",
        city: city ?? " ",
        subdistrict: subdistrict ?? " ",
        postalCode: postalCode ?? " ",
        valid: true ?? false
      );
    }
    return NIKModel.empty();
  }

  /// Validate NIK and make sure the number is correct
  bool _validate(String nik, Map<String, dynamic> location) {
    return nik.length == 16 
      && location['provinsi'][nik.substring(0, 2)] != null
      && location['kabkot'][nik.substring(0, 4)] != null
      && location['kecamatan'][nik.substring(0, 6)] != null;
  }

  /// Load location asset like province, city and subdistrict
  /// from local json data
  Future<Map<String, dynamic>> _getLocationAsset() async 
    => jsonDecode(await rootBundle.loadString("packages/nik_validator/assets/wilayah.json"));
}