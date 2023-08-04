import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_news/product/enums/platform_enum.dart';
import 'package:full_news/product/models/number_model.dart';
import 'package:full_news/product/utility/firebase/firebase_collaction.dart';
import 'package:full_news/product/utility/version_manager.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(const SplashState());
  Future<void> checkApplicationVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();

    if (databaseValue == null || databaseValue.isEmpty) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    ;
    final checkIsNeedForceUpdate = VersionManager(
        deviceValue: clientVersion, databaseValue: databaseValue);

    if(checkIsNeedForceUpdate.isNeedUpdate()){
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }

    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) return null;

    final response = await FirebaseCollection.version.reference
        .withConverter<NumberModel>(
          fromFirestore: (snapshot, options) =>
              NumberModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc()
        .get();

    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  const SplashState({this.isRequiredForceUpdate, this.isRedirectHome});

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequiredForceUpdate:
          isRequiredForceUpdate ?? this.isRequiredForceUpdate,
          isRedirectHome:
          isRedirectHome ?? this.isRedirectHome,
    );
  }
}
