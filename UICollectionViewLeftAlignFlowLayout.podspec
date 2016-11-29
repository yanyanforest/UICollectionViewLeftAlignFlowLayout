#
# Be sure to run `pod lib lint UICollectionViewLeftAlignFlowLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UICollectionViewLeftAlignFlowLayout'
  s.version          = '0.1.2'
  s.summary          = 'UICollectionViewLeftAlignFlowLayout is left align Flowlayout for CollectionView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This library provides a easy use for UICollectionView with left align flow layout. performances!'

  s.homepage         = 'https://github.com/yanyanforest/UICollectionViewLeftAlignFlowLayout'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yanyanforest' => 'yanyanforest@163.com' }
  s.source           = { :git => 'https://github.com/yanyanforest/UICollectionViewLeftAlignFlowLayout.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'UICollectionViewLeftAlignFlowLayout/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UICollectionViewLeftAlignFlowLayout' => ['UICollectionViewLeftAlignFlowLayout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
