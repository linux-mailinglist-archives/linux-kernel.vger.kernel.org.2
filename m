Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848CD4046EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhIIIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:22:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52729 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhIIIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:22:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-211-YcGopUwFOv-5xu_HIwWLMQ-1; Thu, 09 Sep 2021 09:21:05 +0100
X-MC-Unique: YcGopUwFOv-5xu_HIwWLMQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 9 Sep 2021 09:21:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 9 Sep 2021 09:21:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] staging: r8188eu: Shorten calls chain of
 rtw_write8/16/32/N()
Thread-Topic: [PATCH v3 3/3] staging: r8188eu: Shorten calls chain of
 rtw_write8/16/32/N()
Thread-Index: AQHXowbxud4S7oFeskKSrbEZlc25E6uYWqHggALzDACAABMDkA==
Date:   Thu, 9 Sep 2021 08:21:04 +0000
Message-ID: <0614a5a9a1d54700be6d824bdd7c7469@AcuMS.aculab.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-4-fmdefrancesco@gmail.com>
 <5a359f20e80341c9910ecc6286eb0aec@AcuMS.aculab.com>
 <10808398.E1SmXddD8m@localhost.localdomain>
In-Reply-To: <10808398.E1SmXddD8m@localhost.localdomain>
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

RnJvbTogRmFiaW8gTS4gRGUgRnJhbmNlc2NvDQo+IFRvOiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZp
bmdlckBsd2Zpbmdlci5uZXQ+OyBQaGlsbGlwIFBvdHRlciA8cGhpbEBwaGlscG90dGVyLmNvLnVr
PjsgR3JlZyBLcm9haC0NCj4gPiAuLi4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdp
bmcvcjgxODhldS9oYWwvdXNiX29wc19saW51eC5jIGIvZHJpdmVycy8NCj4gc3RhZ2luZy9yODE4
OGV1L2hhbC91c2Jfb3BzX2xpbnV4LmMNCj4gPiA+IGluZGV4IGY5YzRmZDVhMmM1My4uZTMxZDFi
MWZkYjEyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvaGFsL3Vz
Yl9vcHNfbGludXguYw0KPiA+ID4gKysrIGIvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvaGFsL3Vz
Yl9vcHNfbGludXguYw0KPiA+ID4gQEAgLTgsNzYgKzgsNTEgQEANCj4gPiA+ICAjaW5jbHVkZSAi
Li4vaW5jbHVkZS9yZWN2X29zZGVwLmgiDQo+ID4gPiAgI2luY2x1ZGUgIi4uL2luY2x1ZGUvcnRs
ODE4OGVfaGFsLmgiDQo+ID4gPg0KPiA+ID4gLXN0YXRpYyBpbnQgdXNiY3RybF92ZW5kb3JyZXEo
c3RydWN0IGludGZfaGRsICpwaW50ZmhkbCwgdTE2IHZhbHVlLCB2b2lkDQo+ICpwZGF0YSwgdTE2
IGxlbiwgdTgNCj4gPiA+IHJlcXVlc3R0eXBlKQ0KPiA+ID4gK3N0YXRpYyBpbnQgdXNiX3JlYWQo
c3RydWN0IGludGZfaGRsICppbnRmaGRsLCB1MzIgYWRkciwgdm9pZCAqZGF0YSwgdTgNCj4gc2l6
ZSkNCj4gPiA+ICB7DQo+ID4gPiAtCXN0cnVjdCBhZGFwdGVyCSphZGFwdCA9IHBpbnRmaGRsLT5w
YWRhcHRlcjsNCj4gPiA+IC0Jc3RydWN0IGR2b2JqX3ByaXYgICpkdm9ianByaXYgPSBhZGFwdGVy
X3RvX2R2b2JqKGFkYXB0KTsNCj4gPiA+ICsJdTE2IHZhbHVlID0gKHUxNikoYWRkciAmIDB4MDAw
MGZmZmYpOw0KPiA+ID4gKwlzdHJ1Y3QgYWRhcHRlciAqYWRhcHQgPSBpbnRmaGRsLT5wYWRhcHRl
cjsNCj4gPiA+ICsJc3RydWN0IGR2b2JqX3ByaXYgKmR2b2JqcHJpdiA9IGFkYXB0ZXJfdG9fZHZv
YmooYWRhcHQpOw0KPiA+ID4gIAlzdHJ1Y3QgdXNiX2RldmljZSAqdWRldiA9IGR2b2JqcHJpdi0+
cHVzYmRldjsNCj4gPiA+IC0JdW5zaWduZWQgaW50IHBpcGU7DQo+ID4gPiAtCWludCBzdGF0dXMg
PSAwOw0KPiA+ID4gLQl1OCAqcElvX2J1ZjsNCj4gPiA+ICsJaW50IHN0YXR1czsNCj4gPiA+ICsJ
dTggKmlvX2J1ZjsNCj4gPg0KPiA+IFNvbWUgb2YgdGhlc2UgY2hhbmdlcyBhcmUgd2hpdGVzcGFj
ZSBvciByZW5hbWVzLg0KPiA+IFRoZXkgb3VnaHQgdG8gYmUgaW4gYSBkaWZmZXJlbnQgcGF0Y2gu
DQo+IA0KPiBEZWFyIERhdmlkLA0KPiANCj4gTm8sIHRoZXkgYXJlIG5vdC4NCj4gDQo+IEkgZ3Vl
c3MgeW91IHdlcmUgbWlzbGVkIGJ5IHRoZSBzdHJ1Y3R1cmUgb2YgdGhlIHBhdGNoZXMuIFRoZXJl
IGlzIG5vdGhpbmcgSQ0KPiBjYW4gZG8gYWJvdXQgaXQuIFBsZWFzZSBub3RpY2UgdGhhdCB1c2Jf
cmVhZCgpIGlzIGNyZWF0ZWQgaW4gMi8zLCBhbmQgSSdtDQo+IGZyZWUgdG8gdXNlIHRoZSBuYW1l
IG9mIHRoZSB2YXJpYWJsZXMgSSBsaWtlIGluIG5ldyBmdW5jdGlvbnMuIEZ1cnRoZXJtb3JlLA0K
PiB1c2JfcmVhZCgpIGlzIHVudG91Y2hlZCBpbiAzLzMuIEkgY2FuIHNlZSB3aHkgeW91IHRob3Vn
aHQgdGhleSBhcmUgcmVuYW1lcyA6KQ0KDQpIbW1tLi4uIGl0IG1pZ2h0IGJlIHdvcnRoIHBsYXlp
bmcgd2l0aCB0aGUgcGF0Y2hlcyBhbmQgdGhlDQpvcmRlciBvZiBmdW5jdGlvbnMgc28gdGhhdCB0
aGUgZGlmZnMgYXJlIG1lYW5pbmdmdWwuDQoNClNvbWUgZXhwZXJpbWVudGF0aW9uIGNhbiBiZSBu
ZWVkZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

