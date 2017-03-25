# newpost.rb - Create New Jekyll Posts

Ruby script to create new [Jekyll](https://jekyllrb.com/) posts with optional YAML frontmatter.

    usage: newpost.rb TITLE [OPTIONS]

    Options
        -f, --filename [FILENAME]        Filename, different from auto-parsed from title
        -c, --categories [CATEGORIES]    Space-delimited string of categories
        -t, --tags [TAGS]                Space-delimited string of tags
        -s, --summary [SUMMARY]          Summary text for post.
        -e, --edit                       Edit the page

        -h, --help                       Display help for options

Requires a post title.

Accepts optional flags to add:

* A filename different from one parsed from the supplied title
* Categories
* Tags
* A custom `summary:` YAML attribute

Originally based on the [jekyll-page](https://github.com/bruth/jekyll-docs-template/blob/master/bin/jekyll-page) script included with Byron Ruth's [jekyll-docs-template: Jekyll template for documentation-based sites](https://github.com/bruth/jekyll-docs-template/).