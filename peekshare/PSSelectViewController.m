//
//  PSSelectViewController.m
//  peekshare
//
//  Created by Dennis Schmidt on 25.07.14.
//  Copyright (c) 2014 Dennis Schmidt. All rights reserved.
//

#import "PSSelectViewController.h"
#import "TSAssetsPickerController.h"

@interface PSSelectViewController () <UINavigationControllerDelegate, TSAssetsPickerControllerDelegate, TSAssetsPickerControllerDataSource>
@property(nonatomic, strong) TSAssetsPickerController *assetsPickerController;
@end

@implementation PSSelectViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.assetsPickerController = [TSAssetsPickerController new];
  self.assetsPickerController.delegate = self;
  self.assetsPickerController.dataSource = self;
  [self presentViewController:self.assetsPickerController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TSAssetsPickerControllerDataSource

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {

}

- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {

}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {

}

#pragma mark - TSAssetsPickerControllerDataSource

- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
  return INT_MAX;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
  return [TSFilter filterWithType:FilterTypePhoto];
}

@end
