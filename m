Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854E35F8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbhDNQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:09:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:53760 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhDNQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:09:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-220-x4Kd4_CiM3qjXPCTKqRshQ-1; Wed, 14 Apr 2021 17:08:47 +0100
X-MC-Unique: x4Kd4_CiM3qjXPCTKqRshQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 14 Apr 2021 17:08:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 14 Apr 2021 17:08:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>
CC:     Arjun Roy <arjunroy@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Topic: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
Thread-Index: AQHXMJPVg104is/mZUKAIt7DMH9hRKqy8Q+g///+zwCAALJWEIAAenQAgAARogA=
Date:   Wed, 14 Apr 2021 16:08:46 +0000
Message-ID: <1e5576a1a5b24cb0b1d53b9bb22d528e@AcuMS.aculab.com>
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
 <2c6885b0241d4127b8cb7e38abbbe1e5@AcuMS.aculab.com>
 <CANn89iJj9254GORTsabwv6ZBPWzebR4iYAj9VYxuOZSrF99fNg@mail.gmail.com>
In-Reply-To: <CANn89iJj9254GORTsabwv6ZBPWzebR4iYAj9VYxuOZSrF99fNg@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjEgMTc6MDANCi4uLg0KPiA+
IFJlcGVhdGVkIHVuc2FmZV9nZXRfdXNlcigpIGNhbGxzIGFyZSBjcnlpbmcgb3V0IGZvciBhbiBv
cHRpbWlzYXRpb24uDQo+ID4gWW91IGdldCBzb21ldGhpbmcgbGlrZToNCj4gPiAgICAgICAgIGZh
aWxlZCA9IDA7DQo+ID4gICAgICAgICBjb3B5KCk7DQo+ID4gICAgICAgICBpZiAoZmFpbGVkKSBn
b3RvIGVycm9yOw0KPiA+ICAgICAgICAgY29weSgpOw0KPiA+ICAgICAgICAgaWYgKGZhaWxlZCkg
Z290byBlcnJvcjsNCj4gPiBXaGVyZSAnZmFpbGVkJyBpcyBzZXQgYnkgdGhlIGZhdWx0IGhhbmRs
ZXIuDQo+ID4NCj4gPiBUaGlzIGNvdWxkIGJlIG9wdGltaXNlZCB0bzoNCj4gPiAgICAgICAgIGZh
aWxlZCA9IDA7DQo+ID4gICAgICAgICBjb3B5KCk7DQo+ID4gICAgICAgICBjb3B5KCk7DQo+ID4g
ICAgICAgICBpZiAoZmFpbGVkKSBnb3RvIGVycm9yOw0KPiA+IEV2ZW4gaWYgaXQgZmF1bHRzIG9u
IGV2ZXJ5IGludmFsaWQgYWRkcmVzcyBpdCBwcm9iYWJseQ0KPiA+IGRvZXNuJ3QgbWF0dGVyIC0g
bm8gb25lIGNhcmVzIGFib3V0IHRoYXQgcGF0aC4NCj4gDQo+IA0KPiBPbiB3aGljaCBhcmNoIGFy
ZSB5b3UgbG9va2luZyBhdCA/DQo+IA0KPiBPbiB4ODZfNjQgYXQgbGVhc3QsIGNvZGUgZ2VuZXJh
dGlvbiBpcyBqdXN0IHBlcmZlY3QuDQo+IE5vdCBldmVuIGEgY29uZGl0aW9uYWwgam1wLCBpdCBp
cyBhbGwgaGFuZGxlZCBieSBleGNlcHRpb25zIChpZiBhbnkpDQo+IA0KPiBzdGFjDQo+IGNvcHko
KTsNCj4gY29weSgpOw0KPiBjbGFjDQo+IA0KPiANCj4gPG91dF9vZl9saW5lPg0KPiBlZmF1bHRf
ZW5kOiBkbyBlcnJvciByZWNvdmVyeS4NCg0KSXQgd2lsbCBiZSB4ODZfNjQuDQpJJ20gZGVmaW5p
dGVseSBzZWVpbmcgcmVwZWF0ZWQgdGVzdHMgb2YgKElJUkMpICVyZHguDQoNCkl0IG1heSB3ZWxs
IGJlIGJlY2F1c2UgdGhlIGNvbXBpbGVyIGlzbid0IHZlcnkgbmV3Lg0KV2lsbCBiZSBhbiBVYnVu
dHUgYnVpbGQgb2YgOS4zLjAuDQpEb2VzIHRoYXQgc3VwcG9ydCAnYXNtIGdvdG8gd2l0aCBvdXRw
dXRzJyAtIHdoaWNoDQptYXkgYmUgdGhlIGRpZmZlcmVuY2UuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

