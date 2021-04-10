Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2435AD5B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhDJMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:45:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46193 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234262AbhDJMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:45:13 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-265-ddWTUGa6MeiYCKVuvWi_EA-1; Sat, 10 Apr 2021 13:44:56 +0100
X-MC-Unique: ddWTUGa6MeiYCKVuvWi_EA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 10 Apr 2021 13:44:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Sat, 10 Apr 2021 13:44:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Malcolm' <dmalcolm@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: RE: static_branch/jump_label vs branch merging
Thread-Topic: static_branch/jump_label vs branch merging
Thread-Index: AQHXLUcPoLE1E+ToRECqr0r/4koSQqqtr8wQ
Date:   Sat, 10 Apr 2021 12:44:55 +0000
Message-ID: <0a2e658a936a4b7788b23c57ff37119b@AcuMS.aculab.com>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
         <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
         <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
         <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
         <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
         <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
         <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
 <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
In-Reply-To: <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
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

RnJvbTogRGF2aWQgTWFsY29sbQ0KPiBTZW50OiAwOSBBcHJpbCAyMDIxIDE0OjQ5DQouLi4NCj4g
V2l0aCB0aGUgY2F2ZWF0IHRoYXQgbXkga25vd2xlZGdlIG9mIEdDQydzIG1pZGRsZS1lbmQgaXMg
bW9zdGx5IGFib3V0DQo+IGltcGxlbWVudGluZyB3YXJuaW5ncywgcmF0aGVyIHRoYW4gb3B0aW1p
emF0aW9uLCBJIGRpZCBzb21lDQo+IGV4cGVyaW1lbnRhdGlvbiwgd2l0aCBnY2MgdHJ1bmsgb24g
eDg2XzY0IEZXSVcuDQo+IA0KPiBHaXZlbjoNCj4gDQo+IGludCBfX2F0dHJpYnV0ZV9fKChwdXJl
KSkgZm9vKHZvaWQpOw0KPiANCj4gaW50IHQodm9pZCkNCj4gew0KPiAgIGludCBhOw0KICAgICAg
ICAgICA9IDA7DQo+ICAgaWYgKGZvbygpKQ0KPiAgICAgYSsrOw0KPiAgIGlmIChmb28oKSkNCj4g
ICAgIGErKzsNCj4gICBpZiAoZm9vKCkpDQo+ICAgICBhKys7DQo+ICAgcmV0dXJuIGE7DQo+IH0N
Cj4gDQo+IEF0IC1PMSBhbmQgYWJvdmUgdGhpcyBpcyBvcHRpbWl6ZWQgdG8gYSBzaW5nbGUgY2Fs
bCB0byBmb28sIHJldHVybmluZyAwDQo+IG9yIDMgYWNjb3JkaW5nbHkuDQoNCkludGVyZXN0aW5n
IGhvcnJpZCBpZGVhLg0KVGhlIGNvZGUgZ2VuZXJhdGVkIGZvciB0aGUgYWJvdmUgc2hvdWxkIGJl
Og0KCWNhbGwJZm9vDQoJanoJbGFiZWwNClNvIG9ianRvb2wgY291bGQgZmluZCB0aGUgcmVsb2Nh
dGlvbiBlbnRyaWVzIGZvciAnZm9vJw0KYW5kIHVzZSB0aGF0IGluZm9ybWF0aW9uIHRvIHJlcGxh
Y2UgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24NCihhbmQgbWF5YmUgdGhlIGp6KSB3aXRoIGEgc3VpdGFi
bGUgYWx0ZXJuYXRlIGluc3RydWN0aW9uDQpzZXF1ZW5jZS4NCg0KQWx0aG91Z2ggdGhhdCBtaWdo
dCBlbmQgdXAgd2l0aCBhIGdhbWUgb2YgJ3doYWNrLWEtbW9sZScNCm9uIHRoZSBwZXJ2ZXJzZSBp
bnN0cnVjdGlvbiBzZXF1ZW5jZXMgdGhlIGNvbXBpbGVyDQpnZW5lcmF0ZXMuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

