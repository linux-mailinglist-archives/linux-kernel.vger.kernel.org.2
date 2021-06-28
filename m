Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2A3B5A54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhF1ISI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:18:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32813 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhF1ISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:18:06 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-2pjBT2hzNWWe7pI_mruhNQ-1; Mon, 28 Jun 2021 09:15:38 +0100
X-MC-Unique: 2pjBT2hzNWWe7pI_mruhNQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Jun
 2021 09:15:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 28 Jun 2021 09:15:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Alejandro Colomar (man-pages)'" <alx.manpages@gmail.com>,
        glibc <libc-alpha@sourceware.org>
CC:     "tech@openbsd.org" <tech@openbsd.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] strcpys(): New function for copying strings safely
Thread-Topic: [RFC] strcpys(): New function for copying strings safely
Thread-Index: AQHXa40prEqUpDaQkE64wDC5dyLrNKspEcOg
Date:   Mon, 28 Jun 2021 08:15:38 +0000
Message-ID: <f5bfab0dce604736b6a563a4f9f7ce43@AcuMS.aculab.com>
References: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
 <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
In-Reply-To: <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
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

RnJvbTogQWxlamFuZHJvIENvbG9tYXINCj4gU2VudDogMjcgSnVuZSAyMDIxIDIwOjQ3DQo+IA0K
PiBPbiA2LzI3LzIxIDk6MjYgUE0sIEFsZWphbmRybyBDb2xvbWFyIChtYW4tcGFnZXMpIHdyb3Rl
Og0KPiA+DQo+ID4gSXQgaXMgZGVzaWduZWQgc28gdGhhdCB1c2FnZSByZXF1aXJlcyB0aGUgbWlu
aW11bSBudW1iZXIgb2YgbGluZXMgb2YNCj4gPiBjb2RlIGZvciBjb21wbGV0ZSB1c2FnZSAoaW5j
bHVkaW5nIGVycm9yIGhhbmRsaW5nIGNoZWNrcyk6DQo+ID4NCj4gPiBbWw0KPiA+IC8vIFdoZW4g
d2UgYWxyZWFkeSBjaGVja2VkIHRoYXQgJ3NpemUnIGlzID49IDENCj4gPiAvLyBhbmQgdHJ1bmNh
dGlvbiBpcyBub3QgYW4gaXNzdWU6DQo+ID4NCj4gPiBzdHJjcHlzX25wKHNpemUsIGRlc3QsIHNy
YywgTlVMTCk7DQo+IA0KPiBBbHNvLCBnaXZlbiBob3cgdW5saWtlbHkgdGhpcyBjYXNlIGlzLCBJ
IGhhdmUgaW4gbXkgY29kZToNCj4gYFtbZ251Ojp3YXJuX3VudXNlZF9yZXN1bHRdXWANCg0Kd2Fy
bl91bnVzZWRfcmVzdWx0IGlzIHN1Y2ggYSBQSVRBIGl0IHNob3VsZCBuZXZlciBoYXZlIGJlZW4g
aW52ZW50ZWQuDQpBdCBsZWFzdCBubyBvbmUgc2VlbXMgdG8gaGF2ZSBiZWVuIHN0dXBpZCBlbm91
Z2ggdG8gYXBwbHkgaXQgdG8gZnByaW50ZigpDQooeW91IG5lZWQgdG8gZG8gZmZsdXNoKCkgYmVm
b3JlIGxvb2tpbmcgZm9yIGVycm9ycykuDQoNCkluIG1vc3QgY2FzZXMgc3RyY3B5KCkgaXMgc2Fm
ZSAtIGJ1dCBpZiB0aGUgaW5wdXRzIGFyZSAnY29ycnVwdCcNCmhvcnJpZCB0aGluZ3MgaGFwcGVu
IC0gc28geW91IG5lZWQgdHJ1bmNhdGlvbiBmb3Igc2FmZXR5Lg0KQnV0IHlvdSByZWFsbHkgbWF5
IG5vdCBjYXJlIHdoZXRoZXIgdGhlIGRhdGEgZ290IHRydW5jYXRlZC4NCg0KVGhlIG90aGVyIHVz
ZSBpcyB3aGVyZSB5b3Ugd2FudCBhIHNlcXVlbmNlIG9mOg0KCWxlbiAqPSBzdHJfY29weShkZXN0
ICsgbGVuLCBkZXN0X2xlbiAtIGxlbiwgc3JjKTsNCkJ1dCBkb24ndCByZWFsbHkgd2FudCB0byB0
ZXN0IGZvciBvdmVyZmxvdyBhZnRlciBlYWNoIGNhbGwuDQoNCkluIHRoaXMgY2FzZSByZXR1cm5p
bmcgdGhlIGJ1ZmZlciBsZW5ndGggKGluY2x1ZGluZyB0aGUgYWRkZWQNCidcMCcgb24gdHJ1bmNh
dGlvbiB3b3JrcyBxdWl0ZSBuaWNlbHkuDQpObyBjaGFuY2Ugb2Ygd3JpdGluZyBvdXRzaWRlIHRo
ZSBidWZmZXIsIHNhZmUgdHJ1bmNhdGlvbiBhbmQNCmEgc2ltcGxlICdsZW4gPT0gZGVzdF9sZW4n
IGNoZWNrIGZvciBvdmVyZmxvdy4NCg0KT1RPSCB0aGVyZSBhcmUgYWxyZWFkeSB0b28gbWFueSBz
dHJpbmcgY29weSBmdW5jdGlvbnMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

