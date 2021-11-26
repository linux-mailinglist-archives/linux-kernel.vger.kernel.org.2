Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD20545F2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhKZRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:23:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28950 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhKZRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:21:54 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-p6P5kx9jPIac9PXsayavaA-1; Fri, 26 Nov 2021 17:18:35 +0000
X-MC-Unique: p6P5kx9jPIac9PXsayavaA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 26 Nov 2021 17:18:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 26 Nov 2021 17:18:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        X86 ML <x86@kernel.org>
Subject: RE: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Thread-Topic: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Thread-Index: AQHX4bFY91qWVfGwmUGWCXjqsQaln6wWDW5Q
Date:   Fri, 26 Nov 2021 17:18:34 +0000
Message-ID: <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
In-Reply-To: <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI1IE5vdmVtYmVyIDIwMjEgMDQ6MDENCi4uLg0K
PiA+IFRoZSBvdXRwdXRzIHNlZW0gdG8gbWF0Y2ggaWYgYGJ1ZmZgIGlzIGFsaWduZWQgdG8gNjQt
Yml0LiBTdGlsbCBzZWUNCj4gPiBkaWZmZXJlbmNlIHdpdGggYGNzdW1fZm9sZChjc3VtX3BhcnRp
YWwoKSlgIGlmIGBidWZmYCBpcyBub3QgNjQtYml0IGFsaWduZWQuDQo+ID4NCj4gPiBUaGUgY29t
bWVudCBhdCB0aGUgdG9wIHNheXMgaXQncyAiYmVzdCIgdG8gaGF2ZSBgYnVmZmAgNjQtYml0IGFs
aWduZWQgYnV0DQo+ID4gdGhlIGNvZGUgbG9naWMgc2VlbXMgbWVhbnQgdG8gc3VwcG9ydCB0aGUg
bWlzYWxpZ25lZCBjYXNlIHNvIG5vdA0KPiA+IHN1cmUgaWYgaXQncyBhbiBpc3N1ZS4NCj4gPg0K
PiANCj4gSXQgaXMgYW4gaXNzdWUgaW4gZ2VuZXJhbCwgbm90IGluIHN0YW5kYXJkIGNhc2VzIGJl
Y2F1c2UgbmV0d29yaw0KPiBoZWFkZXJzIGFyZSBhbGlnbmVkLg0KPiANCj4gSSB0aGluayBpdCBj
YW1lIHdoZW4gSSBmb2xkZWQgY3N1bV9wYXJ0aWFsKCkgYW5kIGRvX2NzdW0oKSwgSSBmb3Jnb3QN
Cj4gdG8gcm9yKCkgdGhlIHNlZWQuDQo+IA0KPiBJIHN1c3BlY3QgdGhlIGZvbGxvd2luZyB3b3Vs
ZCBoZWxwOg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQu
YyBiL2FyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYw0KPiBpbmRleCAxZWI4ZjJkMTFmN2M3
ODViZTYyNGViYTMxNWZlOWNhNzk4OWZkNTZkLi5lZTdiMGU3YTYwNTViY2JlZjQyZDIyZjdlMWQ4
ZjUyZGRiZDZiZTZkDQo+IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9saWIvY3N1bS1wYXJ0aWFs
XzY0LmMNCj4gKysrIGIvYXJjaC94ODYvbGliL2NzdW0tcGFydGlhbF82NC5jDQo+IEBAIC00MSw2
ICs0MSw3IEBAIF9fd3N1bSBjc3VtX3BhcnRpYWwoY29uc3Qgdm9pZCAqYnVmZiwgaW50IGxlbiwg
X193c3VtIHN1bSkNCj4gICAgICAgICBpZiAodW5saWtlbHkob2RkKSkgew0KPiAgICAgICAgICAg
ICAgICAgaWYgKHVubGlrZWx5KGxlbiA9PSAwKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHN1bTsNCj4gKyAgICAgICAgICAgICAgIHRlbXA2NCA9IHJvcjMyKChfX2ZvcmNlIHU2
NClzdW0sIDgpOw0KPiAgICAgICAgICAgICAgICAgdGVtcDY0ICs9ICgqKHVuc2lnbmVkIGNoYXIg
KilidWZmIDw8IDgpOw0KPiAgICAgICAgICAgICAgICAgbGVuLS07DQo+ICAgICAgICAgICAgICAg
ICBidWZmKys7DQoNCllvdSBjYW4gc2F2ZSBhbiBpbnN0cnVjdGlvbiAoYXMgaWYgdGhpcyBwYXRo
IG1hdHRlcnMpIGJ5Og0KCQkJdGVtcDY0ID0gc3VtICsgKih1bnNpZ25lZCBjaGFyICopYnVmZjsN
CgkJCXRlbXA2NCA8PD0gODsNCkFsdGhvdWdoIHRoYXQgcHJvYmFibHkgZmFsbHMgZm91bCBvZiA2
NGJpdCBzaGlmdHMgYmVpbmcgc2xvdy4NClNvIG1heWJlIGp1c3Q6DQoJCQlzdW0gKz0gKih1bnNp
Z25lZCBjaGFyICopYnVmZjsNCgkJCXRlbXA2NCA9IGJzd2FwMzIoc3VtKTsNCkFGQUlDVCAoZnJv
bSBhIHBkZikgYnN3YXAzMigpIGFuZCByb3IoeCwgOCkgYXJlIGxpa2VseSB0byBiZQ0KdGhlIHNh
bWUgc3BlZWQgYnV0IG1heSB1c2UgZGlmZmVyZW50IGV4ZWN1dGlvbiB1bml0cy4NCg0KSW50ZWwg
c2VlbSBzbyBoYXZlIG1hbmFnZWQgdG8gc2xvdyBkb3duIHJvcih4LCAlY2wpIHRvIDMgY2xvY2tz
DQppbiBzYW5keSBicmlkZ2UgLSBhbmQgc3RpbGwgbm90IGZpeGVkIGl0Lg0KQWx0aG91Z2ggdGhl
IGNvbXBpbGVyIG1pZ2h0IGJlIG1ha2luZyBhIHBpZ3MtYnJlYWtmYXN0IG9mIHRoZQ0KcmVnaXN0
ZXIgYWxsb2NhdGlvbiB3aGVuIHlvdSB0cmllZCBzZXR0aW5nICdvZGQgPSA4Jy4NCg0KV2Vla3Mg
Y2FuIGJlIHNwZW50IGZpZGRsaW5nIHdpdGggdGhpcyBjb2RlIDotKA0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

