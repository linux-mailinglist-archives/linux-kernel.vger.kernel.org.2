Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2735EEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbhDNHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:55:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349227AbhDNHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:55:44 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-0z_89RUiMquoxRveDlGl8w-1; Wed, 14 Apr 2021 08:55:18 +0100
X-MC-Unique: 0z_89RUiMquoxRveDlGl8w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 08:55:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 08:55:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arjun Roy' <arjunroy@google.com>
CC:     Eric Dumazet <edumazet@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Topic: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Index: AQHXMJPVg104is/mZUKAIt7DMH9hRKqy8Q+g///+zwCAALJWEA==
Date:   Wed, 14 Apr 2021 07:55:17 +0000
Message-ID: <2c6885b0241d4127b8cb7e38abbbe1e5@AcuMS.aculab.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com>
 <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
 <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
 <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
 <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
 <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com>
 <CAOFY-A21tjC5dWwM0W0aXHij40kKj2JNo5Nq4X8mBZZdKwr+AA@mail.gmail.com>
In-Reply-To: <CAOFY-A21tjC5dWwM0W0aXHij40kKj2JNo5Nq4X8mBZZdKwr+AA@mail.gmail.com>
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

RnJvbTogQXJqdW4gUm95DQo+IFNlbnQ6IDEzIEFwcmlsIDIwMjEgMjM6MDQNCj4gDQo+IE9uIFR1
ZSwgQXByIDEzLCAyMDIxIGF0IDI6MTkgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IElmIHdlJ3JlIHNwZWNpYWwtY2FzaW5nIDY0LWJp
dCBhcmNoaXRlY3R1cmVzIGFueXdheXMgLSB1bnJvbGxpbmcgdGhlDQo+ID4gPiAzMkIgY29weV9m
cm9tX3VzZXIoKSBmb3Igc3RydWN0IHJzZXFfY3MgYXBwZWFycyB0byBiZSByb3VnaGx5IDUtMTAl
DQo+ID4gPiBzYXZpbmdzIG9uIHg4Ni02NCB3aGVuIEkgbWVhc3VyZWQgaXQgKHdlbGwsIGluIGEg
bWljcm9iZW5jaG1hcmssIG5vdA0KPiA+ID4gaW4gcnNlcV9nZXRfcnNlcV9jcygpIGRpcmVjdGx5
KS4gUGVyaGFwcyB0aGF0IGNvdWxkIGJlIGFuIGFkZGl0aW9uYWwNCj4gPiA+IGF2ZW51ZSBmb3Ig
aW1wcm92ZW1lbnQgaGVyZS4NCj4gPg0KPiA+IFRoZSBraWxsZXIgaXMgdXN1YWxseSAndXNlciBj
b3B5IGhhcmRlbmluZycuDQo+ID4gSXQgc2lnbmlmaWNhbnRseSBzbG93cyBkb3duIHNlbmRtc2co
KSBhbmQgcmVjdm1zZygpLg0KPiA+IEkndmUgZ290IG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnRzIGJ5DQo+ID4gdXNpbmcgX19jb3B5X2Zyb21fdXNlcigpIHdoZW4gdGhlIGJ1ZmZl
ciBzaW5jZSBoYXMNCj4gPiBhbHJlYWR5IGJlZW4gY2hlY2tlZCAtIGJ1dCBpc24ndCBhIGNvbXBp
bGUtdGltZSBjb25zdGFudC4NCj4gPg0KPiA+IFRoZXJlIGlzIGFsc28gc2NvcGUgZm9yIHVzaW5n
IF9nZXRfdXNlcigpIHdoZW4gcmVhZGluZw0KPiA+IGlvdmVjW10gKGluc3RlYWQgb2YgY29weV9m
cm9tX3VzZXIoKSkgYW5kIGRvaW5nIGFsbCB0aGUNCj4gPiBib3VuZCBjaGVja3MgKGV0YykgaW4g
dGhlIGxvb3AuDQo+ID4gVGhhdCBnaXZlcyBhIG1lYXN1cmFibGUgaW1wcm92ZW1lbnQgZm9yIHdy
aXRldigiL2Rldi9udWxsIikuDQo+ID4gSSBtdXN0IHNvcnQgdGhvc2UgcGF0Y2hlcyBvdXQgYWdh
aW4uDQo+ID4NCj4gPiAgICAgICAgIERhdmlkDQo+ID4NCj4gDQo+IEluIHRoaXMgY2FzZSBJIG1l
YW4gcmVwbGFjaW5nIGNvcHlfZnJvbV91c2VyKHJzZXFfY3MsIHVyc2VxX2NzLA0KPiBzaXplb2Yo
KnJzZXFfY3MpKSB3aXRoICA0ICh4OEI9MzIgdG90YWwpIHVuc2FmZV9nZXRfdXNlcigpICh3cmFw
cGVkIGluDQo+IHVzZXJfcmVhZF9hY2Nlc3NfYmVnaW4vZW5kKCkpIHdoaWNoIEkgdGhpbmsgd291
bGQganVzdCBieXBhc3MgdXNlcg0KPiBjb3B5IGhhcmRlbmluZyAoYXMgZmFyIGFzIEkgY2FuIHRl
bGwpLg0KDQpZZXMgdGhhdCBpcyBvbmUgYWR2YW50YWdlIG92ZXIgYW55IG9mIHRoZSBnZXRfdXNl
cigpIGNhbGxzLg0KWW91IGFsc28gbG9zZSBhbGwgdGhlICdob3cgc2hhbGwgd2Ugb3B0aW1pc2Ug
dGhpcycgY2hlY2tzDQppbiBjb3B5X2Zyb21fdXNlcigpLg0KDQpSZXBlYXRlZCB1bnNhZmVfZ2V0
X3VzZXIoKSBjYWxscyBhcmUgY3J5aW5nIG91dCBmb3IgYW4gb3B0aW1pc2F0aW9uLg0KWW91IGdl
dCBzb21ldGhpbmcgbGlrZToNCglmYWlsZWQgPSAwOw0KCWNvcHkoKTsNCglpZiAoZmFpbGVkKSBn
b3RvIGVycm9yOw0KCWNvcHkoKTsNCglpZiAoZmFpbGVkKSBnb3RvIGVycm9yOw0KV2hlcmUgJ2Zh
aWxlZCcgaXMgc2V0IGJ5IHRoZSBmYXVsdCBoYW5kbGVyLg0KDQpUaGlzIGNvdWxkIGJlIG9wdGlt
aXNlZCB0bzoNCglmYWlsZWQgPSAwOw0KCWNvcHkoKTsNCgljb3B5KCk7DQoJaWYgKGZhaWxlZCkg
Z290byBlcnJvcjsNCkV2ZW4gaWYgaXQgZmF1bHRzIG9uIGV2ZXJ5IGludmFsaWQgYWRkcmVzcyBp
dCBwcm9iYWJseQ0KZG9lc24ndCBtYXR0ZXIgLSBubyBvbmUgY2FyZXMgYWJvdXQgdGhhdCBwYXRo
Lg0KDQpJJ3ZlIG5vdCByZWFsbHkgbG9va2VkIGF0IGhvdyBpdCBjb3VsZCBiZSBhY2hpZXZlZCB0
aG91Z2guDQoNCkl0IG1pZ2h0IGJlIHRoYXQgdGhlICdhc20gZ290byB3aXRoIG91dHB1dHMnIHZh
cmlhbnQNCm1hbmFnZXMgdG8gYXZvaWQgdGhlIGNvbXBhcmUgYW5kIGp1bXAuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

