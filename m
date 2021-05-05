Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBE374B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhEEWXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:23:35 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:20116 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhEEWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:23:25 -0400
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Thu, 6 May 2021
 00:22:26 +0200
Received: from GMU418.rsint.net ([10.0.230.144])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 998;
          Thu, 6 May 2021 00:22:25 +0200 (CEST)
Received: from GMU008.rsint.net (10.0.2.29) by GMU418.rsint.net (10.0.230.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 00:22:25 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU008.rsint.net (10.0.2.29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.4; Thu, 6 May
 2021 00:22:25 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2242.008; Thu, 6 May 2021 00:22:24 +0200
From:   Guido Kiener <Guido.Kiener@rohde-schwarz.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: Re: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: Re: Re: [syzbot] INFO: rcu detected stall in tx /ur/
Thread-Index: AddB/PS7Li0nZFy5SOyK+pazcdQJJA==
Date:   Wed, 5 May 2021 22:22:24 +0000
Message-ID: <58bda4726ca24d0e963a6787d4c86313@rohde-schwarz.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-rus_sensitivity: 10
hvs-classificationid: 8485d17c-1b45-47c0-b496-903334a11e28
hvs-prefix: R_S
x-originating-ip: [10.0.9.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-IQAV: YES
X-GBS-PROC: 6KdluzGQerrboy4j1mmdnyGsLkZ0NLPDTIMMABczP9LL43ps3CfDqWURB50ckR7eAKLlWLn6jOlxqerk4sGkEzTfhciNznHsQs5z+MQNWMoX62dltylrf8igsNwu+qrG
X-GBS-PROCJOB: as1p5eGTkF+9lQHM4naQUmJP410WfUY01feE+nsU/wQ1BDGSvTE1sYPC54FKh6x8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGFuIFN0ZXJuIDxzdGVybkBy
b3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNCwgMjAyMSA1OjE0IFBN
DQo+IFRvOiBLaWVuZXIgR3VpZG8gMTREUzEgDQo+IFN1YmplY3Q6IFJlOiBSZTogW3N5emJvdF0g
SU5GTzogcmN1IGRldGVjdGVkIHN0YWxsIGluIHR4DQo+IA0KPiBPbiBNb24sIE1heSAwMywgMjAy
MSBhdCAwOTo1NjowNVBNICswMDAwLCBHdWlkbyBLaWVuZXIgd3JvdGU6DQo+ID4gSGkgYWxsLA0K
PiA+DQo+ID4gRGF2ZSBhbmQgSSBkaXNjdXNzZWQgdGhlICJzZWxmLWRldGVjdGVkIHN0YWxsIG9u
IENQVSIgY2F1c2VkIGJ5IHRoZSB1c2J0bWMNCj4gZHJpdmVyLg0KPiA+DQo+ID4gV2hhdCBoYXBw
ZW5lZD8NCj4gPiBUaGUgY2FsbGJhY2sgaGFuZGxlciB1c2J0bWNfaW50ZXJydXB0KHN0cnVjdCB1
cmIgKnVyYikgZm9yIHRoZSBJTlQgcGlwZSByZWNlaXZlcw0KPiBhbiBlcnJvbmVvdXMgdXJiIHdp
dGggc3RhdHVzIC1FUFJPVE8gKC03MSkuDQo+ID4gU2VlDQo+ID4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZQ0KPiA+
IGUvZHJpdmVycy91c2IvY2xhc3MvdXNidG1jLmM/aD12NS4xMiNuMjM0MA0KPiA+IC1FUFJPVE8g
ZG9lcyBub3QgYWJvcnQvc2h1dGRvd24gdGhlIHBpcGUgYW5kIHRoZSB1cmIgaXMgcmVzdWJtaXR0
ZWQgdG8gcmVjZWl2ZQ0KPiB0aGUgbmV4dCBwYWNrZXQuIEhvd2V2ZXIgdGhlIGNhbGxiYWNrIGhh
bmRsZXIgdXNidG1jX2ludGVycnVwdCBpcyBjYWxsZWQgYWdhaW4gd2l0aA0KPiB0aGUgc2FtZSBl
cnJvbmVvdXMgc3RhdHVzIC1FUFJPVE8gYW5kIHRoaXMgc2VlbXMgdG8gcmVzdWx0IGluIGFuIGVu
ZGxlc3MgbG9vcC4NCj4gPiBBY2NvcmRpbmcgdG8NCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlDQo+ID4gZS9E
b2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdXNiL2Vycm9yLWNvZGVzLnJzdD9oPXY1LjEyI24xNzcN
Cj4gPiB0aGUgZXJyb3IgLUVQUk9UTyBpbmRpY2F0ZXMgYSBoYXJkd2FyZSBwcm9ibGVtIG9yIGEg
YmFkIGNhYmxlLg0KPiA+DQo+ID4gTW9zdCB1c2IgZHJpdmVycyBkbyBub3QgcmVhY3QgaW4gYSBz
cGVjaWZpYyB3YXkgb24gdGhpcyBoYXJkd2FyZSBwcm9ibGVtcyBhbmQNCj4gcmVzdWJtaXQgdGhl
IHVyYi4gV2UgYXNzdW1lIHRoZXNlIGRyaXZlcnMgd2lsbCBydW4gaW50byB0aGUgc2FtZSBlbmRs
ZXNzIGxvb3AuDQo+IFNvbWUgb3RoZXIgZHJpdmVyIHNhbXBsZXMgYXJlOg0KPiA+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmUNCj4gPiBlL2RyaXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYz9oPXY1LjEyI24zNzkNCj4g
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlDQo+ID4gZS9kcml2ZXJzL2hpZC91c2JoaWQvdXNibW91c2UuYz9oPXY1
LjEyI242NQ0KPiA+DQo+ID4gUG9zc2libGUgc29sdXRpb25zOg0KPiA+IEhhcmR3YXJlIGRlZmVj
dHMgb3IgYmFkIGNhYmxlcyBzZWVtcyB0byBiZSBhIGNvbW1vbiBwcm9ibGVtIGZvciBtb3N0IHVz
Yg0KPiBkcml2ZXJzIGFuZCBJIGFzc3VtZSB3ZSBkbyBub3Qgd2FudCB0byBmaXggdGhpcyBwcm9i
bGVtIGluIGFsbCBjbGFzcyBzcGVjaWZpYyBkcml2ZXJzLA0KPiBidXQgaW4gbG93ZXIgbGV2ZWwg
aG9zdCBkcml2ZXJzLCBlLmc6DQo+ID4gMS4gVXNpbmcgYSBjb3VudGVyIGFuZCBjbG9zZSB0aGUg
cGlwZSBhZnRlciBzb21lIGRldGVjdGVkIGVycm9ycyAyLg0KPiA+IERlbGF5IHRoZSByZXN1Ym1p
c3Npb24gb2YgdGhlIHVyYiB0byBhdm9pZCBoaWdoIGNwdSB1c2FnZSAzLiBEbw0KPiA+IG5vdGhp
bmcsIHNpbmNlIGl0IGlzIGp1c3QgYSByYXJlIHByb2JsZW0uDQo+ID4NCj4gPiBXZSd2ZSBuZXZl
ciBzZWVuIHRoaXMgcHJvYmxlbSBpbiBvdXIgcHJvZHVjdHMgYW5kIHdlIGRvIG5vdCBkYXJlIHRv
IGNoYW5nZQ0KPiBhbnl0aGluZy4NCj4gDQo+IERyaXZlcnMgYXJlIG5vdCBjb25zaXN0ZW50IGlu
IHRoZSB3YXkgdGhleSBoYW5kbGUgdGhlc2UgZXJyb3JzLCBhcyB5b3UgaGF2ZSBzZWVuLiAgQQ0K
PiBmZXcgdHJ5IHRvIHRha2UgYWN0aXZlIG1lYXN1cmVzLCBzdWNoIGFzIHJldHJ5cyB3aXRoIGlu
Y3JlYXNpbmcgdGltZW91dHMuICBNYW55DQo+IGRyaXZlcnMganVzdCBpZ25vcmUgdGhlbSwgd2hp
Y2ggaXMgbm90IGEgdmVyeSBnb29kIGlkZWEuDQo+IA0KPiBUaGUgZ2VuZXJhbCBmZWVsaW5nIGFt
b25nIGtlcm5lbCBVU0IgZGV2ZWxvcGVycyBpcyB0aGF0IGEgLUVQUk9UTywgLUVJTFNFUSwgb3IN
Cj4gLUVUSU1FIGVycm9yIHNob3VsZCBiZSByZWdhcmRlZCBhcyBmYXRhbCwgbXVjaCB0aGUgc2Ft
ZSBhcyBhbiB1bnBsdWcgZXZlbnQuICBUaGUNCj4gZHJpdmVyIHNob3VsZCBhdm9pZCByZXN1Ym1p
dHRpbmcgVVJCcyBhbmQganVzdCB3YWl0IHRvIGJlIHVuYm91bmQgZnJvbSB0aGUgZGV2aWNlLg0K
DQpUaGFua3MgZm9yIHlvdXIgYXNzZXNzbWVudC4gSSBhZ3JlZSB3aXRoIHRoZSBnZW5lcmFsIGZl
ZWxpbmcuIEkgY291bnRlZCBhYm91dCBodW5kcmVkDQpzcGVjaWZpYyB1c2IgZHJpdmVycywgc28g
d291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGZpeCB0aGUgcHJvYmxlbSBpbiBzb21lIG9mIHRoZSBo
b3N0IGRyaXZlcnMgKGUuZy4gdXJiLmMpPw0KV2UgY291bGQgcmV0dXJuIGFuIGVycm9yIHdoZW4g
Y2FsbGluZyB1c2Jfc3VibWl0X3VyYigpIG9uIGFuIGVycm9uZW91cyBwaXBlLg0KSSBjYW5ub3Qg
ZXN0aW1hdGUgdGhlIHNpZGUgZWZmZWN0cyBhbmQgd2UgbmVlZCB0byBjaGVjayBhbGwgZHJpdmVy
cyBhZ2FpbiBob3cgdGhleSBkZWFsIHdpdGggdGhlDQplcnJvciBzaXR1YXRpb24uIE1heWJlIHRo
ZXJlIGFyZSBzb21lIHNwZWNpYWwgZHJpdmVyIHRoYXQgbmVlZCBhIHNwZWNpYWxpemVkIGVycm9y
IGhhbmRsaW5nLg0KSW4gdGhpcyBjYXNlIHRoZXNlIGRyaXZlcnMgY291bGQgcmVzZXQgdGhlIChu
ZXc/KSBlcnJvciBmbGFnIHRvIGFsbG93IGNhbGxpbmcgdXNiX3N1Ym1pdF91cmIoKQ0KYWdhaW4g
d2l0aG91dCBlcnJvci4gVGhpcyBjb3VsZCB3b3JrLCBpc24ndCBpdD8NCg0KPiBJZiB5b3Ugd291
bGQgbGlrZSB0byBhdWRpdCBkcml2ZXJzIGFuZCBmaXggdGhlbSB1cCB0byBiZWhhdmUgdGhpcyB3
YXksIHRoYXQgd291bGQgYmUNCj4gZ3JlYXQuDQoNCkN1cnJlbnRseSBub3QuIEkgY2Fubm90IHB1
bGwgdGhlIFVTQiBjYWJsZSBpbiBob21lIG9mZmljZSA6LSksIGJ1dCBJIHdpbGwga2VlcCBhbiBl
eWUgb24gaXQuDQpXaGVuIEknbSBtb3JlIGludm9sdmVkIGluIHRoZSBuZXh0IFVTQiBkcml2ZXIg
aXNzdWUgdGhhbiBJIHdpbGwgdGVzdCBiYWQgY2FibGVzIGFuZCANCm1heWJlIGdldCBtb3JlIGlk
ZWFzIGhvdyB3ZSBjb3VsZCB0ZXN0IGFuZCBmaXggdGhpcyByYXJlIGVycm9yLg0KDQo+IChGWUks
IGJ5IGZhciB0aGUgbW9zdCBjb21tb24gY2F1c2VzIG9mIHRoZXNlIGVycm9ycyBhcmU6IFRoZSB1
c2VyIGhhcyB1bnBsdWdnZWQNCj4gdGhlIFVTQiBjYWJsZSwgb3IgdGhlIGRldmljZSdzIGZpcm13
YXJlIGhhcyBjcmFzaGVkLiAgSXQgaXMgcXVpdGUgcmFyZSBmb3IgdGhlIGNhdXNlIHRvDQo+IGJl
IGludGVybWl0dGVudCwgYWx0aG91Z2ggbm90IGVudGlyZWx5IHVuaGVhcmQgb2YgLS0gZm9yIGV4
YW1wbGUsIHNvbWVvbmUgb25jZQ0KPiByZXBvcnRlZCBlcnJvcnMgcmVzdWx0aW5nIGZyb20gRU0g
b3IgcG93ZXItbGluZSBpbnRlcmZlcmVuY2UgY2F1c2VkIGJ5IGZsaWNrZXJpbmcNCj4gZmx1b3Jl
c2NlbnQgbGlnaHRzIG9yIHNvbWV0aGluZyBvZiB0aGF0IHNvcnQuICBJdCdzIHByZXR0eSBzYWZl
IHRvIGlnbm9yZSB0aGlzIHBvc3NpYmlsaXR5LikNCg0KSSBmZWFyIEkgbWF5IG5vdCB1c2UgdGhl
IDc1IGtXIFRWIHRyYW5zbWl0dGVyIHRvIGludGVyZmVyZSB0aGUgVVNCIGNhYmxlIDotKQ0KDQot
R3VpZG8NCg==
