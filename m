Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364AA43998B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhJYPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:05:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:36279 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233125AbhJYPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:05:33 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-aKNhXINvOZ21MuhdPyf27Q-1; Mon, 25 Oct 2021 16:03:08 +0100
X-MC-Unique: aKNhXINvOZ21MuhdPyf27Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Mon, 25 Oct 2021 16:03:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Mon, 25 Oct 2021 16:03:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        "Quentin Perret" <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Topic: [PATCH 2/4] arm64: implement support for static call trampolines
Thread-Index: AQHXybBSgIVfu8vswkCI9TVLTUwuCavjzkjQ
Date:   Mon, 25 Oct 2021 15:03:07 +0000
Message-ID: <cf2bf7a61a0a4fca8425b96e139d71e2@AcuMS.aculab.com>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
In-Reply-To: <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
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

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMjUgT2N0b2JlciAyMDIxIDE1OjU1DQo+IA0K
PiBPbiBNb24sIDI1IE9jdCAyMDIxIGF0IDE2OjQ3LCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMDQ6
MTk6MTZQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE9jdCAy
NSwgMjAyMSBhdCAwNDowODozN1BNICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4gPg0K
PiA+ID4gPiA+IE9vb2hoLCBidXQgd2hhdCBpZiB5b3UgZ28gZnJvbSAhZnVuYyB0byBOT1AuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBhc3N1bWluZzoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAg
ICAgLmxpdGVyYWwgPSAwDQo+ID4gPiA+ID4gICAgICAgICBCVEkgQw0KPiA+ID4gPiA+ICAgICAg
ICAgUkVUDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAg
ICAgICAgIENQVTAgICAgICAgICAgICAgICAgICAgIENQVTENCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ICAgICAgICAgW1NdIGxpdGVyYWwgPSBmdW5jICAgICAgW0ldIE5PUA0KPiA+ID4gPiA+ICAgICAg
ICAgW1NdIGluc25bMV0gPSBOT1AgICAgICAgW0xdIHgxNiA9IGxpdGVyYWwgKE5VTEwpDQo+ID4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiIHgxNg0KPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKkJBTkcqDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBJcyB0aGF0IHBvc3NpYmxlPyAodG90YWwgbGFjayBvZiBtZW1vcnkgb3JkZXJpbmcgZXRjLi4p
DQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIENCWiB3aWxsIGJyYW5jaCB0byB0aGUg
UkVUIGluc3RydWN0aW9uIGlmIHgxNiA9PSAweDAsIHNvIHRoaXMNCj4gPiA+ID4gc2hvdWxkIG5v
dCBoYXBwZW4uDQo+ID4gPg0KPiA+ID4gT29vaCwgSSBtaXNzZWQgdGhhdCA6LyBJIHdhcyBhYm91
dCB0byBzdWdnZXN0IHdyaXRpbmcgdGhlIGFkZHJlc3Mgb2YgYQ0KPiA+ID4gYmFyZSAncmV0JyB0
cmFtcG9saW5lIGluc3RlYWQgb2YgTlVMTCBpbnRvIHRoZSBsaXRlcmFsLg0KPiA+DQo+ID4gUGVy
aGFwcyBhIGxpdHRsZSBzb21ldGhpbmcgbGlrZSBzby4uIFNoYXZlcyAyIGluc3RydWN0aW9ucyBv
ZmYgZWFjaA0KPiA+IHRyYW1wb2xpbmUuDQo+ID4NCj4gPiAtLS0gYS9hcmNoL2FybTY0L2luY2x1
ZGUvYXNtL3N0YXRpY19jYWxsLmgNCj4gPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N0
YXRpY19jYWxsLmgNCj4gPiBAQCAtMTEsOSArMTEsNyBAQA0KPiA+ICAgICAgICAgICAgICIgICBo
aW50ICAgIDM0ICAgICAgLyogQlRJIEMgKi8gICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxu
IiBcDQo+ID4gICAgICAgICAgICAgICAgIGluc24gIiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXG4iIFwNCj4gPiAgICAgICAgICAgICAiICAgbGRyICAg
ICB4MTYsIDBiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcbiIgXA0K
PiA+IC0gICAgICAgICAgICIgICBjYnogICAgIHgxNiwgMWYgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFxuIiBcDQo+ID4gICAgICAgICAgICAgIiAgIGJyICAgICAgeDE2
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG4iIFwNCj4gPiAt
ICAgICAgICAgICAiMTogcmV0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcbiIgXA0KPiA+ICAgICAgICAgICAgICIgICAucG9wc2VjdGlvbiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuIikNCj4gPg0KPiA+ICAj
ZGVmaW5lIEFSQ0hfREVGSU5FX1NUQVRJQ19DQUxMX1RSQU1QKG5hbWUsIGZ1bmMpICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9wYXRjaGluZy5jDQo+
ID4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvcGF0Y2hpbmcuYw0KPiA+IEBAIC05MCw2ICs5MCwx
MSBAQCBpbnQgX19rcHJvYmVzIGFhcmNoNjRfaW5zbl93cml0ZSh2b2lkICphDQo+ID4gICAgICAg
ICByZXR1cm4gX19hYXJjaDY0X2luc25fd3JpdGUoYWRkciwgJmksIEFBUkNINjRfSU5TTl9TSVpF
KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK2FzbSgiX19zdGF0aWNfY2FsbF9yZXQ6ICAgICAgICAgICAg
ICAgIFxuIg0KPiA+ICsgICAgIiAgcmV0ICAgICAgICAgICAgICAgICAgICAgXG4iKQ0KPiA+ICsN
Cj4gDQo+IFRoaXMgYnJlYWtzIEJUSSBhcyBpdCBsYWNrcyB0aGUgbGFuZGluZyBwYWQsIGFuZCBp
dCB3aWxsIGJlIGNhbGxlZCBpbmRpcmVjdGx5Lg0KPiANCj4gPiArZXh0ZXJuIHZvaWQgX19zdGF0
aWNfY2FsbF9yZXQodm9pZCk7DQo+ID4gKw0KPiANCj4gQmV0dGVyIHRvIGhhdmUgYW4gb3JkaW5h
cnkgQyBmdW5jdGlvbiBoZXJlICh3aXRoIGNvbnNpc3RlbnQgbGlua2FnZSksDQo+IGJ1dCB3ZSBu
ZWVkIHRvIHRha2UgdGhlIGFkZHJlc3MgaW4gYSB3YXkgdGhhdCB3b3JrcyB3aXRoIENsYW5nIENG
SS4NCj4gDQo+IEFzIHRoZSB0d28gYWRkaXRpb25hbCBpbnN0cnVjdGlvbnMgYXJlIG9uIGFuIGlj
ZSBjb2xkIHBhdGggYW55d2F5LCBJJ20NCj4gbm90IHN1cmUgdGhpcyBpcyBhbiBvYnZpb3VzIGlt
cHJvdmVtZW50IHRiaC4NCg0KSWYgbXkgc3VtcyBhcmUgY29ycmVjdCB0aGUgY29kZSBibG9jayBp
cyBleGFjdGx5IDMyIGJ5dGVzLg0KU28gbm8gcG9pbnQgc2F2aW5nIGFuIGluc3RydWN0aW9uLg0K
QnV0IHlvdSBjb3VsZCBoYXZlOg0KCQkubG9uZyAxZg0KCWxhYmVsOg0KCQlidGkgIGMNCgkJbm9w
L2JyYW5jaA0KCQlsZHIgIHgxNiwgMGINCgkJYnIgICB4MTYNCgkxOiAgICBidGkgIGMNCgkJcmV0
DQoNClRoYXQgaXMgYWxsIHNlbGYtY29udGFpbmVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

