Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048A4460900
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 19:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348438AbhK1SgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 13:36:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54030 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233918AbhK1SeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:34:02 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-16-RFD_4oL2MP-91mgmicYPEg-1; Sun, 28 Nov 2021 18:30:41 +0000
X-MC-Unique: RFD_4oL2MP-91mgmicYPEg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sun, 28 Nov 2021 18:30:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sun, 28 Nov 2021 18:30:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>
CC:     Eric Dumazet <edumazet@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        X86 ML <x86@kernel.org>
Subject: RE: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Thread-Topic: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Thread-Index: AQHX4bFY91qWVfGwmUGWCXjqsQaln6wWDW5QgAAQxICAAEM4IIAADxYAgALQJQA=
Date:   Sun, 28 Nov 2021 18:30:40 +0000
Message-ID: <670c2043e9104d6c8d516cc54edef38e@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
 <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
 <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
 <CAFUsyfJmpFFzuMhHrH+oBVzcHggW0QZM9dvXtPQW88kAw_2_BQ@mail.gmail.com>
In-Reply-To: <CAFUsyfJmpFFzuMhHrH+oBVzcHggW0QZM9dvXtPQW88kAw_2_BQ@mail.gmail.com>
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

RnJvbTogTm9haCBHb2xkc3RlaW4NCj4gU2VudDogMjYgTm92ZW1iZXIgMjAyMSAyMzowNA0KPiAN
Cj4gT24gRnJpLCBOb3YgMjYsIDIwMjEgYXQgNDo0MSBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEVyaWMgRHVtYXpldA0KPiA+
ID4gU2VudDogMjYgTm92ZW1iZXIgMjAyMSAxODoxMA0KPiA+IC4uLg0KPiA+ID4gPiBBRkFJQ1Qg
KGZyb20gYSBwZGYpIGJzd2FwMzIoKSBhbmQgcm9yKHgsIDgpIGFyZSBsaWtlbHkgdG8gYmUNCj4g
PiA+ID4gdGhlIHNhbWUgc3BlZWQgYnV0IG1heSB1c2UgZGlmZmVyZW50IGV4ZWN1dGlvbiB1bml0
cy4NCj4gPg0KPiA+IFRoZSA2NGJpdCBzaGlmdHMvcm90YXRlcyBhcmUgYWxzbyBvbmx5IG9uZSBj
bG9jay4NCj4gPiBJdCBpcyB0aGUgYnN3YXA2NCB0aGF0IGNhbiBiZSB0d28uDQo+ID4NCj4gPiA+
ID4gSW50ZWwgc2VlbSBzbyBoYXZlIG1hbmFnZWQgdG8gc2xvdyBkb3duIHJvcih4LCAlY2wpIHRv
IDMgY2xvY2tzDQo+ID4gPiA+IGluIHNhbmR5IGJyaWRnZSAtIGFuZCBzdGlsbCBub3QgZml4ZWQg
aXQuDQo+ID4gPiA+IEFsdGhvdWdoIHRoZSBjb21waWxlciBtaWdodCBiZSBtYWtpbmcgYSBwaWdz
LWJyZWFrZmFzdCBvZiB0aGUNCj4gPiA+ID4gcmVnaXN0ZXIgYWxsb2NhdGlvbiB3aGVuIHlvdSB0
cmllZCBzZXR0aW5nICdvZGQgPSA4Jy4NCj4gPiA+ID4NCj4gPiA+ID4gV2Vla3MgY2FuIGJlIHNw
ZW50IGZpZGRsaW5nIHdpdGggdGhpcyBjb2RlIDotKA0KPiA+ID4NCj4gPiA+IFllcywgYW5kIGlu
IHRoZSBlbmQsIGl0IHdvbid0IGJlIGFibGUgdG8gY29tcGV0ZSB3aXRoICBhDQo+ID4gPiBzcGVj
aWFsaXplZC9pbmxpbmVkIGlwdjZfY3N1bV9wYXJ0aWFsKCkNCj4gPg0KPiA+IEkgYmV0IG1vc3Qg
b2YgdGhlIGdhaW4gY29tZXMgZnJvbSBrbm93aW5nIHRoZXJlIGlzIGEgbm9uLXplcm8NCj4gPiB3
aG9sZSBudW1iZXIgb2YgMzJiaXQgd29yZHMuDQo+ID4gVGhlIHBlc2t5IGVkZ2UgY29uZGl0aW9u
cyBjb3N0Lg0KPiA+DQo+ID4gQW5kIGV2ZW4gdGhlbiB5b3UgbmVlZCB0byBnZXQgaXQgcmlnaHQh
DQo+ID4gVGhlIG9uZSBmb3Igc3VtbWluZyB0aGUgNS13b3JkIElQdjQgaGVhZGVyIGlzIGFjdHVh
bGx5IGhvcnJpZA0KPiA+IG9uIEludGVsIGNwdSBwcmlvciB0byBIYXN3ZWxsIGJlY2F1c2UgJ2Fk
YycgaGFzIGEgbGF0ZW5jeSBvZiAyLg0KPiA+IE9uIFNhbmR5IGJyaWRnZSB0aGUgY2Fycnkgb3V0
cHV0IGlzIHZhbGlkIG9uIHRoZSBuZXh0IGNsb2NrLA0KPiA+IHNvIGFkZGluZyB0byBhbHRlcm5h
dGUgcmVnaXN0ZXJzIGRvdWJsZXMgdGhyb3VnaHB1dC4NCj4gPiAoVGhhdCBjb3VsZCBlYXNpbHkg
YmUgZG9uZSBpbiB0aGUgY3VycmVudCBmdW5jdGlvbiBhbmQgd2lsbA0KPiA+IG1ha2UgYSBiaWcg
ZGlmZmVyZW50IG9uIHRob3NlIGNwdS4pDQo+ID4NCj4gPiBCdXQgYmFzaWNhbGx5IHRoZSBjdXJy
ZW50IGdlbmVyaWMgY29kZSBoYXMgdGhlIGxvb3AgdW5yb2xsZWQNCj4gPiBmdXJ0aGVyIHRoYW4g
aXMgbmVjZXNzYXJ5IGZvciBtb2Rlcm4gKG5vbi1hdG9tKSBjcHUuDQo+ID4gVGhhdCBqdXN0IGFk
ZHMgbW9yZSBjb2RlIG91dHNpZGUgdGhlIGxvb3AuDQo+ID4NCj4gPiBJIGRpZCBtYW5hZ2VkIHRv
IGdldCAxMiBieXRlcy9jbG9jayB1c2luZyBhZGNvL2Fkb3ggd2l0aCBvbmx5DQo+ID4gMzIgYnl0
ZXMgZWFjaCBpdGVyYXRpb24uDQo+ID4gVGhhdCB3aWxsIHJlcXVpcmUgYWxpZ25lZCBidWZmZXJz
Lg0KPiA+DQo+ID4gQWxpZ25tZW50IHdvbid0IG1hdHRlciBmb3IgJ2FkYycgbG9vcHMgYmVjYXVz
ZSB0aGVyZSBhcmUgdHdvDQo+ID4gJ21lbW9yeSByZWFkJyB1bml0cyAtIGJ1dCB0aGVyZSBpcyB0
aGUgZWxlcGhhbnQ6DQo+ID4NCj4gPiBTYW5keSBicmlkZ2UgQ2FjaGUgYmFuayBjb25mbGljdHMN
Cj4gPiBFYWNoIGNvbnNlY3V0aXZlIDEyOCBieXRlcywgb3IgdHdvIGNhY2hlIGxpbmVzLCBpbiB0
aGUgZGF0YSBjYWNoZSBpcyBkaXZpZGVkDQo+ID4gaW50byA4IGJhbmtzIG9mIDE2IGJ5dGVzIGVh
Y2guIEl0IGlzIG5vdCBwb3NzaWJsZSB0byBkbyB0d28gbWVtb3J5IHJlYWRzIGluDQo+ID4gdGhl
IHNhbWUgY2xvY2sgY3ljbGUgaWYgdGhlIHR3byBtZW1vcnkgYWRkcmVzc2VzIGhhdmUgdGhlIHNh
bWUgYmFuayBudW1iZXIsDQo+ID4gaS5lLiBpZiBiaXQgNCAtIDYgaW4gdGhlIHR3byBhZGRyZXNz
ZXMgYXJlIHRoZSBzYW1lLg0KPiA+ICAgICAgICAgOyBFeGFtcGxlIDkuNS4gU2FuZHkgYnJpZGdl
IGNhY2hlIGJhbmsgY29uZmxpY3QNCj4gPiAgICAgICAgIG1vdiBlYXgsIFtyc2ldIDsgVXNlIGJh
bmsgMCwgYXNzdW1pbmcgcnNpIGlzIGRpdmlzaWJsZSBieSA0MEgNCj4gPiAgICAgICAgIG1vdiBl
YngsIFtyc2krMTAwSF0gOyBVc2UgYmFuayAwLiBDYWNoZSBiYW5rIGNvbmZsaWN0DQo+ID4gICAg
ICAgICBtb3YgZWN4LCBbcnNpKzExMEhdIDsgVXNlIGJhbmsgMS4gTm8gY2FjaGUgYmFuayBjb25m
bGljdA0KPiA+DQo+ID4gVGhhdCBpc24ndCBhIHByb2JsZW0gb24gSGFzd2VsbCwgYnV0IGl0IGlz
IHByb2JhYmx5IHdvcnRoIG9yZGVyaW5nDQo+ID4gdGhlICdhZGMnIGluIHRoZSBsb29wIHRvIHJl
ZHVjZSB0aGUgbnVtYmVyIG9mIGNvbmZsaWN0cy4NCj4gPiBJIGRpZG4ndCB0cnkgdG8gbG9vayBm
b3IgdGhhdCB0aG91Z2guDQo+ID4gSSBvbmx5IHJlbWVtYmVyIHRlc3RpbmcgYWxpZ25lZCBidWZm
ZXJzIG9uIFNhbmR5L0l2eSBicmlkZ2UuDQo+ID4gQWRkaW5nIHRvIGFsdGVybmF0ZSByZWdpc3Rl
cnMgaGVscGVkIG5vIGVuZC4NCj4gDQo+IENhbnQgdGhhdCBqdXN0IGJlIHNvbHZlZCBieSBoYXZp
bmcgdGhlIHR3byBpbmRlcGVuZGVudCBhZGN4L2Fkb3ggY2hhaW5zIHdvcmsNCj4gZnJvbSByZWdp
b24gdGhhdCBhcmUgMTYrIGJ5dGVzIGFwYXJ0PyBGb3IgNDAgYnl0ZSBpcHY2IGhlYWRlciBpdCB3
aWxsIGJlIHNpbXBsZS4NCg0KTm90IHJlbGV2YW50LCBhZGN4L2Fkb3ggYXJlIG9ubHkgc3VwcG9y
dGVkIGhhc3dlbGwvYnJvYWR3ZWxsIG9ud2FyZHMNCndoaWNoIGRvbid0IGhhdmUgdGhlICdjYWNo
ZSBiYW5rIGNvbmZsaWN0JyBpc3N1ZS4NCg0KSW4gYW55IGNhc2UgdXNpbmcgYWR4W29jXSBmb3Ig
b25seSA0MCBieXRlcyBpc24ndCB3b3J0aCB0aGUgZWZmb3J0Lg0KDQpUaGUgb3RoZXIgaXNzdWUg
d2l0aCBhZGN4L2Fkb2MgaXMgdGhhdCBzb21lIGNwdSB0aGF0IHN1cHBvcnQgdGhlbQ0KaGF2ZSB2
ZXJ5IHNsb3cgZGVjb2RlIHRpbWVzIC0gc28gdW5sZXNzIHlvdScgZ290IHRoZW0gaW4gYSBsb29w
DQppdCB3aWxsIGJlIGhvcnJpZC4NClRyeWluZyB0byAnbG9vcCBjYXJyeScgYm90aCB0aGUgJ2Nh
cnJ5JyBhbmQgJ292ZXJmbG93JyBmbGFncyBpcyBhbHNvDQpmcmF1Z2h0LiBUaGUgJ2xvb3AnIGlu
c3RydWN0aW9uIHdvdWxkIGRvIGl0IC0gYnV0IHRoYXQgaXMgaG9ycmlibHkNCnNsb3cgb24gSW50
ZWwgY3B1IChJIHRoaW5rIGl0IGlzIG9rIGFuIEFNRCBvbmVzKS4NCllvdSBjYW4gdXNlIGpjeHog
YXQgdGhlIHRvcCBvZiB0aGUgbG9vcCBhbmQgYW4gdW5jb25kaXRpb25hbCBqdW1wIGF0IHRoZSBi
b3R0b20uDQpUaGVyZSBtaWdodCBiZSBhbiBvYnNjdXJlIG1ldGhvZCBvZiBkb2luZyBhIDY0Yml0
LT4zMmJpdCBtb3ZlIGludG8gJXJlY3gNCmFuZCB0aGVuIGEganJjeHogYXQgdGhlIGxvb3AgYm90
dG9tIQ0KDQpGb3IgSXZ5L1NhbmR5IGJyaWRnZSBpdCBpcyBub3RlZDoNClRoZXJlIGlzIGhhcmRs
eSBhbnkgcGVuYWx0eSBmb3IgbWlzYWxpZ25lZCBtZW1vcnkgYWNjZXNzIHdpdGggb3BlcmFuZCBz
aXplcw0Kb2YgNjQgYml0cyBvciBsZXNzLCBleGNlcHQgZm9yIHRoZSBlZmZlY3Qgb2YgdXNpbmcg
bXVsdGlwbGUgY2FjaGUgYmFua3MuDQoNClRoYXQgbWlnaHQgbWVhbiB0aGF0IHlvdSBjYW4gZG8g
YSBtaXNhbGlnbmVkIHJlYWQgZXZlcnkgY2xvY2suDQpXaXRoIHRoZSBvbmx5IGlzc3VlcyBhcmlz
aW5nIGZvciB0aGF0IHRoYXQgaXMgdHJ5aW5nIHRvIGRvIDIgcmVhZHMvY2xvY2suDQpHaXZlbiB0
aGUgY2hlY2tzdW0gY29kZSBuZWVkcyB0byBkbyAnYWRjJywgdGhlIGNhcnJ5IGZsYWcgY29uc3Ry
YWlucw0KeW91IHRvIDEgcmVhZC9jbG9jayAtIHNvIHRoZXJlIG1heSBhY3R1YWxseSBiZSBubyBy
ZWFsIHBlbmFsdHkgZm9yDQphIG1pc2FsaWduZWQgYnVmZmVyIGF0IGFsbC4NCg0KTm8gb25lIChl
eGNlcHQgbWUpIGhhcyBhY3R1YWxseSBub3RpY2VkIHRoYXQgdGhlIGFkYyBjaGFpbiB0YWtlcyB0
d28NCmNsb2NrcyBwZXIgYWRjIG9uIHNhbmR5IGJyaWRnZSwgc28gaWYgdGhlIG1pc2FsaWduZWQg
bWVtb3J5IHJlYWRzDQp0YWtlIHR3byBjbG9ja3MgaXQgbWFrZXMgbm8gZGlmZmVyZW5jZS4NCg0K
KGluZm8gZnJvbSBwZGYncyBmcm9tIHd3dy5hZ25lci5vcmcvb3B0aW1pemUpDQoNCkkndmUgbm90
IGdvdCB0aGUgdGVzdCBzeXN0ZW1zIGFuZCBwcm9ncmFtIEkgdXNlZCBiYWNrIGluIE1heSAyMDIw
DQp0byBoYW5kIGFueSBtb3JlLg0KDQpJIGNlcnRhaW5seSBmb3VuZCB0aGF0IGVmZmljaWVudGx5
IGhhbmRsaW5nIHRoZSAnb2RkIDcgYnl0ZXMnDQp3YXMgYWN0dWFsbHkgbW9yZSBkaWZmaWN1bHQg
dGhhbiBpdCBtaWdodCBzZWVtLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

