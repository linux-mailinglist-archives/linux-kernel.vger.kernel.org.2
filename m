Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E514038815B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhERU2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:28:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48078 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236407AbhERU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:28:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-187-u1M4_405Mqqthx6WPr6Dpw-1; Tue, 18 May 2021 21:26:14 +0100
X-MC-Unique: u1M4_405Mqqthx6WPr6Dpw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 21:26:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 18 May 2021 21:26:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Amanieu d'Antras <amanieu@gmail.com>
CC:     Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
Thread-Topic: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
Thread-Index: AQHXS+Yvvr9W6bW+8Eqdwx3UR+47Aqrprelw
Date:   Tue, 18 May 2021 20:26:12 +0000
Message-ID: <3cb1d369e5e8431284e527e3e74fa6f2@AcuMS.aculab.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
 <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
In-Reply-To: <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxOCBNYXkgMjAyMSAxNDowMg0KLi4uDQo+IA0K
PiBJJ20gc3RpbGwgdW5kZWNpZGVkIGFib3V0IHRoaXMgYXBwcm9hY2guIEl0IGlzIGFuIGVhc3kg
d2F5IHRvIGV4cG9zZSB0aGUgMzItYml0DQo+IEFCSXMsIGl0IG1vc3RseSBjb3BpZXMgd2hhdCB4
ODYtNjQgYWxyZWFkeSBkb2VzIHdpdGggMzItYml0IHN5c2NhbGxzIGFuZA0KPiBpdCBkb2Vzbid0
IGV4cG9zZSBhIGxvdCBvZiBhdHRhY2sgc3VyZmFjZSB0aGF0IGlzbid0IGFscmVhZHkgZXhwb3Nl
ZCB0byBub3JtYWwNCj4gMzItYml0IHRhc2tzIHJ1bm5pbmcgY29tcGF0IG1vZGUuDQo+IA0KPiBP
biB0aGUgb3RoZXIgaGFuZCwgZXhwb3NpbmcgdGhlIGVudGlyZSBhYXJjaDMyIHN5c2NhbGwgc2V0
IHNlZW1zIGJvdGgNCj4gdG9vIGJyb2FkIGFuZCBub3QgYnJvYWQgZW5vdWdoOiBIYWxmIG9mIHRo
ZSBzeXN0ZW0gY2FsbHMgYmVoYXZlIHRoZQ0KPiBleGFjdCBzYW1lIHdheSBpbiBuYXRpdmUgYW5k
IGNvbXBhdCBtb2RlLCBzbyB0aGV5IHdvdWxkbid0IG5lZWQgdG8NCj4gYmUgZXhwb3NlZCBsaWtl
IHRoaXMsIGEgbG90IG9mIG90aGVycyBhcmUgdHJpdmlhbGx5IGVtdWxhdGVkIGluIHVzZXIgc3Bh
Y2UNCj4gYnkgY2FsbGluZyB0aGUgbmF0aXZlIHZlcnNpb25zLiBUaGUgc3lzY2FsbHMgdGhhdCBh
cmUgYWN0dWFsbHkgaGFyZCB0byBkbw0KPiBzdWNoIGFzIGlvY3RsKCkgb3IgdGhlIHNpZ25hbCBo
YW5kbGluZyB3aWxsIHdvcmsgZm9yIGFhcmNoMzIgZW11bGF0aW9uLCBidXQNCj4gdGhleSBhcmUg
c3RpbGwgaW5zdWZmaWNpZW50IHRvIGNvcnJlY3RseSBlbXVsYXRlIG90aGVyIDMyLWJpdCBhcmNo
aXRlY3R1cmVzDQo+IHRoYXQgaGF2ZSBhIHNsaWdodGx5IGRpZmZlcmVudCBBQkkuIFRoaXMgbWVh
bnMgdGhlIGludGVyZmFjZSBpcyBhIGZhaXJseSBnb29kDQo+IGZpdCBmb3IgVGFuZ28sIGJ1dCBt
dWNoIGxlc3Mgc28gZm9yIEZFWC4NCg0KVG8gbXkgbWluZCBiZWNhdXNlIHRoZSBrZXJuZWwgYWxy
ZWFkeSBjb250YWlucyB0aGUgZW11bGF0aW9uIGNvZGUNCnRoZXJlIGlzbid0IG11Y2ggcG9pbnQg
dHJ5aW5nIHRvIHJlcGxpY2F0ZSBpdCBpbiB1c2Vyc3BhY2UuDQoNCk9UT0ggSSB0aGluayB0aGV5
IGFyZSB0cnlpbmcgdG8gZW11bGF0ZSB4ODYgc3lzdGVtIGNhbGxzIG5vdCBhcm0gb25lcy4NClNv
IHRoZSBzdHJ1Y3R1cmUgbGF5b3V0cyBkb24ndCBhbHdheXMgbWF0Y2guDQpIb3dldmVyIGl0IGlz
IHByb2JhYmx5IGEgbG90IG5lYXJlciB0aGFuIHRoZSA2NGJpdCBhcm0uDQoNCldoZXRoZXIgaW5j
bHVkaW5nIHNvbWUgb2YgdGhlICd4MzInIGNvZGUgaW4gYW4gYXJtIGtlcm5lbCB3aWxsDQpoZWxw
IGlzIGFub3RoZXIgbWF0dGVyIC0gaXQgbWlnaHQgYmUgYSB1c2VmdWwgc291cmNlIG9mIGRpZmZl
cmVuY2VzLg0KDQpBbSBJIGFsc28gcmlnaHQgaW4gdGhpbmtpbmcgdGhhdCB0aGlzIGlzbid0IGFj
dHVhbGx5IG5lZWRlZCBhcyBwYXJ0DQpvZiBhICdnZW5lcmljJyBBUk0ga2VybmVsPyBKdXN0IG9u
ZXMgZm9yIHNvbWUgc3BlY2lmaWMgcGxhdGZvcm1zPw0KDQoJRGF2aWQNCg0KKE9oIC0gSSdtIG5v
dCBpbnZvbHZlZCBpbiB0aGUgcHJvamVjdCBhbmQgd2lsbCBwcm9iYWJseSBuZXZlciB1c2UgaXQu
KQ0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

