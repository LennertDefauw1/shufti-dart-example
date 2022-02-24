import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shuftipro_sdk/shuftipro_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'OpenSans'
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFace = false,
      isDoc = false,
      isDoc2 = false,
      isAddress = false,
      isConsent = false,
      isBackground = false,
      isPhone = false;


  var authObject = {
    "auth_type": "basic_auth",
    "client_Id": clientId,
    "secret_key": secretKey,
  };
  Map<String, Object> createdPayload = {
    "country": "GB",
    "language": "EN",
    "email": "",
    "callback_url": "http://www.example.com",
    "redirect_url": "https://www.mydummy.package_sample.com/",
    "show_consent": 1,
    "show_privacy_policy": 1,
    "verification_mode": "image_only",
  };
  Map<String,Object> configObj = {
    "open_webview": false,
    "asyncRequest": false,
    "captureEnabled": false,
  };
  Map<String, Object> verificationObj = {
    "face": {},
    "background_checks": {},
    "phone": {},
    "document": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card",
      ],
      "name": {
        "first_name": "frstName",
        "last_name": "",
        "middle_name": "",
      },
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "fetch_enhanced_data": "",
      "gender": "",
      "backside_proof_required": "0",
    },
    "document_two": {
      "supported_types": [
        "passport",
        "id_card",
        "driving_license",
        "credit_or_debit_card"
      ],
      "name": {"first_name": "", "last_name": "", "middle_name": ""},
      "dob": "",
      "document_number": "",
      "expiry_date": "",
      "issue_date": "",
      "fetch_enhanced_data": "",
      "gender": "",
      "backside_proof_required": "0",
    },
    "address": {
      "full_address": "",
      "name": {
        "first_name": "",
        "last_name": "",
        "middle_name": "",
        "fuzzy_match": "",
      },
      "supported_types": ["id_card", "utility_bill", "bank_statement"],
    },
    "consent": {
      "supported_types": ["printed", "handwritten"],
      "text": "My name is John Doe and I authorize this transaction of \$100/-",
    },
  };

  void faceChk(bool? newVal) => setState(() {
    if(newVal == true){
      isFace = true;
    }else{
      isFace = false;
    }
    if (isFace) {
      createdPayload["face"] = verificationObj['face']as Map<dynamic,dynamic>;
    } else if (!isFace) {
      createdPayload.remove('face');
    }
  });

  void docChk(bool? newVal) => setState(() {
    if(newVal == true){
      isDoc = true;
    }else{
      isDoc = false;
    }
    if (isDoc) {
      createdPayload["document"] = verificationObj['document']as Map<String,Object>;
    } else if (!isDoc) {
      createdPayload.remove('document');
    }
  });

  void docChk2(bool? newVal) => setState(() {
    if(newVal == true){
      isDoc2 = true;
    }else{
      isDoc2 = false;
    }
    if (isDoc2) {
      createdPayload["document_two"] = verificationObj['document_two']as Map<String,Object>;
    } else if (!isDoc2) {
      createdPayload.remove('document_two');
    }
  });

  void addressChk(bool? newVal) => setState(() {
    if(newVal == true){
      isAddress = true;
    }else{
      isAddress = false;
    }
    if (isAddress) {
      createdPayload["address"] = verificationObj['address']as Map<String,Object>;
    } else if (!isAddress) {
      createdPayload.remove('address');
    }
  });

  void consentChk(bool? newVal) => setState(() {
    if(newVal == true){
      isConsent = true;
    }else{
      isConsent = false;
    }
    if (isConsent) {
      createdPayload["consent"] = verificationObj['consent']as Map<String,Object>;
    } else if (!isConsent) {
      createdPayload.remove('consent');
    }
  });

  void backgroundChk(bool? newVal) => setState(() {
    if(newVal == true){
      isBackground = true;
    }else{
      isBackground = false;
    }
    if (isBackground){
      createdPayload["background_checks"] = verificationObj['background_checks'] as Map<dynamic,dynamic>;
    } else if (!isBackground) {
      createdPayload.remove('background_checks');
    }
  });

  void phoneChk(bool? newVal) => setState(() {
    if(newVal == true){
      isPhone = true;
    }else{
      isPhone = false;
    }
    if (isPhone) {
      createdPayload["phone"] = verificationObj['phone'] as Map<dynamic,dynamic>;
    } else if (!isPhone) {
      createdPayload.remove('phone');
    }
  });

  void continueFun() {
    if(isFace || isDoc || isDoc2 || isAddress ||isConsent || isBackground || isPhone){
      var v = DateTime.now();
      var reference = "package_sample_Flutter_$v";
      createdPayload["reference"] = reference;
      print('continue: $createdPayload');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new MySecond(authObject: authObject, config: configObj,
          createdPayload: createdPayload, callback: (String value) {  },)),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select atleast one method of verification.'),
      ));
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black45,
        width: 0.5,
      ),
    );
  }

  int web= 0, syn = 0, consnt = 1, privcy = 1, reslt = 1, backs = 0;
  var asyncVar= false;
  Map<String,Object> docObjTemp = {};


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () =>
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 45.w,
                    left: 15.w,
                    bottom: 35.w,
                    right: 15.w,
                  ),
                  child: new Text(
                    "Verification",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.w,
                  ),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: new Text(
                      "Choose your method \nof Verification",
                      style: new TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),


                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 20.w,
                        bottom: 2.w,
                        right: 7.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed: () {
                            if(web == 1){
                              createdPayload["open_webView"] = false;
                              setState(() => web = 0);
                            }
                            else{
                              createdPayload["open_webView"] = true;
                              setState(() => web = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: web == 0 ? new Text(
                              "open_webview: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "open_webview: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 0.w,
                        bottom: 2.w,
                        right: 7.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed: () {
                            if(syn == 1){
                              configObj["asyncRequest"] = false;
                              setState(() => syn = 0);
                            }
                            else{
                              configObj["asyncRequest"] = true;
                              setState(() => syn = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: syn == 0 ? new Text(
                              "async: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "async: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 0.w,
                        bottom: 2.w,
                        right: 5.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed: () {
                            if(consnt == 1){
                              createdPayload["show_consent"] = 0;
                              setState(() => consnt = 0);
                            }
                            else{
                              createdPayload["show_consent"] = 1;
                              setState(() => consnt = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: consnt == 0? new Text(
                              "show_consent: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "show_consent: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 20.w,
                        bottom: 2.w,
                        right: 7.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed:  () {
                            if(privcy == 1){
                              createdPayload["show_privacy_policy"] = 0;
                              setState(() => privcy = 0);
                            }
                            else{
                              createdPayload["show_privacy_policy"] = 1;
                              setState(() => privcy = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: privcy== 0? new Text(
                              "privacy_policy: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "privacy_policy: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 0.w,
                        bottom: 2.w,
                        right: 5.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed:   () {
                            if(reslt == 1){
                              createdPayload["show_results"] = 0;
                              setState(() => reslt = 0);
                            }
                            else{
                              createdPayload["show_results"] = 1;
                              setState(() => reslt = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: reslt==0? new Text(
                              "show_results: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "show_results: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.w,
                        left: 0.w,
                        bottom: 2.w,
                        right: 5.w,
                      ),
                      child: Container(
                        child: OutlinedButton(
                          onPressed:   () {
                            docObjTemp = verificationObj["document"] as Map<String,Object>;
                            if(backs == 1){
                              docObjTemp["backside_proof_required"] = 0;
                              setState(() => backs = 0);
                            }
                            else{
                              docObjTemp["backside_proof_required"] = 1;
                              setState(() => backs = 1);
                            }
                          },
                          style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          child: new Container(
                            alignment: Alignment.center,
                            height: 45.h,
                            width: 0.2.sw,
                            child: backs==0? new Text(
                              "backside: 0",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ): new Text(
                              "backside: 1",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 295.h,
                  child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                            top: 0.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              faceChk(!isFace);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                        child: new IconButton(
                                          icon: Image.asset('assets/images/face.png'),
                                          onPressed: null,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Face Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Checkbox(
                                      value: isFace,
                                      onChanged: faceChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              docChk(!isDoc);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/document.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Document Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isDoc,
                                      onChanged: docChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              docChk2(!isDoc2);
                            },
                            child: new Container(

                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/document.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Document Two Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isDoc2,
                                      onChanged: docChk2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              addressChk(!isAddress);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/address.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Address Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isAddress,
                                      onChanged: addressChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              consentChk(!isConsent);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/consent.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Consent Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isConsent,
                                      onChanged: consentChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              backgroundChk(!isBackground);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/bgChecks.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Background Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isBackground,
                                      onChanged: backgroundChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            bottom: 5.w,
                            right: 20.w,
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              phoneChk(!isPhone);
                            },
                            child: new Container(
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new IconButton(
                                        icon: Image.asset('assets/images/2fa.png'),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 5.w,
                                    ),
                                    child: Container(
                                      child: new Text(
                                        "Two Factor Verification",
                                        style: new TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Checkbox(
                                      value: isPhone,
                                      onChanged: phoneChk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.w,
                    left: 10.w,
                    bottom: 20.w,
                    right: 10.w,
                  ),
                  child: Container(
                    child: OutlinedButton(
                      onPressed: continueFun,
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
                      child: new Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        width: 1.sw,
                        child: new Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) );
  }
}


String clientId = "";//Set your client id here.
String secretKey = ""; //Set your secret key here.

typedef CalbackFunction = void Function(String value);

var response = "";
bool isDoc = false;
Map<String, Object> secondPayload = {},secondConfig={};
var secondAuthObject;


class MySecond extends StatefulWidget {
  final CalbackFunction callback;
  MySecond(
      {var authObject,
        required Map<String,Object> config,
        required Map<String, Object> createdPayload, required this.callback}) {
    secondConfig = config;
    secondAuthObject = authObject;
    secondPayload = createdPayload;
  }

  @override
  SecondScreen createState() => new SecondScreen();
}

class SecondScreen extends State<MySecond>{
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String response = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try{
      response = await ShuftiproSdk.sendRequest(authObject: secondAuthObject,
          createdPayload: secondPayload, configObject: secondConfig);
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
        content: Text(response),
      ));
    }catch(e){
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 27,
            width: 27,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Image(
              image: AssetImage("assets/images/back_icon.png"),
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 65.w,
                left: 15.w,
                bottom: 25.w,
                right: 15.w,
              ),
              child: Image(
                image: AssetImage("assets/images/selectTypeIcon.png"),
                height: 100.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.w,
                left: 15.w,
                bottom: 5.w,
                right: 15.w,
              ),
              child: Text(
                'Choose Verification Type',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 15.w,
                left: 10.w,
                bottom: 5.w,
                right: 10.w,
              ),
              child: GestureDetector(
                onTap: () {
                  secondPayload["verification_mode"] = "image_only";
                  initPlatformState();

                },
                child: Container(
                  height: 40.h,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          height: 40.h,
                          width: 0.11.sw,
                          child: new IconButton(
                            icon: Image.asset('assets/images/imageCam.png'),
                            onPressed: null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          child: new Text(
                            "Image Proof",
                            style: new TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 6.w,
                        ),
                        child: Container(
                          height: 18.h,
                          width: 0.06.sw,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          alignment: Alignment.centerRight,
                          child: Image(
                            image: AssetImage("assets/images/continue_next.png"),
                            height: 18.h,
                            width: 0.06.sw,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                bottom: 5.w,
                right: 10.w,
              ),
              child: GestureDetector(
                onTap: () {
                  secondPayload["verification_mode"] = "video_only";
                  initPlatformState();
                },
                child: Container(
                  height: 40.h,
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          height: 40.h,
                          width: 0.11.sw,
                          child: new IconButton(
                            icon: Image.asset('assets/images/videoCam.png'),
                            onPressed: null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Container(
                          child: new Text(
                            "Video Proof ",
                            style: new TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 6.w,
                        ),
                        child: Container(
                          height: 18.h,
                          width: 0.06.sw,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          alignment: Alignment.centerRight,
                          child: Image(
                            image: AssetImage("assets/images/continue_next.png"),
                            height: 18.h,
                            width: 0.06.sw,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 9.w,
              ),
              child: Container(
                  height: 13.h,
                  child: Image.asset("assets/images/footerImage.png")),
            ),

          ],
        ),
      ),
    );
  }
}