Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B83FE4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbhIAV0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:26:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:22955 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231829AbhIAV0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:26:42 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-c390Co3qPK-uD5n_1goeJA-1; Wed, 01 Sep 2021 22:25:41 +0100
X-MC-Unique: c390Co3qPK-uD5n_1goeJA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 1 Sep 2021 22:25:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 1 Sep 2021 22:25:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miaohe Lin' <linmiaohe@huawei.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Thread-Topic: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro
 K()
Thread-Index: AQHXnwRH7aDqZJ0qj0GamkvkPYegv6uPsZXw
Date:   Wed, 1 Sep 2021 21:25:40 +0000
Message-ID: <f2f9754bef1b48b8b58718b2af21895f@AcuMS.aculab.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <9161665.bUqNH3lxUD@natalenko.name>
 <52bbb8f2-db63-8c56-ea49-d982c13ba541@huawei.com>
 <9426505.MgecbftzqH@natalenko.name>
 <03653d41-abe0-46f0-9eee-28cad9f5edea@huawei.com>
In-Reply-To: <03653d41-abe0-46f0-9eee-28cad9f5edea@huawei.com>
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

RnJvbTogTWlhb2hlIExpbg0KPiBTZW50OiAwMSBTZXB0ZW1iZXIgMjAyMSAwODozOA0KLi4uDQo+
ID4+PiBTaG91bGRuJ3QgdGhpcyBtYWNybyBnbyB0byBzb21lIGhlYWRlciBmaWxlIGluc3RlYWQg
dG8gZ2V0IHJpZCBvZiBkZWZpbmUNCj4gPj4+IHJlcGV0aXRpb25zPw0KPiA+Pg0KPiA+PiBNYW55
IHRoYW5rcyBmb3IgZmlndXJpbmcgdGhpcyBvdXQuIEkgdGhpbmsgd2Ugc2hvdWxkIGdldCByaWQg
b2YgdGhlc2UNCj4gPj4gcmVwZXRpdGlvbnMgdG9vLiBCdXQgSSdhbSBub3Qgc3VyZSB3aGVyZSB0
aGlzIGRlZmluaXRpb24gc2hvdWxkIGJlLiBBbnkNCj4gPj4gc3VnZ2VzdGlvbj8gVGhhbmtzLg0K
PiA+DQo+ID4gSSdtIG5vdCBzdXJlIHdoYXQgcGxhY2Ugc3VpdHMgYmVzdC4gQXQgZmlyc3QgSSB0
aG91Z2h0IG1heWJlIGxpbnV4L21tLmggb3INCj4gPiBsaW51eC9tbV9pbmxpbmUuaCwgYnV0IHNp
bmNlIFBBR0VfU0hJRlQgaXMgZGVjbGFyZWQgaW4gYXNtLWdlbmVyaWMvcGFnZS5oLA0KPiA+IHBy
b2JhYmx5IEsoeCkgY2FuIGFsc28gZ28gdGhlcmUgYXMgd2VsbD8NCj4gDQo+IEsoeCkgaXMgcmVs
ZXZhbnQgd2l0aCBQQUdFX1NISUZULiBTbyBJIHRoaW5rIEsoeCkgY2FuIGFsc28gZ28gYXNtLWdl
bmVyaWMvcGFnZS5oIHRvby4NCj4gQW0gSSBzdXBwb3NlZCB0byBkbyB0aGlzIHdoZW4gZnJlZSBv
ciB3aWxsIHlvdSBraW5kbHkgZG8gdGhpcz8NCg0KSXQgaXMgYSBiaXQgb2YgYSBzaG9ydCBuYW1l
IHRvIGdvIGluIGEgcHVibGljIGhlYWRlciBmaWxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

