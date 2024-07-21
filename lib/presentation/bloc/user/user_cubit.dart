import 'package:course_tusk_app/data/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<User> {
  UserCubit() : super(User());

  update(User n) => emit(n);
}
