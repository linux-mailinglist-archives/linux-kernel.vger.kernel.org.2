Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA31370B58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhEBLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 07:36:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34379 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhEBLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 07:36:14 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-220-8YP8zTAbMZCNW5G_cyVtLA-1; Sun, 02 May 2021 12:35:20 +0100
X-MC-Unique: 8YP8zTAbMZCNW5G_cyVtLA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sun, 2 May 2021 12:35:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sun, 2 May 2021 12:35:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Bunk' <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: RE: Very slow clang kernel config ..
Thread-Topic: Very slow clang kernel config ..
Thread-Index: AQHXPzXqH46G91tEpEmd7WaoBDaEqarQCO0Q
Date:   Sun, 2 May 2021 11:35:19 +0000
Message-ID: <0eba31ea508f4ec491f56e3b8c85fb6c@AcuMS.aculab.com>
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
In-Reply-To: <20210502093123.GC12293@localhost>
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

RnJvbTogQWRyaWFuIEJ1bmsNCj4gU2VudDogMDIgTWF5IDIwMjEgMTA6MzENCj4gDQo+IE9uIFNh
dCwgTWF5IDAxLCAyMDIxIGF0IDA5OjMyOjI1QU0gLTA3MDAsIExpbnVzIFRvcnZhbGRzIHdyb3Rl
Og0KPiA+Li4uDQo+ID4gWWVzLCBpdCBjYW4gc2F2ZSBvbiBkaXNrIHVzZSwgYnV0IHVubGVzcyBp
dCdzIHNvbWUgdmVyeSBjb3JlIGxpYnJhcnkNCj4gPiB1c2VkIGJ5IGEgbG90IG9mIHRoaW5ncyAo
aWUgcGFydGljdWxhcmx5IHRoaW5ncyBsaWtlIEdVSSBsaWJyYXJpZXMNCj4gPiBsaWtlIGdub21l
IG9yIFF0IG9yIHNpbWlsYXIpLCB0aGUgZGlzayBzYXZpbmdzIGFyZSBvZnRlbiBub3QgYWxsIHRo
YXQNCj4gPiBiaWcgLSBhbmQgZGlzayBpcyBjaGVhcC4gQW5kIHRoZSBtZW1vcnkgc2F2aW5ncyBh
cmUgb2Z0ZW4gYWN0dWFsbHkNCj4gPiBuZWdhdGl2ZSAoYWdhaW4sIHVubGVzcyBpdCdzIHNvbWUg
YmlnIGxpYnJhcnkgdGhhdCBpcyB0eXBpY2FsbHkgdXNlZA0KPiA+IGJ5IGxvdHMgb2YgZGlmZmVy
ZW50IHByb2dyYW1zIGF0IHRoZSBzYW1lIHRpbWUpLg0KPiA+Li4uDQo+ID4gSSB0aGluayBwZW9w
bGUgaGF2ZSB0aGlzIGluY29ycmVjdCBwaWN0dXJlIHRoYXQgInNoYXJlZCBsaWJyYXJpZXMgYXJl
DQo+ID4gaW5oZXJlbnRseSBnb29kIi4gVGhleSByZWFsbHkgcmVhbGx5IGFyZW4ndC4gVGhleSBj
YXVzZSBhIGxvdCBvZg0KPiA+IHByb2JsZW1zLCBhbmQgdGhlIGFkdmFudGFnZSByZWFsbHkgc2hv
dWxkIGFsd2F5cyBiZSB3ZWlnaGVkIGFnYWluc3QNCj4gPiB0aG9zZSAoYmlnKSBkaXNhZHZhbnRh
Z2VzLg0KPiA+Li4uDQo+IA0KPiBEaXNrIGFuZCBtZW1vcnkgdXNhZ2UgaXMgbm90IHRoZSBiaWdn
ZXN0IGFkdmFudGFnZS4NCj4gDQo+IFRoZSBiaWdnZXN0IGFkdmFudGFnZSBvZiBzaGFyZWQgbGli
cmFyaWVzIGlzIHRoYXQgdGhleSBlbmFibGUNCj4gZGlzdHJpYnV0aW9ucyB0byBwcm92aWRlIHNl
Y3VyaXR5IGZpeGVzLg0KPiANCj4gRGlzdHJpYnV0aW9ucyB0cnkgaGFyZCB0byBoYXZlIG9ubHkg
b25lIHBsYWNlIHRvIHBhdGNoIGFuZCBvbmUgcGFja2FnZQ0KPiB0byByZWJ1aWxkIHdoZW4gYSBD
VkUgaGFzIHRvIGJlIGZpeGVkLg0KPiANCj4gSXQgaXMgbm90IGZlYXNpYmxlIHRvIHJlYnVpbGQg
YWxsIHVzZXJzIG9mIGEgbGlicmFyeSBpbiBhDQo+IGRpc3RyaWJ1dGlvbiBldmVyeSB0aW1lIGEg
Q1ZFIGdldHMgcHVibGlzaGVkIGZvciBhIGxpYnJhcnkuDQoNCkFic29sdXRlbHkuDQpZb3UnZCBh
bHNvIG5lZWQgdG8gcmVidWlsZCBldmVyeSBhcHBsaWNhdGlvbiB0aGF0IG1pZ2h0IGluY2x1ZGUN
CnRoZSBzdGF0aWMgdmVyc2lvbiBvZiB0aGUgYnJva2VuIGZ1bmN0aW9uLg0KR29vZCBsdWNrIGZp
bmRpbmcgYWxsIHRob3NlIG9uIGEgYmlnIGluc3RhbGwuDQoNCk9UT0gganVzdCBzcGxpdHRpbmcg
YSBjb21waWxlciBpbnRvIG11bHRpcGxlIHNoYXJlZCBvYmplY3RzDQp0aGF0IGhhdmUgbm8gb3Ro
ZXIgdXNlIGlzLCBhcyBMaW51cyBzYWlkLCBzdHVwaWQuDQoNCkJ1aWxkaW5nIHNoYXJlZCBsaWJy
YXJpZXMgcmVxdWlyZXMgdGhlIHNhbWUgY29udHJvbCBhcyBidWlsZGluZw0KdGhlIGtlcm5lbC4N
ClRoZSB1c2VyIGludGVyZmFjZSBtdXN0bid0IGNoYW5nZS4NCllvdSBjYW4gYWRkIG5ldyBmdW5j
dGlvbnMsIGJ1dCBub3QgY2hhbmdlIGFueSBleGlzdGluZyBvbmVzLg0KVGhpcyBpcyBlYXN5IGlu
IEMsIGRpZmZpY3VsdCBpbiBDKysuDQoNClNpbmNlIFBMVCBsb29rdXBzIGNhbiBvbmx5IGhhbmRs
ZSBjb2RlLCB5b3UgcmVhbGx5IGRvbid0IHdhbnQNCmRhdGEgYXJlYXMgc2hhcmVkIGJldHdlZW4g
dGhlIHByb2dyYW0gYW5kIGxpYnJhcnkuDQpJZiB0aGUgc2l6ZSBldmVyIGNoYW5nZXMgJ2hvcnJp
ZCB0aGluZ3MgKHRtKScgaGFwcGVuLg0KDQpXZSBjb21waWxlIGFueSBzaGFyZWQgbGlicmFyaWVz
IHdpdGggLWZ2aXNpYmlsaXR5PWhpZGRlbiBhbmQNCm1hcmsgYW55IGVudHJ5IHBvaW50cyB3aXRo
IF9fYXR0cmlidXRlX18oKHZpc2liaWxpdHkoInByb3RlY3RlZCIpKSkuDQpUaGlzIG1lYW5zIHRo
YXQgY2FsbHMgd2l0aCBhIGxpYnJhcnkgYXJlIHNpbXBsZSBQQy1yZWxhdGl2ZQ0KYW5kIG9ubHkg
dGhlIGVudHJ5IHBvaW50cyBhcmUgdmlzaWJsZSBvdXRzaWRlLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

