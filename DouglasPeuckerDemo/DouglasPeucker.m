//
//  DouglasPeucker.m
//  DouglasPeuckerDemo
//
//  Created by 杨磊 on 2018/7/18.
//

#import "DouglasPeucker.h"
#import "LatLngEntity.h"
@implementation DouglasPeucker

/**
 * 道格拉斯算法，处理coordinateList序列
 * 先将首末两点加入points序列中，然后在coordinateList序列找出距离首末点连线距离的最大距离值dmax并与阈值threshold进行比较，
 * 若大于阈值则将这个点加入points序列，重新遍历points序列。否则将两点间的所有点(coordinateList)移除
 * @return 返回经过道格拉斯算法后得到的点的序列
 */
- (NSArray*)douglasAlgorithm:(NSArray <LatLngEntity *>*)coordinateList threshold:(CGFloat)threshold{
    // 将首末两点加入到序列中
    NSMutableArray *points = [NSMutableArray array];
    NSMutableArray *list = [NSMutableArray arrayWithArray:coordinateList];
    
    [points addObject:list[0]];
    [points addObject:coordinateList[coordinateList.count - 1]];
    
    for (NSInteger i = 0; i<points.count - 1; i++) {
        NSUInteger start = (NSUInteger)[list indexOfObject:points[i]];
        NSUInteger end = (NSUInteger)[list indexOfObject:points[i+1]];
        if ((end - start) == 1) {
            continue;
        }
        NSString *value = [self getMaxDistance:list startIndex:start endIndex:end threshold:threshold];
        NSString *dist = [value componentsSeparatedByString:@","][0];
        CGFloat maxDist = [dist floatValue];
        
        //大于限差 将点加入到points数组
        if (maxDist >= threshold) {
            NSInteger position = [[value componentsSeparatedByString:@","][1] integerValue];
            [points insertObject:list[position] atIndex:i+1];
            // 将循环变量i初始化,即重新遍历points序列
            i = -1;
        }else {
            /**
             * 将两点间的点全部删除
             */
            NSInteger removePosition = start + 1;
            for (NSInteger j = 0; j < end - start - 1; j++) {
                [list removeObjectAtIndex:removePosition];
            }
        }
    }
    
    return points;
}

/**
 * 根据给定的始末点，计算出距离始末点直线的最远距离和点在coordinateList列表中的位置
 * @param startIndex 遍历coordinateList起始点
 * @param endIndex 遍历coordinateList终点
 * @return maxDistance + "," + position 返回最大距离+"," + 在coordinateList中位置
 */
- (NSString *)getMaxDistance:(NSArray <LatLngEntity *>*)coordinateList startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex threshold:(CGFloat)threshold{
    
    CGFloat maxDistance = -1;
    NSInteger position = -1;
    CGFloat distance = [self getDistance:coordinateList[startIndex] lastEntity:coordinateList[endIndex]];
    
    for(NSInteger i = startIndex; i < endIndex; i++){
        CGFloat firstSide = [self getDistance:coordinateList[startIndex] lastEntity:coordinateList[i]];
        if(firstSide < threshold){
            continue;
        }
        
        CGFloat lastSide = [self getDistance:coordinateList[endIndex] lastEntity:coordinateList[i]];
        if(lastSide < threshold){
            continue;
        }
        
        // 使用海伦公式求距离
        CGFloat p = (distance + firstSide + lastSide) / 2.0;
        CGFloat dis = sqrt(p * (p - distance) * (p - firstSide) * (p - lastSide)) / distance * 2;
        
        if(dis > maxDistance){
            maxDistance = dis;
            position = i;
        }
    }
    
    NSString *strMaxDistance = [NSString stringWithFormat:@"%f,%ld", maxDistance,position];
    return strMaxDistance;
}

// 两点间距离公式
- (CGFloat)getDistance:(LatLngEntity*)firstEntity lastEntity:(LatLngEntity*)lastEntity{
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:firstEntity.Latitude longitude:firstEntity.Longitude];
    CLLocation *lastLocation = [[CLLocation alloc] initWithLatitude:lastEntity.Latitude longitude:lastEntity.Longitude];
    
    CGFloat  distance  = [firstLocation distanceFromLocation:lastLocation];
    return  distance;
}

@end
