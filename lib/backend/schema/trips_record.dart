import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class TripsRecord extends FirestoreRecord {
  TripsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "FROM" field.
  String? _from;
  String get from => _from ?? '';
  bool hasFrom() => _from != null;

  // "TO" field.
  String? _to;
  String get to => _to ?? '';
  bool hasTo() => _to != null;

  // "When" field.
  DateTime? _when;
  DateTime? get when => _when;
  bool hasWhen() => _when != null;

  // "car" field.
  DocumentReference? _car;
  DocumentReference? get car => _car;
  bool hasCar() => _car != null;

  // "driver" field.
  DocumentReference? _driver;
  DocumentReference? get driver => _driver;
  bool hasDriver() => _driver != null;

  // "passngers" field.
  List<DocumentReference>? _passngers;
  List<DocumentReference> get passngers => _passngers ?? const [];
  bool hasPassngers() => _passngers != null;

  void _initializeFields() {
    _from = snapshotData['FROM'] as String?;
    _to = snapshotData['TO'] as String?;
    _when = snapshotData['When'] as DateTime?;
    _car = snapshotData['car'] as DocumentReference?;
    _driver = snapshotData['driver'] as DocumentReference?;
    _passngers = getDataList(snapshotData['passngers']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trips');

  static Stream<TripsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TripsRecord.fromSnapshot(s));

  static Future<TripsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TripsRecord.fromSnapshot(s));

  static TripsRecord fromSnapshot(DocumentSnapshot snapshot) => TripsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TripsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TripsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TripsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TripsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTripsRecordData({
  String? from,
  String? to,
  DateTime? when,
  DocumentReference? car,
  DocumentReference? driver,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'FROM': from,
      'TO': to,
      'When': when,
      'car': car,
      'driver': driver,
    }.withoutNulls,
  );

  return firestoreData;
}

class TripsRecordDocumentEquality implements Equality<TripsRecord> {
  const TripsRecordDocumentEquality();

  @override
  bool equals(TripsRecord? e1, TripsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.from == e2?.from &&
        e1?.to == e2?.to &&
        e1?.when == e2?.when &&
        e1?.car == e2?.car &&
        e1?.driver == e2?.driver &&
        listEquality.equals(e1?.passngers, e2?.passngers);
  }

  @override
  int hash(TripsRecord? e) => const ListEquality()
      .hash([e?.from, e?.to, e?.when, e?.car, e?.driver, e?.passngers]);

  @override
  bool isValidKey(Object? o) => o is TripsRecord;
}
