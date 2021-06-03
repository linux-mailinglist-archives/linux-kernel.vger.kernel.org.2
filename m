Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3658839ACB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFCVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:24:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:43904 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbhFCVYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:24:33 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-286-Jvo2qcnVMfKEowSTBxAhDg-1; Thu, 03 Jun 2021 22:22:45 +0100
X-MC-Unique: Jvo2qcnVMfKEowSTBxAhDg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Thu, 3 Jun 2021 22:22:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Thu, 3 Jun 2021 22:22:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Manikishan Ghantasala' <manikishanghantasala@gmail.com>,
        Alex Elder <elder@ieee.org>
CC:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "greybus-dev@lists.linaro.org" <greybus-dev@lists.linaro.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
Thread-Topic: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
Thread-Index: AQHXV7uPElUZ9thDckyuMtjnIAGFwKsCzNHA
Date:   Thu, 3 Jun 2021 21:22:44 +0000
Message-ID: <792dd57c0ef8454497e5ae4c4534dea2@AcuMS.aculab.com>
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
 <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
In-Reply-To: <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
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

RnJvbTogTWFuaWtpc2hhbiBHaGFudGFzYWxhDQo+IFNlbnQ6IDAyIEp1bmUgMjAyMSAxNToyOA0K
PiANCj4gSSBhZ3JlZSB0aG9zZSBhcmUgY2FsbGVkIGJpdC1maWVsZCBtZW1iZXIgbmFtZXMgcmF0
aGVyIHRoYW4gbGFiZWxzLg0KPiBCdXQgdGhlIHJlYXNvbiBJIG1lbnRpb25lZCBpcyBiZWNhdXNl
IHRoZSAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbA0KPiBnYXZlIG91dCBhIHdhcm5pbmcgc2F5aW5n
ICJsYWJlbHMgc2hvdWxkIG5vdCBiZSBpbmRlbnRlZCIuDQo+IA0KPiBTb3JyeSBmb3IgdGhlIGNv
bmZ1c2lvbiBpbiB0aGUgbmFtZSBJIHJlZmVycmVkIHRvLiBTbywgSSB0aGluayB0aGlzDQo+IGNo
YW5nZSBpcyBuZWVkZWQgYXMgSSBmZWVsIHRoaXMgaXMgbm90IGZvbGxvd2luZyB0aGUgY29kaW5n
LXN0eWxlIGJ5DQo+IGhhdmluZyBpbmRlbnQgYmVmb3JlIHRoZSB3aWR0aCBmb3IgYml0IGZpZWxk
IG1lbWJlci4gSSB3ZW50IHRocm91Z2gNCj4gb3RoZXIgcGxhY2VzIGluIHNvdXJjZSBjb2RlIHRv
IG1ha2Ugc3VyZSB0aGlzIGlzIGNvcnJlY3QsIGFuZCBzZW50IHRoZQ0KPiBwYXRjaCBhZnRlciBj
b25maXJtYXRpb24uDQo+IA0KPiBSZWdhcmRzLA0KPiBNYW5pa2lzaGFuIEdoYW50YXNhbGENCj4g
DQo+IE9uIFdlZCwgMiBKdW4gMjAyMSBhdCAxOToxMywgQWxleCBFbGRlciA8ZWxkZXJAaWVlZS5v
cmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gNi8yLzIxIDg6MzYgQU0sIHNoNG5udSB3cm90ZToNCj4g
PiA+IEZyb206IE1hbmlraXNoYW4gR2hhbnRhc2FsYSA8bWFuaWtpc2hhbmdoYW50YXNhbGFAZ21h
aWwuY29tPg0KPiA+ID4NCj4gPiA+IHN0YWdpbmc6IGdyZXlidXM6IGdwaW8uYzogQ2xlYXIgY29k
aW5nLXN0eWxlIHByb2JsZW0NCj4gPiA+ICJsYWJlbHMgc2hvdWxkIG5vdCBiZSBpbmRlbnRlZCIg
YnkgcmVtb3ZpbmcgaW5kZW50YXRpb24uDQo+ID4NCj4gPiBUaGVzZSBhcmUgbm90IGxhYmVscy4N
Cj4gPg0KPiA+IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2hhdCB5b3UncmUgZG9pbmcgaGVy
ZS4NCj4gPg0KPiA+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2h5IHlvdSB0aGluayB0aGlzIG5l
ZWRzIGNoYW5naW5nPw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC1BbGV4DQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlraXNoYW4gR2hhbnRh
c2FsYSA8bWFuaWtpc2hhbmdoYW50YXNhbGFAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAg
IGRyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2dwaW8uYyB8IDYgKysrLS0tDQo+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2dwaW8uYyBiL2RyaXZlcnMvc3Rh
Z2luZy9ncmV5YnVzL2dwaW8uYw0KPiA+ID4gaW5kZXggN2U2MzQ3ZmU5M2Y5Li40NjYxZjRhMjUx
YmQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9ncGlvLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2dwaW8uYw0KPiA+ID4gQEAgLTIwLDkg
KzIwLDkgQEANCj4gPiA+ICAgc3RydWN0IGdiX2dwaW9fbGluZSB7DQo+ID4gPiAgICAgICAvKiBU
aGUgZm9sbG93aW5nIGhhcyB0byBiZSBhbiBhcnJheSBvZiBsaW5lX21heCBlbnRyaWVzICovDQo+
ID4gPiAgICAgICAvKiAtLT4gbWFrZSB0aGVtIGp1c3QgYSBmbGFncyBmaWVsZCAqLw0KPiA+ID4g
LSAgICAgdTggICAgICAgICAgICAgICAgICAgICAgYWN0aXZlOiAgICAxLA0KPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGlyZWN0aW9uOiAxLCAgIC8qIDAgPSBvdXRwdXQsIDEg
PSBpbnB1dCAqLw0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWU6ICAg
ICAxOyAgIC8qIDAgPSBsb3csIDEgPSBoaWdoICovDQo+ID4gPiArICAgICB1OCAgICAgICAgICAg
ICAgICAgICAgICBhY3RpdmU6MSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRpcmVjdGlvbjoxLCAgICAvKiAwID0gb3V0cHV0LCAxID0gaW5wdXQgKi8NCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlOjE7ICAgICAgICAvKiAwID0gbG93LCAxID0g
aGlnaCAqLw0KDQpXaHkgYXJlIHlvdSBldmVuIHVzaW5nIGJpdGZpZWxkcyBhdCBhbGw/DQpJZiB5
b3UgY2FyZWQgYWJvdXQgdGhlIHN0cnVjdHVyZSBzaXplIHlvdSdkIG5vdCBoYXZlIGEgYnl0ZS1z
aXplIHBhZCBoZXJlLg0KDQpTaW5jZSBJIGRvdWJ0IG1hbnkgY29waWVzIG9mIHRoaXMgc3RydWN0
dXJlIGdldCBhbGxvY2F0ZWQgdGhlDQoodHlwaWNhbCkgaW5jcmVhc2UgaW4gY29kZSBzaXplIGZv
ciB0aGUgYml0ZmllbGRzIHdpbGwgYWxzbw0KZXhjZWVkIGFueSBzaXplIHNhdmluZy4NCg0KSXNu
J3QgdGhlIGtlcm5lbCBzdHlsZSBhbHNvIHRvIHJlcGVhdCB0aGUgdHlwZSBmb3IgZXZlcnkgZmll
bGQ/DQoNCglEYXZpZA0KDQoNCj4gPiA+ICAgICAgIHUxNiAgICAgICAgICAgICAgICAgICAgIGRl
Ym91bmNlX3VzZWM7DQo+ID4gPg0KPiA+ID4gICAgICAgdTggICAgICAgICAgICAgICAgICAgICAg
aXJxX3R5cGU7DQo+ID4gPg0KPiA+DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

