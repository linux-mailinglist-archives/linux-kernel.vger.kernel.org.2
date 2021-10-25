Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974924398C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhJYOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:41:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57365 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229727AbhJYOlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:41:03 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-84-c45TSIbeOTKq5pLxwqcVGw-1; Mon, 25 Oct 2021 15:38:39 +0100
X-MC-Unique: c45TSIbeOTKq5pLxwqcVGw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Mon, 25 Oct 2021 15:38:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Mon, 25 Oct 2021 15:38:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Topic: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Index: AQHXyZrPgIVfu8vswkCI9TVLTUwuCavjxAog///yAQCAABGOUA==
Date:   Mon, 25 Oct 2021 14:38:38 +0000
Message-ID: <9247968df0fa4ab8a617b24195f178b4@AcuMS.aculab.com>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <1b19fbeccf3d4a75a5ed3a507d29f7dd@AcuMS.aculab.com>
 <CAMj1kXGuVdSVe29WoensbxC5fqp4HFQeBK2-oLxHA_BQLp2jww@mail.gmail.com>
In-Reply-To: <CAMj1kXGuVdSVe29WoensbxC5fqp4HFQeBK2-oLxHA_BQLp2jww@mail.gmail.com>
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

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMjUgT2N0b2JlciAyMDIxIDE1OjMyDQouLi4N
Cj4gT24gYXJtNjQsIHdlIGNhbiBvbmx5IHBhdGNoIE5PUHMgaW50byBicmFuY2ggaW5zdHJ1Y3Rp
b25zIG9yIHZpY2UNCj4gdmVyc2EsIG9yIHdlJ2QgaGF2ZSB0byBydW4gdGhlIHdob2xlIHRoaW5n
IHVuZGVyIHN0b3BfbWFjaGluZSgpIHRvDQo+IGVuc3VyZSB0aGF0IG90aGVyIGNvcmVzIGRvbid0
IGZldGNoIGdhcmJhZ2UuDQoNCk9rLCBJIHdhcyB0aGlua2luZyBpdCB3b3VsZCBiZSBzYWZlIHRv
IHBhdGNoIGEgc2luZ2xlIGluc3RydWN0aW9uLg0KQ2xlYXJseSB5b3UgY2FuJ3QgcGF0Y2ggbW9y
ZSB0aGFuIG9uZSB3aXRob3V0IGRhbmdlciBvZiAnZ2FyYmFnZScuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

