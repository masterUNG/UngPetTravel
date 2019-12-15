class TravelModel {

  String name, detail, address, path;
  double lat, lng;

  TravelModel(this.name, this.detail, this.address, this.path, this.lat, this.lng);

  TravelModel.fromJSON(Map<String, dynamic> map){

    name = map['Name'];
    detail = map['Detail'];
    address = map['Address'];
    path = map['Path'];
    lat = map['Lat'];
    lng = map['Lng'];

  }
  
}