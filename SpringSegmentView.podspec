Pod::Spec.new do |spec|

    spec.name         = 'SpringSegmentView'
    spec.version      = '0.0.1'
    spec.summary      = 'Segment View with springing pointer. Based on UIStackView.'
    spec.license      = { :type => 'MIT', :file => 'LICENSE' }

    spec.ios.deployment_target   = '10.0'

    spec.homepage     = 'https://github.com/<GITHUB_USERNAME>/SpringSegmentView'
    spec.authors      = { 'Oleksii Dobush' => 'dobush.oleksij@gmail.com' }
    spec.source       = { :git => 'https://github.com/Odobush1/SpringSegmentView.git', :tag => spec.version.to_s }

    spec.source_files  = 'SpringSegmentView/*'

end
