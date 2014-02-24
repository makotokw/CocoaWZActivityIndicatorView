Pod::Spec.new do |s|
  s.name     = 'WZYActivityIndicatorView'
  s.version  = '0.1'
  s.summary  = 'ActivityIndicatorView with custom image'
  s.homepage = 'https://github.com/makotokw/CocoaWZYActivityIndicatorView.git'
  s.license  = { :type => 'MIT License', :file => 'LICENSE' }
  s.author   = { 'Makoto Kawasaki' => 'makoto.kw@gmail.com' }
  s.source   = { :git => 'https://github.com/makotokw/CocoaWZYActivityIndicatorView.git', :tag => '0.1' }
  s.platform = :ios, '5.0'

  s.requires_arc  = true
  s.source_files  = 'Classes/*.{h,m}'
  s.frameworks = 'QuartzCore'
end
