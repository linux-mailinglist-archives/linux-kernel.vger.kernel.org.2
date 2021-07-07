Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3723BE624
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGGKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:10:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35949 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhGGKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:10:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-g79YA_UqNSq2doqSydWg2A-1; Wed, 07 Jul 2021 11:07:17 +0100
X-MC-Unique: g79YA_UqNSq2doqSydWg2A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 7 Jul 2021 11:07:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 7 Jul 2021 11:07:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "akira.tsukamoto@gmail.com" <akira.tsukamoto@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
Thread-Topic: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize
 unaligned memory access and pipeline stall
Thread-Index: AQHXcr0E9zBxyMGA8EqGz08GSOYzlas3R1qQ
Date:   Wed, 7 Jul 2021 10:07:16 +0000
Message-ID: <7f6e56390954403fb07a1c606fbc7e6d@AcuMS.aculab.com>
References: <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com>
 <mhng-f4c7d64b-f4e9-491a-8868-bc1baa7a72a7@palmerdabbelt-glaptop>
In-Reply-To: <mhng-f4c7d64b-f4e9-491a-8868-bc1baa7a72a7@palmerdabbelt-glaptop>
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

Li4uDQo+ID4gKwlmaXh1cCBSRUdfTCAgIGE0LCAgICAgICAgMChhMSksIDEwZg0KPiA+ICsJZml4
dXAgUkVHX0wgICBhNSwgICAgU1pSRUcoYTEpLCAxMGYNCj4gPiArCWZpeHVwIFJFR19MICAgYTYs
ICAyKlNaUkVHKGExKSwgMTBmDQo+ID4gKwlmaXh1cCBSRUdfTCAgIGE3LCAgMypTWlJFRyhhMSks
IDEwZg0KPiA+ICsJZml4dXAgUkVHX0wgICB0MSwgIDQqU1pSRUcoYTEpLCAxMGYNCj4gPiArCWZp
eHVwIFJFR19MICAgdDIsICA1KlNaUkVHKGExKSwgMTBmDQo+ID4gKwlmaXh1cCBSRUdfTCAgIHQz
LCAgNipTWlJFRyhhMSksIDEwZg0KPiA+ICsJZml4dXAgUkVHX0wgICB0NCwgIDcqU1pSRUcoYTEp
LCAxMGYNCj4gPiArCWZpeHVwIFJFR19TICAgYTQsICAgICAgICAwKGEwKSwgMTBmDQo+ID4gKwlm
aXh1cCBSRUdfUyAgIGE1LCAgICBTWlJFRyhhMCksIDEwZg0KPiA+ICsJZml4dXAgUkVHX1MgICBh
NiwgIDIqU1pSRUcoYTApLCAxMGYNCj4gPiArCWZpeHVwIFJFR19TICAgYTcsICAzKlNaUkVHKGEw
KSwgMTBmDQo+ID4gKwlmaXh1cCBSRUdfUyAgIHQxLCAgNCpTWlJFRyhhMCksIDEwZg0KPiA+ICsJ
Zml4dXAgUkVHX1MgICB0MiwgIDUqU1pSRUcoYTApLCAxMGYNCj4gPiArCWZpeHVwIFJFR19TICAg
dDMsICA2KlNaUkVHKGEwKSwgMTBmDQo+ID4gKwlmaXh1cCBSRUdfUyAgIHQ0LCAgNypTWlJFRyhh
MCksIDEwZg0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIGEgc3VzcGljaW91c2x5IGxhcmdlIHVucm9s
bGluZyBmYWN0b3IsIGF0IGxlYXN0IHdpdGhvdXQNCj4gYSBmYWxsYmFjay4gIE15IGd1ZXNzIGlz
IHRoYXQgc29tZSB3b3JrbG9hZHMgd2lsbCB3YW50IHNvbWUgc21hbGxlcg0KPiB1bnJvbGxpbmcg
ZmFjdG9ycywgYnV0IGdpdmVuIHRoYXQgd2UgcnVuIG9uIHRoZXNlIHNpbmdsZS1pc3N1ZSBpbi1v
cmRlcg0KPiBwcm9jZXNzb3JzIGl0J3MgcHJvYmFibHkgYmVzdCB0byBoYXZlIHNvbWUgYmlnIHVu
cm9sbGluZyBmYWN0b3JzIGFzIHdlbGwNCj4gc2luY2UgdGhleSdyZSBwcmV0dHkgbGltaXRlZCBX
UlQgaW50ZWdlciBiYW5kd2lkdGguDQoNCkJ1dCBhIHNpbmdsZS1pc3N1ZSBjcHUgaXMgdW5saWtl
bHkgdG8gaGF2ZSBhbiA4IGNsb2NrIGRhdGEgZGVsYXkuDQpPVE9IIGEgY3B1IHRoYW4gY2FuIGRv
IGNvbmN1cnJlbnQgbWVtb3J5IHJlYWQgYW5kIHdyaXRlIG1pZ2h0DQpub3QgaGF2ZSBlbm91Z2gg
J291dCBvZiBvcmRlcicgY2FwYWJpbGl0eSB0byBkbyBzbyB3aXRoIHRoZSBhYm92ZSBsb29wLg0K
DQpZb3UgbWF5IHdhbnQgdG8gaW50ZXJsZWF2ZSB0aGUgcmVhZHMgYW5kIHdyaXRlcyAtIHN0YXJ0
aW5nIHdpdGgNCnR3byBvciB0aHJlZSByZWFkcyAocG9zc2libHkgd2l0aCB0aGUgZXh0cmEgb25l
cyBvdXRzaWRlIHRoZSBsb29wKS4NCg0KSSBkb24ndCBrbm93IHRoZSBtaWNyb2FyY2hpdGVjdHVy
ZXMgd2VsbCBlbm91Z2ggKHdlbGwgYXQgYWxsKQ0KdG8ga25vdyB0aGUgZXhhY3QgcGl0ZmFsbHMu
DQoNClRoZSB2ZXJ5IHNpbXBsZSBjcHUgbWlnaHQgaGF2ZSB0aGUgc2FtZSAnaXNzdWUnIHRoZSBO
aW9zMiBoYXMNCihhbm90aGVyIE1JUFMgY2xvbmUgZnBnYSBzb2Z0IGNwdSkgd2hlcmUgdGhlcmUg
Y2FuIGJlIGEgcGlwZWxpbmUNCnN0YWxsIGJldHdlZW4gYSB3cml0ZSBhbmQgcmVhZC4NCkkgZG91
YnQgdGhlIG5vbi10cml2aWFsIHJpc2N2IGhhdmUgdGhhdCBpc3N1ZSB0aG91Z2guDQoNCj4gPiAr
CWFkZGkJYTAsIGEwLCA4KlNaUkVHDQo+ID4gKwlhZGRpCWExLCBhMSwgOCpTWlJFRw0KPiA+ICsJ
Ymx0dQlhMCwgdDAsIDJiDQoNCkZvciBhIGR1YWwtaXNzdWUgY3B1IHlvdSB3YW50IHRvIG1vdmUg
dGhlIHR3byAnYWRkaScgaGlnaGVyDQp1cCB0aGUgbG9vcCBzbyB0aGF0IHRoZXkgYXJlICdmcmVl
Jy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

