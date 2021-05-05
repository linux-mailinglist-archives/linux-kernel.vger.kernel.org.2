Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90D37387E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEEKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:21:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32533 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232095AbhEEKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:21:41 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-NBzCLfwUMDaGZYPLw1SIkQ-1; Wed, 05 May 2021 11:20:41 +0100
X-MC-Unique: NBzCLfwUMDaGZYPLw1SIkQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 11:20:41 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 11:20:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [RFC PATCH] crypto: arc4: Implement a version optimized for
 memory usage
Thread-Topic: [RFC PATCH] crypto: arc4: Implement a version optimized for
 memory usage
Thread-Index: AQHXQQ8/MxI87C5LlEaRIASgh2FBkKrUrGEQ
Date:   Wed, 5 May 2021 10:20:41 +0000
Message-ID: <4fe67cdda2c64c1da314142eda998967@AcuMS.aculab.com>
References: <c52bd8972c9763c3fac685d7c6af3c46a23a1477.1619983555.git.christophe.jaillet@wanadoo.fr>
 <YJF8/oaWUqZsWfOb@gmail.com>
 <d523902e-744c-1291-aee8-9be734f2a3ce@wanadoo.fr>
In-Reply-To: <d523902e-744c-1291-aee8-9be734f2a3ce@wanadoo.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBKQUlMTEVUDQo+IFNlbnQ6IDA0IE1heSAyMDIxIDE5OjAwDQo+IA0K
PiBMZSAwNC8wNS8yMDIxIMOgIDE4OjU3LCBFcmljIEJpZ2dlcnMgYSDDqWNyaXTCoDoNCj4gPiBP
biBTdW4sIE1heSAwMiwgMjAyMSBhdCAwOToyOTo0NlBNICswMjAwLCBDaHJpc3RvcGhlIEpBSUxM
RVQgd3JvdGU6DQo+ID4+ICsjaWYgZGVmaW5lZChDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElH
TkVEX0FDQ0VTUykNCj4gPj4gKyNkZWZpbmUgU190eXBlCXU4DQo+ID4+ICsjZWxzZQ0KPiA+PiAr
I2RlZmluZSBTX3R5cGUJdTMyDQo+ID4+ICsjZW5kaWYNCj4gPj4gKw0KPiA+PiAgIHN0cnVjdCBh
cmM0X2N0eCB7DQo+ID4+IC0JdTMyIFNbMjU2XTsNCj4gPj4gKwlTX3R5cGUgU1syNTZdOw0KPiA+
PiAgIAl1MzIgeCwgeTsNCj4gPj4gICB9Ow0KPiA+DQo+ID4gSXMgaXQgYWN0dWFsbHkgdXNlZnVs
IHRvIGtlZXAgYm90aCB2ZXJzaW9ucz8gIEl0IHNlZW1zIHdlIGNvdWxkIGp1c3QgdXNlIHRoZSB1
OA0KPiA+IHZlcnNpb24gZXZlcnl3aGVyZS4gIE5vdGUgdGhhdCB0aGVyZSBhcmVuJ3QgYWN0dWFs
bHkgYW55IHVuYWxpZ25lZCBtZW1vcnkNCj4gPiBhY2Nlc3Nlcywgc28gY2hvb3NpbmcgdGhlIHZl
cnNpb24gY29uZGl0aW9uYWxseSBvbg0KPiA+IENPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdO
RURfQUNDRVNTIHNlZW1zIG9kZC4gIFdoYXQgYXJlIHlvdSB0cnlpbmcgdG8NCj4gPiBkZXRlcm1p
bmUgYnkgY2hlY2tpbmcgdGhhdD8NCj4gDQo+IEhpLCB0aGlzIGlzIGEgYmFkIGludGVycHJldGF0
aW9uIGZyb20gbWUuDQouLi4NCj4gDQo+IEkgd2FudGVkIHRvIGF2b2lkIHBvdGVudGlhbCBwZXJm
b3JtYW5jZSBjb3N0IHJlbGF0ZWQgdG8gdXNpbmcgY2hhciAoaS5lDQo+IHU4KSBpbnN0ZWFkIG9m
IGludCAoaS5lLiB1MzIpLg0KPiBPbiBzb21lIGFyY2hpdGVjdHVyZSB0aGlzIGNvdWxkIHJlcXVp
cmUgc29tZSBzaGlmdCBvciBtYXNraW5nIG9yDQo+IHdoYXRldmVyIHRvICJ1bnBhY2siIHRoZSB2
YWx1ZXMgb2YgUy4NCg0KVGhlIG9ubHkgYXJjaGl0ZWN0dXJlIHRoYXQgTGludXggcmFuIG9uIHdo
ZXJlIHRoZSBoYXJkd2FyZQ0KZGlkIFJNVyBhY2Nlc3NlcyBmb3IgYnl0ZSB3cml0ZXMgd2FzIHNv
bWUgdmVyeSBvbGQgYWxwaGEgY3B1Lg0KRXZlbiBtb3JlIHJlY2VudCBhbHBoYSBzdXBwb3J0ZWQg
Ynl0ZSB3cml0ZXMgdG8gbWVtb3J5Lg0KDQpPbiBtYW55IGFyY2hpdGVjdHVyZXMgKG5vdCB4ODYg
b3IgYXJtKSBpbmRleGluZyBhIGJ5dGUgYXJyYXkNCmlzIGJldHRlciBiZWNhdXNlIGl0IHNhdmVz
IHRoZSBpbnN0cnVjdGlvbiB0byBtdWx0aXBseSB0aGUgaW5kZXggYnkgNC4NCk9uIHg4Ni02NCB5
b3Ugd2FudCB0byBiZSB1c2luZyAndW5zaWduZWQgaW50JyBmb3IgYXJyYXkgaW5kZXhlcw0Kc28g
dGhlIGNvbXBpbGVyIGRvZXNuJ3QgaGF2ZSB0byBlbWl0IHRoZSBpbnN0cnVjdGlvbiB0byBzaWdu
IGV4dGVuZA0KYSAzMmJpdCBpbnQgdG8gNjQgYml0cyAoc29tZXRpbWVzIGl0IGtub3dzIGl0IGNh
bid0IGJlIG5lZWRlZCkuDQoNCkZXSVcgd2l0aCBhIG1vZGVybiBjb21waWxlciBhbGwgdGhvc2Ug
dGVtcG9yYXJpZXMgYXJlIHBvaW50bGVzcy4NClRoZSBudW1iZXIgb2YgbGluZXMgb2YgY29kZSBj
YW4gYmUgaGFsdmVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

