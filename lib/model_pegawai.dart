class ModelPegawai {
  int _id;
  String _firstName;
  String _lastName;
  String _mobileNo;
  String _emailId;

  ModelPegawai(this._firstName, this._lastName, this._mobileNo, this._emailId);

  ModelPegawai.map(dynamic obj){
    this._id = obj['id'];
    this._firstName = obj['firstname'];
    this._lastName = obj['lastname'];
    this._mobileNo = obj['mobileno'];
    this._emailId  = obj['emailid'];
  }

  int get id => _id;
  String get firstname => _firstName;
  String get lastname => _lastName;
  String get mobileno => _mobileNo;
  String get emailid  => _emailId;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if (_id !=null) {
        map['id'] = _id;
      }
      map['firstname'] = _firstName;
      map['lastname']  = _lastName;
      map['mobileno']  = _mobileNo;
      map['emailid']   = _emailId;

      return map;
  }

  ModelPegawai.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._firstName = map['firstname'];
    this._lastName = map['lastname'];
    this._mobileNo = map['mobileno'];
    this._emailId  = map['emailid'];
  }
}