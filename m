Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6445A09B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhKWKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:45:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49428 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhKWKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:45:56 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-2tPn8oYfPyWx8e-MFoUrzw-1; Tue, 23 Nov 2021 10:42:46 +0000
X-MC-Unique: 2tPn8oYfPyWx8e-MFoUrzw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 10:42:45 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 10:42:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Vaittinen, Matti'" <Matti.Vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Topic: [PATCH 1/4] bitops: Add single_bit_set()
Thread-Index: AQHX35CZ2t64bA8wLE2j/heX74SAnqwPaOmAgAAUvoCAAAQ4gIAABfAAgAFlEYA=
Date:   Tue, 23 Nov 2021 10:42:45 +0000
Message-ID: <874db8b91ff04001a8958f100a614ed8@AcuMS.aculab.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
 <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
 <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
In-Reply-To: <e2675600-7b04-19b0-79ce-28a4e1d1f225@fi.rohmeurope.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmFpdHRpbmVuLCBNYXR0aQ0KPiBTZW50OiAyMiBOb3ZlbWJlciAyMDIxIDEzOjE5DQo+
IA0KPiBPbiAxMS8yMi8yMSAxNDo1NywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIE1v
biwgTm92IDIyLCAyMDIxIGF0IDEyOjQyOjIxUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3Jv
dGU6DQo+ID4+IE9uIDExLzIyLzIxIDEzOjI4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4+
PiBPbiBNb24sIE5vdiAyMiwgMjAyMSBhdCAwMTowMzoyNVBNICswMjAwLCBNYXR0aSBWYWl0dGlu
ZW4gd3JvdGU6DQo+ID4NCj4gPiBXaGF0IGRvIHlvdSBtZWFuIGJ5IHRoaXM/DQo+ID4NCj4gPiBo
d2VpZ2h0KCkgd2lsbCByZXR1cm4geW91IHRoZSBudW1iZXIgb2YgdGhlIG5vbi16ZXJvIGVsZW1l
bnRzIGluIHRoZSBzZXQuDQo+IA0KPiBFeGFjdGx5LiBUaGUgZnVuY3Rpb24gSSBhZGRlZCBkaWQg
b25seSBjaGVjayBpZiBnaXZlbiBzZXQgb2YgYml0cyBoYWQNCj4gb25seSBvbmUgYml0IHNldC4N
Cg0KQ2hlY2tpbmcgZm9yIGV4YWN0bHkgb25lIGJpdCBjYW4gdXNlIHRoZSAoeCAmICh4IC0gMSkp
IGNoZWNrIG9uDQpub24temVybyB2YWx1ZXMgLSB3aGljaCBtYXkgZXZlbiBiZSBiZXR0ZXIgb24g
c29tZSBjcHVzIHdpdGggYQ0KcG9wY250IGluc3RydWN0aW9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

