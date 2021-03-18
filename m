Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40213401A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCRJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:14:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48643 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhCRJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:14:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-HB0JS3AuOO2RQEe5DAakJQ-1; Thu, 18 Mar 2021 09:14:31 +0000
X-MC-Unique: HB0JS3AuOO2RQEe5DAakJQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 18 Mar 2021 09:14:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 18 Mar 2021 09:14:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: RE: [PATCH mm] kfence: fix printk format for ptrdiff_t
Thread-Topic: [PATCH mm] kfence: fix printk format for ptrdiff_t
Thread-Index: AQHXGnrjHw0GM4Y/B0GSBDFCMZ5+u6qIIzEwgABPpACAAQUwQA==
Date:   Thu, 18 Mar 2021 09:14:27 +0000
Message-ID: <4f7becfe2b6e4263be83b5ee461b5732@AcuMS.aculab.com>
References: <20210303121157.3430807-1-elver@google.com>
 <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
 <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
 <20210316153320.GF16691@gate.crashing.org>
 <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu>
 <6d4b370dc76543f2ba8ad7c6dcdfc7af@AcuMS.aculab.com>
 <001a139e-d4fa-2fd7-348f-173392210dfd@csgroup.eu>
In-Reply-To: <001a139e-d4fa-2fd7-348f-173392210dfd@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNyBNYXJjaCAyMDIxIDE3OjM1DQo+IA0K
PiBMZSAxNy8wMy8yMDIxIMOgIDEzOjUxLCBEYXZpZCBMYWlnaHQgYSDDqWNyaXTCoDoNCj4gPiBG
cm9tOiBDaHJpc3RvcGhlIExlcm95DQo+ID4+IFNlbnQ6IDE2IE1hcmNoIDIwMjEgMTU6NDENCj4g
PiAuLi4NCj4gPj4+PiBpbmNsdWRlL2xpbnV4L3R5cGVzLmg6dHlwZWRlZiBfX2tlcm5lbF9wdHJk
aWZmX3QJcHRyZGlmZl90Ow0KPiA+Pj4+DQo+ID4+Pj4gQW5kIGdldDoNCj4gPj4+Pg0KPiA+Pj4+
ICAgICBDQyAgICAgIG1tL2tmZW5jZS9yZXBvcnQubw0KPiA+Pj4+IEluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAuL2luY2x1ZGUvbGludXgvcHJpbnRrLmg6NywNCj4gPj4+PiAgICAgICAgICAgICAgICAg
ICAgZnJvbSAuL2luY2x1ZGUvbGludXgva2VybmVsLmg6MTYsDQo+ID4+Pj4gICAgICAgICAgICAg
ICAgICAgIGZyb20gbW0va2ZlbmNlL3JlcG9ydC5jOjEwOg0KPiA+Pj4+IG1tL2tmZW5jZS9yZXBv
cnQuYzogSW4gZnVuY3Rpb24gJ2tmZW5jZV9yZXBvcnRfZXJyb3InOg0KPiA+Pj4+IC4vaW5jbHVk
ZS9saW51eC9rZXJuX2xldmVscy5oOjU6MTg6IHdhcm5pbmc6IGZvcm1hdCAnJXRkJyBleHBlY3Rz
IGFyZ3VtZW50DQo+ID4+Pj4gb2YgdHlwZSAncHRyZGlmZl90JywgYnV0IGFyZ3VtZW50IDYgaGFz
IHR5cGUgJ2xvbmcgaW50JyBbLVdmb3JtYXQ9XQ0KPiA+Pj4NCj4gPj4+IFRoaXMgaXMgZGVjbGFy
ZWQgYXMNCj4gPj4+ICAgICAgICAgICBjb25zdCBwdHJkaWZmX3Qgb2JqZWN0X2luZGV4ID0gbWV0
YSA/IG1ldGEgLSBrZmVuY2VfbWV0YWRhdGEgOiAtMTsNCj4gPj4+IHNvIG1heWJlIHNvbWV0aGlu
ZyB3aXRoIHRoYXQgZ29lcyB3cm9uZz8gIFdoYXQgaGFwcGVucyBpZiB5b3UgZGVsZXRlIHRoZQ0K
PiA+Pj4gKHVzZWxlc3MpICJjb25zdCIgaGVyZT8NCj4gPg0KPiA+IFRoZSBvYnZpb3VzIHRoaW5n
IHRvIHRyeSBpcyBjaGFuZ2luZyBpdCB0byAnaW50Jy4NCj4gPiBUaGF0IHdpbGwgYnJlYWsgNjRi
aXQgYnVpbGRzLCBidXQgaWYgaXQgZml4ZXMgdGhlIDMyYml0IG9uZQ0KPiA+IGl0IHdpbGwgdGVs
bCB5b3Ugd2hhdCB0eXBlIGdjYyBpcyBleHBlY3RpbmcuDQo+ID4NCj4gDQo+IFllcywgaWYgZGVm
aW5pbmcgJ29iamVjdF9pbmRleCcgYXMgaW50LCBnY2MgaXMgaGFwcHkuDQo+IElmIHJlbW92aW5n
IHRoZSBwb3dlcnBjIHJlLWRlZmluaXRpb24gb2YgcHRyZGlmZl90IHR5cGVkZWYgaW4NCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTItcmMzL3NvdXJjZS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS91YXBpL2FzbS9wb3NpeF90eXBlcy5oICwgaXQNCj4gd29ya3MgZ3JlYXQgYXMg
d2VsbC4NCj4gDQo+IFNvIHNlZW1zIGxpa2UgZ2NjIGRvZXNuJ3QgdGFrZSBpbnRvIGFjY291bnQg
dGhlIHR5cGVkZWYgYmVoaW5kIHB0cmRpZmZfdCwgaXQganVzdCBleHBlY3RzIGl0IHRvIGJlDQo+
IGludCBvbiAzMiBiaXRzID8NCg0KZ2NjIG5ldmVyIGNhcmVzIGhvdyBwdHJkaWZmX3QgKG9yIGFu
eSBvZiB0aGUgcmVsYXRlZCB0eXBlcykgaXMgZGVmaW5lZA0KaXQgcmVxdWlyZXMgaW50IG9yIGxv
bmcgZm9yIHRoZSBmb3JtYXQgZGVwZW5kaW5nIG9uIHRoZSBhcmNoaXRlY3R1cmUuDQpUaGUgZXJy
b3IgbWVzc2FnZSB3aWxsIHNheSBwdHJkaWZmX3Qgb3Igc2l6ZV90IChldGMpIC0gYnV0IHRoYXQg
aXMganVzdA0KaW4gdGhlIGVycm9yIG1lc3NhZ2UuDQoNClNvIHRoZSBwcGMzMiB1YXBpIGRlZmlu
aXRpb24gb2YgX19rZXJuZWxfcHRyZGlmZl90IGlzIHdyb25nLg0KSG93ZXZlciBpdCBpcyBwcm9i
YWJseSBzZXQgaW4gc3RvbmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

