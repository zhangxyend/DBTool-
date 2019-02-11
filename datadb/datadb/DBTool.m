//
//  DBTool.m
//  datadb
//
//  Created by Yulin Zhao on 2019/2/11.
//  Copyright © 2019 Yulin Zhao. All rights reserved.
//


#import "DBTool.h"
#import <JQFMDB.h>
@interface DBTool ()
@property(nonatomic,strong)JQFMDB * db;
@end
static DBTool * _dbTool;
@implementation DBTool
+ (instancetype)share{
    static dispatch_once_t onceToken;
    if (!_dbTool) {
        dispatch_once(&onceToken, ^{
            _dbTool = [[DBTool alloc]init];
        });
    }
    return _dbTool;
}
//默认在NSDocumentDirectory下创建dbName.sqlite
- (BOOL)createDBWithDBName:(NSString *)dbName{
    _db = [[JQFMDB alloc]initWithDBName:dbName];
    if (_db) {
        return YES;
    }
    return NO;
}
//在dbPath路径下创建dbName.sqlite
- (BOOL)createDBWithDBName:(NSString *)dbName path:(NSString *)dbPath{
    _db = [[JQFMDB alloc]initWithDBName:dbName path:dbPath];
    if (_db) {
        return YES;
    }
    return NO;
}
//创建表
- (BOOL)createTable:(NSString *)tableName dicOrModel:(id)parameters{
    return [_db jq_createTable:tableName dicOrModel:parameters];
}
//插入一个数据
- (BOOL)insertTable:(NSString *)tableName dicOrModel:(id)parameters{
    return [_db jq_insertTable:tableName dicOrModel:parameters];
}
//插入一组数据
- (NSArray *)insertTable:(NSString *)tableName dicOrModelArray:(NSArray *)dicOrModelArray{
    return [_db jq_insertTable:tableName dicOrModelArray:dicOrModelArray];
}
//根据条件语句删除想要删除的数据
- (BOOL)deleteTable:(NSString *)tableName whereFormat:(NSString *)format, ...{
    return [_db jq_deleteTable:tableName whereFormat:format];
}
//根据表名tableName删除表
- (BOOL)deleteAllDataFromTable:(NSString *)tableName{
    return [_db jq_deleteTable:tableName];
}
//parameters为要更新的数据,可以是model或dictionary, format为条件语句
- (BOOL)updateTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...{
    return [_db jq_updateTable:tableName dicOrModel:parameters whereFormat:format];
}
//parameters为查找到数据后每条数据要存入的模型,可以为model或dictionary
- (NSArray *)lookupTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...{
    return [_db jq_lookupTable:tableName dicOrModel:parameters whereFormat:format];
}
// 操作事务的方法
- (void)inTransaction:(void(^)(BOOL *rollback))block{
    [_db jq_inTransaction:block];
}
@end
