# About Origami #

Origami is a Ruby framework for manipulating PDF documents. It features a PDF compliant parser and allows to analyze, modify or create malicious PDF files. Although it may be use for multiple purposes, Origami is primarily intended as a security tool. As such, it does not focus on the graphics contents of a document and does not include a PDF renderer. Origami supports advanced features of the latest PDF specifications:
  * Encryption, up to Adobe Reader X
  * Digital signatures
  * Forms (Acrobat and XML)
  * JavaScript
  * Annotations
  * Flash
  * File attachments
  * Object streams


# Installation #

The easiest way to install the latest version of Origami is to use Rubygems:
```
gem install origami
```

You can also get a copy of development tree with Mercurial:
```
hg clone 'https://code.google.com/p/origami-pdf/' origami
```

## Optional dependencies ##

Depending on your needs, optional packages can also be installed to extend Origami features.


For the graphical interface support:
```
gem install gtk2
```

For the JavaScript environment support:
```
gem install therubyracer
```


# Usage #

There are multiple ways for using Origami:
  * the graphical interface
  * the shell interface
  * writing custom scripts with the Origami API

## Graphical interface (PDF Walker) ##

If you installed the `gtk2` gem, you can try the graphical interface of Origami. This will allow you to quickly browse the contents of a document, without modifying it.

You can follow an object reference by double-clicking on it, and go backward with the `Esc` key.

To launch it:
```
$ pdfwalker
```

![http://aslr.fr/dotclear/public/origami/pdfwalker.png](http://aslr.fr/dotclear/public/origami/pdfwalker.png)

## Shell interface ##

The Origami shell is a standard Ruby shell including the Origami namespace. It is handy for performing simple operations on a document with a few lines of code.

```
$ pdfsh
>>>
```

  * Creating a new blank file:
```rb

>>> PDF.new.save('blank.pdf') ```

  * Infecting and encrypting an existing document:
```rb

>>> pdf = PDF.read 'foo.pdf'
>>> pdf.onDocumentOpen Action::JavaScript[ 'app.alert("Hello!")' ]
>>> pdf.encrypt.save 'bar.pdf' ```

  * Looking for specific data in objects
```rb

>>> pdf.grep "/bin/sh" ```

  * Inspecting PDF objects:
```rb

>>> pdf = PDF.read 'sample.pdf'
>>> page = pdf.pages.first
33 0 obj
<<%
/MediaBox [ 0 0 243.78 153.071 ]
/Parent 24 0 R
/Contents 38 0 R
/Resources 34 0 R
/CropBox [ 0 0 243.78 153.071 ]
/Rotate 0
/Type /Page
>>
endobj
>>> page.xrefs[0]
[ 33 0 R 1 0 R ]
>>> page.xrefs[0].parent
24 0 obj
<<%
/Count 2
/Kids [ 33 0 R 1 0 R ]
/Type /Pages
>>
endobj
>>> page.Parent
24 0 obj
<<%
/Count 2
/Kids [ 33 0 R 1 0 R ]
/Type /Pages
>>
endobj
>>> pdf[24]
24 0 obj
<<%
/Count 2
/Kids [ 33 0 R 1 0 R ]
/Type /Pages
>>
endobj```

  * Editing page raw contents (you may need to set up the `EDITOR` environment variable):
```rb

>>> pdf.pages[2].edit ```

  * Editing a stream:
```ruby

>>> pdf.Catalog.Metadata.edit ```

  * You can also make use of the JavaScript engine if you added support for it:
```ruby

>>> pdf.Catalog.OpenAction.JS.eval_js
>>> pdf.js_engine.shell
js> this
[object Doc]
js> console.println('foo')
foo
nil
js> this.numPages
2```

## Custom scripts ##

Origami being a Ruby framework, you can also write your own set of Ruby scripts suited to your needs using the Origami API. This can be useful for performing specific actions on a set of documents.

Origami already comes up with some commonly useful scripts:
  * `pdfencrypt`/`pdfdecrypt` (encrypts or decrypts a document)
  * `pdfdecompress` (removes any compression layer)
  * `pdfmetadata` (prints document metadata)
  * `pdfextract` (extracts various objects from a document)
  * `pdfcop` (automatized analysis engine)
  * Some other miscellaneous scripts (`pdf2ruby`, `pdf2graph`, `pdf2pdfa`, ...)

You can also take a look into in the `samples` directory of Origami to find some basic scripting examples.