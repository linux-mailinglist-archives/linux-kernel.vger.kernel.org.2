Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93939418410
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 21:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhIYTIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 15:08:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54006 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhIYTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 15:08:41 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-161-wVsmmQEKP26rzW7cxYafgg-1; Sat, 25 Sep 2021 20:07:03 +0100
X-MC-Unique: wVsmmQEKP26rzW7cxYafgg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 25 Sep 2021 20:07:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 25 Sep 2021 20:07:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Kees Cook <keescook@chromium.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>
Subject: RE: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Thread-Topic: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Thread-Index: AQHXsNcuqtoUBVFLwk2kLaGlW2BOzKu1GzQg
Date:   Sat, 25 Sep 2021 19:07:02 +0000
Message-ID: <bbe02e79355c42139d3b7fcc15344474@AcuMS.aculab.com>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble> <202109211931.E6E33500E8@keescook>
 <CAG48ez2zC=+PuNgezH53HBPZ8CXU5H=vkWx7nJs60G8RXt3w0Q@mail.gmail.com>
In-Reply-To: <CAG48ez2zC=+PuNgezH53HBPZ8CXU5H=vkWx7nJs60G8RXt3w0Q@mail.gmail.com>
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

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDIxIDAxOjAwDQouLi4NCj4g
PiBOb3JtYWxseSB3Y2hhbiBpcyBwcm90ZWN0ZWQgYnk6DQo+ID4NCj4gPiAgICAgICAgIHB0cmFj
ZV9tYXlfYWNjZXNzKHRhc2ssIFBUUkFDRV9NT0RFX1JFQURfRlNDUkVEUykNCj4gPg0KPiA+IEkg
bWlnaHQgYXJndWUgdGhhdCB0aGlzIGNoZWNrIGlzbid0IHJpZ2h0IC0tIGl0IG5lZWRzIHRvIGJl
IHVzaW5nDQo+ID4gZl9jcmVkLCBidXQgSSdsbCBsZXQgSmFubiBhbnN3ZXIgbW9yZSB0aGVyZS4N
Cj4gPg0KPiA+ID4gLi4uIHNpbmNlIHByZXN1bWFibHkgcHJvY19waWRfd2NoYW4oKSdzIHVzZSBv
ZiAnJXBzJyBjYW4gcmVzdWx0IGluIGFuDQo+ID4gPiBhY3R1YWwgYWRkcmVzcyBnZXR0aW5nIHBy
aW50ZWQgaWYgdGhlIHVud2luZCBnZXRzIGNvbmZ1c2VkLCB0aGFua3MgdG8NCj4gPiA+IF9fc3By
aW50X3N5bWJvbCgpJ3MgYmFja3VwIG9wdGlvbiBpZiBrYWxsc3ltc19sb29rdXBfYnVpbGRpZCgp
IGRvZXNuJ3QNCj4gPiA+IGZpbmQgYSBuYW1lLg0KPiA+DQo+ID4gRXcsIHllYWgsIF9fc3ByaW50
X3N5bWJvbCgpIGZhbGxzIGJhY2sgdG8gZXhwb3NpbmcgYWRkcmVzc2VzLiA6KA0KPiA+DQo+ID4g
ICAgICAgICBuYW1lID0ga2FsbHN5bXNfbG9va3VwX2J1aWxkaWQoYWRkcmVzcywgJnNpemUsICZv
ZmZzZXQsICZtb2RuYW1lLCAmYnVpbGRpZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBidWZmZXIpOw0KPiA+ICAgICAgICAgaWYgKCFuYW1lKQ0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gc3ByaW50ZihidWZmZXIsICIweCVseCIsIGFkZHJlc3MgLSBzeW1i
b2xfb2Zmc2V0KTsNCj4gDQo+IFdoYWFhYXQ/IFRoYXQncyBub3QgaG93IHdjaGFuIHdvcmtlZCB3
aGVuIEkgbG9va2VkIGF0IHRoaXMgdGhlIGxhc3QNCj4gdGltZSBhIGZldyB5ZWFycyBhZ28uLi4N
Cg0KSG1tbW0uLi4uDQpIaXN0b3JpY2FsbHkgKGFuZCBJIG1lYW4gU1lTViBhbmQgcHJvYmFibHkg
QlNEKSB0aGUgJ3djaGFuJw0Kd2FzIHRoZSAndG9rZW4nIHBhc3NlZCB0byB0aGUga2VybmVsIHNs
ZWVwKCkgZnVuY3Rpb24gYW5kDQp2YWx1ZSB0aGF0IG5lZWRlZCB0byBiZSBwYXNzZWQgdG8gd2Fr
ZXVwKCkgdG8gZ2V0IHRoZSBwcm9jZXNzDQpyZXNjaGVkdWxlZC4NCkl0IHdhcyB1c3VhbGx5IHRo
ZSBhZGRyZXNzIG9mIHNvbWV0aGluZyBhc3NvY2lhdGVkIHdpdGggdGhlDQpzbGVlcCAtIGJ1dCBk
aWRuJ3QgaGF2ZSB0byBiZS4NCkxpbnV4IGRvZXNuJ3QgZG8gcHJvY2VzcyBzbGVlcC93YWtldXAg
dGhlIHNhbWUgd2F5Lg0KDQpUaGUgbmVhcmVzdCB0aGluZyB3b3VsZCBiZSAnc3RydWN0IHdhaXRf
cXVldWVfaGVhZCcuDQpCdXQgdGhlIGFkZHJlc3Mgb2YgdGhhdCBpc24ndCBhIHVzZWZ1bCB2YWx1
ZS4NClBsYXVzaWJseSB0aGUgYWRkcmVzcyBvZiB0aGUgZnVuY3Rpb24gdGhhdCBpbml0aWFsaXNl
cw0KdGhlIHdhaXRfcXVldWVfaGVhZCBjb3VsZCBiZSBwdXQgaW50byBpdCBhbmQgdGhhdA0KdmFs
dWUgc2F2ZWQgYnkgc2NoZWR1bGUoKSB0byB0aGF0IGl0IGNhbiBiZSByZXR1cm5lZA0KYXMgdGhl
ICd3Y2hhbicuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

