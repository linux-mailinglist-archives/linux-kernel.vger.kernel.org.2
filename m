Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB33A4E99
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFLMTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:19:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20220 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhFLMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:19:28 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-13-dZBTIf2VMkmyrAJF_oOoUw-1; Sat, 12 Jun 2021 13:17:23 +0100
X-MC-Unique: dZBTIf2VMkmyrAJF_oOoUw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 12 Jun
 2021 13:17:22 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Sat, 12 Jun 2021 13:17:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "akira.tsukamoto@gmail.com" <akira.tsukamoto@gmail.com>
CC:     "akira.tsukamoto@gmail.com" <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] riscv: prevent pipeline stall in
 __asm_to/copy_from_user
Thread-Topic: [PATCH 1/1] riscv: prevent pipeline stall in
 __asm_to/copy_from_user
Thread-Index: AQHXWSgp7oRD1A6yb0KBcJjcvPCgrasJ/LbggAXAiYCAAJBmMA==
Date:   Sat, 12 Jun 2021 12:17:22 +0000
Message-ID: <de82d455e12e44898a6f14a3885d9f0c@AcuMS.aculab.com>
References: <67dab8dc517f4add8b0c29074a6b3f06@AcuMS.aculab.com>
 <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop>
In-Reply-To: <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop>
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

RnJvbTogUGFsbWVyIERhYmJlbHQNCj4gU2VudDogMTIgSnVuZSAyMDIxIDA1OjA1DQouLi4NCj4g
PiBJIGRvbid0IGtub3cgdGhlIGFyY2hpdGVjdHVyZSwgYnV0IHVubGVzcyB0aGVyZSBpcyBhIHN0
dW5uaW5nDQo+ID4gcGlwZWxpbmUgZGVsYXkgZm9yIG1lbW9yeSByZWFkcyBhIHNpbXBsZSBpbnRl
cmxlYXZlZCBjb3B5DQo+ID4gbWF5IGJlIGZhc3QgZW5vdWdoLg0KPiA+IFNvIHNvbWV0aGluZyBs
aWtlOg0KPiA+IAlhID0gc3JjWzBdOw0KPiA+IAlkbyB7DQo+ID4gCQliID0gc3JjWzFdOw0KPiA+
IAkJc3JjICs9IDI7DQo+ID4gCQlkc3RbMF0gPSBhOw0KPiA+IAkJZHN0ICs9IDI7DQo+ID4gCQlh
ID0gc3JjWzBdOw0KPiA+IAkJZHN0Wy0xXSA9IGI7DQo+ID4gCX0gd2hpbGUgKHNyYyAhPSBzcmNf
ZW5kKTsNCj4gPiAJZHN0WzBdID0gYTsNCj4gPg0KPiA+IEl0IGlzIHByb2JhYmx5IHdvcnRoIGRv
aW5nIGJlbmNobWFya3Mgb2YgdGhlIGNvcHkgbG9vcA0KPiA+IGluIHVzZXJzcGFjZS4NCj4gDQo+
IEkgYWxzbyBkb24ndCBrbm93IHRoaXMgbWljcm9hcmNoaXRlY3R1cmUsIGJ1dCB0aGlzIHNlZW1z
IGxpa2UgYSBwcmV0dHkNCj4gd2Fja3kgbG9hZC11c2UgZGVsYXkuDQoNCkl0IGlzIHF1aXRlIHNh
bmUgcmVhbGx5Lg0KDQpXaGlsZSBtYW55IGNwdSBjYW4gdXNlIHRoZSByZXN1bHQgb2YgdGhlIEFM
VSBpbiB0aGUgbmV4dCBjbG9jaw0KKHRoZXJlIGlzIHR5cGljYWxseSBzcGVjaWFsIGxvZ2ljIHRv
IGJ5cGFzcyB0aGUgd3JpdGUgdG8gdGhlDQpyZWdpc3RlciBmaWxlKSB0aGlzIGlzbid0IGFsd2F5
cyB0cnVlIGZvciBtZW1vcnkgKGNhY2hlKSByZWFkcy4NCkl0IG1heSBldmVuIGJlIHRoYXQgdGhl
IHJlYWQgaXRzZWxmIHRha2VzIG1vcmUgdGhhbiBvbmUgY3ljbGUNCihwcm9iYWJseSBwaXBlbGlu
ZWQgc28gdGhleSBjYW4gaGFwcGVuIGV2ZXJ5IGN5Y2xlKS4NCg0KU28gYSBzaW1wbGUgJypkZXN0
ID0gKnNyYycgY29weSBsb29wIHN1ZmZlcnMgdGhlICdtZW1vcnkgcmVhZCcNCnBlbmFsdHkgZXZl
ciBpdGVyYXRpb24uDQpBdCBvdXQtb2Ytb3JkZXIgZXhlY3V0aW9uIHVuaXQgdGhhdCB1c2VzIHJl
Z2lzdGVyIHJlbmFtZXMNCihsaWtlIG1vc3QgeDg2KSB3aWxsIGp1c3QgZGVmZXIgdGhlIHdyaXRl
cyB1bnRpbCB0aGUgZGF0YQ0KaXMgYXZhaWxhYmxlIC0gc28gaXNuJ3QgaW1wYWN0ZWQuDQoNCklu
dGVybGVhdmluZyB0aGUgcmVhZHMgYW5kIHdyaXRlcyBtZWFucyB5b3UgaXNzdWUgYSByZWFkDQp3
aGlsZSB3YWl0aW5nIGZvciB0aGUgdmFsdWUgZnJvbSB0aGUgcHJldmlvdXMgcmVhZCB0bw0KZ2V0
IHRvIHRoZSByZWdpc3RlciBmaWxlIC0gYW5kIGJlIGF2YWlsYWJsZSBmb3IgdGhlDQp3cml0ZSBp
bnN0cnVjdGlvbi4NCg0KTW92aW5nIHRoZSAnc3JjL2RzdCArPSAyJyBpbnRvIHRoZSBsb29wIGdp
dmVzIGEgcmVhc29uYWJsZQ0KY2hhbmNlIHRoYXQgdGhleSBhcmUgZXhlY3V0ZWQgaW4gcGFyYWxs
ZWwgd2l0aCBhIG1lbW9yeQ0KYWNjZXNzIChvbiBpbi1vcmRlciBzdXBlcnNjYWxlciBjcHUpIHJh
dGhlciB0aGFuIGJ1bmNoaW5nDQp0aGVtIHVwIGF0IHRoZSBlbmQgd2hlcmUgdGhlIHN0YXJ0IGFk
ZGluZyBjbG9ja3MuDQoNCklmIHlvdXIgY3B1IGNhbiBvbmx5IGRvIG9uZSBtZW1vcnkgcmVhZCBv
ciBvbmUgbWVtb3J5IHdyaXRlDQpwZXIgY2xvY2sgdGhlbiB5b3Ugb25seSBuZWVkIGl0IHRvIGV4
ZWN1dGUgdHdvIGluc3RydWN0aW9ucw0KcGVyIGNsb2NrIGZvciB0aGUgbG9vcCBhYm92ZSB0byBy
dW4gYXQgbWF4aW11bSBzcGVlZC4NCkV2ZW4gd2l0aCBhICdyZWFkIGxhdGVuY3knIG9mIHR3byBj
bG9ja3MuDQooRXNwZWNpYWxseSBzaW5jZSByaXNjdiBoYXMgJ21pcHMgbGlrZScgJ2NvbXBhcmUg
YW5kIGJyYW5jaCcNCmluc3RydWN0aW9ucyB0aGF0IHByb2JhYmx5IGV4ZWN1dGUgaW4gMSBjbG9j
ayB3aGVuIHByZWRpY3RlZA0KdGFrZW4uKQ0KDQpJZiB0aGUgY3B1IGNhbiBkbyBhIHJlYWQgYW5k
IGEgd3JpdGUgaW4gb25lIGNsb2NrIHRoZW4gdGhlDQpsb29wIG1heSBzdGlsbCBydW4gYXQgdGhl
IG1heGltdW0gc3BlZWQuDQpGb3IgdGhpcyB0byBoYXBwZW4geW91IGRvIG5lZWQgaGUgcmVhZCBk
YXRhIHRvIGJlIGF2YWlsYWJsZQ0KbmV4dCBjbG9jayBhbmQgdG8gcnVuIGxvYWQsIHN0b3JlLCBh
ZGQgYW5kIGNvbXBhcmUgaW5zdHJ1Y3Rpb25zDQppbiBhIHNpbmdsZSBjbG9jay4NCldpdGhvdXQg
dGhhdCBtdWNoIHBhcmFsbGVsaXNtIGl0IG1pZ2h0IGJlIG5lY2Vzc2FyeSB0byBhZGQNCmFuIGV4
dHJhIHJlYWQvd3JpdGUgaW50ZXJsZWF2ZSAoYW4gbWF5YmUgYSA0dGggdG8gYXZvaWQgYQ0KZGl2
aWRlIGJ5IHRocmVlKS4NCg0KVGhlICdlbGVwaGFudCBpbiB0aGUgcm9vbScgaXMgYSBwb3RlbnRp
YWwgYWRkaXRpb25hbCBzdGFsbA0Kb24gcmVhZHMgaWYgdGhlIHByZXZpb3VzIGN5Y2xlIGlzIGEg
d3JpdGUgdG8gdGhlIHNhbWUgY2FjaGUgYXJlYS4NCkZvciBpbnN0YW5jZSB0aGUgbmlvczIgKGEg
c29mdCBjcHUgZm9yIGFsdGVyYSBmcGdhKSBjYW4gZG8NCmJhY2sgdG8gYmFjayByZWFkcyBvciBi
YWNrIHRvIGJhY2sgd3JpdGVzLCBidXQgc2luY2UgdGhlIHJlYWRzDQphcmUgZG9uZSBzcGVjdWxh
dGl2ZWx5IChyZWdhcmRsZXNzIG9mIHRoZSBvcGNvZGUhKSB0aGV5IGhhdmUgdG8NCmJlIGRlZmVy
cmVkIHdoZW4gYSB3cml0ZSBpcyB1c2luZyB0aGUgbWVtb3J5IGJsb2NrLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

