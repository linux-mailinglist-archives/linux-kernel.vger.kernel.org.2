Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5969539F500
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFHLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:33:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29583 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231630AbhFHLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:33:37 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-237-4PJJ-y6jPCSvRvqvFJVMeA-1; Tue, 08 Jun 2021 12:31:41 +0100
X-MC-Unique: 4PJJ-y6jPCSvRvqvFJVMeA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 12:31:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 12:31:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Akira Tsukamoto' <akira.tsukamoto@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] riscv: prevent pipeline stall in
 __asm_to/copy_from_user
Thread-Topic: [PATCH 1/1] riscv: prevent pipeline stall in
 __asm_to/copy_from_user
Thread-Index: AQHXWSgp7oRD1A6yb0KBcJjcvPCgrasJ/Lbg
Date:   Tue, 8 Jun 2021 11:31:40 +0000
Message-ID: <67dab8dc517f4add8b0c29074a6b3f06@AcuMS.aculab.com>
References: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
 <CACuRN0Pd8VFTz55qzXvJeqOEt2ZGi--j1wDyqnAt=q_42ES++w@mail.gmail.com>
In-Reply-To: <CACuRN0Pd8VFTz55qzXvJeqOEt2ZGi--j1wDyqnAt=q_42ES++w@mail.gmail.com>
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

RnJvbTogQWtpcmEgVHN1a2Ftb3RvDQo+IFNlbnQ6IDA0IEp1bmUgMjAyMSAxMDo1Nw0KPiANCj4g
UmVkdWNpbmcgcGlwZWxpbmUgc3RhbGwgb2YgcmVhZCBhZnRlciB3cml0ZSAoUkFXKS4NCj4gDQo+
IFRoZXNlIGFyZSB0aGUgcmVzdWx0cyBmcm9tIGNvbWJpbmF0aW9uIG9mIHRoZSBzcGVlZHVwIHdp
dGgNCj4gR2FyeSdzIG1pc2FsaWduIGZpeC4gU3BlZWRzIHVwIGZyb20gNjgwTWJwcyB0byA5MDBN
YnBzLg0KPiANCj4gQmVmb3JlIGFwcGx5aW5nIHRoZXNlIHR3byBwYXRjaGVzLg0KDQpJIHRoaW5r
IHRoZSBjaGFuZ2VzIHNob3VsZCBiZSBpbiBzZXBhcmF0ZSBwYXRjaGVzLg0KT3RoZXJ3aXNlIGl0
IGlzIGRpZmZpY3VsdCB0byBzZWUgd2hhdCBpcyByZWxldmFudC4NCkl0IGFsc28gbG9va3MgYXMg
aWYgdGhlcmUgaXMgYSByZWdpc3RlciByZW5hbWUuDQpNYXliZSB0aGF0IHNob3VsZCBiZSBhIHBy
ZWN1cnNvciBwYXRjaD8NCi4uLg0KDQpJIHRoaW5rIHRoaXMgaXMgdGhlIG9sZCBtYWluIGNvcHkg
bG9vcDoNCj4gIDE6DQo+IC0gICAgZml4dXAgUkVHX0wsIHQyLCAoYTEpLCAxMGYNCj4gLSAgICBm
aXh1cCBSRUdfUywgdDIsIChhMCksIDEwZg0KPiAtICAgIGFkZGkgYTEsIGExLCBTWlJFRw0KPiAt
ICAgIGFkZGkgYTAsIGEwLCBTWlJFRw0KPiAtICAgIGJsdHUgYTEsIHQxLCAxYg0KYW5kIHRoaXMg
aXMgdGhlIG5ldyBvbmU6DQo+ICAzOg0KPiArICAgIGZpeHVwIFJFR19MIGE0LCAgICAgICAwKGEx
KSwgMTBmDQo+ICsgICAgZml4dXAgUkVHX0wgYTUsICAgU1pSRUcoYTEpLCAxMGYNCj4gKyAgICBm
aXh1cCBSRUdfTCBhNiwgMipTWlJFRyhhMSksIDEwZg0KPiArICAgIGZpeHVwIFJFR19MIGE3LCAz
KlNaUkVHKGExKSwgMTBmDQo+ICsgICAgZml4dXAgUkVHX0wgdDAsIDQqU1pSRUcoYTEpLCAxMGYN
Cj4gKyAgICBmaXh1cCBSRUdfTCB0MSwgNSpTWlJFRyhhMSksIDEwZg0KPiArICAgIGZpeHVwIFJF
R19MIHQyLCA2KlNaUkVHKGExKSwgMTBmDQo+ICsgICAgZml4dXAgUkVHX0wgdDMsIDcqU1pSRUco
YTEpLCAxMGYNCj4gKyAgICBmaXh1cCBSRUdfUyBhNCwgICAgICAgMCh0NSksIDEwZg0KPiArICAg
IGZpeHVwIFJFR19TIGE1LCAgIFNaUkVHKHQ1KSwgMTBmDQo+ICsgICAgZml4dXAgUkVHX1MgYTYs
IDIqU1pSRUcodDUpLCAxMGYNCj4gKyAgICBmaXh1cCBSRUdfUyBhNywgMypTWlJFRyh0NSksIDEw
Zg0KPiArICAgIGZpeHVwIFJFR19TIHQwLCA0KlNaUkVHKHQ1KSwgMTBmDQo+ICsgICAgZml4dXAg
UkVHX1MgdDEsIDUqU1pSRUcodDUpLCAxMGYNCj4gKyAgICBmaXh1cCBSRUdfUyB0MiwgNipTWlJF
Ryh0NSksIDEwZg0KPiArICAgIGZpeHVwIFJFR19TIHQzLCA3KlNaUkVHKHQ1KSwgMTBmDQo+ICsg
ICAgYWRkaSBhMSwgYTEsIDgqU1pSRUcNCj4gKyAgICBhZGRpIHQ1LCB0NSwgOCpTWlJFRw0KPiAr
ICAgIGJsdHUgYTEsIGEzLCAzYg0KDQpJIGRvbid0IGtub3cgdGhlIGFyY2hpdGVjdHVyZSwgYnV0
IHVubGVzcyB0aGVyZSBpcyBhIHN0dW5uaW5nDQpwaXBlbGluZSBkZWxheSBmb3IgbWVtb3J5IHJl
YWRzIGEgc2ltcGxlIGludGVybGVhdmVkIGNvcHkNCm1heSBiZSBmYXN0IGVub3VnaC4NClNvIHNv
bWV0aGluZyBsaWtlOg0KCWEgPSBzcmNbMF07DQoJZG8gew0KCQliID0gc3JjWzFdOw0KCQlzcmMg
Kz0gMjsNCgkJZHN0WzBdID0gYTsNCgkJZHN0ICs9IDI7DQoJCWEgPSBzcmNbMF07DQoJCWRzdFst
MV0gPSBiOw0KCX0gd2hpbGUgKHNyYyAhPSBzcmNfZW5kKTsNCglkc3RbMF0gPSBhOw0KDQpJdCBp
cyBwcm9iYWJseSB3b3J0aCBkb2luZyBiZW5jaG1hcmtzIG9mIHRoZSBjb3B5IGxvb3ANCmluIHVz
ZXJzcGFjZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

