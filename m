Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A803BE605
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGGJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:58:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34602 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230150AbhGGJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:58:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-168-w7_5D2ULM7Sj_pMeGe5qtA-1; Wed, 07 Jul 2021 10:55:36 +0100
X-MC-Unique: w7_5D2ULM7Sj_pMeGe5qtA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 7 Jul 2021 10:55:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 7 Jul 2021 10:55:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Chen Huang <chenhuang5@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] arm64: an infinite loop in generic_perform_write()
Thread-Topic: [BUG] arm64: an infinite loop in generic_perform_write()
Thread-Index: AQHXcpt1OwfjX4VCyEKfx+OvZYZ3DKs3RYEQ
Date:   Wed, 7 Jul 2021 09:55:35 +0000
Message-ID: <4a1473fc5af9496e9c8ed02c7f631d72@AcuMS.aculab.com>
References: <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org> <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk> <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
 <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
 <20210706175052.GD15218@arm.com>
 <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
In-Reply-To: <dd30df30-5271-2724-48eb-9f47c5f3e1aa@arm.com>
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

PiA+IEkgdGhpbmsgaXQncyB3b3J0aCBkb2luZyB0aGUgY29weV90b191c2VyKCkgZmFsbGJhY2sg
aW4gYSBsb29wIHVudGlsIGl0DQo+ID4gZmF1bHRzIG9yIGhpdHMgdGhlIGVuZCBvZiB0aGUgYnVm
ZmVyLiBUaGlzIHdvdWxkIHNvbHZlIHRoZSBwcm9ibGVtIHdlDQo+ID4gY3VycmVudGx5IGhhdmUg
d2l0aCB3cml0aW5nIG1vcmUgYnl0ZXMgdGhhbiBhY3R1YWxseSByZXBvcnRlZC4gVGhlDQo+ID4g
Y29weV9mcm9tX3VzZXIoKSBpcyBub3QgbmVjZXNzYXJ5LCBhIGJ5dGUgd291bGQgc3VmZmljZS4N
Cj4gDQo+IFRoZSB0aGluZyBpcywgd2UgZG9uJ3QgcmVhbGx5IGhhdmUgdGhhdCBwcm9ibGVtIHNp
bmNlIHRoZSBzZXRfZnMgY2xlYW51cA0KPiByZW1vdmVkIElNUC1ERUYgU1RQIGJlaGF2aW91ciBm
cm9tIHRoZSBwaWN0dXJlIC0gZXZlbiB3aXRoIHRoZSBjdXJyZW50DQo+IG1lc3Mgd2UgY291bGQg
cGVyZmVjdGx5IHdlbGwga25vdyB3aGljaCBvZiB0aGUgdHdvIFNUVFJzIGZhdWx0ZWQgaWYgd2UN
Ci4uLg0KDQpUaGVyZSBpcyBhIG11Y2ggbW9yZSBpbnRlcmVzdGluZyBjYXNlIHRob3VnaC4NCkl0
IGlzIHBvc3NpYmxlIGZvciB1c2Vyc3BhY2UgdG8gaGF2ZSBzdXBwbGllZCBhIG1pc2FsaWduZWQN
CmJ1ZmZlciB0aGF0IGlzIG1tYXBwZWQgdG8gYW4gSU8gYWRkcmVzcyB0aGF0IGRvZXNuJ3Qgc3Vw
cG9ydA0KbWlzYWxpZ25lZCBhY2Nlc3NlcyBldmVuIHRob3VnaCBub3JtYWwgbWVtb3J5IGRvZXMg
c3VwcG9ydCB0aGVtLg0KDQpTbyB0aGUgJ2J5dGUgcmV0cnknIGxvb3Agd291bGQgd29yayBmb3Ig
dGhlIGVudGlyZSBidWZmZXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

