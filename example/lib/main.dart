import 'package:flutter/material.dart';
import 'package:nik_validator/nik_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIK Validator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("NIK Validator"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nikController = TextEditingController();
  NIKModel? nikResult;
  
  ///Validate NIK informations
  void validate() async {
    if (nikController.text.isNotEmpty) {
      NIKModel result = await NIKValidator.instance.parse(nik: nikController.text);
      ///use result.valid to check if the nik is valid
      setState(() {
        nikResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _fieldNIK(),
              _buttonParse(),
              SizedBox(height: 20),
              nikResult != null
                ? _resultWidget()
                : SizedBox(),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultWidget() {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _textWidgeT(
              title: "NIK",
              value: nikResult!.nik!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Kode Unik",
              value: nikResult!.uniqueCode!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Jenis Kelamin",
              value: nikResult!.gender!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Tanggal Lahir",
              value: nikResult!.bornDate!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Usia",
              value: nikResult!.age!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Ulang Tahun",
              value: nikResult!.nextBirthday!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Zodiak",
              value: nikResult!.zodiac!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Provinsi",
              value: nikResult!.province!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Kota/Kabupaten",
              value: nikResult!.city!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Kecamatan",
              value: nikResult!.subdistrict!
            ),
            Divider(color: Colors.black),
            _textWidgeT(
              title: "Kode Pos",
              value: nikResult!.postalCode!
            ),
          ],
        ),
      ),
    );
  }

  Widget _textWidgeT({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18
            ),
          ),
        )
      ],
    );
  }

  Widget _fieldNIK() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nikController,
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Masukkan nomor NIK",
            border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.blue)),
            labelText: "NIK"
          ),
        ),
        SizedBox(height: 5),
        
        nikResult != null && nikResult!.valid == false
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kode NIK tidak valid",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15
                ),
              ),
              SizedBox(height: 5),
            ],
          )
          : SizedBox()
      ],
    );
  }

  Widget _buttonParse() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
        ),
        onPressed: () => validate(),
        child: Text(
          "Validate NIK",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}