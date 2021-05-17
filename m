Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF83827FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhEQJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:51070 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236020AbhEQJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:13:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-84-WDg8lplMP12FiW5wm3JgTQ-1; Mon, 17 May 2021 10:12:20 +0100
X-MC-Unique: WDg8lplMP12FiW5wm3JgTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 17 May 2021 10:12:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 17 May 2021 10:12:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Borislav Petkov" <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [GIT PULL] Stack randomization fix
Thread-Topic: [GIT PULL] Stack randomization fix
Thread-Index: AQHXSa2rgPfmA100B0Ku/Ax10JhCW6rnZAkA
Date:   Mon, 17 May 2021 09:12:17 +0000
Message-ID: <7f24c86f00e34e1d94ab38ff8d6419e2@AcuMS.aculab.com>
References: <20210515073453.GA78379@gmail.com>
 <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
In-Reply-To: <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTUgTWF5IDIwMjEgMTg6MTMNCj4gDQo+IE9u
IFNhdCwgTWF5IDE1LCAyMDIxIGF0IDEyOjM1IEFNIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gPg0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcmFuZG9taXplX2tzdGFj
ay5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9yYW5kb21pemVfa3N0YWNrLmgNCj4gPiBAQCAt
MzgsNyArMzgsNyBAQCB2b2lkICpfX2J1aWx0aW5fYWxsb2NhKHNpemVfdCBzaXplKTsNCj4gPiAg
ICAgICAgICAgICAgICAgLyogS2VlcCBhbGxvY2F0aW9uIGV2ZW4gYWZ0ZXIgInB0ciIgbG9zZXMg
c2NvcGUuICovICAgICBcDQo+ID4gLSAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiIiA6ICI9
byIoKnB0cikgOjogIm1lbW9yeSIpOyAgICAgICAgICAgICAgXA0KPiA+ICsgICAgICAgICAgICAg
ICBhc20gdm9sYXRpbGUoIiIgOjogInIiKHB0cikgOiAibWVtb3J5Iik7ICAgICAgICAgICAgICAg
IFwNCj4gPiAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+IA0KPiBTaWRlIG5vdGU6IGF0IHNvbWUgcG9pbnQs
IGEgY29tcGlsZXIgd2lsbCAoY29ycmVjdGx5KSBkZWNpZGUgdGhhdA0KPiByZWdhcmRsZXNzIG9m
IHRoZSBpbmxpbmUgYXNtIGhlcmUsIHRoZSBzY29wZSBvZiB0aGF0IGFsbG9jYXRpb24gaXMNCj4g
b25seSB0aGF0IG9uZSBibG9jay4NCj4gDQo+IFRvIGJlIGFjdHVhbGx5IHJlbGlhYmxlLCBJIHN1
c3BlY3QgdGhhdCBhZGRfcmFuZG9tX2tzdGFja19vZmZzZXQoKQ0KPiBzaG91bGQgcmV0dXJuIHRo
YXQgcG9pbnRlciBhcyBhIGNvb2tpZSwgYW5kIHRoZW4gdXNlcnMgc2hvdWxkIGhhdmUgYQ0KPiAN
Cj4gICAgICBlbmRfcmFuZG9tX2tzdGFja19vZmZzZXQoY29va2llKTsNCj4gDQo+IGF0IHRoZSBl
bmQgb2YgdGhlIGZ1bmN0aW9uIHRoYXQgZGlkIHRoZSBhZGRfcmFuZG9tX2tzdGFja19vZmZzZXQo
KS4NCg0KSG1tbS4uLiB3b3VsZCB0aGF0IGV2ZW4gaGVscD8NClRoZSBzY29wZSBvZiB0aGUgYWxs
b2NhKCkgYmxvY2sgaXMgc3RpbGwgdGhlIGNvZGUgYmxvY2sgaW4gd2hpY2ggaXQNCmlzIGNyZWF0
ZWQgLSBzbyB5b3UgYXJlIHN0aWxsIHVzaW5nIGEgcG9pbnRlciB0byBzdGFsZSBzdGFjay4NCg0K
VGhlIGFsbG9jYSgpIHdvdWxkIGhhdmUgdG8gaGF2ZSBmdW5jdGlvbiBzY29wZSB0byByZW1haW4g
dmFsaWQNCnRocm91Z2hvdXQgdGhlIGVudGlyZSBzeXN0ZW0gY2FsbC4NClRoZW4gdGhlIHNpbXBs
ZSBhc20gc3RhdGVtZW50IHRoYXQganVzdCBzYXZlcyB0aGUgcG9pbnRlciBvdWdodA0KdG8gYmUg
Z29vZCBlbm91Z2ggc2luY2UgdGhlIGNvbXBpbGVyIG11c3QgYXNzdW1lIHRoYXQgY2FuIGJlIHJl
YWQNCm11Y2ggbGF0ZXIgaW4gdGhlIHN5c2NhbGwgY29kZS4NCg0KSSd2ZSB0aG91Z2h0IG9mIGFu
IGFsdGVybmF0aXZlIGFwcHJvYWNoLg0KSW5zdGVhZCBvZiB1c2luZyBhbGxvY2EoKSBzYXZlIHRo
ZSBvZmZzZXQgaW4gYSBwZXItY3B1IGxvY2F0aW9uLg0KSW4gdGhlIG5leHQgc3lzdGVtIGNhbGwg
dXNlIHRoZSBzYXZlZCBvZmZzZXQgdG8gYWRqdXN0IHRoZQ0Kc3RhY2sgcG9pbnRlciBpbiB0aGUg
YXNtIHdyYXBwZXIuDQoNCkl0IGhhcyB0byBiZSBlYXNpZXIgdG8gYWRqdXN0IHRoZSBzdGFjayBw
b2ludGVyIHZlcnkgZWFybHkNCmluIHRoZSBzeXNjYWxsIGVudHJ5IHBhdGg/DQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

