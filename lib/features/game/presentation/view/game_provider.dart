import 'package:abc_fun/core/db/daos/action_custom_item_dao.dart';
import 'package:abc_fun/core/providers/providers.dart';
import 'package:abc_fun/features/game/data/action_items_default_data_source_imp.dart';
import 'package:abc_fun/features/game/data/action_items_local_data_source_imp.dart';
import 'package:abc_fun/features/game/data/action_items_repository.dart';
import 'package:abc_fun/features/game/presentation/bloc/game_bloc.dart';
import 'package:abc_fun/features/game/presentation/view/game_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

@RoutePage()
class GameProvider extends StatelessWidget {
  const GameProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (context) => GameBloc(
        repository: ActionItemsRepositoryImp(
          defaultDataSource: ActionItemsDefaultDataSourceImp(),
          localDataSource: ActionItemsLocalDataSourceImp(
            ActionCustomItemDao(
              provider.read<Future<Isar>>(Providers.db),
            ),
          ),
        ),
      ),
      child: const GamePage(),
    );
  }
}
