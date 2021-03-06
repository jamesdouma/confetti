module Confetti
  module Template
    class IosInfo < Base
      ORIENTATIONS_MAP = {
        :landscape => [
          "UIInterfaceOrientationLandscapeLeft",
          "UIInterfaceOrientationLandscapeRight"
        ],
        :portrait => [
          "UIInterfaceOrientationPortrait",
          "UIInterfaceOrientationPortraitUpsideDown"
        ],
        :default => [
          "UIInterfaceOrientationPortrait",
          "UIInterfaceOrientationPortraitUpsideDown",
          "UIInterfaceOrientationLandscapeLeft",
          "UIInterfaceOrientationLandscapeRight"
        ]
      }

      def icons
        @config.plist_icon_set
      end

      def bundle_identifier
        @config.package
      end

      def bundle_version
        @config.version_string
      end

      def product_name
        @config.name.name
      end

      def output_filename
        "Info.plist"
      end

      def devices 
        nibs = ["NSMainNibFile"]
        @config.preference_set.each do |preference|
          nibs << "NSMainNibFile~ipad"  if preference.name.match /^universal$/
        end
        nibs
      end

      def app_orientations
        ORIENTATIONS_MAP[@config.orientation]
      end

      def fullscreen?
        @config.preference(:fullscreen) == :true
      end

      def prerendered_icon?
        @config.preference("prerendered-icon") == :true
      end
    end
  end
end
