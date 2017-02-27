# imp_HttpBootstrapTemplateWithAjaxJQuery
A standard bootstrap template customised to auto grab status data using JQuery + Ajax from up to 3 Imp Agent URLs and get Imp Agent to respond to on/off button presses. It will auto update every 20 seconds using JQuery setTimeout. As yet the code does not do a proper check to make sure that the initial ajax instruction is complete before next timer triggers so not advisable to reduce auto updates below say 8 seconds, to be sure.

The Index.html can work as is on a laptop / pc. No need to use local server or upload to a web server. The html uses CDN references to latest JQuery and Bootstrap CSS + JS. There is no other CSS used. The customer JQuery code is appended at the bottom within script tags. You will need to amend the URL references to the Imp Agent within these script tags. There are 3 constants URL1, URL2, URL3. These can be different URLs or the same.

The Imp agent code is just the snippet handling the http requests. It is up to you to insert and handle device communication etc.
