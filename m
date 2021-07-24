Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68AE3D4747
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhGXKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:24:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28627 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhGXKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:24:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-11-Wgv43lgyNsS-jERKh4_2vw-1; Sat, 24 Jul 2021 12:04:30 +0100
X-MC-Unique: Wgv43lgyNsS-jERKh4_2vw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 24 Jul 2021 12:04:28 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 24 Jul 2021 12:04:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Topic: [PATCH v3 1/2] staging: rtl8188eu: Replace a custom function
 with crc32_le()
Thread-Index: AQHXfiEvucvRPynR106nc+5J/iJ13qtPHROQgAGploCAASyokA==
Date:   Sat, 24 Jul 2021 11:04:28 +0000
Message-ID: <9385be072a3e4d29ad55bb1b27b7ae03@AcuMS.aculab.com>
References: <20210721110052.26376-1-fmdefrancesco@gmail.com>
 <20210721110052.26376-2-fmdefrancesco@gmail.com>
 <f396ffee4a414ee092625ee486b871fe@AcuMS.aculab.com>
 <3650881.QlJdx9khu8@localhost.localdomain>
In-Reply-To: <3650881.QlJdx9khu8@localhost.localdomain>
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

RnJvbTogRmFiaW8gTS4gRGUgRnJhbmNlc2NvDQo+IFNlbnQ6IDIzIEp1bHkgMjAyMSAxODo0MQ0K
PiANCj4gSGkgRGF2aWQsDQo+IA0KPiBUaGlzIGRyaXZlciBpcyBnb2luZyB0byBiZSByZXBsYWNl
ZCBieSBhICJiZXR0ZXIiIHZlcnNpb24sIHNvIEknbSBub3Qgc3VyZQ0KPiB3aGV0aGVyIG9yIG5v
dCB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lZWRlZC4NCj4gDQo+IEhvd2V2ZXIsIEkgc2VlIHRoYXQg
d2UgaGF2ZSBzaW1pbGFyIHByb2JsZW1zIGluIHJ0bDg3MjNicyBhbmQgcGVyaGFwcyBhbHNvIGlu
DQo+IG90aGVyIGRyaXZlcnMuIFRoZXJlZm9yZSwgSSdkIGxpa2UgdG8gc29sdmUgdGhpcyBwcm9i
bGVtLCB3aGF0ZXZlciB3aWxsIGhhcHBlbg0KPiB0byB0aGUgIndvcnNlIiBydGk4MTg4ZXUsIGFu
ZCBjaGFuZ2UgdGhlIGNvZGUgd2hlcmUgZWxzZSBpdCBuZWVkcyB0byBiZQ0KPiBjaGFuZ2VkLg0K
PiANCj4gTm93IEkgaGF2ZSBhIGZldyBxdWVzdGlvbnMuLi4NCg0KWW91ciBtYWlsZXIgbWFpbCBh
IHJpZ2h0IHBpZ3MgYnJlYWtmYXN0IG9mIHRoaXMgcXVvdGVkIHRleHQuDQpFdmVuIG91dGxvb2sg
KHdoaWNoIHdvcmsgbWFrZXMgbWUgdXNlKSBpc24ndCB0aGF0IGJhZA0KLSBpdCBpcyBwcmV0dHkg
c2hpdHR5IHRob3VnaC4NCg0KLi4uDQo+ID4gQ2hhbmdlIGNyYyB0byBiZSBfX2xlMzIsIGtpbGwg
dGhlIGNhc3RzIGFuZCBwYXNzICZjcmMgaW4gdGhlIGxhc3QgY2FsbC4NCj4gPg0KPiANCj4gSSBj
b3VsZCBkbyBpdCwgYnV0IHRoZSBsYXN0IGNhbGwgKHRoYXQgdG8gYXJjZm91cl9lbmNyeXB0KCkg
dGFrZXMgYSBwb2ludGVyIHRvDQo+IHU4IHR5cGUgYXMgdGhlIHRoaXJkIHBhcmFtZXRlci4gSG93
IGNhbiBJIHVzZSBhIF9fbGUzMiBmb3IgdGhhdD8NCg0KVHJ5IGEgY2FzdCA6LSkNCmFyY2ZvdXJf
ZW5jcnlwdCgpIHRha2VzIGEgJ2J1ZmZlcicgLSBzbyBpdCBzaG91bGQgYmUgJ2NvbnN0IHZvaWQg
KicuDQpUaGF0IHdpbGwgbGV0IHRoZSBjYWxsIHBhc3Mgd2hhdCB0aGV5IHdhbnQuDQoNCi4uLg0K
PiA+ID4gQEAgLTY4Miw3ICs2NjksNyBAQCB1MzIgcnR3X3RraXBfZGVjcnlwdChzdHJ1Y3QgYWRh
cHRlciAqcGFkYXB0ZXIsIHN0cnVjdA0KPiByZWN2X2ZyYW1lDQo+ID4gPiAqcHJlY3ZmcmFtZSk+
DQo+ID4gPiAgCQkJYXJjZm91cl9pbml0KCZteWNvbnRleHQsIHJjNGtleSwgMTYpOw0KPiA+ID4g
IAkJCWFyY2ZvdXJfZW5jcnlwdCgmbXljb250ZXh0LCBwYXlsb2FkLA0KPiBwYXlsb2FkLCBsZW5n
dGgpOw0KPiA+ID4NCj4gPiA+IC0JCQkqKChfX2xlMzIgKiljcmMpID0gZ2V0Y3JjMzIocGF5bG9h
ZCwgbGVuZ3RoDQo+IC0gNCk7DQo+ID4gPiArCQkJKigoX19sZTMyICopY3JjKSA9IGNwdV90b19s
ZTMyKH5jcmMzMl9sZSh+MCwNCj4gcGF5bG9hZCwgbGVuZ3RoIC0gNCkpOw0KPiA+ID4NCj4gPiA+
ICAJCQlpZiAoY3JjWzNdICE9IHBheWxvYWRbbGVuZ3RoIC0gMV0gfHwNCj4gPiA+DQo+ID4gPiAg
CQkJICAgIGNyY1syXSAhPSBwYXlsb2FkW2xlbmd0aCAtIDJdIHx8DQo+ID4NCj4gPiBZb3UgY291
bGQgdG8gdGhlIHNhbWUgaGVyZSwgb3IgbWFrZSBjcmMgdTMyLCByZW1vdmUgdGhlIGNwdV90b19s
ZTMyKCkNCj4gPiBhbmQgdXNlIGdldF91bmFsaWduZWRfdTMyKHBheWxvYWQgKyBsZW5ndGggLSA0
KSAob3Igd2hhdGV2ZXIgaXQgaXMgY2FsbGVkKS4NCj4gPg0KPiANCj4gU29ycnksIEkgY2FuJ3Qg
dW5kZXJzdGFuZCB0aGlzIGxpbmUuIENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBpdCBhIGJpdCBt
b3JlPw0KPiANCj4gPiBCdXQgaXQgaXMgbXVjaCBiZXR0ZXIgdG8gZG86DQo+ID4gCWNyYyA9IGNy
YzMyX2xlKH4wLCBwYXlsb2FkLCBsZW5ndGgpOw0KPiA+IAlpZiAoY3JjICE9IFZBTElEX0NSQzMy
KQ0KPiA+IAkJcmVzID0gX0ZBSUw7DQo+ID4NCj4gDQo+IFdoeSAiY3JjID0gY3JjMzJfbGUofjAs
IHBheWxvYWQsIGxlbmd0aCk7Ij8gU2hvdWxkbid0IGl0IGJlICJjcmMgPQ0KPiBjcHVfdG9fbGUz
Mih+Y3JjMzJfbGUofjAsIHBhdGxvYWQsIGxlbmd0aCk7Ij8NCj4gDQo+IFdoeSBkaWQgeW91IGRy
b3AgYm90aCB0aGUgY3B1X3RvX2xlMzIoKSBjYWxsIGFuZCB0aGUgJ34nIG9wZXJhdG9yPw0KDQpC
ZWNhdXNlIHRoZXkgYXJlbid0IG5lZWRlZC4NClRoaW5rIGFib3V0IHdoYXQgaGFwcGVucyB3aGVu
IHRoZSBDUkMgaXMgcHJvY2Vzc2VkIGJpdCBieSBiaXQgd2l0aA0KYSBoYXJkd2FyZSBzaGlmdCBy
ZWdpc3Rlci4NCldoZW4gJ2xlbmd0aCAtIDQnIGJ5dGVzIGhhdmUgYmVlbiBwcm9jZXNzZWQgdGhl
IHJlY2VpdmVycyBDUkMgcmVnaXN0ZXINCm1hdGNoZXMgdGhhdCB0aGUgdHJhbnNtaXR0ZXIgaGFk
IGF0IHRoZSBzYW1lIHBvaW50Lg0KVGhlIHRyYW5zbWl0dGVyIGludmVydHMgZWFjaCBjcmMgYml0
IGJlZm9yZSBzZW5kaW5nIGl0Lg0KU28gd2hlbiB0aGUgcmVjZWl2ZXIgWE9SJ3MgYSByZWNlaXZl
ZCBiaXQgd2l0aCBhIENSQyBiaXQgKHRvIGZlZWQgYmFjaw0KaW50byB0aGUgc2hpZnQgcmVnaXN0
ZXIpIGl0IGFsd2F5cyBnZXRzIGEgJzEnIGJpdHMNCihlaXRoZXIgdGhlIGNyYyBiaXQgb3IgdGhl
IGRhdGEgaXMgYSAxKS4NCk9uY2UgdGhlIHJlY2VpdmVyIGhhcyBwcm9jZXNzZWQgJ2xlbmd0aCcg
Ynl0ZXMgdGhlIENSQyByZWdpc3RlciBhbHdheXMNCmNvbnRhaW5zIHRoZSBjcmMgb2YgZm91ciAw
eGZmIGJ5dGVzIC0gcmVnYXJkbGVzcyBvZiB0aGUgaW5wdXQgZnJhbWUuDQoNCklmIHlvdSBkb24n
dCBpbnZlcnQgdGhlIGNyYyBiZWZvcmUgc2VuZGluZyAoc29tZSBlYXJseSBmcmFtZSBmb3JtYXRz
DQpkaWRuJ3QpIHRoZW4gdGhlIGxhc3QgZGF0YSBiaXRzIGFuZCBjcmMgYml0cyBjYW5jZWwgZWFj
aCBvdGhlciBvdXQNCmFuZCB0aGUgY3JjIGlzIGFsd2F5cyAwIGZvciBhIGdvb2QgZnJhbWUuDQoN
Ckl0IGlzIGFsc28gd29ydGggcmVhbGlzaW5nIHRoYXQgYSBjcmMgaXMgYSBsaW5lYXIgZnVuY3Rp
b24uDQpUaGlzIG1lYW5zIHRoYXQgaWYgeW91ICdleGNsdXNpdmUgb3InIHR3byBmcmFtZXMgd2l0
aCB2YWxpZCBDUkMNCnRoZSByZXN1bHRhbnQgYnVmZmVyIGFsc28gaGFzIGEgdmFsaWQgY3JjIChh
bGlnbiB0aGUgZW5kcyBvZg0KdGhlIGZyYW1lcykuDQpJbml0aWFsaXNpbmcgdGhlIGNyYyB0byB+
MCBoYXMgdGhlIGVmZmVjdCBvZiBpbmNsdWRpbmcgdGhlIGZyYW1lDQpsZW5ndGggaW4gdGhlIGNy
YyAtIHBhcnRpY3VsYXJseSB1c2VmdWwgaWYgdGhlIGZyYW1lIHN0YXJ0cyB3aXRoDQp6ZXJvIGJ5
dGVzLg0KDQpTaW5jZSB0aGUgY3JjIGFsZ29yaXRobSBpcyByZXZlcnNhYmxlLCBpZiB5b3UgZ2V0
IGEgQ1JDIGVycm9yDQp5b3UgY2FuICd3aW5kIGJhY2snIHRoZSBlcnJvciBiaXRzIHVudGlsIG9u
bHkgYSBzbWFsbCBudW1iZXINCm9mIGJpdHMgYXJlIGFmZmVjdGVkIC0gZmxpcCB0aGUgbWF0Y2hp
bmcgYml0cyBvZiB0aGUgcmVjZWl2ZQ0KZGF0YSBhbmQgc28gY29ycmVjdCBhIHNpbmdsZSBzaG9y
dCBlcnJvciBidXJzdCAodGhlIG1vc3QNCmxpa2VseSBlcnJvcnMpIHRvIGdldCB0aGUgb3JpZ2lu
YWwgZGF0YS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

