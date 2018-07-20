//
//  DouglasPeucker.h
//  DouglasPeuckerDemo
//
//  Created by 杨磊 on 2018/7/18.
//  Copyright © 2018年 Beijing Sino Dance Culture Media Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
/**
 道格拉斯-普克算法(Douglas–Peucker algorithm，亦称为拉默-道格拉斯-普克算法、迭代适应点算法、分裂与合并算法)是将曲线近似表示为一系列点，并减少点的数量的一种算法。该算法的原始类型分别由乌尔斯·拉默（Urs Ramer）于1972年以及大卫·道格拉斯（David Douglas）和托马斯·普克（Thomas Peucker）于1973年提出，并在之后的数十年中由其他学者予以完善。
 
 
 经典的Douglas-Peucker算法描述如下：
 
 （1）在曲线首尾两点A，B之间连接一条直线AB，该直线为曲线的弦；
 
 （2）得到曲线上离该直线段距离最大的点C，计算其与AB的距离d；
 
 （3）比较该距离与预先给定的阈值threshold的大小，如果小于threshold，则该直线段作为曲线的近似，该段曲线处理完毕。
 
 （4）如果距离大于阈值，则用C将曲线分为两段AC和BC，并分别对两段取信进行1~3的处理。
 
 （5）当所有曲线都处理完毕时，依次连接各个分割点形成的折线，即可以作为曲线的近似。
 
 */

@interface DouglasPeucker : NSObject


/**
 对数组进行抽稀算法

 @param coordinateList 原始数据
 @param threshold 阈值 控制数据压缩精度的极差
 @return 处理过的数据
 */
- (NSArray*)douglasAlgorithm:(NSArray *)coordinateList threshold:(CGFloat)threshold;

@end
