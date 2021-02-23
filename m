Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838103229A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhBWLsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:48:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22056 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhBWLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:48:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-k4jgkJgCOduc41m4UdoBHw-1; Tue, 23 Feb 2021 11:46:29 +0000
X-MC-Unique: k4jgkJgCOduc41m4UdoBHw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 23 Feb 2021 11:46:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 23 Feb 2021 11:46:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Michael J. Baars'" <mjbaars1977.gcc@cyberfiber.eu>,
        Andrew Pinski <pinskia@gmail.com>
CC:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: problems with memory allocation and the alignment check
Thread-Topic: problems with memory allocation and the alignment check
Thread-Index: AQHXCQVoyFvEwTTs3U2Rfs3mBdGve6pln5+g
Date:   Tue, 23 Feb 2021 11:46:28 +0000
Message-ID: <bea4697e847e4b5aa548e62e284d56ca@AcuMS.aculab.com>
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
         <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
 <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
In-Reply-To: <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
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

PiA+ID4gSSBqdXN0IHdyb3RlIHRoaXMgbGl0dGxlIHByb2dyYW0gdG8gZGVtb25zdHJhdGUgYSBw
b3NzaWJsZSBmbGF3IGluIGJvdGggbWFsbG9jIGFuZCBjYWxsb2MuDQo+ID4gPg0KPiA+ID4gSWYg
SSBhbGxvY2F0ZSBhIHRoZSBzaW1wbGVzdCBtZW1vcnkgcmVnaW9uIGZyb20gbWFpbigpLCBvbmUg
b3V0IG9mIHRocmVlIG9wdGltaXphdGlvbiBmbGFncyBmYWlsLg0KPiA+ID4gSWYgSSBhbGxvY2F0
ZSB0aGUgc2FtZSByZWdpb24gZnJvbSBhIGZ1bmN0aW9uLCB0aHJlZSBvdXQgb2YgdGhyZWUgb3B0
aW1pemF0aW9uIGZsYWdzIGZhaWwuDQo+ID4gPg0KPiA+ID4gRG9lcyBzb21lb25lIGtub3cgaWYg
dGhpcyByZWFsbHkgaXMgYSBmbGF3LCBhbmQgaWYgc28sIGlzIGl0IGEgZ2NjIG9yIGEga2VybmVs
IGZsYXc/DQo+ID4NCj4gPiBUaGVyZSBpcyBubyBmbGF3LiAgR0NDIChrZXJuZWwsIGdsaWJjKSBh
bGwgYXNzdW1lIHVuYWxpZ25lZCBhY2Nlc3Nlcw0KPiA+IG9uIHg4NiB3aWxsIG5vdCBjYXVzZSBh
biBleGNlcHRpb24uDQo+IA0KPiBJcyB0aGlzIGp1c3QgYW4gYXNzdW1wdGlvbiBvciBtb3JlIGxp
a2UgYSBmYWN0PyBJIGFncmVlIHdpdGggeW91IHRoYXQgYnl0ZSBhbGlnbmVkIGlzIG1vcmUgb3Ig
bGVzcyB0aGUNCj4gc2FtZSBhcyB1bmFsaWduZWQuDQoNClRoZXkgcmVxdWlyZSB0aGF0IHN1Y2gg
YWNjZXNzZXMgZG9uJ3QgY2F1c2UgYW4gZXhjZXB0aW9uLg0KDQpXaGlsZSB0aGUgbWlzYWxpZ25l
ZCBhY2Nlc3NlcyBhcmUgc2xpZ2h0bHkgc2xvd2VyIChhcGFydCBmcm9tIGxvY2tlZCBhY2Nlc3Nl
cw0KdGhhdCBjcm9zcyBwYWdlIGJvdW5kYXJpZXMpIHRoZSBjb3N0IG9mIGF2b2lkaW5nIHRoZW0g
aXMgdHlwaWNhbGx5IGhpZ2hlci4NCg0KVGhpcyBpcyBwYXJ0aWN1bGFybHkgdHJ1ZSBmb3IgZnVu
Y3Rpb25zIGxpa2Ugc3RybGVuKCkgd2hpY2ggYXJlIG9mdGVuDQpjYWxsZWQgZm9yIHNob3J0IHN0
cmluZ3MuDQpDYXJlIGRvZXMgaGF2ZSB0byBiZSB0YWtlbiB0byBzdG9wIHN0cmxlbigpIHJlYWRp
bmcgYWNyb3NzIGEgcGFnZSBib3VuZGFyeS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

