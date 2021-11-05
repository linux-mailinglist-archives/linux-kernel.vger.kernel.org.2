Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D4446297
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhKELXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:23:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50474 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232115AbhKELXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:23:34 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-98-6-DqjhWkP3-hUnDVQ128PA-1; Fri, 05 Nov 2021 11:20:48 +0000
X-MC-Unique: 6-DqjhWkP3-hUnDVQ128PA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Fri, 5 Nov 2021 11:20:46 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Fri, 5 Nov 2021 11:20:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>
Subject: RE: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
Thread-Topic: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
Thread-Index: AQHX0aXpJqQeacvBF0aIR0DE1IX+p6v0ycnw
Date:   Fri, 5 Nov 2021 11:20:46 +0000
Message-ID: <27a6d8f307414a1ba6e59e3cbfb7870e@AcuMS.aculab.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.625383149@infradead.org> <YYQfy2CNYyXO4KLV@zn.tnic>
In-Reply-To: <YYQfy2CNYyXO4KLV@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDA0IE5vdmVtYmVyIDIwMjEgMTg6MDENCj4g
DQo+IE9uIFRodSwgTm92IDA0LCAyMDIxIGF0IDA1OjQ3OjMxUE0gKzAxMDAsIFBldGVyIFppamxz
dHJhIHdyb3RlOg0KPiA+IFRoaXMgY29kZSBwdXRzIGFuIGV4Y2VwdGlvbiB0YWJsZSBlbnRyeSBv
biB0aGUgIlBSRUZJWCIgaW5zdHJ1Y3Rpb24gdG8NCj4gPiBvdmVyd3JpdGUgaXQgd2l0aCBhIGpt
cC5kOCB3aGVuIGl0IHRyaWdnZXJzIGFuIGV4Y2VwdGlvbi4gRXhjZXB0IG9mDQo+ID4gY291cnNl
LCBvdXIgY29kZSBpcyBubyBsb25nZXIgd3JpdGFibGUsIGFsc28gU01QLg0KPiA+DQo+ID4gUmVw
bGFjZSBpdCB3aXRoIEFMVEVSTkFUSVZFLCB0aGUgbm92ZWwNCj4gPg0KPiA+IFhYWDogYXJndWFi
bHkgd2Ugc2hvdWxkIGp1c3QgZGVsZXRlIHRoaXMgY29kZQ0KPiANCj4gWWFoLCBtaWdodCBhcyB3
ZWxsLg0KPiANCj4gV2lraXBlZGlhIHNheXMgdGhlIGxhc3QgQU1EIENQVSB3aGljaCBzdXBwb3J0
cyAzRE5vdyBpcyBBOC0zODcwSyB3aGljaA0KPiBpcyBmYW1pbHkgMHgxMSwgaS5lLiwNCj4gDQo+
IDEuIGEgcmVhbCByYXJpdHkNCj4gMi4gaXQgaXMgcHJldHR5IG11Y2ggb2Jzb2xldGUNCj4gMy4g
ZXZlbiBpZiBub3QsIGl0IGNhbiBkbyBBTUQ2NA0KPiA0LiBhbmQgZXZlbiBpZiBwZW9wbGUgd2hv
IGhhdmUgaXQsIHdhbm5hIHJ1biAzMi1iaXQsIHRoZXkgY2FuIHVzZSB0aGUNCj4gbm9ybWFsIG1l
bWNweSwgaS5lLiwgQ09ORklHX1g4Nl9VU0VfM0ROT1c9biBzaG91bGQgd29yayB0aGVyZQ0KPiAN
Cj4gSW4gb3VyIGNhc2UsIGl0IGlzIGEgYml0IGRpZmZlcmVudCwgdGhvdWdoOg0KPiANCj4gY29u
ZmlnIFg4Nl9VU0VfM0ROT1cNCj4gICAgICAgICBkZWZfYm9vbCB5DQo+ICAgICAgICAgZGVwZW5k
cyBvbiAoTUNZUklYSUlJIHx8IE1LNyB8fCBNR0VPREVfTFgpICYmICFVTUwNCj4gDQo+IE1LNyBp
cyBLNyAtIHRoYXQgaXMgcHJhY3RpY2FsbHkgZGVhZC4NCj4gDQo+IFRoZSBvbmx5IHRoaW5nIEkg
aGF2ZSBubyBjbHVlIGFib3V0IGFyZSB0aG9zZSBjeXJpeCBhbmQgZ2VvZGUgdGhpbmdzIGFuZA0K
PiB3aGV0aGVyIHRoZXkncmUgc3RpbGwgYWN0aXZlbHkgdXNlZCBpbiBzb21lIGVtYmVkZGVkIGd1
bmsuDQoNCkFuZCB3aGV0aGVyIHRoZSBwcmVmZXRjaCBhY3R1YWxseSBoZWxwcyBvbiB0aG9zZSBh
dCBhbGwuDQoNCkFuZCBldmVuIGlmIGl0IGRvZXMsIGRvIGVub3VnaCBtZW1jcHkoKSBuZWVkIHRv
IHByZWZldGNoIHRoZQ0KZGF0YSB0byBtYWtlIGl0IGFuIGFjdHVhbCBnYWluIC0gcmF0aGVyIHRo
YW4ganVzdCBzbG93aW5nDQpkb3duIG1lbWNweSgpIHdoZXJlIHRoZSBidWZmZXJzIGFyZSBjYWNo
ZSByZXNpZGVudC4NCg0KTm90IHRvIG1lbnRpb24gdGhlIGNhc2VzIHdoZXJlIHByZWZldGNoaW5n
IG9uIHRoZSBzb3VyY2UgZGlzcGxhY2VzDQphIHRhcmdldCBidWZmZXIgY2FjaGUgbGluZS4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

