# Jekyll Responsive Images Wrapper

Jekyll Responsive Images Wrapper is a Jekyll Tag plugin created for simplifying the implementation of responsive images in a Jekyll site.

This plugin was created because I didn't like writing or maintaining the HTML markup in my code.
This means that this plugin doesn't create new resized images based on given settings, but creates the markup with a few simple attributes without having to maintain all the HTML code.

## Installation

You can copy the jekyll-responsive-images-wrapper.rb in the `_plugins` directory.

**Notice**: This plugin cannot be used with Github Pages due to security reasons.

## Configuration

Open your `_config.yml` file to add the required configuration settings for this plugin.
The required keys are the main `responsive-images-wrapper` and `instances`.

**Settings example with all possible keys**

``` yaml
responsive-images-wrapper:
  instances:
    default:
      - width: "100w"
    header:
      - width: "500w"
        hash: "_md"
      - width: "2x"
        hash: "_lg"
    gallery:
      - width: "500w"
        hash: "_gal_1"
      - width: "2x"
        hash: "_gal_2"
  sizes: "(min-width: 33em) 33em, 100vw"
  lazy_load: true
  lazy_class: "lazy"

```
**instances [Required]**

Here you can add your image 'groups' with their settings. You may use as many groups as you want but you need to have at least one group called default. The `width` key is required and is the viewport width. The `hash` key, is the string that will be appended in the image name just before the file extention, and it's optional. If skipped the width will be added instead. More on this in [Usage](#usage) section.

**sizes [Optional]**

It's the `sizes` attribute for your images.

**lazy_load [Optional]**

If you decide to use the third party lazysizes.js library set this to true and `srcset` tag will become `data-srcset`.

**lazy_class [Optional]**

Use this in case you want to add a class for the lazysizes.js library in your images.


## Usage
Using this plugin is very simple. All you have to do is add this tag with the `name` attribute.

```
{% responsive_image name: /public/dynamic_menu.jpg %}
```


This creates the following html markup. As you can see we skipped the `hash` key and the `width` key was appended.

```
<img src="/public/my_image.jpg"
          data-srcset="/public/my_image_100w.jpg 100vw"
          sizes="(min-width: 33em) 33em, 100vw"
          class="lazy" alt="" title="" >

```

Another example with more attributes

```
{% responsive_image name: /public/my_image.jpg alt: "this is an alt tag" title: "This is a title for the image" group: gallery %}
```

```
<img src="/public/my_image.jpg"
          data-srcset="/public/my_image_gal_1.jpg 500w, /public/my_image_gal_2.jpg 2x"
          sizes="(min-width: 33em) 33em, 100vw"
          class="lazy" alt="this is an alt tag" title="This is a title for the image">
```

**Available attributes**

| Attribute        |             | Description                                                              |
| ---------------- |:-----------:| :------------------------------------------------------------------------|
| name             | Required    | The image name with its path                                             |
| group            | Optional    | If skipped uses the `default` group as defined in the `_config.yml file` |
| class            | Optional    | Adds a class attribute to the image                                      |
| title            | Optional    | Adds a title attribute to the image                                      |

## Additional Libraries

* [Picturefill.js](https://github.com/scottjehl/picturefill){:target="_blank"}
Is the library to use, if you wish for full browser support.

* [lazysizes.js](https://github.com/aFarkas/lazysizes){:target="_blank"} A javascript library to add lazy load functionality to your images.
There is an option in the configuration to alter the `srcset` attribute to `data-srcset` to support this library.

## Additional Read

* [https://responsiveimages.org/](https://responsiveimages.org/){:target="_blank"}

## TODO:
* Create a gem for this plugin
