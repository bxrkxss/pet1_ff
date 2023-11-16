import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class CarUserRecord extends FirestoreRecord {
  CarUserRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "mark" field.
  String? _mark;
  String get mark => _mark ?? '';
  bool hasMark() => _mark != null;

  // "model" field.
  String? _model;
  String get model => _model ?? '';
  bool hasModel() => _model != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "regnumber" field.
  String? _regnumber;
  String get regnumber => _regnumber ?? '';
  bool hasRegnumber() => _regnumber != null;

  void _initializeFields() {
    _mark = snapshotData['mark'] as String?;
    _model = snapshotData['model'] as String?;
    _image = snapshotData['image'] as String?;
    _regnumber = snapshotData['regnumber'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('car_user');

  static Stream<CarUserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CarUserRecord.fromSnapshot(s));

  static Future<CarUserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CarUserRecord.fromSnapshot(s));

  static CarUserRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CarUserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CarUserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CarUserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CarUserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CarUserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCarUserRecordData({
  String? mark,
  String? model,
  String? image,
  String? regnumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'mark': mark,
      'model': model,
      'image': image,
      'regnumber': regnumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class CarUserRecordDocumentEquality implements Equality<CarUserRecord> {
  const CarUserRecordDocumentEquality();

  @override
  bool equals(CarUserRecord? e1, CarUserRecord? e2) {
    return e1?.mark == e2?.mark &&
        e1?.model == e2?.model &&
        e1?.image == e2?.image &&
        e1?.regnumber == e2?.regnumber;
  }

  @override
  int hash(CarUserRecord? e) =>
      const ListEquality().hash([e?.mark, e?.model, e?.image, e?.regnumber]);

  @override
  bool isValidKey(Object? o) => o is CarUserRecord;
}
