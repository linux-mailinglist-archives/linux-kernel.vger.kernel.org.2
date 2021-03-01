Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF686328E86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhCATd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:33:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29903 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236248AbhCAQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:53:57 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-30-hbKdKRBkNlOJNkbIkPc6Ng-1; Mon, 01 Mar 2021 16:52:16 +0000
X-MC-Unique: hbKdKRBkNlOJNkbIkPc6Ng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Mar 2021 16:52:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Mar 2021 16:52:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: #pragma once (was Re: incoming)
Thread-Topic: #pragma once (was Re: incoming)
Thread-Index: AQHXDJO7g0uYV47wjESpqf+pEawAGKpvW2CQ
Date:   Mon, 1 Mar 2021 16:52:16 +0000
Message-ID: <a941107b94f74be0914a359b144ec134@AcuMS.aculab.com>
References: <YDlXWHkYntoO4fk0@localhost.localdomain>
 <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
 <YDl9/QU8EsCOPyuf@localhost.localdomain>
In-Reply-To: <YDl9/QU8EsCOPyuf@localhost.localdomain>
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

RnJvbTogQWxleGV5IERvYnJpeWFuIDxhZG9icml5YW5AZ21haWwuY29tPg0KPiBTZW50OiAyNiBG
ZWJydWFyeSAyMDIxIDIzOjAyDQo+IA0KPiBPbiBGcmksIEZlYiAyNiwgMjAyMSBhdCAwMTo1Mzo0
OFBNIC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiBPbiBGcmksIEZlYiAyNiwgMjAy
MSBhdCAxMjoxNyBQTSBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IEkgd2FudCB0byBzZW50IHRyZWV3aWRlICIjcHJhZ21hIG9uY2UiIGNv
bnZlcnNpb246DQo+ID4NCj4gPiBBcmUgdGhlcmUgKmFueSogYWR2YW50YWdlcyB0byBpdD8NCj4g
Pg0KPiA+IEl0J3Mgbm9uLXN0YW5kYXJkLA0KPiANCj4gSXQgaXMgZWZmZWN0aXZlbHkgc3RhbmRh
cmQ6DQo+IGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL1ByYWdtYV9vbmNlI1BvcnRhYmls
aXR5DQoNCkF0IHRoZSB0b3Agb2YgdGhlIHBhZ2UuLi4uDQoNCkluIHRoZSBDIGFuZCBDKysgcHJv
Z3JhbW1pbmcgbGFuZ3VhZ2VzLCBwcmFnbWEgb25jZSBpcyBhIG5vbi1zdGFuZGFyZCBidXQgd2lk
ZWx5IHN1cHBvcnRlZA0KDQpTbyBub24tc3RhbmRhcmQgOi0pDQoNCkFuZCAjcHJhZ21hIGlzIHVn
bHkuLi4NCg0KVGhlcmUgYXJlIGFsc28gdGltZXMgd2hlbiBhbiBpbmNsdWRlIGd1YXJkIGhhcyB0
byBiZSBzZXQgaW4gb3JkZXIgdG8gc3RvcA0KYSBwcm9ibGVtYXRpYyBpbm5lciBmaWxlIGJlaW5n
IGluY2x1ZGVkLg0KUGVyaGFwcyBvbmx5IGR1cmluZyBoYWNraW5nLCBidXQgaXQgaXMgdXNlZnVs
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

