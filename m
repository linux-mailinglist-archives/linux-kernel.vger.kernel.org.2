Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5668146098A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbhK1TxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:53:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:60352 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232965AbhK1TvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:51:09 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-118-qy-x9jMpP1-ksZIE77l-EA-1; Sun, 28 Nov 2021 19:47:50 +0000
X-MC-Unique: qy-x9jMpP1-ksZIE77l-EA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sun, 28 Nov 2021 19:47:49 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sun, 28 Nov 2021 19:47:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>,
        Eric Dumazet <edumazet@google.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in
 csum_partial.c
Thread-Topic: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in
 csum_partial.c
Thread-Index: AQHX4nNzHa79im/GnUeKV4t1ya1z3awZWESA
Date:   Sun, 28 Nov 2021 19:47:49 +0000
Message-ID: <8e4961ae0cf04a5ca4dffdec7da2e57b@AcuMS.aculab.com>
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CAFUsyfLKqonuKAh4k2qdBa24H1wQtR5FkAmmtXQGBpyizi6xvQ@mail.gmail.com>
 <CAFUsyfJ619Jx_BS515Se0V_zRdypOg3_2YzbKUk5zDBNaixhaQ@mail.gmail.com>
In-Reply-To: <CAFUsyfJ619Jx_BS515Se0V_zRdypOg3_2YzbKUk5zDBNaixhaQ@mail.gmail.com>
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

Li4uDQo+IFJlZ2FyZGluZyB0aGUgMzIgYnl0ZSBjYXNlLCBhZGRpbmcgdHdvIGFjY3VtdWxhdG9y
cyBoZWxwcyB3aXRoIHRoZSBsYXRlbmN5DQo+IG51bWJlcnMgYnV0IGNhdXNlcyBhIHJlZ3Jlc3Np
b24gaW4gdGhyb3VnaHB1dCBmb3IgdGhlIDQwLzQ4IGJ5dGUgY2FzZXMuIFdoaWNoDQo+IGlzIHRo
ZSBtb3JlIGltcG9ydGFudCBtZXRyaWMgZm9yIHRoZSB1c2FnZSBvZiBjc3VtX3BhcnRpYWwoKT8N
Cj4gDQo+IEhlcmUgYXJlIHRoZSBudW1iZXJzIGZvciB0aGUgc21hbGxlciBzaXplczoNCj4gDQo+
IHNpemUsIGxhdCBvbGQsICAgIGxhdCB2ZXIyLCAgICBsYXQgdmVyMSwgICAgdHB1dCBvbGQsICAg
dHB1dCB2ZXIyLCAgIHRwdXQgdmVyMQ0KPiAgICAwLCAgIDQuOTYxLCAgICAgICA0LjUwMywgICAg
ICAgNC45MDEsICAgICAgIDQuODg3LCAgICAgICA0LjM5OSwgICAgICAgNC45NTENCj4gICAgOCwg
ICA1LjU5MCwgICAgICAgNS41OTQsICAgICAgIDUuNjIwLCAgICAgICA0LjIyNywgICAgICAgNC4x
MTAsICAgICAgIDQuMjUyDQo+ICAgMTYsICAgNi4xODIsICAgICAgIDYuMzk4LCAgICAgICA2LjIw
MiwgICAgICAgNC4yMzMsICAgICAgIDQuMDYyLCAgICAgICA0LjI3OA0KPiAgIDI0LCAgIDcuMzky
LCAgICAgICA3LjU5MSwgICAgICAgNy4zODAsICAgICAgIDQuMjU2LCAgICAgICA0LjI0NiwgICAg
ICAgNC4yNzkNCj4gICAzMiwgICA3LjM3MSwgICAgICAgNi4zNjYsICAgICAgIDcuMzkwLCAgICAg
ICA0LjU1MCwgICAgICAgNC45MDAsICAgICAgIDQuNTM3DQo+ICAgNDAsICAgOC42MjEsICAgICAg
IDcuNDk2LCAgICAgICA4LjYwMSwgICAgICAgNC44NjIsICAgICAgIDUuMTYyLCAgICAgICA0Ljgz
Ng0KPiAgIDQ4LCAgIDkuNDA2LCAgICAgICA4LjEyOCwgICAgICAgOS4zNzQsICAgICAgIDUuMjA2
LCAgICAgICA1LjczNiwgICAgICAgNS4yMzQNCj4gICA1NiwgIDEwLjUzNSwgICAgICAgOS4xODks
ICAgICAgMTAuNTIyLCAgICAgICA1LjQxNiwgICAgICAgNS43NzIsICAgICAgIDUuNDQ3DQo+ICAg
NjQsICAxMC4wMDAsICAgICAgIDcuNDg3LCAgICAgICA3LjU5MCwgICAgICAgNi45NDYsICAgICAg
IDYuOTc1LCAgICAgICA2Ljk4OQ0KPiAgIDcyLCAgMTEuMTkyLCAgICAgICA4LjYzOSwgICAgICAg
OC43NjMsICAgICAgIDcuMjEwLCAgICAgICA3LjMxMSwgICAgICAgNy4yNzcNCj4gICA4MCwgIDEx
LjczNCwgICAgICAgOS4xNzksICAgICAgIDkuNDA5LCAgICAgICA3LjYwNSwgICAgICAgNy42MjAs
ICAgICAgIDcuNTQ4DQo+ICAgODgsICAxMi45MzMsICAgICAgMTAuNTQ1LCAgICAgIDEwLjU4NCwg
ICAgICAgNy44NzgsICAgICAgIDcuOTAyLCAgICAgICA3Ljg1OA0KPiAgIDk2LCAgMTIuOTUyLCAg
ICAgICA5LjMzMSwgICAgICAxMC42MjUsICAgICAgIDguMTY4LCAgICAgICA4LjQ3MCwgICAgICAg
OC4yMDYNCj4gIDEwNCwgIDE0LjIwNiwgICAgICAxMC40MjQsICAgICAgMTEuODM5LCAgICAgICA4
LjQ5MSwgICAgICAgOC43ODUsICAgICAgIDguNTAyDQo+ICAxMTIsICAxNC43NjMsICAgICAgMTEu
NDAzLCAgICAgIDEyLjQxNiwgICAgICAgOC43OTgsICAgICAgIDkuMTM0LCAgICAgICA4Ljc3MQ0K
PiAgMTIwLCAgMTUuOTU1LCAgICAgIDEyLjYzNSwgICAgICAxMy42NTEsICAgICAgIDkuMTc1LCAg
ICAgICA5LjQ5NCwgICAgICAgOS4xMzANCj4gIDEyOCwgIDE1LjI3MSwgICAgICAxMC41OTksICAg
ICAgMTAuNzI0LCAgICAgICA5LjcyNiwgICAgICAgOS42NzIsICAgICAgIDkuNjU1DQo+IA0KPiAn
dmVyMicgdXNlcyB0d28gYWNjdW11bGF0b3JzIGZvciAzMiBieXRlIGNhc2UgYW5kIGhhcyBiZXR0
ZXIgbGF0ZW5jeSBudW1iZXJzDQo+IGJ1dCByZWdyZXNzaW9ucyBpbiB0cHV0IGNvbXBhcmVkIHRv
ICdvbGQnIGFuZCAndmVyMScuICd2ZXIxJyBpcyB0aGUNCj4gaW1wbGVtZW50YXRpb24NCj4gcG9z
dGVkIHdoaWNoIGhhcyBlc3NlbnRpYWxseSB0aGUgc2FtZSBudW1iZXJzIGZvciB0cHV0L2xhdCBh
cyAnb2xkJw0KPiBmb3Igc2l6ZXMgWzAsIDYzXS4NCg0KV2hpY2ggY3B1IGFyZSB5b3UgdGVzdGlu
ZyBvbiAtIGl0IHdpbGwgbWFrZSBhIGJpZyBkaWZmZXJlbmNlID8NCkFuZCB3aGF0IGFyZSB5b3Ug
bWVhc2luZyB0aHJvdWdocHV0IGluPw0KQW5kIGFyZSB5b3UgdGVzdGluZyBhbGlnbmVkIG9yIG1p
cy1hbGlnbmVkIDY0Yml0IHJlYWRzPw0KDQpJIHRoaW5rIG9uZSBvZiB0aGUgcGVyZm9ybWFuY2Ug
Y291bnRlcnMgd2lsbCBnaXZlICdjcHUgY2xvY2tzJy4NCg0KSSBkaWQgc29tZSB0ZXN0cyBlYXJs
eSBsYXN0IHllYXIgYW5kIGdvdCA4IGJ5dGVzL2Nsb2NrIG9uIGJyb2Fkd2VsbC9oYXN3ZWxsDQp3
aXRoIGNvZGUgdGhhdCAnbG9vcCBjYXJyaWVkJyB0aGUgY2FycnkgZmxhZyAoYSBzaW5nbGUgYWRj
IGNoYWluKS4NCk9uIHRoZSBvbGRlciBJbnRlbCBjcHUgKEl2eSBicmlkZ2Ugb253YXJkcykgJ2Fk
YycgaGFzIGEgbGF0ZW5jeSBvZiAyDQpmb3IgdGhlIHJlc3VsdCwgYnV0IHRoZSBjYXJyeSBmbGFn
IGlzIGF2YWlsYWJsZSBlYXJsaWVyLg0KU28gYWx0ZXJuYXRpbmcgdGhlIHRhcmdldCByZWdpc3Rl
ciBpbiB0aGUgJ2FkYycgY2hhaW4gd2lsbCBnaXZlIChuZWFybHkpDQo4IGJ5dGVzL2Nsb2NrIC0g
SSB0aGluayBJIGdvdCB0byA3LjUuDQoNClRoYXQgY2FuIGFsbCBiZSBkb25lIHdpdGggb25seSA0
IHJlYWRzIHBlciBpbnRlcmFjdGlvbi4NCklJUkMgYnJvYWR3ZWxsL2hhc3dlbGwgb25seSBuZWVk
IDIgcmVhZHMvaXRlcmF0aW9uLg0KDQpJdCBpcyBhY3R1YWxseSBsaWtlbHkgKGNlcnRhaW5seSB3
b3J0aCBjaGVja2luZykgdGhhdCBoYXN3ZWxsL2Jyb2Fkd2VsbA0KY2FuIGRvIHR3byBtaXNhbGln
bmVkIG1lbW9yeSByZWFkcyBldmVyeSBjbG9jay4NClNvIGl0IG1heSBub3QgYmUgd29ydGggYWxp
Z25pbmcgdGhlIHJlYWRzICh3aGljaCB0aGUgb2xkIGNvZGUgZGlkKS4NCkluIGFueSBjYXNlIGFy
ZW4ndCB0eCBwYWNrZXRzIGxpa2VseSB0byBiZSBhbGlnbmVkLCBhbmQgcnggb25lcw0KbWlzYWxp
Z25lZCB0byBzb21lIGtub3duIDRuKzIgYm91bmRhcnk/DQoNClVzaW5nIGFkeGMvYWR4byB0b2dl
dGhlciBpcyBhIHJpZ2h0IFBJVEEuDQpJIGRpZCBnZXQgKGFib3V0KSAxMiBieXRlcy9jbG9jayBm
byBsb25nIGJ1ZmZlcnMgd2hpbGUgbG9vcCBjYXJyeWluZw0KYm90aCB0aGUgb3ZlcmZsb3cgYW5k
IGNhcnJ5IGZsYWdzLg0KDQpBbHNvIGlzIHRoZXJlIGEgY29weSBvZiB0aGUgcGF0Y2hlZCBjb2Rl
IGFueXdoZXJlPw0KSSB0aGluayBJJ3ZlIG1pc3NlZCBzb21lIG9mIHRoZSBwYXRjaGVzIGFuZCB0
aGV5IGFyZSBkaWZmaWN1bHQgdG8gZm9sbG93Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

