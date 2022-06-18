import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit() : super(GetUsersInitial());
  getUsers() async {
    try {
      emit(GetUsersLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(GetUsersSuccess(['Ali', 'Kiba']));
    } catch (e) {
      emit(GetUsersFailed(e.toString()));
    }
  }
}
