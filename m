Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00000370924
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEAV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 17:59:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28269 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhEAV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 17:59:50 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-219-XitVAh9wO_qslDbvJLjheA-1; Sat, 01 May 2021 22:58:56 +0100
X-MC-Unique: XitVAh9wO_qslDbvJLjheA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 1 May 2021 22:58:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 1 May 2021 22:58:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: RE: Very slow clang kernel config ..
Thread-Topic: Very slow clang kernel config ..
Thread-Index: AQHXPqegH46G91tEpEmd7WaoBDaEqarPJ2lw
Date:   Sat, 1 May 2021 21:58:55 +0000
Message-ID: <4b77489c05f6459ead7233c3fb69f61e@AcuMS.aculab.com>
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
In-Reply-To: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDEgTWF5IDIwMjEgMTc6MzINCj4gDQo+IE9u
IEZyaSwgQXByIDMwLCAyMDIxIGF0IDg6MzMgUE0gVG9tIFN0ZWxsYXJkIDx0c3RlbGxhckByZWRo
YXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFllcywgaXQncyBpbnRlbnRpb25hbC4gIER5bmFtaWMg
bGlua2luZyBsaWJyYXJpZXMgZnJvbSBvdGhlciBwYWNrYWdlcyBpcw0KPiA+IHRoZSBGZWRvcmEg
cG9saWN5WzFdLCBhbmQgY2xhbmcgYW5kIGxsdm0gYXJlIHNlcGFyYXRlIHBhY2thZ2VzIChpbiBG
ZWRvcmEpLg0KPiANCj4gU2lkZSBub3RlOiBJIHJlYWxseSB3aXNoIEZlZG9yYSBzdG9wcGVkIGRv
aW5nIHRoYXQuDQo+IA0KPiBTaGFyZWQgbGlicmFyaWVzIGFyZSBub3QgYSBnb29kIHRoaW5nIGlu
IGdlbmVyYWwuIFRoZXkgYWRkIGEgbG90IG9mDQo+IG92ZXJoZWFkIGluIHRoaXMgY2FzZSwgYnV0
IG1vcmUgaW1wb3J0YW50bHkgdGhleSBhbHNvIGFkZCBsb3RzIG9mDQo+IHVubmVjZXNzYXJ5IGRl
cGVuZGVuY2llcyBhbmQgY29tcGxleGl0eSwgYW5kIGFsbW9zdCBubyBzaGFyZWQNCj4gbGlicmFy
aWVzIGFyZSBhY3R1YWxseSB2ZXJzaW9uLXNhZmUsIHNvIGl0IGFkZHMgYWJzb2x1dGVseSB6ZXJv
DQo+IHVwc2lkZS4NCg0KSXQncyAnc3dpbmdzIGFuZCByb3VuZGFib3V0cycuLi4NCg0KSSB1c2Vk
IGEgc3lzdGVtIHdoZXJlIHRoZSBsaWJjLnNvIHRoZSBsaW5rZXIgZm91bmQgd2FzIGFjdHVhbGx5
DQphbiBhcmNoaXZlIGxpYnJhcnksIG9uZSBtZW1iZXIgYmVpbmcgbGliYy5zby4xLg0KVGhlIGZ1
bmN0aW9uIHRoYXQgdXBkYXRlZCB1dG1wIGFuZCB1dG1weCAobGFzdCBsb2dpbiBkZXRhaWxzKQ0K
d2FzIGluIHRoZSBhcmNoaXZlIHBhcnQuDQpUaGlzIGNvZGUgaGFkIGluY29ycmVjdCBsb2NraW5n
IGFuZCBjb3JydXB0ZWQgdGhlIGZpbGVzLg0KV2hpbGUgdGhlIGZpeCB3YXMgZWFzeSwgZ2V0dGlu
ZyBpbiAnaW5zdGFsbGVkJyB3YXNuJ3QgYmVjYXVzZSBhbGwNCnRoZSBwcm9ncmFtcyB0aGF0IHVz
ZWQgaXQgbmVlZGVkIHRvIGJlIHJlbGlua2VkIC0gaGFyZCB3aGVuIHNvbWUNCndoZXJlIHByb3Zp
ZGVkIGFzIGNvbW1lcmNpYWwgYmluYXJpZXMgYnkgM3JkIHBhcnRpZXMuDQoNCkkndmUgYWxzbyBk
b25lIHNvbWUgZXhwZXJpbWVudHMgd2l0aCB0aGUgbW96aWxsYSB3ZWIgYnJvd3Nlci4NClRoaXMg
bG9hZGVkIGFib3V0IDMwIGxpYnJhcmllcyBhdCBwcm9ncmFtIHN0YXJ0dXAuDQpUaGUgZWxmIHN5
bWJvbCBoYXNoaW5nIHJ1bGVzIGRvbid0IGhlbHAgYXQgYWxsIQ0KRXZlcnkgc3ltYm9sIGdldHMg
bG9va2VkIGZvciBpbiBldmVyeSBsaWJyYXJ5IChvZnRlbiBjaGVja2luZw0KZm9yIGEgbm9uLXdl
YWsgc3ltYm9sIGhhdmluZyBmb3VuZCBhIHdlYWsgZGVmaW5pdGlvbikuDQpTbyB0aGUgaGFzaCBv
ZiB0aGUgc3ltYm9sIGlzIGNhbGN1bGF0ZWQuDQpJdCBpcyByZW1haW5kZXJlZCBieSB0aGUgaGFz
aCB0YWJsZSBzaXplIGFuZCB0aGUgbGlua2VkIGxpc3Qgc2Nhbm5lZC4NCk5vdyB0aGUgaGFzaCB0
YWJsZSBzaXplIGlzIHRoZSBwcmltZSBiZWxvdyB0aGUgcG93ZXIgb2YgMiBiZWxvdw0KdGhlIG51
bWJlciBvZiBzeW1ib2xzICh3ZWxsIHdhcyB3aGVuIEkgZGlkIHRoaXMpLg0KU28gdGhlIGF2ZXJh
Z2UgaGFzaCBjaGFpbiBoYXMgYWJvdXQgMS41IGVudHJpZXMuDQpXaXRoIDMwIGxpYnJhcmllcyB0
aGlzIGlzIH40NSBzdHJpbmcgY29tcGFyZXMuDQpJZiBhbGwgdGhlIHN0cmluZ3Mgc3RhcnQgd2l0
aCBzaW1pbGFyIHN0cmluZ3MgKEMrK2NsYXNzZXMpDQp0aGVuIHRoZSBzdHJjbXAoKSBhcmUgcXVp
dGUgbG9uZy4NCg0KSSBwbGF5ZWQgYXJvdW5kIHdpdGggdGhlIGhhc2ggdGFibGUgc2l6ZS4NCkl0
IHJlYWxseSBkaWRuJ3QgbWF0dGVyIHdoZXRoZXIgaXQgd2FzIGEgcHJpbWUgb3Igbm90Lg0KRm9y
IGxpYmMgdGhlIGRpc3RyaWJ1dGlvbiB3YXMgYWx3YXlzIGhvcnJpZCAtIHdpdGggc29tZQ0KcXVp
dGUgbG9uZyBoYXNoIGNoYWlucy4NCk1ha2luZyB0aGUgaGFzaCB0YWJsZSBsYXJnZXIgdGhhbiB0
aGUgbnVtYmVyIG9mIHN5bWJvbHMNCihwZXJoYXBzIDIgcG93ZXJzIG9mIDIgYWJvdmUpIHdvdWxk
IGJlIG1vcmUgbGlrZWx5IHRvDQptYWtlIHRoZSBoYXNoIGhpdCBhbiBlbXB0eSBsaXN0IC0gYW5k
IHNraXAgYWxsIHRoZSBzdHJjbXAoKS4NCg0KVGhlIG90aGVyICd0cmljaycgd2FzIGEgcmV3cml0
ZSBvZiB0aGUgZHluYW1pYyBsb2FkZXIgdG8NCmdlbmVyYXRlIGEgc2luZ2xlIHN5bWJvbCB0YWJs
ZSB0aGF0IGNvbnRhaW5lZCBhbGwgdGhlIHN5bWJvbHMNCm9mIGFsbCB0aGUgbGlicmFyaWVzIGxv
YWRlZCBhdCBwcm9ncmFtIHN0YXJ0dXAuDQpQcm9jZXNzIHRoZSBsaWJyYXJpZXMgaW4gdGhlIHJp
Z2h0IG9yZGVyIGFuZCB0aGlzIGlzIGVhc3kuDQpUaGF0IG1hZGUgYSBjb25zaWRlcmFibGUgaW1w
cm92ZW1lbnQgdG8gcHJvZ3JhbSBzdGFydHVwLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

