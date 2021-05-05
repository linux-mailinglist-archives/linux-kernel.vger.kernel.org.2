Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE15D3738FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhEELHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 07:07:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48505 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232256AbhEELG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 07:06:58 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-89-jmuEs67kPHax_weughYq5A-1; Wed, 05 May 2021 12:05:59 +0100
X-MC-Unique: jmuEs67kPHax_weughYq5A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 12:05:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 12:05:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>,
        Adrian Bunk <bunk@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: RE: Very slow clang kernel config ..
Thread-Topic: Very slow clang kernel config ..
Thread-Index: AQHXQS0DH46G91tEpEmd7WaoBDaEqarUt3wQ
Date:   Wed, 5 May 2021 11:05:58 +0000
Message-ID: <5256ed6b6f7d423daeb36fcbfc837fbc@AcuMS.aculab.com>
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
In-Reply-To: <CANiq72=aK-JJhpnZdeeGBtADrnXhyEp1Whw5+5rK6a4u85PhxA@mail.gmail.com>
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

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDA0IE1heSAyMDIxIDIyOjMzDQouLi4NCj4gPiBX
aGF0IGhhcHBlbnMgaWYgeW91IHVzZSBhIHByb2dyYW0gcHJvdmlkZWQgYnkgeW91ciBkaXN0cmli
dXRpb24gdGhhdCBpcw0KPiA+IHdyaXR0ZW4gaW4gUnVzdCBhbmQgaGFuZGxlcyB1bnRydXN0ZWQg
aW5wdXQgaW4gYSB3YXkgdGhhdCBpdCBtaWdodCBiZQ0KPiA+IHZ1bG5lcmFibGUgdG8gZXhwbG9p
dHMgYmFzZWQgb24gb25lIG9mIHRoZXNlIENWRXM/DQo+ID4NCj4gPiBUaGUgcHJvZ3JhbSBoYXMg
YSBrbm93biB2dWxuZXJhYmlsaXR5IHRoYXQgd2lsbCBsaWtlbHkgc3RheSB1bmZpeGVkLg0KPiAN
Cj4gV2h5PyBJIGZhaWwgdG8gc2VlIHdoYXQgaXMgdGhlIGlzc3VlIHJlYnVpbGRpbmcgKG9yIHJl
bGlua2luZykgYWxsDQo+IHBhY2thZ2VzIGV4Y2VwdCBkaXN0cmlidXRpb25zIGxhY2tpbmcgZW5v
dWdoIGNvbXB1dGUgcmVzb3VyY2VzLg0KDQpUaGUgcHJvYmxlbSBpc24ndCB0aGUgcGFja2FnZXMg
dGhhdCBjb21lIHdpdGggdGhlIGRpc3RyaWJ1dGlvbi4NCg0KVGhlIHByb2JsZW0gaXMgM3JkIHBh
cnR5IHByb2dyYW1zIHN1cHBsaWVkIGFzIGJpbmFyaWVzLg0KVGhleSBoYXZlIDIgYmlnIHJlcXVp
cmVtZW50czoNCjEpIFRoZSBzYW1lIGJpbmFyeSB3aWxsIHJ1biBvbiBhbGwgZGlzdHJpYnV0aW9u
cyAobmV3ZXIgdGhhbiBzb21lIGN1dG9mZikuDQoyKSBBbnkgc2VyaW91cyBidWcgZml4ZXMgaW4g
c3lzdGVtIGxpYnJhcmllcyBnZXQgcGlja2VkIHVwIHdoZW4gdGhlDQogICBkaXN0cmlidXRpb24g
dXBkYXRlcyB0aGUgbGlicmFyeS4NCg0KVGhlcmUgaXMgYWxzbyB0aGUgcG9zc2liaWxpdHkgdGhh
dCB0aGUgaW1wbGVtZW50YXRpb24gb2Ygc29tZQ0KZnVuY3Rpb24gZGlmZmVycyBiZXR3ZWVuIGRp
c3RyaWJ1dGlvbnMuDQpTbyB5b3UgYWJzb2x1dGVseSBuZWVkIHRvIHVzZSB0aGUgdmVyc2lvbiBm
cm9tIHRoZSBpbnN0YWxsZWQgc3lzdGVtDQpub3Qgd2hhdGV2ZXIgd2FzIGluIHNvbWUgc3RhdGlj
IGxpYnJhcnkgb24gdGhlIGFjdHVhbCBidWlsZCBtYWNoaW5lLg0KDQpCb3RoIG9mIHRoZXNlIG5l
ZWQgc3RhYmxlIEFCSSBhbmQgc2hhcmVkIGxpYnJhcmllcy4NCg0KUmVtZW1iZXIsIGFzIGZhciBh
cyB1c2Vyc3BhY2UgaXMgY29uY2VybmVkLCBmb28uaCBpcyB0aGUgZGVmaW5pdGlvbg0KZm9yICdm
b28nIGFuZCBmb28uc28gaXMgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24uDQooeWVzLCBJIGtu
b3cgYSBsaXR0bGUgYml0IG9mIGluZm8gaXMgdGFrZW4gZnJvbSBmb28uc28gb24gdGhlIGJ1aWxk
DQpzeXN0ZW0gLSBidXQgdGhhdCBvdWdodCB0byBiZSBhYnNvbHV0ZWx5IG1pbmltYWwuKQ0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

