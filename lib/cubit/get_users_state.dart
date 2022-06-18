part of 'get_users_cubit.dart';

@immutable
abstract class GetUsersState {}

class GetUsersInitial extends GetUsersState {}

class GetUsersLoading extends GetUsersState {}

class GetUsersSuccess extends GetUsersState {
  final List<String> users;

  GetUsersSuccess(this.users);
}

class GetUsersFailed extends GetUsersState {
  final String error;

  GetUsersFailed(this.error);
}
