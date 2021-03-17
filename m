Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAC33F0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCQMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:52:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:20381 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhCQMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:52:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-178-ED19Hj86PCuP2PKcO90fAQ-1; Wed, 17 Mar 2021 12:51:59 +0000
X-MC-Unique: ED19Hj86PCuP2PKcO90fAQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 12:51:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 17 Mar 2021 12:51:58 +0000
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
Thread-Index: AQHXGnrjHw0GM4Y/B0GSBDFCMZ5+u6qIIzEw
Date:   Wed, 17 Mar 2021 12:51:58 +0000
Message-ID: <6d4b370dc76543f2ba8ad7c6dcdfc7af@AcuMS.aculab.com>
References: <20210303121157.3430807-1-elver@google.com>
 <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
 <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu>
 <20210316153320.GF16691@gate.crashing.org>
 <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu>
In-Reply-To: <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNiBNYXJjaCAyMDIxIDE1OjQxDQouLi4N
Cj4gPj4gaW5jbHVkZS9saW51eC90eXBlcy5oOnR5cGVkZWYgX19rZXJuZWxfcHRyZGlmZl90CXB0
cmRpZmZfdDsNCj4gPj4NCj4gPj4gQW5kIGdldDoNCj4gPj4NCj4gPj4gICAgQ0MgICAgICBtbS9r
ZmVuY2UvcmVwb3J0Lm8NCj4gPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51
eC9wcmludGsuaDo3LA0KPiA+PiAgICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51
eC9rZXJuZWwuaDoxNiwNCj4gPj4gICAgICAgICAgICAgICAgICAgZnJvbSBtbS9rZmVuY2UvcmVw
b3J0LmM6MTA6DQo+ID4+IG1tL2tmZW5jZS9yZXBvcnQuYzogSW4gZnVuY3Rpb24gJ2tmZW5jZV9y
ZXBvcnRfZXJyb3InOg0KPiA+PiAuL2luY2x1ZGUvbGludXgva2Vybl9sZXZlbHMuaDo1OjE4OiB3
YXJuaW5nOiBmb3JtYXQgJyV0ZCcgZXhwZWN0cyBhcmd1bWVudA0KPiA+PiBvZiB0eXBlICdwdHJk
aWZmX3QnLCBidXQgYXJndW1lbnQgNiBoYXMgdHlwZSAnbG9uZyBpbnQnIFstV2Zvcm1hdD1dDQo+
ID4NCj4gPiBUaGlzIGlzIGRlY2xhcmVkIGFzDQo+ID4gICAgICAgICAgY29uc3QgcHRyZGlmZl90
IG9iamVjdF9pbmRleCA9IG1ldGEgPyBtZXRhIC0ga2ZlbmNlX21ldGFkYXRhIDogLTE7DQo+ID4g
c28gbWF5YmUgc29tZXRoaW5nIHdpdGggdGhhdCBnb2VzIHdyb25nPyAgV2hhdCBoYXBwZW5zIGlm
IHlvdSBkZWxldGUgdGhlDQo+ID4gKHVzZWxlc3MpICJjb25zdCIgaGVyZT8NCg0KVGhlIG9idmlv
dXMgdGhpbmcgdG8gdHJ5IGlzIGNoYW5naW5nIGl0IHRvICdpbnQnLg0KVGhhdCB3aWxsIGJyZWFr
IDY0Yml0IGJ1aWxkcywgYnV0IGlmIGl0IGZpeGVzIHRoZSAzMmJpdCBvbmUNCml0IHdpbGwgdGVs
bCB5b3Ugd2hhdCB0eXBlIGdjYyBpcyBleHBlY3RpbmcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

