Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74973C6EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhGMKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:44:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21000 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235748AbhGMKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:44:21 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-195-YcZhAG2bMUqc6APF1V5etQ-1; Tue, 13 Jul 2021 11:41:28 +0100
X-MC-Unique: YcZhAG2bMUqc6APF1V5etQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 13 Jul 2021 11:41:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 13 Jul 2021 11:41:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>, yaozhenguo <yaozhenguo1@gmail.com>,
        "oleg@redhat.comm" <oleg@redhat.comm>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaozhenguo@jd.com" <yaozhenguo@jd.com>
Subject: RE: [PATCH] task_work: return -EBUSY when adding same work
Thread-Topic: [PATCH] task_work: return -EBUSY when adding same work
Thread-Index: AQHXdM1OJOja+KCFTU2lU5NJFMx/zqtAvCEQ
Date:   Tue, 13 Jul 2021 10:41:26 +0000
Message-ID: <3079d213543c4d398d96031e6da26c82@AcuMS.aculab.com>
References: <20210709122712.42844-1-yaozhenguo1@gmail.com>
 <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
In-Reply-To: <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
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

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAwOSBKdWx5IDIwMjEgMTU6MTgNCi4uLg0KPiA+ICAg
Ki8NCj4gPiAgaW50IHRhc2tfd29ya19hZGQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1
Y3QgY2FsbGJhY2tfaGVhZCAqd29yaywNCj4gPiAgCQkgIGVudW0gdGFza193b3JrX25vdGlmeV9t
b2RlIG5vdGlmeSkNCj4gPiBAQCAtNDEsNiArNDEsOCBAQCBpbnQgdGFza193b3JrX2FkZChzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCBjYWxsYmFja19oZWFkICp3b3JrLA0KPiA+ICAJ
CWhlYWQgPSBSRUFEX09OQ0UodGFzay0+dGFza193b3Jrcyk7DQo+ID4gIAkJaWYgKHVubGlrZWx5
KGhlYWQgPT0gJndvcmtfZXhpdGVkKSkNCj4gPiAgCQkJcmV0dXJuIC1FU1JDSDsNCj4gPiArCQlp
ZiAodW5saWtlbHkoaGVhZCA9PSB3b3JrKSkNCj4gPiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gPiAg
CQl3b3JrLT5uZXh0ID0gaGVhZDsNCj4gPiAgCX0gd2hpbGUgKGNtcHhjaGcoJnRhc2stPnRhc2tf
d29ya3MsIGhlYWQsIHdvcmspICE9IGhlYWQpOw0KPiANCj4gSSBkb24ndCB0aGluayB0aGVyZSdz
IGFueXRoaW5nIGNvbmNlcHR1YWxseSB3cm9uZyB3aXRoIHRoaXMgcGF0Y2gsIGJ1dA0KPiBpdCBt
YWtlcyBtZSB0aGluayB0aGF0IHlvdSBoaXQgdGhpcyBjb25kaXRpb24uIEl0J3MgcmVhbGx5IGEg
YnVnIGluIHRoZQ0KPiBjYWxsZXIsIG9mIGNvdXJzZSwgaXMgYSBXQVJOX09OX09OQ0UoKSB3YXJy
YW50ZWQgaGVyZT8gQW5kIHdobyB3YXMgdGhlDQo+IGNhbGxlcj8NCg0KSG93IGNhbiB0aGUgY2Fs
bGVyIGtub3cgdGhhdCB0aGUgdGFzayBpcyBvbiB0aGUgcXVldWU/DQoNClRoZXJlIHdpbGwgYmUg
YSByYWNlIGNvbmRpdGlvbiBqdXN0IGJlZm9yZSB0aGUgd29yayBmdW5jdGlvbg0KaXMgY2FsbGVk
IGFuZC9vciBqdXN0IGFmdGVyIGl0IHJldHVybnMgdGhhdCB0aGUgY2FsbGVyDQpjYW4ndCBkZXRl
Y3QuDQpUaGUgY2hlY2sgbmVlZHMgdG8gYmUgZG9uZSBhdG9taWNhbGx5IHdpdGggdGhlIGNvZGUg
dGhhdA0KcmVtb3ZlcyB0aGUgd29yayBpdGVtIGZyb20gdGhlIGxpc3QuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

