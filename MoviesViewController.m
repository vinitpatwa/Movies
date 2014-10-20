//
//  MoviesViewController.m
//  rottenTomatoesDemo
//
//  Created by Vinit Patwa on 10/15/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "MovieDetailViewController.h"
#import "WBErrorNoticeView.h"

@interface MoviesViewController ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;

- (IBAction)showWithStatus;
- (IBAction)dismiss;
- (IBAction)dismissSuccess;
- (IBAction)dismissError;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showWithStatus];
    
    self.title = @"Movies";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120;
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieCell" bundle:nil];
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"MovieCell"];
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=j26mp33uc2p8ds9cdkfp64tg"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"Network Error!" message:@"Please check your Network Connection"];
            notice.alpha = 0.8;
            notice.originY = 60;
            [notice show];
            [self dismissError];
        } else {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = responseDictionary[@"movies"];
            [self.tableView reloadData];
            [self dismissSuccess];
            self.refreshControl = [[UIRefreshControl alloc] init];
            [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
            [self.tableView insertSubview:self.refreshControl atIndex:0];
        }
    }];
}

- (void)onRefresh {
    [self showWithStatus];
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=j26mp33uc2p8ds9cdkfp64tg"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [self.refreshControl endRefreshing];
            [self dismissError];
        } else {
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            [self dismissSuccess];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [self.tableView  dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    cell.movieName.text = self.movies[indexPath.row][@"title"];
    cell.movieDescription.text = self.movies[indexPath.row][@"synopsis"];
    NSString *urlString = self.movies[indexPath.row][@"posters"][@"profile"];
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.poster setImageWithURL:url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *detail = [[MovieDetailViewController alloc] init];
    detail.title = self.movies[indexPath.row][@"Movies"];
    detail.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Navigation
- (void)showWithStatus {
    [SVProgressHUD showWithStatus:@"Loading"];
}

#pragma mark -
#pragma mark Dismiss Methods Sample

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)dismissSuccess {
    [SVProgressHUD showSuccessWithStatus:@"Great Success!"];
}

- (void)dismissError {
    [SVProgressHUD showErrorWithStatus:@"Failed with Error"];
}
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
