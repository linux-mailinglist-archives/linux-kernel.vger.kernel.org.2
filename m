Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00D45F6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbhKZWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:46:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32676 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245116AbhKZWo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:44:28 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-166-QV9_LRS0PZikqvg_y7xmSw-1; Fri, 26 Nov 2021 22:41:11 +0000
X-MC-Unique: QV9_LRS0PZikqvg_y7xmSw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 26 Nov 2021 22:41:10 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 26 Nov 2021 22:41:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>
CC:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
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
Thread-Index: AQHX4bFY91qWVfGwmUGWCXjqsQaln6wWDW5QgAAQxICAAEM4IA==
Date:   Fri, 26 Nov 2021 22:41:10 +0000
Message-ID: <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
 <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
In-Reply-To: <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI2IE5vdmVtYmVyIDIwMjEgMTg6MTANCi4uLg0K
PiA+IEFGQUlDVCAoZnJvbSBhIHBkZikgYnN3YXAzMigpIGFuZCByb3IoeCwgOCkgYXJlIGxpa2Vs
eSB0byBiZQ0KPiA+IHRoZSBzYW1lIHNwZWVkIGJ1dCBtYXkgdXNlIGRpZmZlcmVudCBleGVjdXRp
b24gdW5pdHMuDQoNClRoZSA2NGJpdCBzaGlmdHMvcm90YXRlcyBhcmUgYWxzbyBvbmx5IG9uZSBj
bG9jay4NCkl0IGlzIHRoZSBic3dhcDY0IHRoYXQgY2FuIGJlIHR3by4NCg0KPiA+IEludGVsIHNl
ZW0gc28gaGF2ZSBtYW5hZ2VkIHRvIHNsb3cgZG93biByb3IoeCwgJWNsKSB0byAzIGNsb2Nrcw0K
PiA+IGluIHNhbmR5IGJyaWRnZSAtIGFuZCBzdGlsbCBub3QgZml4ZWQgaXQuDQo+ID4gQWx0aG91
Z2ggdGhlIGNvbXBpbGVyIG1pZ2h0IGJlIG1ha2luZyBhIHBpZ3MtYnJlYWtmYXN0IG9mIHRoZQ0K
PiA+IHJlZ2lzdGVyIGFsbG9jYXRpb24gd2hlbiB5b3UgdHJpZWQgc2V0dGluZyAnb2RkID0gOCcu
DQo+ID4NCj4gPiBXZWVrcyBjYW4gYmUgc3BlbnQgZmlkZGxpbmcgd2l0aCB0aGlzIGNvZGUgOi0o
DQo+IA0KPiBZZXMsIGFuZCBpbiB0aGUgZW5kLCBpdCB3b24ndCBiZSBhYmxlIHRvIGNvbXBldGUg
d2l0aCAgYQ0KPiBzcGVjaWFsaXplZC9pbmxpbmVkIGlwdjZfY3N1bV9wYXJ0aWFsKCkNCg0KSSBi
ZXQgbW9zdCBvZiB0aGUgZ2FpbiBjb21lcyBmcm9tIGtub3dpbmcgdGhlcmUgaXMgYSBub24temVy
bw0Kd2hvbGUgbnVtYmVyIG9mIDMyYml0IHdvcmRzLg0KVGhlIHBlc2t5IGVkZ2UgY29uZGl0aW9u
cyBjb3N0Lg0KDQpBbmQgZXZlbiB0aGVuIHlvdSBuZWVkIHRvIGdldCBpdCByaWdodCENClRoZSBv
bmUgZm9yIHN1bW1pbmcgdGhlIDUtd29yZCBJUHY0IGhlYWRlciBpcyBhY3R1YWxseSBob3JyaWQN
Cm9uIEludGVsIGNwdSBwcmlvciB0byBIYXN3ZWxsIGJlY2F1c2UgJ2FkYycgaGFzIGEgbGF0ZW5j
eSBvZiAyLg0KT24gU2FuZHkgYnJpZGdlIHRoZSBjYXJyeSBvdXRwdXQgaXMgdmFsaWQgb24gdGhl
IG5leHQgY2xvY2ssDQpzbyBhZGRpbmcgdG8gYWx0ZXJuYXRlIHJlZ2lzdGVycyBkb3VibGVzIHRo
cm91Z2hwdXQuDQooVGhhdCBjb3VsZCBlYXNpbHkgYmUgZG9uZSBpbiB0aGUgY3VycmVudCBmdW5j
dGlvbiBhbmQgd2lsbA0KbWFrZSBhIGJpZyBkaWZmZXJlbnQgb24gdGhvc2UgY3B1LikNCg0KQnV0
IGJhc2ljYWxseSB0aGUgY3VycmVudCBnZW5lcmljIGNvZGUgaGFzIHRoZSBsb29wIHVucm9sbGVk
DQpmdXJ0aGVyIHRoYW4gaXMgbmVjZXNzYXJ5IGZvciBtb2Rlcm4gKG5vbi1hdG9tKSBjcHUuDQpU
aGF0IGp1c3QgYWRkcyBtb3JlIGNvZGUgb3V0c2lkZSB0aGUgbG9vcC4NCg0KSSBkaWQgbWFuYWdl
ZCB0byBnZXQgMTIgYnl0ZXMvY2xvY2sgdXNpbmcgYWRjby9hZG94IHdpdGggb25seQ0KMzIgYnl0
ZXMgZWFjaCBpdGVyYXRpb24uDQpUaGF0IHdpbGwgcmVxdWlyZSBhbGlnbmVkIGJ1ZmZlcnMuDQoN
CkFsaWdubWVudCB3b24ndCBtYXR0ZXIgZm9yICdhZGMnIGxvb3BzIGJlY2F1c2UgdGhlcmUgYXJl
IHR3bw0KJ21lbW9yeSByZWFkJyB1bml0cyAtIGJ1dCB0aGVyZSBpcyB0aGUgZWxlcGhhbnQ6DQoN
ClNhbmR5IGJyaWRnZSBDYWNoZSBiYW5rIGNvbmZsaWN0cw0KRWFjaCBjb25zZWN1dGl2ZSAxMjgg
Ynl0ZXMsIG9yIHR3byBjYWNoZSBsaW5lcywgaW4gdGhlIGRhdGEgY2FjaGUgaXMgZGl2aWRlZA0K
aW50byA4IGJhbmtzIG9mIDE2IGJ5dGVzIGVhY2guIEl0IGlzIG5vdCBwb3NzaWJsZSB0byBkbyB0
d28gbWVtb3J5IHJlYWRzIGluDQp0aGUgc2FtZSBjbG9jayBjeWNsZSBpZiB0aGUgdHdvIG1lbW9y
eSBhZGRyZXNzZXMgaGF2ZSB0aGUgc2FtZSBiYW5rIG51bWJlciwNCmkuZS4gaWYgYml0IDQgLSA2
IGluIHRoZSB0d28gYWRkcmVzc2VzIGFyZSB0aGUgc2FtZS4NCgk7IEV4YW1wbGUgOS41LiBTYW5k
eSBicmlkZ2UgY2FjaGUgYmFuayBjb25mbGljdA0KCW1vdiBlYXgsIFtyc2ldIDsgVXNlIGJhbmsg
MCwgYXNzdW1pbmcgcnNpIGlzIGRpdmlzaWJsZSBieSA0MEgNCgltb3YgZWJ4LCBbcnNpKzEwMEhd
IDsgVXNlIGJhbmsgMC4gQ2FjaGUgYmFuayBjb25mbGljdA0KCW1vdiBlY3gsIFtyc2krMTEwSF0g
OyBVc2UgYmFuayAxLiBObyBjYWNoZSBiYW5rIGNvbmZsaWN0DQoNClRoYXQgaXNuJ3QgYSBwcm9i
bGVtIG9uIEhhc3dlbGwsIGJ1dCBpdCBpcyBwcm9iYWJseSB3b3J0aCBvcmRlcmluZw0KdGhlICdh
ZGMnIGluIHRoZSBsb29wIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIGNvbmZsaWN0cy4NCkkgZGlk
bid0IHRyeSB0byBsb29rIGZvciB0aGF0IHRob3VnaC4NCkkgb25seSByZW1lbWJlciB0ZXN0aW5n
IGFsaWduZWQgYnVmZmVycyBvbiBTYW5keS9JdnkgYnJpZGdlLg0KQWRkaW5nIHRvIGFsdGVybmF0
ZSByZWdpc3RlcnMgaGVscGVkIG5vIGVuZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

