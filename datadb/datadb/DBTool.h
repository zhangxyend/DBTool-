//
//  DBTool.h
//  datadb
//
//  Created by Yulin Zhao on 2019/2/11.
//  Copyright © 2019 Yulin Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTool : NSObject
+(instancetype)share;
//默认在NSDocumentDirectory下创建dbName.sqlite
- (BOOL)createDBWithDBName:(NSString *)dbName;
//在dbPath路径下创建dbName.sqlite
- (BOOL)createDBWithDBName:(NSString *)dbName path:(NSString *)dbPath;
/**
 创建表 通过传入的model或dictionary(如果是字典注意类型要写对),虽然都可以不过还是推荐以下都用model
 
 @param tableName 表的名称
 @param parameters 设置表的字段,可以传model(runtime自动生成字段)或字典(格式:@{@"name":@"TEXT"})
 @return 是否创建成功
 */
//主键是默认自动创建的,名为pkid,如果你需要在你的Model中使用主键, 需要添加主键属性, 属性名必须为pkid
//@property (nonatomic, assign)NSInteger pkid;
//主键不会参加插入和修改操作
- (BOOL)createTable:(NSString *)tableName dicOrModel:(id)parameters;
//无论你想插入的是一个model还是dictionary都没问题,都会智能接收并存储;
- (BOOL)insertTable:(NSString *)tableName dicOrModel:(id)parameters;
//插入一组数据, 也支持model和dictionary混合的数组
- (NSArray *)insertTable:(NSString *)tableName dicOrModelArray:(NSArray *)dicOrModelArray;
//根据条件语句删除想要删除的数据
- (BOOL)deleteTable:(NSString *)tableName whereFormat:(NSString *)format, ...;
//根据表名tableName删除表
- (BOOL)deleteAllDataFromTable:(NSString *)tableName;
//parameters为要更新的数据,可以是model或dictionary, format为条件语句
- (BOOL)updateTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...;
//parameters为查找到数据后每条数据要存入的模型,可以为model或dictionary
- (NSArray *)lookupTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...;
/**
 Person *p = [[Person alloc] init];
 p.name = @"小李";
 for (int i=0,i < 1000,i++) {
 [jq jq_inTransaction:^(BOOL *rollback) {
 BOOL flag = [jq jq_insertTable:@"users" dicOrModel:p];
 if (!flag) {
 *rollback = YES; //只要有一次不成功,则进行回滚操作
 return;
 }
 }];
 }
 */
// 操作事务的方法
- (void)inTransaction:(void(^)(BOOL *rollback))block;
@end
