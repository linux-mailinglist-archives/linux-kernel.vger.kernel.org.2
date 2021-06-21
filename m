Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2A3AE872
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFUL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:57:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57355 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFUL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:57:55 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-11-6_goVtNKMYqCsuMD0i38gA-1; Mon, 21 Jun 2021 12:55:38 +0100
X-MC-Unique: 6_goVtNKMYqCsuMD0i38gA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 21 Jun
 2021 12:55:37 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 21 Jun 2021 12:55:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Akira Tsukamoto' <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 5/5] riscv: __asm_to/copy_from_user: Bulk copy when both
 src, dst are aligned
Thread-Topic: [PATCH 5/5] riscv: __asm_to/copy_from_user: Bulk copy when both
 src, dst are aligned
Thread-Index: AQHXZQBMzI5fByhdl0uLY1idpEeJFqseXBJw
Date:   Mon, 21 Jun 2021 11:55:37 +0000
Message-ID: <4a847070ad494e839de1d3fc5b39ba57@AcuMS.aculab.com>
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
 <4637f0f2-2da9-1056-37bf-17c0861b6bff@gmail.com>
In-Reply-To: <4637f0f2-2da9-1056-37bf-17c0861b6bff@gmail.com>
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

RnJvbTogQWtpcmEgVHN1a2Ftb3RvDQo+IFNlbnQ6IDE5IEp1bmUgMjAyMSAxMjo0Mw0KPiANCj4g
SW4gdGhlIGx1Y2t5IHNpdHVhdGlvbiB0aGF0IHRoZSBib3RoIHNvdXJjZSBhbmQgZGVzdGluYXRp
b24gYWRkcmVzcyBhcmUgb24NCj4gdGhlIGFsaWduZWQgYm91bmRhcnksIHBlcmZvcm0gbG9hZCBh
bmQgc3RvcmUgd2l0aCByZWdpc3RlciBzaXplIHRvIGNvcHkgdGhlDQo+IGRhdGEuDQo+IA0KPiBX
aXRob3V0IHRoZSB1bnJvbGxpbmcsIGl0IHdpbGwgcmVkdWNlIHRoZSBzcGVlZCBzaW5jZSB0aGUg
bmV4dCBzdG9yZQ0KPiBpbnN0cnVjdGlvbiBmb3IgdGhlIHNhbWUgcmVnaXN0ZXIgdXNpbmcgZnJv
bSB0aGUgbG9hZCB3aWxsIHN0YWxsIHRoZQ0KPiBwaXBlbGluZS4NCi4uLg0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9yaXNjdi9saWIvdWFjY2Vzcy5TIGIvYXJjaC9yaXNjdi9saWIvdWFjY2Vzcy5TDQo+
IGluZGV4IGUyZTU3NTUxZmM3Ni4uYmNlYjA2MjllNDQwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jp
c2N2L2xpYi91YWNjZXNzLlMNCj4gKysrIGIvYXJjaC9yaXNjdi9saWIvdWFjY2Vzcy5TDQo+IEBA
IC02Nyw2ICs2NywzOSBAQCBFTlRSWShfX2FzbV9jb3B5X2Zyb21fdXNlcikNCj4gIAlibmV6CWEz
LCAuTHNoaWZ0X2NvcHkNCj4gDQo+ICAuTHdvcmRfY29weToNCj4gKyAgICAgICAgLyoNCj4gKwkg
KiBCb3RoIHNyYyBhbmQgZHN0IGFyZSBhbGlnbmVkLCB1bnJvbGxlZCB3b3JkIGNvcHkNCj4gKwkg
Kg0KPiArCSAqIGEwIC0gc3RhcnQgb2YgYWxpZ25lZCBkc3QNCj4gKwkgKiBhMSAtIHN0YXJ0IG9m
IGFsaWduZWQgc3JjDQo+ICsJICogYTMgLSBhMSAmIG1hc2s6KFNaUkVHLTEpDQo+ICsJICogdDAg
LSBlbmQgb2YgYWxpZ25lZCBkc3QNCj4gKwkgKi8NCj4gKwlhZGRpCXQwLCB0MCwgLSg4KlNaUkVH
LTEpIC8qIG5vdCB0byBvdmVyIHJ1biAqLw0KPiArMjoNCj4gKwlmaXh1cCBSRUdfTCAgIGE0LCAg
ICAgICAgMChhMSksIDEwZg0KPiArCWZpeHVwIFJFR19MICAgYTUsICAgIFNaUkVHKGExKSwgMTBm
DQo+ICsJZml4dXAgUkVHX0wgICBhNiwgIDIqU1pSRUcoYTEpLCAxMGYNCj4gKwlmaXh1cCBSRUdf
TCAgIGE3LCAgMypTWlJFRyhhMSksIDEwZg0KPiArCWZpeHVwIFJFR19MICAgdDEsICA0KlNaUkVH
KGExKSwgMTBmDQo+ICsJZml4dXAgUkVHX0wgICB0MiwgIDUqU1pSRUcoYTEpLCAxMGYNCj4gKwlm
aXh1cCBSRUdfTCAgIHQzLCAgNipTWlJFRyhhMSksIDEwZg0KPiArCWZpeHVwIFJFR19MICAgdDQs
ICA3KlNaUkVHKGExKSwgMTBmDQo+ICsJZml4dXAgUkVHX1MgICBhNCwgICAgICAgIDAoYTApLCAx
MGYNCj4gKwlmaXh1cCBSRUdfUyAgIGE1LCAgICBTWlJFRyhhMCksIDEwZg0KPiArCWZpeHVwIFJF
R19TICAgYTYsICAyKlNaUkVHKGEwKSwgMTBmDQo+ICsJZml4dXAgUkVHX1MgICBhNywgIDMqU1pS
RUcoYTApLCAxMGYNCj4gKwlmaXh1cCBSRUdfUyAgIHQxLCAgNCpTWlJFRyhhMCksIDEwZg0KPiAr
CWZpeHVwIFJFR19TICAgdDIsICA1KlNaUkVHKGEwKSwgMTBmDQo+ICsJZml4dXAgUkVHX1MgICB0
MywgIDYqU1pSRUcoYTApLCAxMGYNCj4gKwlmaXh1cCBSRUdfUyAgIHQ0LCAgNypTWlJFRyhhMCks
IDEwZg0KPiArCWFkZGkJYTAsIGEwLCA4KlNaUkVHDQo+ICsJYWRkaQlhMSwgYTEsIDgqU1pSRUcN
Cj4gKwlibHR1CWEwLCB0MCwgMmINCj4gKw0KPiArCWFkZGkJdDAsIHQwLCA4KlNaUkVHLTEgLyog
cmV2ZXJ0IHRvIG9yaWdpbmFsIHZhbHVlICovDQo+ICsJagkuTGJ5dGVfY29weV90YWlsDQo+ICsN
Cg0KQXJlIHRoZXJlIGFueSByaXNjdiBjaGlwcyB0aGFuIGNhbiBkbyBhIG1lbW9yeSByZWFkIGFu
ZCBhDQptZW1vcnkgd3JpdGUgaW50IHRoZSBzYW1lIGN5Y2xlIGJ1dCBkb24ndCBoYXZlIHNpZ25p
ZmljYW50DQonb3V0IG9mIG9yZGVyJyBleGVjdXRpb24/DQoNClN1Y2ggY2hpcHMgd2lsbCBleGVj
dXRlIHRoYXQgY29kZSB2ZXJ5IGJhZGx5Lg0KT3IsIHJhdGhlciwgdGhlcmUgYXJlIGxvb3BzIHRo
YXQgYWxsb3cgY29uY3VycmVudCByZWFkK3dyaXRlDQp0aGF0IHdpbGwgYmUgYSBsb3QgZmFzdGVy
Lg0KDQpBbHNvIG9uIGEgY3B1IHRoYXQgY2FuIGV4ZWN1dGUgYSBtZW1vcnkgcmVhZC93cml0ZQ0K
YXQgdGhlIHNhbWUgdGltZSBhcyBhbiBhZGQgKHByb2JhYmx5IGFueXRoaW5nIHN1cGVyY2FsZXIp
DQp5b3Ugd2FudCB0byBtb3ZlIHRoZSB0d28gJ2FkZGknIGZ1cnRoZXIgdXAgc28gdGhleSBnZXQN
CmV4ZWN1dGVkICdmb3IgZnJlZScuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

