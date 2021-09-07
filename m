Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A54402708
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbhIGKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:19:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40454 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245372AbhIGKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:19:56 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-15-U4AVA6WDMeu_uJxNYyLMwA-1; Tue, 07 Sep 2021 11:18:48 +0100
X-MC-Unique: U4AVA6WDMeu_uJxNYyLMwA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 7 Sep 2021 11:18:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 7 Sep 2021 11:18:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: dozens of sysbot reports
Thread-Topic: dozens of sysbot reports
Thread-Index: AQHXowm7cxrYRLDtVEurJnfsdUdZU6uYXHUQ
Date:   Tue, 7 Sep 2021 10:18:47 +0000
Message-ID: <e2202d5c43ce4730b2e46262717c711a@AcuMS.aculab.com>
References: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
 <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
In-Reply-To: <CAHk-=wiENdk_AXGRrmbbOYqq9zYptdv=vYszgG2ZzztDUTJwRA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDMgU2VwdGVtYmVyIDIwMjEgMjM6MjENCj4g
DQo+IE9uIEZyaSwgU2VwIDMsIDIwMjEgYXQgMTo0NCBQTSBFcmljIER1bWF6ZXQgPGVyaWMuZHVt
YXpldEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSSBoYXZlIGEgcGlsZSBvZiAoc3RpbGwg
dW5kZXIgdHJpYWdlKSBzeXNib3QgcmVwb3J0cyBjb21pbmcgYWZ0ZXIgb25lIG9mIHlvdXIgcGF0
Y2gNCj4gPg0KPiA+IFR5cGljYWwgc3RhY2sgdHJhY2U6DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS1b
IGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gPiBXQVJOSU5HOiBDUFU6IDEgUElEOiAyNDg4OSBh
dCBtbS91dGlsLmM6NTk3IGt2bWFsbG9jX25vZGUrMHgxMTEvMHgxMjAgbW0vdXRpbC5jOjU5Nw0K
PiA+IENhbGwgVHJhY2U6DQo+ID4gIGhhc2hfaXBwb3J0X2NyZWF0ZSsweDNkZC8weDEyMjAgbmV0
L25ldGZpbHRlci9pcHNldC9pcF9zZXRfaGFzaF9nZW4uaDoxNTI0DQo+ID4gIGlwX3NldF9jcmVh
dGUrMHg3ODIvMHgxNWEwIG5ldC9uZXRmaWx0ZXIvaXBzZXQvaXBfc2V0X2NvcmUuYzoxMTAwDQo+
ID4gIG5mbmV0bGlua19yY3ZfbXNnKzB4YmM5LzB4MTNmMCBuZXQvbmV0ZmlsdGVyL25mbmV0bGlu
ay5jOjI5Ng0KPiANCj4gU28gdGhlIHJlYWwgcXVlc3Rpb24gaXMgbWFpbmx5IGp1c3Qgd2hldGhl
ciB0aG9zZSBodWdlIGFsbG9jYXRpb25zDQo+IGFjdHVhbGx5IG1ha2Ugc2Vuc2Ugb3Igbm90Lg0K
PiANCj4gSWYgdGhleSB0cnVseSBhcmUgc2Vuc2libGUsIHdlIGNhbiByZW1vdmUgdGhlIHdhcm5p
bmcuIEJ1dCBpdCB3b3VsZCBiZQ0KPiBnb29kIHRvIHBlcmhhcHMgbG9vayBhdCB0aGVtIG1vcmUu
DQo+IA0KPiBCZWNhdXNlIG5vOg0KPiANCj4gPiBEbyB3ZSB3YW50IHRvIGZpeCBhbGwgcHJvYmxl
bWF0aWMgY2FsbGVycywgd2l0aCBhZC1ob2MgcGF0Y2hlcyBsaWtlDQo+IA0KPiBOb3QgaW5zYW5l
IHBhdGNoZXMgbGlrZSB0aGlzLCBuby4NCj4gDQo+ID4gIGlwX3NldF9hbGxvYyhzaXplX3Qgc2l6
ZSkNCj4gPiAgew0KPiA+ICsgICAgICAgaWYgKHNpemUgPiBJTlRfTUFYKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgICAgICAgIHJldHVybiBrdnphbGxvYyhzaXplLCBH
RlBfS0VSTkVMX0FDQ09VTlQpOw0KPiA+ICB9DQo+IA0KPiBCdXQgZG9lcyB0aGF0IGtpbmQgb2Yg
c2l6ZSByZWFsbHkgbWFrZSBzZW5zZT8gSSdtIGxvb2tpbmcgYXQgdGhlDQo+IHBhcnRpY3VsYXIg
Y2FsbGVyLCBpcyBpdCAqcmVhbGx5KiBzZW5zZWlibGUgdG8gaGF2ZSBhIDRHQisgaGFzaCB0YWJs
ZQ0KPiBzaXplPw0KDQpJIHdvbmRlciBpZiB0aGVyZSBzaG91bGQgYmUgYSBHRlBfTEFSR0VfQUxM
T0MgZmxhZyB0aGF0IG11c3QNCmJlIHNldCBpbiBvcmRlciB0byBhbGxvdyBhbGxvY2F0ZXMgb3Zl
ciBhIGZldyBNQj8NCihQcm9iYWJseSB3aXRoIHdhcm4gKyBhbGxvY2F0ZSBmb3Igbm93LikNCg0K
VGhhdCB3aWxsIGdlbmVyYXRlIGV2ZW4gbW9yZSB3YXJuaW5ncyBmb3Igb3ZlcnNpemUgYWxsb2Nh
dGVzDQpidXQgc3RvcCBhY2NpZGVudGFsIGh1Z2UgYWxsb2NhdGVzIGluIHBsYWNlcyB0aGF0IHJl
YWxseQ0KZG9uJ3QgZXhwZWN0IHRoZW0uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

