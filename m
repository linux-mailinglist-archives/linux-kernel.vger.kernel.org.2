Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0544BEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKJKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:42:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48319 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhKJKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:42:28 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-187-TOk1bqhPOSKk8dwfNT7h9A-1; Wed, 10 Nov 2021 10:39:36 +0000
X-MC-Unique: TOk1bqhPOSKk8dwfNT7h9A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Wed, 10 Nov 2021 10:39:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Wed, 10 Nov 2021 10:39:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vasily Gorbik' <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Thread-Topic: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Thread-Index: AQHX1LcGf8T9B03p9E+LvaxuKPEBTKv8k6YA
Date:   Wed, 10 Nov 2021 10:39:35 +0000
Message-ID: <88372012a2374a8fa6e34a709e03b767@AcuMS.aculab.com>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
 <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
 <20211105165418.ucsrpk53dv5kgu6k@treble>
 <your-ad-here.call-01636386038-ext-6578@work.hours>
In-Reply-To: <your-ad-here.call-01636386038-ext-6578@work.hours>
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

RnJvbTogVmFzaWx5IEdvcmJpaw0KPiBTZW50OiAwOCBOb3ZlbWJlciAyMDIxIDE1OjQxDQo+IA0K
PiBPbiBGcmksIE5vdiAwNSwgMjAyMSBhdCAwOTo1NDoxOEFNIC0wNzAwLCBKb3NoIFBvaW1ib2V1
ZiB3cm90ZToNCj4gPiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCAwMzowMzowOFBNICswMjAwLCBW
YXNpbHkgR29yYmlrIHdyb3RlOg0KPiA+ID4gVGhlIGV4cGFuc2lvbiBvZiBhbm5vdGF0ZV9yZWFj
aGFibGUvYW5ub3RhdGVfdW5yZWFjaGFibGUgb24gczM5MCB3aWxsDQo+ID4gPiByZXN1bHQgaW4g
YSBjb21waWxlciBlcnJvciBpZiB0aGUgX19DT1VOVEVSX18gdmFsdWUgaXMgaGlnaCBlbm91Z2gu
DQouLi4NCj4gPiBJIHdvbmRlciBpZiB3ZSBjb3VsZCBnbyBiYWNrIHRvIHRoZSBvcmlnaW5hbCBh
cHByb2FjaCBvZiBwcm92aWRpbmcNCj4gPiBfX0NPVU5URVJfXyBhcyBhbiBpbnB1dCB0byB0aGUg
YXNtLCBidXQgdGhlbiBtYXNrIGl0IHRvIDwgMTI4Lg0KLi4uDQo+ID4gICAqIFRoZSBfX0NPVU5U
RVJfXyBiYXNlZCBsYWJlbHMgYXJlIGEgaGFjayB0byBtYWtlIGVhY2ggaW5zdGFuY2Ugb2YgdGhl
IG1hY3Jvcw0KPiA+ICAgKiB1bmlxdWUsIHRvIGNvbnZpbmNlIEdDQyBub3QgdG8gbWVyZ2UgZHVw
bGljYXRlIGlubGluZSBhc20gc3RhdGVtZW50cy4NCg0KSSd2ZSB1c2VkIGFzbSBjb21tZW50cyBn
ZXQgdGhlIHNhbWUgZWZmZWN0Lg0KQW5ub3lpbmdseSB0aGVyZSBpc24ndCBhIHN0YW5kYXJkIGNv
bW1lbnQgZGVsaW1pdGVyLg0KDQpJIHRoaW5rIHlvdSBjYW4ganVzdCB1c2UgYSAuZXF1IChvciAu
c2V0KSBkaXJlY3RpdmUgKHRvIGFzc2lnbiBhIHZhbHVlKQ0KcmF0aGVyIHRoYW4gcHV0dGluZyBh
IHZhbHVlIGludG8gYSAndG8gYmUgZGlzY2FyZGVkJyBzZWN0aW9uLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

