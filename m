Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0D342317
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCSRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:18:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31900 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhCSRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:18:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-cUoMqJKhPp-pnlrNcM1hcw-1; Fri, 19 Mar 2021 17:18:15 +0000
X-MC-Unique: cUoMqJKhPp-pnlrNcM1hcw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 17:18:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Fri, 19 Mar 2021 17:18:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "mbenes@suse.com" <mbenes@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
Thread-Topic: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
Thread-Index: AQHXHBuOjMKa9Pnfuk6RUu8GKds+rKqLhqcg
Date:   Fri, 19 Mar 2021 17:18:14 +0000
Message-ID: <f7a36237052f4c09ad101431653038a5@AcuMS.aculab.com>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.580212227@infradead.org>
In-Reply-To: <20210318171919.580212227@infradead.org>
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMTggTWFyY2ggMjAyMSAxNzoxMQ0KPiANCj4g
RHVlIHRvIGNvbW1pdCBjOWMzMjRkYzIyYWEgKCJvYmp0b29sOiBTdXBwb3J0IHN0YWNrIGxheW91
dCBjaGFuZ2VzDQo+IGluIGFsdGVybmF0aXZlcyIpLCBpdCBpcyBwb3NzaWJsZSB0byBzaW1wbGlm
eSB0aGUgcmV0cG9saW5lcy4NCj4gDQouLi4NCj4gTm90aWNlIHRoYXQgc2luY2UgdGhlIGxvbmdl
c3QgYWx0ZXJuYXRpdmUgc2VxdWVuY2UgaXMgbm93Og0KPiANCj4gICAgMDogICBlOCAwNyAwMCAw
MCAwMCAgICAgICAgICBjYWxscSAgYyA8LmFsdGluc3RyX3JlcGxhY2VtZW50KzB4Yz4NCj4gICAg
NTogICBmMyA5MCAgICAgICAgICAgICAgICAgICBwYXVzZQ0KPiAgICA3OiAgIDBmIGFlIGU4ICAg
ICAgICAgICAgICAgIGxmZW5jZQ0KPiAgICBhOiAgIGViIGY5ICAgICAgICAgICAgICAgICAgIGpt
cCAgICA1IDwuYWx0aW5zdHJfcmVwbGFjZW1lbnQrMHg1Pg0KPiAgICBjOiAgIDQ4IDg5IDA0IDI0
ICAgICAgICAgICAgIG1vdiAgICAlcmF4LCglcnNwKQ0KPiAgIDEwOiAgIGMzICAgICAgICAgICAg
ICAgICAgICAgIHJldHENCj4gDQo+IDE3IGJ5dGVzLCB3ZSBoYXZlIDE1IGJ5dGVzIE5PUCBhdCB0
aGUgZW5kIG9mIG91ciAzMiBieXRlIHNsb3QuIChJT1csDQo+IGlmIHdlIGNhbiBzaHJpbmsgdGhl
IHJldHBvbGluZSBieSAxIGJ5dGUgd2UgY2FuIHBhY2sgaXQgbW9yZSBkZW5zZSkNCg0KSSdtIGlu
dHJpZ3VlZCBhYm91dCB0aGUgbGZlbmNlIGFmdGVyIHRoZSBwYXVzZS4NCkNsZWFybHkgdGhpcyBp
cyBmb3IgdmVyeSB3YXJwZWQgY3B1IGJlaGF2aW91ci4NClRvIGdldCB0byB0aGUgcGF1c2UgeW91
IGhhdmUgdG8gYmUgc3BlY3VsYXRpbmcgcGFzdCBhbg0KdW5jb25kaXRpb25hbCBjYWxsLg0KDQpU
byBnZXQgdG8gdGhlIGxmZW5jZSB5b3UgaGF2ZSB0byAobW9zdGx5KSBoYXZlIGlnbm9yZWQgdGhl
IHBhdXNlLg0KV2hpY2ggaXMgY29tbWVudGVkOg0KCV9tbV9wYXVzZSgpOyAvKiBBYm9ydCBzcGVj
dWxhdGlvbiAqLw0KaW4gYSBjb3VwbGUgb2YgZXhhbXBsZXMgaW4gMjQ4OTY2LTAzMy4NCg0KSSB3
b25kZXIgd2hhdCBlZmZlY3QgcmVwbGFjaW5nIHRoZSBsZmVuY2Ugd2l0aCBobHQgd291bGQgaGF2
ZT8NCkl0IHdvdWxkIGNlcnRhaW5seSBzYXZlIDIgYnl0ZXMgYW5kIGFsbG93IHRoZSBlbnRpcmUg
cmV0cG9saW5lDQpiZSBwdXQgaW50byBhIHNpbmdsZSAxNmJ5dGUgY29kZSBmZXRjaCBibG9jay4N
Cg0KMjQ4OTY2LTAzMyBhbHNvIGNvbnRhaW5zIGEgbm90ZSB0aGF0IHRoZSBpbnN0cnVjdGlvbihz
KSBhZnRlcg0KYW4gaW5kaXJlY3QganVtcCBtYXkgZ2V0IGV4ZWN1dGVkLg0KSXQgc3VnZ2VzdHMg
YWRkaW5nIGEgcGF1c2UgKG9yIGlsbGVnYWwgaW5zdHJ1Y3Rpb24pIHRvIHN0b3ANCmFueXRoaW5n
IG9kZCBoYXBwZW5pbmcgKHRoZXkga25ldyBpdCBjb3VsZCBiZSBob3JyaWQgaW4gSnVuZSAyMDE2
Lg0KQnV0IHRoZW4gZ28gb24gdG8gc2F5IHRoZSBhZGRpbmcgcGF1c2UgbWF5IGJlIGEgcGVyZm9y
bWFuY2UgaXNzdWUuDQooUHJlc3VtYWJseSBiZWNhdXNlIGlmIGl0IGlzIHNwZWN1bGF0aXZlbHkg
ZXhlY3V0ZWQgaXQgdGFrZXMgYWdlcy4pDQoNCkkgZG8gcmVtZW1iZXIgc29tZXRoaW5nIGZyb20g
ZXZlbiBsb25nZXIgYWdvIGFib3V0IHRyeWluZyB0byBuZXZlcg0Kc3BlY3VsYXRlIGFueSBvZiB0
aGUgdHJpZyBvcGNvZGVzIC0gYmVjYXVzZSBhdCBsYXN0IHNvbWUgY3B1IGNvdWxkbid0DQphYm9y
dCB0aGUgaW5zdHJ1Y3Rpb24uDQoNClRoaXMgbWF5IGFsc28gbWVhbiB0aGF0IGEgYmlnIHBpbGUg
b2YgMHg5MCBub3BzIGFmdGVyIHRoZSBqbXAgKCVlYXgpDQppcyBhY3R1YWxseSBiZXR0ZXIgdGhh
biAyIG9yIDMgJ2JpZycgbm9wcy4NCk9mIGNvdXJzZSwgaWYgeW91IGV4ZWN1dGUgdGhlIG5vcHMg
eW91IGFsd2F5cyB3YW50IHRoZSBiaWcgb25lcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

