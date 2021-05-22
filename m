Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5438D5FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhEVNUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:20:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:38218 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230466AbhEVNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:20:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-186-YyNY5b8DMRiUupCLn4Pc3Q-1; Sat, 22 May 2021 14:19:01 +0100
X-MC-Unique: YyNY5b8DMRiUupCLn4Pc3Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 22 May 2021 14:19:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 22 May 2021 14:19:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/6] x86/syscall: use int everywhere for system call
 numbers
Thread-Topic: [PATCH v4 6/6] x86/syscall: use int everywhere for system call
 numbers
Thread-Index: AQHXTolzOOJ56hwIbUKIzI134bBX1arvaoRw
Date:   Sat, 22 May 2021 13:19:00 +0000
Message-ID: <39d875e0212240c9869c0419efd75bfa@AcuMS.aculab.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
 <20210518191303.4135296-7-hpa@zytor.com>
 <87zgwpbxby.ffs@nanos.tec.linutronix.de>
 <e43577cf-ab35-1de2-818a-ccc2e2fb99b8@zytor.com>
In-Reply-To: <e43577cf-ab35-1de2-818a-ccc2e2fb99b8@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMjEgTWF5IDIwMjEgMjI6MzcNCj4gDQo+IE9u
IDUvMjAvMjEgMTo1MyBBTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWF5
IDE4IDIwMjEgYXQgMTI6MTMsIEguIFBldGVyIEFudmluIHdyb3RlOg0KPiA+PiArc3RhdGljIF9f
YWx3YXlzX2lubGluZSBib29sIGRvX3N5c2NhbGxfeDY0KHN0cnVjdCBwdF9yZWdzICpyZWdzLCBp
bnQgbnIpDQo+ID4+ICt7DQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBDb252ZXJ0IG5lZ2F0aXZlIG51
bWJlcnMgdG8gdmVyeSBoaWdoIGFuZCB0aHVzIG91dCBvZiByYW5nZQ0KPiA+PiArCSAqIG51bWJl
cnMgZm9yIGNvbXBhcmlzb25zLiBVc2UgdW5zaWduZWQgbG9uZyB0byBzbGlnaHRseQ0KPiA+PiAr
CSAqIGltcHJvdmUgdGhlIGFycmF5X2luZGV4X25vc3BlYygpIGdlbmVyYXRlZCBjb2RlLg0KPiA+
DQo+ID4gSG93IGlzIHRoYXQgYWN0dWFsbHkgaW1wcm92aW5nIHRoZSBnZW5lcmF0ZWQgY29kZT8N
Cj4gPg0KPiA+IHVuc2lnbmVkIGxvbmc6DQo+ID4NCj4gPiAgIDEwNDoJNDggODEgZmEgYmYgMDEg
MDAgMDAgCWNtcCAgICAkMHgxYmYsJXJkeA0KPiA+ICAgMTBiOgk0OCAxOSBjMCAgICAgICAgICAg
ICAJc2JiICAgICVyYXgsJXJheA0KPiA+ICAgMTBlOgk0OCAyMSBjMiAgICAgICAgICAgICAJYW5k
ICAgICVyYXgsJXJkeA0KPiA+ICAgMTExOgk0OCA4OSBkZiAgICAgICAgICAgICAJbW92ICAgICVy
YngsJXJkaQ0KPiA+ICAgMTE0Ogk0OCA4YiAwNCBkNSAwMCAwMCAwMCAJbW92ICAgIDB4MCgsJXJk
eCw4KSwlcmF4DQo+ID4gICAxMWI6CTAwDQo+ID4gICAxMWM6CWU4IDAwIDAwIDAwIDAwICAgICAg
IAljYWxscSAgMTIxIDxkb19zeXNjYWxsXzY0KzB4NDE+DQo+ID4NCj4gPiB1bnNpZ25lZCBpbnQ6
DQo+ID4NCj4gPiAgICBmMToJNDggODEgZmEgYmYgMDEgMDAgMDAgCWNtcCAgICAkMHgxYmYsJXJk
eA0KPiA+ICAgIGY4Ogk0OCAxOSBkMiAgICAgICAgICAgICAJc2JiICAgICVyZHgsJXJkeA0KPiA+
ICAgIGZiOgkyMSBkMCAgICAgICAgICAgICAgICAJYW5kICAgICVlZHgsJWVheA0KPiA+ICAgIGZk
Ogk0OCA4OSBkZiAgICAgICAgICAgICAJbW92ICAgICVyYngsJXJkaQ0KPiA+ICAgMTAwOgk0OCA4
YiAwNCBjNSAwMCAwMCAwMCAJbW92ICAgIDB4MCgsJXJheCw4KSwlcmF4DQo+ID4gICAxMDc6CTAw
DQo+ID4gICAxMDg6CWU4IDAwIDAwIDAwIDAwICAgICAgIAljYWxscSAgMTBkIDxkb19zeXNjYWxs
XzY0KzB4M2Q+DQo+ID4NCj4gPiBUZXh0IHNpemUgaW5jcmVhc2VzIHdpdGggdGhhdCB1bnNpZ25l
ZCBsb25nIGNhc3QuDQo+ID4NCj4gPiBJIG11c3QgYmUgbWlzc2luZyBzb21ldGhpbmcuDQo+ID4N
Cj4gDQo+ICJ1bnNpZ25lZCBsb25nIiBnYXZlIHNsaWdodGx5IGJldHRlciBjb2RlIHRoYW4gImlu
dCIsIGJ1dCBhcyB5b3UNCj4gY29ycmVjdGx5IHBvaW50IG91dCBoZXJlLCAidW5zaWduZWQgaW50
IiBpcyBldmVuIGJldHRlci4NCg0KSW5kZXhpbmcgYXJyYXlzIHdpdGggJ2ludCcgYWxtb3N0IGFs
d2F5cyBlbmRzIHVwIGdlbmVyYXRpbmcNCmFuIGV4dHJhIGluc3RydWN0aW9uIHRvIHNpZ24tZXh0
ZW5kIHRoZSAzMmJpdCB2YWx1ZSB0byA2NGJpdHMuDQpUaGlzIGxlbmd0aGVucyB0aGUgcmVnaXN0
ZXIgZGVwZW5kZW5jeSBjaGFpbiBhcyBpcyBsaWtlbHkgdG8NCmFkZCBhIGNsb2NrLg0KDQpPVE9I
IHVzaW5nICd1bnNpZ25lZCBpbnQnIGNhbiBzYXZlIGEgJ3JlZycgcHJlZml4IChhcyBoZXJlKQ0K
bWFyZ2luYWxseSByZWR1Y2luZyB0aGUgY2FjaGUgZm9vdHByaW50Lg0KVGhhdCBtaWdodCBzcGVl
ZCBpdCB1cCwgYnV0IG1heSBzbG93IGl0IGRvd24hDQpSYXRoZXIgZGVwZW5kcyBvbiB0aGUgZXhh
Y3QgYWxpZ25tZW50IG9mIGluc3RydWN0aW9ucw0KcmVsYXRpdmUgdG8gKG9uIEludGVsIGNwdSkg
dGhlIDE2LWJ5dGUgZmV0Y2gvZGVjb2RlIGJsb2Nrcy4NCg0KTG9va2luZyBhdCB0aGUgYWJvdmUg
Y29kZSwgb3V0IG9mIHJhbmdlIHZhbHVlcyBnZXQgbWFza2VkDQp0byB6ZXJvIHRvIGVuc3VyZSB0
aGF0IHNwZWN1bGF0aXZlIGV4ZWN1dGlvbiBkb2Vzbid0IGV4cG9zZQ0KYW55dGhpbmcuDQpJZiB0
aGUgc3lzY2FsbCBudW1iZXIgaXMgb2Zmc2V0IGJ5IG9uZSBiZWZvcmUgbWFza2luZw0KYSB6ZXJv
IHdpbGwgb25seSBiZSBnZW5lcmF0ZWQgZm9yIGludmFsaWQgdmFsdWVzOg0KDQpodHRwczovL2dv
ZGJvbHQub3JnL3ovYXY4Mzlic3hmDQoNCmJvb2wgZG9fc3lzY2FsbF94NjQoc3RydWN0IHB0X3Jl
Z3MgKnJlZ3MsIGludCBucikNCnsNCgl1bnNpZ25lZCBsb25nIHVuciA9IG5yICsgMTsNCg0KCXVu
ciA9IGFycmF5X2luZGV4X25vc3BlYyh1bnIsIE5SX3N5c2NhbGxzICsgMSk7DQoJaWYgKCF1bnIp
DQoJCXJldHVybiBmYWxzZTsNCglyZWdzLT5heCA9IHN5c19jYWxsX3RhYmxlW3VuciAtIDFdKHJl
Z3MpOw0KCXJldHVybiB0cnVlOw0KfQ0KDQpUaGlzIHNwZWVkcyB1cCB0aGUgbmF0aXZlIHN5c3Rl
bSBjYWxscyB3aXRoIGEgc2xpZ2h0IHNsb3cgZG93bg0Kb2YgdGhlIGNvbXBhdCBvbmVzLg0KDQpJ
biBwcmluY2lwbGUgc3lzX2NhbGxfdGFibGVbXSBjb3VsZCBiZSBvZmZzZXQgYnkgb25lLg0KU28g
dGhhdCBpbnZhbGlkIG51bWJlcnMgZ28gdGhyb3VnaCBzeXNfY2FsbF90YWJsZVswXS4NCllvdSB3
b3VsZG4ndCB3YW50IHRvIGRvIHRoaXMgaWYgYSBzZWNvbmQgdGFibGUgZm9sbG93cy4NCg0KSSdt
IGFsc28gc2VlaW5nIGJldHRlciBjb2RlIGZvciAndW5zaWduZWQgbG9uZycuDQpQcm9iYWJseSBi
ZWNhdXNlIGFycmF5X2luZGV4X21hc2tfbm9zcGVjKCkgaXMgZGVmaW5lZCBmb3IgbG9uZy4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

