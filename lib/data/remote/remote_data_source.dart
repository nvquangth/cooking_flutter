import 'dart:convert';

import 'package:cooking_flutter/data/constant/constant.dart';
import 'package:cooking_flutter/data/model/category.dart';
import 'package:cooking_flutter/data/model/recipe.dart';
import 'package:cooking_flutter/data/remote/response/category_response.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<Category>> getCategories();

  Future<List<Recipe>> getRecipes();

  Future<List<Recipe>> getRecipesByCategory(int categoryId);

  Future<List<Recipe>> getRecipesByName(String name);
}

class _RemoteDataSource implements RemoteDataSource {
  static _RemoteDataSource _instance;

  factory _RemoteDataSource() {
    if (_instance == null) {
      _instance = _RemoteDataSource._internal();
    }
    return _instance;
  }

  _RemoteDataSource._internal();

  @override
  Future<List<Category>> getCategories() async {
    final response = await http.get(_getFullUrl(Constant.ROUTE_CATEGORY));
    return _isSuccess(response)
        ? CategoryResponse.fromJsonMap(json.decode(response.body)).categories
        : throw Exception(Constant.PARAM_ERROR);
  }

  @override
  Future<List<Recipe>> getRecipes() {
    // TODO: implement getRecipes
    return null;
  }

  @override
  Future<List<Recipe>> getRecipesByCategory(int categoryId) {
    // TODO: implement getRecipesByCategory
    return null;
  }

  @override
  Future<List<Recipe>> getRecipesByName(String name) {
    // TODO: implement getRecipesByName
    return null;
  }

  String _getFullUrl(String path) => Constant.BASE_URL + path;

  Uri _uriPathQuery(String path, Map<String, String> query) =>
      Uri.https(Constant.DOMAIN_URL, "/$path", query);

  bool _isSuccess(http.Response response) {
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}