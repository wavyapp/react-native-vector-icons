require 'json'
package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name           = "RNVectorIcons"
  s.version        = package["version"]
  s.summary        = package["description"]
  s.description    = package["description"]
  s.homepage       = package["homepage"]
  s.license        = package["license"]
  s.author         = { package["author"]["name"] => package["author"]["email"] }
  s.platforms      = { :ios => "12.0", :tvos => "9.0" }
  s.source         = { :git => package["repository"]["url"], :tag => "v#{s.version}" }

  s.source_files   = 'RNVectorIconsManager/**/*.{h,m,mm,swift}'
  s.resources      = "Fonts/*.ttf"
  s.preserve_paths = "**/*.js"

 # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"
    # Don't install the dependencies when we run `pod install` in the old architecture.
    if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }
    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
    end
  end    
end
