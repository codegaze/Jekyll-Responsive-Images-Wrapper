
module Jekyll
  class ResponsiveImagesWrapper < Liquid::Tag

    def initialize(tag_name, attributes, tokens)
      super
      
      @attributes = {}
      
      # Get all the attributes from given tag
      attributes.scan(::Liquid::TagAttributes) do |key, value|
        @attributes[key] = value.gsub(/^['"]|['"]$/, '')
      end

    end

    def render(context)
        
      settings = context.registers[:site].config['responsive-images-wrapper']
       
       
      result = ""

      # Get Tag attributes
      image_full_name = @attributes['name']
      image_class = @attributes['class']
      image_title = @attributes['title']
      image_alt = @attributes['alt']
      image_group = @attributes['group']


      #Get The plain file name and file extention
      image_file_name = getDirName(image_full_name) + getFileName(image_full_name)
      image_file_extention = getExtension(image_full_name)   
      image_instances = []
      image_sizes = settings['sizes']

      # Get enable plugin setting {True/False/Nil}
      image_lazyload = settings['lazy_load']
      

      # Check for given group
      if image_group == nil
        image_group = "default"
      end
      # Add lazysizes class
      image_lazyload_class = settings['lazy_class']
      image_src_attr = "srcset"

      # Check for lazysizes plugin
      if image_lazyload == true
          image_src_attr = "data-srcset"
      end if


      settings['instances'][image_group].each do |sizes|

        width = sizes['width'].to_s
        hash = sizes['hash'].to_s

        # If hash is empty then get append the given width to image name
        if hash == "" 
            hash = "_" + width
        end

        # Push one more image width to the incances array
        image_instances << image_file_name + hash + image_file_extention + " " + width
          
      end

      # Join all the widths in one String
      result = image_instances.join(", ")

      "<img src=\"#{image_full_name}\"
          #{image_src_attr}=\"#{result}\"
          sizes=\"#{image_sizes}\"
          class=\"#{image_class} #{image_lazyload_class}\" alt=\"#{image_alt}\" title=\"#{image_title}\" >"
    end

    # Get stripped filename without extension
    def getFileName(file)
      File.basename(file, ".*")
    end

    # Get only file extension
    def getExtension(file)
      File.extname(file)
    end

    # Get path to file
    def getDirName(file)
      return File.dirname(file) + "/"
    end 
  end
end

Liquid::Template.register_tag('responsive_image', Jekyll::ResponsiveImagesWrapper)