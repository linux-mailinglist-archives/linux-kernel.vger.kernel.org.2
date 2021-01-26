Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52271305B54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhA0M1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:27:40 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49546 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S314021AbhAZWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:55:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-76-30NQJlUXPP2CXDT06Y_EHA-1; Tue, 26 Jan 2021 22:53:34 +0000
X-MC-Unique: 30NQJlUXPP2CXDT06Y_EHA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 Jan 2021 22:53:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 26 Jan 2021 22:53:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Candle Sun <candlesea@gmail.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "candle.sun@unisoc.com" <candle.sun@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
Thread-Topic: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
Thread-Index: AQHW8v+fVpSBFdR3bUKo3QkF9iGP/qo4I1KAgAIcALWAAEXe8A==
Date:   Tue, 26 Jan 2021 22:53:31 +0000
Message-ID: <9b48470af3b841e4bd8ba15a4ee5e745@AcuMS.aculab.com>
References: <20210125085622.2322-1-candlesea@gmail.com>
 <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
 <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
 <CAKwvOdnH8kXt+jAutjqsL_5H5PzswLGEZOieaGru2SDn13pj+w@mail.gmail.com>
In-Reply-To: <CAKwvOdnH8kXt+jAutjqsL_5H5PzswLGEZOieaGru2SDn13pj+w@mail.gmail.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyNiBKYW51YXJ5IDIwMjEgMTg6NDANCj4g
DQo+IE9uIFR1ZSwgSmFuIDI2LCAyMDIxIGF0IDY6MTMgQU0gQ2FuZGxlIFN1biA8Y2FuZGxlc2Vh
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIEphbiAyNSwgMjAyMSBhdCA2OjM3
IFBNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IEZyb206IENhbmRsZSBTdW4NCj4gPiA+ID4gU2VudDogMjUgSmFudWFyeSAyMDIxIDA4
OjU2DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IENhbmRsZSBTdW4gPGNhbmRsZS5zdW5AdW5pc29j
LmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhvdWdoIGRvX292ZXJ3cml0dGVuKCkgZm9sbG93cyBk
b19ub3RoaW5nKCkgaW4gc291cmNlIGNvZGUsIHRoZSBmaW5hbA0KPiA+ID4gPiBtZW1vcnkgYWRk
cmVzcyBvcmRlciBpcyBkZXRlcm1pbmVkIGJ5IGNvbXBpbGVyLiBXZSBjYW4ndCBhbHdheXMgYXNz
dW1lDQo+ID4gPiA+IGFkZHJlc3Mgb2YgZG9fb3ZlcndyaXR0ZW4oKSBpcyBiaWdnZXIgdGhhbiBk
b19ub3RoaW5nKCkuIEF0IGxlYXN0IHRoZQ0KPiA+ID4gPiBDbGFuZyB3ZSBhcmUgdXNpbmcgcGxh
Y2VzIGRvX292ZXJ3cml0dGVuKCkgYmVmb3JlIGRvX25vdGhpbmcoKSBpbiB0aGUNCj4gPiA+ID4g
b2JqZWN0LiBUaGlzIGNhdXNlcyB0aGUgY29weSBzaXplIGluIGxrZHRtX1dSSVRFX0tFUk4oKSBp
cyAqcmVhbGx5Kg0KPiA+ID4gPiBiaWcgYW5kIFdSSVRFX0tFUk4gdGVzdCBvbiBBUk0zMiBhcmNo
IHdpbGwgZmFpbC4NCj4gPiA+ID4NCj4gPiA+ID4gQ29tcGFyZSB0aGUgYWRkcmVzcyBvcmRlciBi
ZWZvcmUgZG9pbmcgdGhlIHN1YnRyYWN0aW9uLg0KPiA+ID4NCj4gPiA+IEl0IGlzbid0IGNsZWFy
IHRoYXQgaGVscHMuDQo+ID4gPiBDb21waWxlIHdpdGggLWZmdW5jdGlvbi1zZWN0aW9ucyBhbmQv
b3IgZG8gTFRPIGFuIHRoZXJlDQo+ID4gPiBpcyBubyByZWFzb24gYXQgYWxsIHdoeSB0aGUgZnVu
Y3Rpb25zIHNob3VsZCBiZSB0b2dldGhlci4NCj4gPiA+DQo+ID4gPiBFdmVuIHdpdGhvdXQgdGhh
dCBsa2R0bV9XUklURV9LRVJOKCkgY291bGQgZWFzaWx5IGJlIGJldHdlZW4gdGhlbS4NCj4gPiA+
DQo+ID4gPiBZb3UgbmVlZCB0byBnZXQgdGhlIHNpemUgb2YgdGhlICdlbXB0eSBmdW5jdGlvbicg
ZnJvbSB0aGUNCj4gPiA+IHN5bWJvbCB0YWJsZS4NCj4gPiA+DQo+ID4gPiAgICAgICAgIERhdmlk
DQo+ID4NCj4gPiBUaGFua3MgRGF2aWQuDQo+ID4NCj4gPiBJIHRoaW5rIHVzaW5nIGFicygpIGJ5
IE5pY2sncyBhZHZpY2Ugd291bGQgYmUgYmV0dGVyLiBCdXQgY291bGQgeW91DQo+ID4gcG9pbnQg
b3V0IHdoaWNoIGtlcm5lbCBmdW5jdGlvbiBjYW4gZ2V0IGZ1bmN0aW9uIHNpemU/DQo+IA0KPiBU
aGUgRWxmIHN5bWJvbCB0YWJsZSBzaG91bGQgY29udGFpbiB0aGlzIGluZm8sIElJVUMuDQo+IA0K
PiBHaXZlbiBhIHN0cmluZyBsaXRlcmFsIG9mIGEgc3ltYm9sIChzdWNoIGFzIGEgZnVuY3Rpb24g
aWRlbnRpZmllciksDQo+IGthbGxzeW1zX2xvb2t1cF9uYW1lKCkgY2FuIGJlIHVzZWQgdG8gcmV0
dXJuIGl0cyBhZGRyZXNzLg0KPiANCj4gRnJvbSB0aGVyZSB3ZSdkIHdhbnQgdG8gZmV0Y2ggdGhl
IEVsZl9TeW0gZm9yIHRoZSBhZGRyZXNzIHdoaWNoIHNob3VsZA0KPiBjb250YWluIGEgc3Rfc2l6
ZSBmaWVsZCB3aGljaCBJIHRoaW5rIGNvcnJlc3BvbmRzIHRvIHRoZSBzaXplIGluIGJ5dGVzDQo+
IG9mIHRoZSBmdW5jdGlvbi4gIChBdCBsZWFzdCwgZnJvbSBwbGF5aW5nIHdpdGggYGxsdm0tcmVh
ZGVsZiAtc2ApDQo+IFByb2JhYmx5IHdvdWxkIHdhbnQgdG8gdmFsaWRhdGUgaXQncyBhbiBTVFRf
RlVOQyBzeW1ib2wgdHlwZSwgdG9vLiAgV2UNCj4gYmFzaWNhbGx5IHdhbnQgc29tZXRoaW5nIGxp
a2Uga2V4ZWNfcHVyZ2F0b3J5X2ZpbmRfc3ltYm9sKCksIGJ1dCB0aGF0DQo+IGtub3dzIGFib3V0
IHRoZSBlbnRpcmUga2VybmVsIGltYWdlLCBhbmQgbm90IHRoZSBwdXJnYXRvcnkgaW1hZ2UgdXNl
ZA0KPiBkdXJpbmcga2V4ZWMuICBJIGRvbid0IHNlZSBhbnkgc3VjaCBmdW5jdGlvbiBjdXJyZW50
bHkgaW4gdGhlDQo+IGtlcm5lbC4uLmJ1dCBpdCdzIGEgbGFyZ2UgY29kZWJhc2UgdG8gc2VhcmNo
IHRocm91Z2guDQoNClRoZSBhbHRlcm5hdGl2ZSBpcyB0byBnZXQgdGhlIGxpbmtlciBzY3JpcHQg
dG8gZGVmaW5lIGEgc3BlY2lmaWMNCmNvbnN0YW50IHRvIHRoZSBzaXplIG9mIHRoZSBmdW5jdGlv
bi4NCllvdSBjYW4gdGhlbiBsaW5rIGFnYWluc3QgaXQgKGJ5IHVzaW5nIGl0IGFzIHRoZSBhZGRy
ZXNzIG9mIGEgc3ltYm9sKS4NCg0KSXQgbWF5IGJlIGVhc2llciB0byB1c2UgYW4gYXNtIGZpbGUg
Zm9yIHRoZSAncmV0dXJuIDAnIGNvZGUuDQpJJ20gZ3Vlc3NpbmcgdGhlcmUgYXJlIHRoaW5ncyBp
biB0aGUgc3RhdGljIGJyYW5jaCBhcmVhDQp0aGF0IGNvdWxkIGJlIHVzZWQuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

