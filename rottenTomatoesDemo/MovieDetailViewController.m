//
//  MovieDetailViewController.m
//  rottenTomatoesDemo
//
//  Created by Vinit Patwa on 10/19/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsis;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

- (void)loadHighResImage:(NSString *)strUrl currentImageView:(UIImageView *)imageView;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.movie[@"title"];
    NSString *posterUrl = self.movie[@"posters"][@"detailed"];
    NSURL *url = [NSURL URLWithString:posterUrl];
    [self.moviePoster setImageWithURL:url];

    [self loadHighResImage:posterUrl currentImageView:self.moviePoster];
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    self.movieName.text = self.movie[@"title"];
    self.movieSynopsis.text = self.movie[@"synopsis"];
}


- (void)loadHighResImage:(NSString *)strUrl currentImageView:(UIImageView *)imageView {
    NSString *posterUrlHigh = [strUrl stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"ori.jpg"];
    NSURL *urlObject = [NSURL URLWithString:posterUrlHigh];
    __weak UIImageView *iv = imageView;
    [imageView
     setImageWithURLRequest:[NSURLRequest requestWithURL:urlObject]
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             iv.image = image;
      }
     failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
