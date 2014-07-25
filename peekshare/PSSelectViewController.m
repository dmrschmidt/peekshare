//
//  PSSelectViewController.m
//  peekshare
//
//  Created by Dennis Schmidt on 25.07.14.
//  Copyright (c) 2014 Dennis Schmidt. All rights reserved.
//

#import "PSSelectViewController.h"
#import "TSAssetsPickerController.h"
#import "GalleryViewController.h"
#import "ALAssetAdapter.h"

@interface PSSelectViewController () <UINavigationControllerDelegate, TSAssetsPickerControllerDelegate, TSAssetsPickerControllerDataSource>
@property(nonatomic) TSAssetsPickerController *assetsPickerController;
@property(nonatomic) NSMutableArray *adaptedAssets;
@property(nonatomic) BOOL firstRun;
@end

@implementation PSSelectViewController

#pragma mark - View Lifecycle

- (id)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    _firstRun = YES;
  }

  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if (self.firstRun) {
    self.firstRun = NO;

    self.assetsPickerController = [TSAssetsPickerController new];
    self.assetsPickerController.delegate = self;
    self.assetsPickerController.dataSource = self;
    [self presentViewController:self.assetsPickerController animated:YES completion:nil];
  }
}

#pragma mark - TSAssetsPickerControllerDataSource

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
  NSLog(@"finished picking %@", assets);

  self.adaptedAssets = [[NSMutableArray alloc] initWithCapacity:assets.count];
  [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
      ALAssetAdapter *assetAdapter = [[ALAssetAdapter alloc] init];
      assetAdapter.asset = asset;

      [self.adaptedAssets addObject:assetAdapter];
  }];

  GalleryViewController *galleryViewController = [[GalleryViewController alloc] init];
  galleryViewController.assets = self.adaptedAssets;
//  [self dismissViewControllerAnimated:NO completion:nil];
  [self.assetsPickerController presentViewController:galleryViewController animated:NO completion:nil];
}

- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
  NSLog(@"canceled picking");
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
  NSLog(@"failed picking");
}

#pragma mark - TSAssetsPickerControllerDataSource

- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
  return INT_MAX;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
  return [TSFilter filterWithType:FilterTypePhoto];
}

@end
