Pod::Spec.new do |spec|
    spec.name         = 'SpringSegmentView'
    spec.version      = '0.1.0'
    spec.summary      = 'Segment View with springing pointer. Based on UIStackView.'
    spec.license      = 'MIT'

    spec.ios.deployment_target   = '10.0'

    spec.homepage     = 'https://github.com/<GITHUB_USERNAME>/SpringSegmentView'
    spec.authors      = { 'Oleksii Dobush' => 'dobush.oleksij@gmail.com' }
    spec.source       = { :git => 'https://github.com/<GITHUB_USERNAME>/SpringSegmentView.git', :tag => spec.version.to_s }
    spec.source_files  = 'SpringSegmentView/Classes/*.swift'
end
