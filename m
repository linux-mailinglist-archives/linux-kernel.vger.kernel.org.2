Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F439B4AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFDIPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:15:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:35700 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhFDIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:15:46 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-2sxBWfMpNbqbAlsW2s2RJA-1; Fri, 04 Jun 2021 09:13:57 +0100
X-MC-Unique: 2sxBWfMpNbqbAlsW2s2RJA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Fri, 4 Jun 2021 09:13:57 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Fri, 4 Jun 2021 09:13:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alex Elder' <elder@linaro.org>,
        'Manikishan Ghantasala' <manikishanghantasala@gmail.com>,
        Alex Elder <elder@ieee.org>
CC:     Alex Elder <elder@kernel.org>,
        "greybus-dev@lists.linaro.org" <greybus-dev@lists.linaro.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [greybus-dev] [PATCH] staging: greybus: fixed the coding style,
 labels should not be indented.
Thread-Topic: [greybus-dev] [PATCH] staging: greybus: fixed the coding style,
 labels should not be indented.
Thread-Index: AQHXV7uPElUZ9thDckyuMtjnIAGFwKsCzNHA///2ooCAABDyEP//8ZgAgAC7OdA=
Date:   Fri, 4 Jun 2021 08:13:57 +0000
Message-ID: <c29b5c97f97b48c894917647915bf510@AcuMS.aculab.com>
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
 <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
 <792dd57c0ef8454497e5ae4c4534dea2@AcuMS.aculab.com>
 <e1c36fb4-ab72-0cce-f6fe-3f04125dae28@linaro.org>
 <e23879ae78404be2b707b550b3029e43@AcuMS.aculab.com>
 <10ad30e2-c906-b210-bf0e-5e20b6de1993@linaro.org>
In-Reply-To: <10ad30e2-c906-b210-bf0e-5e20b6de1993@linaro.org>
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

RnJvbTogQWxleCBFbGRlcg0KPiBTZW50OiAwMyBKdW5lIDIwMjEgMjI6NTUNCi4uLg0KPiBOb3Qg
bmVjZXNzYXJpbHksIHNpemVvZihib29sKSBpcyBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkLg0KPiBB
bmQgSSB0aG91Z2h0IHlvdSBkaWRuJ3QgdGhpbmsgdGhlIHNpemUgb2YgdGhlIHN0cnVjdHVyZQ0K
PiB3YXMgdmVyeSBpbXBvcnRhbnQuLi4NCg0KSXQgaXMgJ2ltcGxlbWVudGF0aW9uIGRlZmluZWQn
IGJ1dCB3aWxsIGJlIDMyIGJpdHMgb24gZXZlcnl0aGluZw0KZXhjZXB0IGFuIG9sZCAzMmJpdCBB
Uk0gQUJJLg0KDQo+IEluIGFueSBjYXNlLCBJJ20gb3BlbiB0byBjaGFuZ2luZyB0aGUgdHlwZSBv
ZiB0aGVzZSBmaWVsZHMsDQo+IGFuZCBteSBwcmVmZXJlbmNlIHdvdWxkIGJlIGJvb2wgcmF0aGVy
IHRoYW4gdTgsIGJlY2F1c2UgaXQNCj4gaXMgY29tcGxldGVseSBjbGVhciB3aGF0IGl0IHJlcHJl
c2VudHMuDQoNClllcywgYW5kIGl0IGlzbid0IGF0IGFsbCBjbGVhciB3aGF0IGl0IGFjdHVhbGx5
IG1lYW5zLg0KSWYgdGhlIHZhbHVlIG9mIGEgYm9vbCBtZW1vcnkgbG9jYXRpb24gaXNuJ3QgMCBv
ciAxDQp3aGF0IGRvZXMgJ2Jvb2xfYSAmIGJvb2xfYicgbWVhbi4NCkl0IG1pZ2h0IGJlICd1bmRl
ZmluZWQgYmVoYXZpb3VyJyAtIGJ1dCB0aGF0IGRvZXNuJ3QgYWN0dWFsbHkNCmV4Y2x1ZGUgYW4g
SUNCTSBoaXR0aW5nIHRoZSBjb2RlcidzIGhvdXNlIQ0KSSd2ZSBzZWVuIHZlcnkgc2lsbHkgY29k
ZSBnZW5lcmF0ZWQgKGJ5IGFuIG9sZCBnY2MpIGZvcg0Kc2ltcGxlIHN0YXRlbWVudHMgbGlrZToN
Cglib29sX2EgfD0gYm9vbF9iOw0KTW9zdGx5IGJlY2F1c2UgaXQgZGlkbid0IHRydXN0IHRoZSB2
YWx1ZXMgdG8gYmUgMCBvciAxDQphbmQgd2FudGVkIHRvIGVuc3VyZSB0aGUgcmVzdWx0IHdhcyBl
aXRoZXIgMCBvciAxLg0KDQpJZiBJIHVzZSBhbiBpbnRlZ2VyIHR5cGUgKGFzIGluIHRyYWRpdGlv
bmFsIEMpIEkga25vdw0Kd2hhdCBJJ20gZ2V0dGluZyBhbmQgdGhlcmUgYXJlIG5vIHVuZXhwZWN0
ZWQgY29tcGFyaXNvbnMNCmFuZCBjb25kaXRpb25hbHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

