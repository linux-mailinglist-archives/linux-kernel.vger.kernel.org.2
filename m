Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F843B01A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhJZKhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:37:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51851 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234330AbhJZKhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:37:04 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-A_jv2xcfNTGsiWxUaiBkAg-1; Tue, 26 Oct 2021 11:34:32 +0100
X-MC-Unique: A_jv2xcfNTGsiWxUaiBkAg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Tue, 26 Oct 2021 11:34:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Tue, 26 Oct 2021 11:34:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Terrell' <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Topic: [PATCH] lib: zstd: Add cast to silence clang's
 -Wbitwise-instead-of-logical
Thread-Index: AQHXxrmhV8EJKX2UAE+nrwZQNmVvMavkgQmAgACZsEA=
Date:   Tue, 26 Oct 2021 10:34:31 +0000
Message-ID: <d21e97487ba3447194538ccf0e88ead9@AcuMS.aculab.com>
References: <20211021202353.2356400-1-nathan@kernel.org>
 <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
In-Reply-To: <4245BD7A-4B12-4172-B4EE-76A99C717C7D@fb.com>
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

RnJvbTogTmljayBUZXJyZWxsDQo+IFNlbnQ6IDI2IE9jdG9iZXIgMjAyMSAwMjoxOA0KPiANCj4g
PiBPbiBPY3QgMjEsIDIwMjEsIGF0IDE6MjMgUE0sIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5A
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBBIG5ldyB3YXJuaW5nIGluIGNsYW5nIHdhcm5z
IHRoYXQgdGhlcmUgaXMgYW4gaW5zdGFuY2Ugd2hlcmUgYm9vbGVhbg0KPiA+IGV4cHJlc3Npb25z
IGFyZSBiZWluZyB1c2VkIHdpdGggYml0d2lzZSBvcGVyYXRvcnMgaW5zdGVhZCBvZiBsb2dpY2Fs
DQo+ID4gb25lczoNCj4gPg0KPiA+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3Mu
Yzo4OTA6MjU6IHdhcm5pbmc6IHVzZSBvZiBiaXR3aXNlICcmJyB3aXRoIGJvb2xlYW4gb3BlcmFu
ZHMgWy0NCj4gV2JpdHdpc2UtaW5zdGVhZC1vZi1sb2dpY2FsXQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgKEJJVF9yZWxvYWREU3RyZWFtRmFzdCgmYml0RDEpID09IEJJVF9EU3RyZWFtX3Vu
ZmluaXNoZWQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPg0KPiA+IHpzdGQgZG9l
cyB0aGlzIGZyZXF1ZW50bHkgdG8gaGVscCB3aXRoIHBlcmZvcm1hbmNlLCBhcyBsb2dpY2FsIG9w
ZXJhdG9ycw0KPiA+IGhhdmUgYnJhbmNoZXMgd2hlcmVhcyBiaXR3aXNlIG9uZXMgZG8gbm90Lg0K
Li4uDQo+ID4gVGhlIGZpcnN0IFUzMiBjYXN0IGlzIHRvIHNpbGVuY2UgYW4gaW5zdGFuY2Ugb2Yg
LVdzaG9ydGVuLTY0LXRvLTMyDQo+ID4gYmVjYXVzZSBfX2J1aWx0aW5fZXhwZWN0KCkgcmV0dXJu
cyBsb25nIHNvIGl0IGNhbm5vdCBiZSBtb3ZlZC4NCg0KSXNuJ3QgZW5hYmxpbmcgdGhhdCB3YXJu
aW5nIGNvbXBsZXRlbHkgc3R1cGlkPw0KVGhlIGNhc3RzIHJlcXVpcmVkIHRvIHNpbGVuY2UgaXQg
Y291bGQgZWFzaWx5IGNhdXNlIG1vcmUgcHJvYmxlbXMNCi0gYnkgaGlkaW5nIG1vcmUgaW1wb3J0
YW50IGJ1Z3MuIEFuZCBzZXJpb3VzbHkgYWZmZWN0IGNvZGUgcmVhZGFiaWxpdHkuDQoNCi4uLmMN
Cj4gPiBpbmRleCAwNTU3MGVkNWY4YmUuLjUxMDVlNTlhYzA0YSAxMDA2NDQNCj4gPiAtLS0gYS9s
aWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4gPiArKysgYi9saWIvenN0ZC9k
ZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4gPiBAQCAtODg2LDcgKzg4Niw3IEBAIEhVRl9k
ZWNvbXByZXNzNFgyX3VzaW5nRFRhYmxlX2ludGVybmFsX2JvZHkoDQo+ID4gICAgICAgICAgICAg
SFVGX0RFQ09ERV9TWU1CT0xYMl8wKG9wMiwgJmJpdEQyKTsNCj4gPiAgICAgICAgICAgICBIVUZf
REVDT0RFX1NZTUJPTFgyXzAob3AzLCAmYml0RDMpOw0KPiA+ICAgICAgICAgICAgIEhVRl9ERUNP
REVfU1lNQk9MWDJfMChvcDQsICZiaXRENCk7DQo+ID4gLSAgICAgICAgICAgIGVuZFNpZ25hbCA9
IChVMzIpTElLRUxZKA0KPiA+ICsgICAgICAgICAgICBlbmRTaWduYWwgPSAoVTMyKUxJS0VMWSgo
VTMyKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIChCSVRfcmVsb2FkRFN0cmVhbUZhc3Qo
JmJpdEQxKSA9PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAmIChCSVRfcmVsb2FkRFN0cmVhbUZhc3QoJmJpdEQyKSA9PSBCSVRfRFN0cmVhbV91bmZp
bmlzaGVkKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAmIChCSVRfcmVsb2FkRFN0cmVhbUZh
c3QoJmJpdEQzKSA9PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0KDQpJc24ndCB0aGF0IHRoZSBz
YW1lIGFzOg0KCSgoQklUX3JlbG9hZCgpICYgQklUX3JlbG9hZCgpICYgQklUX3JlbG9hZCgpKSA9
PSBCSVRfRFN0cmVhbV91bmZpbmlzaGVkKQ0Kd2hpY2ggd2lsbCBnZW5lcmF0ZSBtdWNoIGJldHRl
ciBjb2RlLg0KRXNwZWNpYWxseSBvbiBjcHUgd2l0aG91dCAnc2V0ZXEnIGluc3RydWN0aW9ucy4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

