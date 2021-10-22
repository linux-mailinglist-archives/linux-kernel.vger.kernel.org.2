Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208B1437EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhJVT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:29:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50748 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233564AbhJVT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:29:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-280-yjQbEnhkMzaoHe-X7EcTnA-1; Fri, 22 Oct 2021 20:27:08 +0100
X-MC-Unique: yjQbEnhkMzaoHe-X7EcTnA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 22 Oct 2021 20:27:06 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 22 Oct 2021 20:27:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: RE: [PATCH v2 06/14] x86/asm: Fix register order
Thread-Topic: [PATCH v2 06/14] x86/asm: Fix register order
Thread-Index: AQHXxaHGAyzgkVkilESbivhSUK4dYqvfZkyA
Date:   Fri, 22 Oct 2021 19:27:06 +0000
Message-ID: <5821ce60ca08414382bf2f0702b7ffb5@AcuMS.aculab.com>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.859476776@infradead.org>
In-Reply-To: <20211020105842.859476776@infradead.org>
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMjAgT2N0b2JlciAyMDIxIDExOjQ1DQo+IA0K
PiBFbnN1cmUgdGhlIHJlZ2lzdGVyIG9yZGVyIGlzIGNvcnJlY3Q7IHRoaXMgYWxsb3dzIGZvciBl
YXN5IHRyYW5zbGF0aW9uDQo+IGJldHdlZW4gcmVnaXN0ZXIgbnVtYmVyIGFuZCB0cmFtcG9saW5l
IGFuZCB2aWNlLXZlcnNhLg0KDQpUaGVyZSBpcyBhbiBhbHRlcm5hdGUgY3BwIHBhdHRlcm4gdGhh
dCBjYW4gYmUgdXNlZCB0byBoYXZlIHRoZQ0Kc2FtZSBlZmZlY3QuDQpQb3NzaWJseSBsZXNzIGVy
cm9yIHByb25lLg0KU3RlYWxpbmcgc29tZSB0ZXh0IGZyb20gMiBwYXRjaGVzIHlvdSdkIGhhdmU6
DQoNCmFzbS9HRU4tZm9yLWVhY2gtcmVnLmggd291bGQgY29udGFpbjoNCg0KI2RlZmluZSBHRU5f
Rk9SX0VBQ0hfUkVHKEdFTikgXA0KICBHRU4ocmF4KSBcDQogIEdFTihyY3gpIFwNCiAgR0VOKHJk
eCkgXA0KICBHRU4ocmJ4KSBcDQogIEdFTihyc3ApIFwNCiAgR0VOKHJicCkgXA0KICBHRU4ocnNp
KSBcDQogIEdFTihyZGkpIFwNCiAgR0VOKHI4KSAgXA0KICBHRU4ocjkpICBcDQogIEdFTihyMTAp
DQoNCmFuZCB0aGUgdXNlciB3b3VsZCBjb250YWluOg0KDQojaW5jbHVkZSA8YXNtL0dFTi1mb3It
ZWFjaC1yZWcuaD4NCg0KI2RlZmluZSBHRU4ocmVnKSBcDQogCWV4dGVybiBhc21saW5rYWdlIHZv
aWQgX194ODZfaW5kaXJlY3RfdGh1bmtfICMjIHJlZyAodm9pZCk7DQpHRU5fRk9SX0VBQ0hfUkVH
KEdFTikNCiN1bmRlZiBHRU4NCg0KI2RlZmluZSBHRU4ocmVnKSBcDQogCWV4dGVybiBhc21saW5r
YWdlIHZvaWQgX194ODZfaW5kaXJlY3RfYWx0X2NhbGxfICMjIHJlZyAodm9pZCk7DQpHRU5fRk9S
X0VBQ0hfUkVHKEdFTikNCiN1bmRlZiBHRU4NCg0KSXQgaXMgcHJvYmFibHkgcG9zc2libGUgdG8g
dXNlIC4uLiBhbmQgX1ZBX0xJU1RfLg0KU29tZXRoaW5nIGxpa2U6DQoNCiNkZWZpbmUgR0VOX0ZP
Ul9FQUNIX1JFRyhHRU4sIC4uLikgXA0KICBHRU4ocmF4LCBfVkFfTElTVF8pIFwNCiAgLi4uDQoN
CiNkZWZpbmUgR0VOX1RIVU5LKHJlZywgdGh1bmspIFwNCglleHRlcm4gYXNtbGlua2FnZSB2b2lk
IHRodW5rICMjIHJlZyAodm9pZCk7DQoNCkdFTl9GT1JfRUFDSF9SRUcoR0VOX1RIVU5LLCBfX3g4
Nl9pbmRpcmVjdF90aHVua18pDQpHRU5fRk9SX0VBQ0hfUkVHKEdFTl9USFVOSywgX194ODZfaW5k
aXJlY3RfYWx0X2NhbGxfKQ0KI3VuZGVmIEdFTl9USFVOSw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

