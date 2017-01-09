- run locally DONE
- load editor in own html DONE (serve own html)
- Serve editor own document DONE (just send it custom doc in url bar)
  remove #edit, just use 5 char url
- Connect editor to own server ??? (probs better to use his server, adjusted a bit)
- Make it better
  embed in place of current textarea. Connect to doc with contenteditable in created().


Server Notes
- Start opens createServer from http, then other files that also open that can just add their handlers. Mostly this is in server.js just running handler on nothing.(I think?)
- server passes everything to route, which path matches (based on list of paths from...modules? json?)
  routes are added in server.js, in the handle function. It takes a method, url, and func.
  url is in an array, as text? What's the deal there? ex: url: ['docs', null, 'events'], func..
  client is requesting /docs/~document~ so path matching peels it back to 'docs' I guess?
  poll requests (GET) ask for /events? at the end of document path, not sure about null yet.
  POST also goes to /events? to send data for that doc.

- server only responds if route matches a document request. How? Document requests are to url like /docs/blah, so docs is the path it matches.

- all other serving done from... somewhere else.
- Instance.js is where a new document is created. There are some already made ones in defaultinstances.js with a little bit of text or whatever.

collab.js
- Majority of this file is EditorConnection, which is a big object that manages all send/receive for a document.
- sets this.url which is path to request from server for documents. Document path is : /docs/~documentname~
  events (GET/POST) go to /docs/~documentname~/events?
- this.url is initialised as part of an EditorConnection, which takes report, url. Url is actual doc, ie: /docs/example1. Report is a new reporter (reporter.js) which is maybe the bit that manages a document state?
- new document creation happens around 275-285. There's a listener on the html that shows a little doc selector. If a different doc is selected it sets the hash to #edit-[docname]. This appears in the url bar after the html, as a query I guess. If a new doc is created, same thing only it sets the hash to the new doc name (which is entered by an alert).
- There's a listener on this hash, which runs "connect from hash" any time it changes. This closes old connections and opens a new one (EditorConnection as above), then starts synching. nb: this listener is on window.location.hash, and matches anything that's #edit- at the start.
- Bottom of this file connects to a hash, defaulting to example1.
- GOOD NEWS can type in fresh document name to urlbar and it will create document/add to list of documents/allow others to connect. Should be able to pass in whatever to this.url then I think?
