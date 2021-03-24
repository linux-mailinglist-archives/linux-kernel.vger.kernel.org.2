Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA4347DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhCXQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:39:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20052 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235892AbhCXQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:38:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-ieJ6ILjUMhinNlWCciDQvA-1; Wed, 24 Mar 2021 16:38:31 +0000
X-MC-Unique: ieJ6ILjUMhinNlWCciDQvA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 24 Mar 2021 16:38:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Wed, 24 Mar 2021 16:38:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
Subject: RE: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
Thread-Topic: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
Thread-Index: AQHXH915IdtKoxR55UKYkN65PW6keqqTVkuA
Date:   Wed, 24 Mar 2021 16:38:31 +0000
Message-ID: <62602598e7b742d09c581f3fc988e487@AcuMS.aculab.com>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
 <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
In-Reply-To: <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
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

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjEgMTI6MDkNCj4gDQo+IE9u
IDIwMjEtMDMtMjMgMDc6MzQsIFlhbmcgWWluZ2xpYW5nIHdyb3RlOg0KPiA+IFdoZW4gY29weSBv
dmVyIDEyOCBieXRlcywgc3JjL2RzdCBpcyBhZGRlZCBhZnRlcg0KPiA+IGVhY2ggbGRwL3N0cCBp
bnN0cnVjdGlvbiwgaXQgd2lsbCBjb3N0IG1vcmUgdGltZS4NCj4gPiBUbyBpbXByb3ZlIHRoaXMs
IHdlIG9ubHkgYWRkIHNyYy9kc3QgYWZ0ZXIgbG9hZA0KPiA+IG9yIHN0b3JlIDY0IGJ5dGVzLg0K
PiANCj4gVGhpcyBicmVha3MgdGhlIHJlcXVpcmVkIGJlaGF2aW91ciBmb3IgY29weV8qX3VzZXIo
KSwgc2luY2UgdGhlIGZhdWx0DQo+IGhhbmRsZXIgZXhwZWN0cyB0aGUgYmFzZSBhZGRyZXNzIHRv
IGJlIHVwLXRvLWRhdGUgYXQgYWxsIHRpbWVzLiBTYXkNCj4geW91J3JlIGNvcHlpbmcgMTI4IGJ5
dGVzIGFuZCBmYXVsdCBvbiB0aGUgNHRoIHN0b3JlLCBpdCBzaG91bGQgcmV0dXJuIDgwDQo+IGJ5
dGVzIG5vdCBjb3BpZWQ7IHRoZSBjb2RlIGJlbG93IHdvdWxkIHJldHVybiAxMjggYnl0ZXMgbm90
IGNvcGllZCwgZXZlbg0KPiB0aG91Z2ggNDggYnl0ZXMgaGF2ZSBhY3R1YWxseSBiZWVuIHdyaXR0
ZW4gdG8gdGhlIGRlc3RpbmF0aW9uLg0KDQpBcmUgdGhlcmUgYW55IG5vbi1zdXBlcnNjYWxlciBh
bWQ2NCBjcHUgKHRoYXQgYW55b25lIGNhcmVzIGFib3V0KT8NCg0KSWYgdGhlIGNwdSBjYW4gZXhl
Y3V0ZSBtdWx0aXBsZSBpbnN0cnVjdGlvbnMgaW4gb25lIGNsb2NrDQp0aGVuIGl0IGlzIHVzdWFs
bHkgcG9zc2libGUgdG8gZ2V0IHRoZSBsb29wIGNvbnRyb2wgKGFsbW9zdCkgZnJlZS4NCg0KWW91
IG1pZ2h0IG5lZWQgdG8gdW5yb2xsIG9uY2UgdG8gaW50ZXJsZWF2ZSByZWFkL3dyaXRlDQpidXQg
YW55IG1vcmUgbWF5IGJlIHBvaW50bGVzcy4NClNvIHNvbWV0aGluZyBsaWtlOg0KCWEgPSAqc3Jj
KysNCglkbyB7DQoJCWIgPSAqc3JjKys7DQoJCSpkc3QrKyA9IGE7DQoJCWEgPSAqc3JjKys7DQoJ
CSpkc3QrKyA9IGI7DQoJfSB3aGlsZSAoc3JjICE9IGxpbSk7DQoJKmRzdCsrID0gYjsNCg0KICAg
IERhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

