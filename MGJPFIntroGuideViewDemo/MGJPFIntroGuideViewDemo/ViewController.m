//
//  ViewController.m
//  MGJPFIntroGuideViewDemo
//
//  Created by Senmiao on 16/7/15.
//  Copyright © 2016年 Senmiao. All rights reserved.
//

#import "ViewController.h"
#import <MGJPFIntroguideView/MGJPFIntroguideView.h>

@interface CollectionViewCell : UICollectionViewCell

@end

@implementation CollectionViewCell

@end

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *introduceArray;
@property (nonatomic, strong) MGJPFIntroGuideView *coachMarksView;
@property (nonatomic, assign) BOOL coachMarksShown;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.coachMarksView.animationDuration = 0.3;
    [self.navigationController.view addSubview:self.coachMarksView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collectionView.layoutMargins = UIEdgeInsetsMake(30, 10, 0, 10);
}

- (void)viewDidLayoutSubviews {
    if (self.coachMarksShown == NO  && self.introduceArray.count) {
        // 展示引导层
        self.coachMarksShown = YES;
        [self.coachMarksView loadMarks:self.introduceArray];
        self.coachMarksView.showFrequency = 1;
        [self.coachMarksView start];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        [self.introduceArray addObject:cell];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%100/100. green:arc4random()%100/100. blue:arc4random()%100/100. alpha:arc4random()%100/100.];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)/3 - 10;
    return (CGSize){width,width};
}

#pragma mark - getter Method
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSMutableArray *)introduceArray {
    if (_introduceArray == nil) {
        _introduceArray = [NSMutableArray array];
    }
    return _introduceArray;
}

- (MGJPFIntroGuideView *)coachMarksView {
    if (!_coachMarksView) {
        _coachMarksView = [[MGJPFIntroGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _coachMarksView;
}

@end
