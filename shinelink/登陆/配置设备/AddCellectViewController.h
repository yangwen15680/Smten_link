//
//  AddCellectViewController.h
//  ShinePhone
//
//  Created by ZML on 15/5/26.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AddCellectViewController : RootViewController
@property(nonatomic,strong)NSString *stationId;
- (instancetype)initWithDataDict:(NSMutableDictionary *)dataDict;
@end
