//
//  ViewController.m
//  datadb
//
//  Created by Yulin Zhao on 2019/2/2.
//  Copyright © 2019 Yulin Zhao. All rights reserved.
//

#import "ViewController.h"
#import "DBTool.h"
@interface ViewController ()
@property(nonatomic,strong)DBTool * db;
@property(nonatomic,strong)NSString * tableName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建database路径
   NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
   DBTool * dbtool = [DBTool share];
    //2.创建对应路径下数据库
   BOOL hav_db = [dbtool createDBWithDBName:@"fisrt.db" path:docuPath];
    if (hav_db) {
        _tableName = @"student";
     BOOL hav_table = [dbtool createTable:_tableName dicOrModel:@{@"name":@"TEXT",@"age":@"INTEGER",@"number":@"INTEGER"}];
        if (hav_table) {
             NSLog(@"建表成功");
        }else{
             NSLog(@"建表失败");
        }
    }else{
        NSLog(@"建库失败");
    }
   
}
- (IBAction)insert:(id)sender {
     DBTool * dbtool = [DBTool share];
     NSLog(@"%p",dbtool);
    for (int i = 0; i<10; i++) {
    NSString * name = [NSString stringWithFormat:@"san+%d",i];
        NSInteger age = 10+i;
        NSInteger number = 20+i;
    [dbtool insertTable:_tableName dicOrModel:@{@"name":name,@"age":@(age),@"number":@(number)}];
    }
}
- (IBAction)delete:(id)sender {
     DBTool * dbtool = [DBTool share];
    NSString * where = @"where name like 'san+7'";
    [dbtool deleteTable:_tableName whereFormat:where];
}
- (IBAction)update:(id)sender {
     DBTool * dbtool = [DBTool share];
    NSString * where = @"where number>25;";
    [dbtool updateTable:_tableName dicOrModel:@{@"age":@(10)} whereFormat:where];
}
- (IBAction)find:(id)sender {
     DBTool * dbtool = [DBTool share];
    NSString * where = @"";
    NSArray * arr = [dbtool lookupTable:_tableName dicOrModel:@{@"name":@"TEXT",@"age":@"INTEGER",@"number":@"INTEGER"} whereFormat:where];
    for (NSDictionary * dic  in arr) {
        NSLog(@"look=====%@",dic);
    }
}

@end
