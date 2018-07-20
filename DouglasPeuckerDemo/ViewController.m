//
//  ViewController.m
//  DouglasPeuckerDemo
//
//  Created by 杨磊 on 2018/7/20.
//

#import "ViewController.h"
#import "LatLngEntity.h"
#import "DouglasPeucker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"20180715113556366" ofType:@"csv"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:bundle];
    if (!isExist)
    {
        return;
    }
    
    NSError *error = nil;
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *fileContents = [NSString stringWithContentsOfFile:bundle encoding:encode error:&error];
    if (error)
    {
        return;
    }
    
    NSArray *locationArr = [fileContents componentsSeparatedByString:@"\n"];
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (NSString *str in locationArr)
    {
        if (!str)
        {
            continue;
        }
        NSArray *strArr = [str componentsSeparatedByString:@","];
        if (strArr.count == 8 && strArr[1] && strArr[2])
        {
            LatLngEntity *entity = [LatLngEntity new];
            entity.Longitude = [strArr[1] doubleValue];
            entity.Latitude  = [strArr[2] doubleValue];
            [modelArr addObject:entity];
        }
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        DouglasPeucker *peucker = [DouglasPeucker new];
        NSArray *arrPeucker = modelArr;
        if (modelArr.count > 300)
        {//轨迹大于300个点做一下数据抽稀
            arrPeucker = [peucker douglasAlgorithm:modelArr threshold:5];
        }
        NSLog(@"原来有%ld个轨迹点 抽稀后有%ld个轨迹点",modelArr.count,arrPeucker.count);
        dispatch_async(dispatch_get_main_queue(), ^{
           //do something...
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
