Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06434A825
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCZNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:32:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40705 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhCZNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:32:36 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-9-1wt_UL1sPA2C6UYdNIVbOQ-1;
 Fri, 26 Mar 2021 13:32:32 +0000
X-MC-Unique: 1wt_UL1sPA2C6UYdNIVbOQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 26 Mar 2021 13:32:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Fri, 26 Mar 2021 13:32:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Subject: RE: Why does glibc use AVX-512?
Thread-Topic: Why does glibc use AVX-512?
Thread-Index: AQHXIfoDPTL8bfD4xUusWDRPF/V336qWQECQ
Date:   Fri, 26 Mar 2021 13:32:31 +0000
Message-ID: <5cb200606c5c40d4a289dbc6ad08f437@AcuMS.aculab.com>
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
In-Reply-To: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDI2IE1hcmNoIDIwMjEgMDQ6MzgNCj4gDQo+
IEhpIGFsbC0NCj4gDQo+IGdsaWJjIGFwcGVhcnMgdG8gdXNlIEFWWDUxMkYgZm9yIG1lbWNweSBi
eSBkZWZhdWx0LiAgKFVubGVzcw0KPiBQcmVmZXJfRVJNUyBpcyBkZWZhdWx0LW9uLCBidXQgSSBn
ZW51aW5lbHkgY2FuJ3QgdGVsbCBpZiB0aGlzIGlzIHRoZQ0KPiBjYXNlLiAgSSBkaWQgc29tZSBz
ZWFyY2hpbmcuKSAgVGhlIGNvbW1pdCBhZGRpbmcgaXQgcmVmZXJzIHRvIGEgMjAxNg0KPiBlbWFp
bCBzYXlpbmcgdGhhdCBpdCdzIDMwJSBvbiBLTkwuICBVbmZvcnR1bmF0ZWx5LCBBVlgtNTEyIGlz
IG5vdw0KPiBhdmFpbGFibGUgaW4gbm9ybWFsIGhhcmR3YXJlLCBhbmQgdGhlIG92ZXJoZWFkIGZy
b20gc3dpdGNoaW5nIGJldHdlZW4NCj4gbm9ybWFsIGFuZCBBVlgtNTEyIGNvZGUgYXBwZWFycyB0
byB2YXJ5IGZyb20gYmFkIHRvIGdlbnVpbmVseQ0KPiBob3JyaWJsZS4gIEFuZCwgb25jZSBhbnl0
aGluZyBoYXMgdXNlZCB0aGUgaGlnaCBwYXJ0cyBvZiBZTU0gYW5kL29yDQo+IFpNTSwgdGhvc2Ug
c3RhdGVzIHRlbmQgdG8gZ2V0IHN0dWNrIHdpdGggWElOVVNFPTEuDQoNClllcyBJIHdvbmRlciBo
b3cgbXVjaCBmYXN0ZXIgJ25vcm1hbCcgY29waWVzIGV2ZXIgZ2V0IGJlY2F1c2UNCm9mIHRoZXNl
IG9wdGltaXNhdGlvbnMuDQpOb3QgbWFueSBwcm9ncmFtcyBzaXQgaW4gYSBsb29wIHJlcGVhdGVk
bHkgY29weWluZyB0aGUgc2FtZSA4ayBidWZmZXIuDQoNCk5vdCB0byBtZW50aW9uIHRoZSBjcHUg
d2hlcmUgdGhlICd3aWRlJyBpbnN0cnVjdGlvbnMgZWl0aGVyDQp1c2UgdGhlICduYXJyb3cnIGV4
ZWN1dGlvbiB1bml0IHR3aWNlIG9yIGF0IGhhbGYgZnJlcXVlbmN5Lg0KU28gd2hpbGUgc3VwcG9y
dGVkLCB1c2luZyB0aGVtIGlzbid0IHJlYWxseSB1c2VmdWwuDQoNCklJUkMgdGhlIFtYWVpdTU0g
cmVnaXN0ZXJzIGFyZSBhbGwgY2FsbGVyIHNhdmVkPw0KU28gc3lzdGVtIGNhbGxzIChvciByYXRo
ZXIgdGhlIEMgd3JhcHBlcikgaXMgYWxsb3dlZCB0bw0KdHJhc2ggdGhlbSBhbGwuDQpTbyB0aGUg
c3lzdGVtIGNhbGwgZW50cnkgY291bGQgemVybyBhbGwgdGhlIFtYWVpdTU0gcmVnaXN0ZXJzLg0K
SSB0aGluayB0aGV5IFhTQVZFeHh4IGFuZCBsYXRlciBYUkVTVE9SRXh4eCBhcmUgdGhlbiBxdWlj
ay4NCkluIHBhcnRpY3VsYXIgdGhleSBkb24ndCBuZWVkIHNhdmluZyBvbiBhIGNvbnRleHQgc3dp
dGNoIGZyb20NCmEgc3lzdGVtIGNhbGwuDQpUaGlzIG1pZ2h0IGdldCB0aGVtIG1hcmtlZCAnbm90
IGluIHVzZScgbW9yZSBvZnRlbi4NCkJ1dCBwcm9iYWJseSBub3QgaWYgbWVtY3B5KCkgc3RhcnRz
IHVzaW5nIHRoZW0uDQooVGhpcyBkb2Vzbid0IGhlbHAgc2lnbmFsIGhhbmRsZXJzLikNCg0KSVNU
UiBvbmUgY3B1IGZhbWlseSB3aGVyZSBaVkVST1VQUEVSIGdvZXMgZnJvbSAnY2hlYXAnIHRvDQon
ZXhwZW5zaXZlJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

