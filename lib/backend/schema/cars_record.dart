import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class CarsRecord extends FirestoreRecord {
  CarsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "mark" field.
  String? _mark;
  String get mark => _mark ?? '';
  bool hasMark() => _mark != null;

  // "models" field.
  List<String>? _models;
  List<String> get models => _models ?? const [];
  bool hasModels() => _models != null;

  void _initializeFields() {
    _mark = snapshotData['mark'] as String?;
    _models = getDataList(snapshotData['models']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cars');

  static Stream<CarsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CarsRecord.fromSnapshot(s));

  static Future<CarsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CarsRecord.fromSnapshot(s));

  static CarsRecord fromSnapshot(DocumentSnapshot snapshot) => CarsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CarsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CarsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CarsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CarsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCarsRecordData({
  String? mark,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'mark': mark,
    }.withoutNulls,
  );

  return firestoreData;
}

class CarsRecordDocumentEquality implements Equality<CarsRecord> {
  const CarsRecordDocumentEquality();

  @override
  bool equals(CarsRecord? e1, CarsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.mark == e2?.mark && listEquality.equals(e1?.models, e2?.models);
  }

  @override
  int hash(CarsRecord? e) => const ListEquality().hash([e?.mark, e?.models]);

  @override
  bool isValidKey(Object? o) => o is CarsRecord;
}
