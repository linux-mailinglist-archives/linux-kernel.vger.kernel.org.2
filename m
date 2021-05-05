Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594F7373FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhEEQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:26:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51469 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233931AbhEEQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:26:45 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-13FH7VziP7ScG2ZTHadrWg-1; Wed, 05 May 2021 17:25:46 +0100
X-MC-Unique: 13FH7VziP7ScG2ZTHadrWg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 17:25:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 17:25:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>
CC:     Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: RE: Very slow clang kernel config ..
Thread-Topic: Very slow clang kernel config ..
Thread-Index: AQHXQS0DH46G91tEpEmd7WaoBDaEqarUt3wQgAAhgoCAABGacIAAE5MAgAASd3A=
Date:   Wed, 5 May 2021 16:25:45 +0000
Message-ID: <42fdc9f1b4b44136b4eeffa0957ebc3e@AcuMS.aculab.com>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
 <CANiq72=aK-JJhpnZdeeGBtADrnXhyEp1Whw5+5rK6a4u85PhxA@mail.gmail.com>
 <5256ed6b6f7d423daeb36fcbfc837fbc@AcuMS.aculab.com>
 <CANiq72mq-SP5n_0cVr+eaP19xqJTP15V+JKUeqLiT910x=3NdA@mail.gmail.com>
 <3ab89c4f8b1d455ba46781b392ef0b2d@AcuMS.aculab.com>
 <CANiq72kPx48wTKCfgohwb2CbAf=SG3gyhv3htd3n_17aGAq2FA@mail.gmail.com>
In-Reply-To: <CANiq72kPx48wTKCfgohwb2CbAf=SG3gyhv3htd3n_17aGAq2FA@mail.gmail.com>
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

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDA1IE1heSAyMDIxIDE3OjA3DQo+IA0KPiBPbiBX
ZWQsIE1heSA1LCAyMDIxIGF0IDQ6MTMgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBNYW55IHllYXJzIGFnbyB0aGUgY29tcGFueSBJIHdv
cmtlZCBmb3IgZm91bmQgdGhhdCB0aGUgdW5peCAndXRtcHgnDQo+ID4gZmlsZSB3YXMgZ2V0dGlu
ZyBjb3JydXB0ZWQgKGR1ZSB0byBpbmNvcnJlY3QgbG9ja2luZykuDQo+ID4gVGhlIGZ1bmN0aW9u
cyBoYWQgYmVlbiBwbGFjZXMgaW4gYW4gYXJjaGl2ZSBwYXJ0IG9mIGxpYmMgKGZvcg0KPiA+IHZh
cmlvdXMgcmVhc29ucykuDQo+ID4gR2V0dGluZyB0aGUgZml4IG9udG8gdGhlIGN1c3RvbWVycyBt
YWNoaW5lICh3ZSB3ZXJlIHRoZSBPUyB2ZW5kb3IpDQo+ID4gaW52b2x2ZWQgZGV0ZXJtaW5pbmcg
d2hpY2ggYXBwbGljYXRpb25zIGZyb20gM3JkICg0dGg/KSBwYXJ0aWVzDQo+ID4gaGFkIGJlZW4g
bGlua2VkIHdpdGggdGhlIGJyb2tlbiBjb2RlIGFuZCB0aGVuIGFwcGx5aW5nIGVub3VnaA0KPiA+
ICdnZW50bGUgcGVyc3Vhc2lvbicgdG8gZ2V0IHRoZW0gdG8gcmVsaW5rIHRoZSBvZmZlbmRpbmcg
cHJvZ3JhbXMuDQo+ID4gRXZlbiB0aGlzIGNhbiBiZSBwcm9ibGVtYXRpYyBiZWNhdXNlIHRoZSBz
b3VyY2UgY29udHJvbCBzeXN0ZW1zDQo+ID4gb2Ygc29tZSBjb21wYW5pZXMgaXNuJ3QgZ3JlYXQg
KGl0IGlzIHByb2JhYmx5IGJldHRlciB0aGVzZSBkYXlzKS4NCj4gPiBCdXQgZ2V0dGluZyB0aGUg
J3ByZXZpb3VzIHZlcnNpb24nIHJlYnVpbHQgd2l0aCBhIG5ldyBsaWJjLmENCj4gPiBjYW4gYmUg
dmVyeSBwcm9ibGVtYXRpYy4NCj4gDQo+IElmIHlvdSBhcmUgYSBsaWJyYXJ5IHZlbmRvciBhbmQg
eW91IHByb3ZpZGUgdGhlIGZpeGVkIGxpYnJhcnksIHRoZW4NCj4geW91IGFyZSBkb25lLiBJdCBp
cyB5b3VyIGN1c3RvbWVyJ3MgY2FsbCB0byByZWJ1aWxkIHRoZWlyIHNvZnR3YXJlIG9yDQo+IG5v
dDsgYW5kIHRoZXkgYXJlIHRoZSBvbmVzIGNob29zaW5nIHN0YXRpYyBsaW5raW5nIG9yIG5vdC4N
Cg0KQnV0IGl0IGlzIHRoZSBjdXN0b21lcidzIGN1c3RvbWVyIHdobyBjb21lcyBiYWNrIHRvIHlv
dSBzYXlpbmcNCnRoYXQgc29tZXRoaW5nIGluIHlvdXIgbGlicmFyeSBpcyBicm9rZW4uDQpUaGlz
IGlzIHdoZW4geW91IHJlYWxseSBkb24ndCB3aGF0IHN0YXRpYyBsaW5raW5nIC0gZXZlci4NCg0K
PiBTdXJlLCB5b3Ugd2FudCB0byBvZmZlciB0aGUgYmVzdCBzZXJ2aWNlIHRvIHlvdXIgY2xpZW50
cywgYW5kIHNvbWUNCj4gY3VzdG9tZXJzIHdpbGwgY2hvb3NlIHN0YXRpYyBsaW5raW5nIHdpdGhv
dXQgZnVsbHkgdW5kZXJzdGFuZGluZyB0aGUNCj4gcHJvcy9jb25zLCBidXQgeW91IGNhbm5vdCBk
byBhbnl0aGluZyBhZ2FpbnN0IHRoYXQuIEFuZCB5b3Ugc3RpbGwgbmVlZA0KPiB0byBwcm92aWRl
IHRoZSBzdGF0aWMgdmVyc2lvbiBmb3IgdGhvc2UgY2xpZW50cyB0aGF0IGtub3cgdGhleSBuZWVk
DQo+IGl0Lg0KPiANCj4gPiBObyBiZWNhdXNlIHRoZXJlIGFyZSBtZXNzYWdlcyBzZW50IHRvIHN5
c3RlbSBkYWVtb25zIGFuZCBmaWxlDQo+ID4gZm9ybWF0cyB0aGF0IGNhbiBiZSBzeXN0ZW0gZGVw
ZW5kYW50Lg0KPiA+IE5vdCBldmVyeXRoaW5nIGlzIGEgc3lzdGVtIGNhbGwuDQo+IA0KPiBUaGF0
IGlzIG9ydGhvZ29uYWwgdG8gc3RhdGljIGxpbmtpbmcgb3Igbm90LCB3aGljaCB3YXMgdGhlIHRv
cGljIGF0IGhhbmQuDQo+IA0KPiBXaGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dCBub3cgYXJlIGRl
cGVuZGVuY2llcyBvbiBleHRlcm5hbCBlbnRpdGllcw0KPiBhbmQgc2VydmljZXMuIFN0YXRpYyBs
aW5raW5nIGlzIG5vdCBiZXR0ZXIgbm9yIHdvcnNlIGp1c3QgYmVjYXVzZSB5b3UNCj4gZGVwZW5k
IG9uIGEgbG9jYWwgcHJvY2VzcywgYSBmaWxlLCBhIG5ldHdvcmtlZCBzZXJ2aWNlLCBhIHBhcnRp
Y3VsYXINCj4gcGllY2Ugb2YgaGFyZHdhcmUgYmVpbmcgcHJlc2VudCwgZXRjLg0KDQpTdGF0aWMg
bGlua2luZyBpcyBtdWNoIHdvcnNlIGJlY2F1c2UgZGlmZmVyZW50IHBhcnRzIG9mIHRoZSAnc3lz
dGVtJw0KYXJlIHByb3ZpZGVkIGJ5IGRpZmZlcmVudCBwZW9wbGUuDQpXaXRoIGEgbGl0dGxlIGNh
cmUgYSBDIHNoYXJlZCBsaWJyYXJ5IGNhbiBiZSBpbXBsZW1lbnRlZCBieSBkaWZmZXJlbnQNCmNv
bXBhbmllcyB3aGlsZSBzdGlsbCBtZWV0aW5nIHRoZSBzYW1lIEFCSS4NCg0KPiA+IFJlbWluZCBi
ZSB0byByZXF1ZXN0IG91ciBtYW5hZ2VtZW50IHRvIGxldCBtZSByZW1vdmUgYWxsIHRoZSBDKysN
Cj4gPiBmcm9tIG1vc3Qgb2Ygb3VyIHByb2dyYW1zLg0KPiANCj4gWWVhaCwgdGhlIHByb2JsZW0g
ZXhpc3RzIHNpbmNlIGJlZm9yZSAxOTk4IDopDQo+IA0KPiBBIHN0YWJsZSwgY29tbW9uIEMrKyBB
QkkgZXRjLiB3b3VsZCBoYXZlIGhhZCBzb21lIGFkdmFudGFnZXMsIGJ1dCBpdA0KPiBkaWQgbm90
IGhhcHBlbi4NCj4gDQo+ID4gTm9uZSBvZiB0aGVtIGFjdHVhbGx5IG5lZWQgaXQsIHRoZSByZWFz
b25zIGZvciBDKysgYXJlbid0IHRlY2huaWNhbC4NCj4gDQo+IFdlbGwsIG5vIHByb2dyYW0gIm5l
ZWRzIiBhbnkgcGFydGljdWxhciBsYW5ndWFnZSwgYnV0IHRoZXJlIGFyZQ0KPiBhZHZhbnRhZ2Vz
IGFuZCBkaXNhZHZhbnRhZ2VzIG9mIHVzaW5nIGxhbmd1YWdlcyB3aXRoIG1vcmUgZmVhdHVyZXMN
Cj4gKGFuZCBtb3JlIGNvbXBsZXhpdHksIHRvbykuIEl0IGlzIGEgYmFsYW5jZS4NCg0KSXQgdGhp
cyBjYXNlIGl0IHdhcyBkb25lIHRvIGdpdmUgdGhlIHNvZnR3YXJlIGVuZ2luZWVycyBzb21lDQpl
eHBlcmllbmNlIG9mIHdyaXRpbmcgQysrLg0KVGVjaG5pY2FsbHkgaXQgd2FzIGEgYmlnIG1pc3Rh
a2UuDQoNCkJhZCBDKysgaXMgYWxzbyBpbmZpbml0ZWx5IHdvcnNlIHRoYXQgYmFkIEMuDQpFeGNl
cHRpb24gaGFuZGxpbmcgKHdoaWNoIHlvdSBtaWdodCB0aGluayBvZiBhcyBhIGdhaW4pDQppcyB2
ZXJ5IGVhc3kgdG8gZ2V0IGJhZGx5IHdyb25nLg0KQ2xhc3MgbWVtYmVyIG92ZXJsb2FkcyBtYWtl
IGl0IGltcG9zc2libGUgdG8gd29yayBvdXQgd2hlcmUgZGF0YSBpcyB1c2VkLg0KRnVuY3Rpb24g
b3ZlcmxvYWRzIGFyZSBzb21ldGltZXMgbmljZSAtIGJ1dCB1bm5lY2Vzc2FyeS4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

