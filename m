Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6438DC1F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhEWROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:14:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32879 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231907AbhEWRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:13:59 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-cLEc0GmiMieukhPjIpklkg-1; Sun, 23 May 2021 18:12:26 +0100
X-MC-Unique: cLEc0GmiMieukhPjIpklkg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sun, 23 May 2021 18:12:24 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sun, 23 May 2021 18:12:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "gary@garyguo.net" <gary@garyguo.net>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Thread-Topic: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Thread-Index: AQHXT3WL0lTofUR6TU66MVYMSFr0J6rxS6gA
Date:   Sun, 23 May 2021 17:12:23 +0000
Message-ID: <17637b10e71b41b89126cbb1b2fa61cf@AcuMS.aculab.com>
References: <20210522232256.00003f08@garyguo.net>
 <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
In-Reply-To: <mhng-fdda10f7-fc83-4654-a0b2-e9c86b92c37e@palmerdabbelt-glaptop>
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

RnJvbTogUGFsbWVyIERhYmJlbHQNCj4gU2VudDogMjMgTWF5IDIwMjEgMDI6NDcNCi4uLg0KPiBJ
TU8gdGhlIHJpZ2h0IHdheSB0byBnbyBoZXJlIGlzIHRvIGp1c3QgbW92ZSB0byBDLWJhc2VkIHN0
cmluZyByb3V0aW5lcywNCj4gYXQgbGVhc3QgdW50aWwgd2UgZ2V0IHRvIHRoZSBwb2ludCB3aGVy
ZSB3ZSdyZSBzZXJpb3VzbHkgb3B0aW1pemluZyBmb3INCj4gc3BlY2lmaWMgcHJvY2Vzc29ycy4g
IFdlIHdlbnQgd2l0aCB0aGUgQy1iYXNlZCBzdHJpbmcgcm91bnRpbmVzIGluIGdsaWJjDQo+IGFz
IHBhcnQgb2YgdGhlIHVwc3RyZWFtaW5nIHByb2Nlc3MgYW5kIGZvdW5kIG9ubHkgc29tZSBzbWFs
bCBwZXJmb3JtYW5jZQ0KPiBkaWZmZXJlbmNlcyB3aGVuIGNvbXBhcmVkIHRvIHRoZSBoYW5kLXdy
aXR0ZW4gYXNzZW1ibHksIGFuZCB0aGV5J3JlIHdheQ0KPiBlYXNpZXIgdG8gbWFpbnRhaW4uDQo+
IA0KPiBJSVJDIExpbnV4IG9ubHkgaGFzIHRyaXZpYWwgQyBzdHJpbmcgcm91dGluZXMgaW4gbGli
LCBJIHRoaW5rIHRoZSBiZXN0DQo+IHdheSB0byBnbyBhYm91dCB0aGF0IHdvdWxkIGJlIHRvIGhp
Z2hlciBwZXJmb3JtYW5jZSB2ZXJzaW9ucyBpbiB0aGVyZS4NCj4gVGhhdCB3aWxsIGFsbG93IG90
aGVyIHBvcnRzIHRvIHVzZSB0aGVtLg0KDQpJIGNlcnRhaW5seSB3b25kZXIgaG93IG11Y2ggYmVu
ZWZpdCB0aGVzZSBtYXNzaXZlbHkgdW5yb2xsZWQNCmxvb3BzIGhhdmUgb24gbW9kZXJuIHN1cGVy
c2NhbGVyIHByb2Nlc3NvcnMgLSBlc3BlY2lhbGx5IHRob3NlDQp3aXRoIGFueSBmb3JtIG9mICdv
dXQgb2Ygb3JkZXInIGV4ZWN1dGlvbi4NCg0KSXQgaXMgb2Z0ZW4gZWFzeSB0byB3cml0ZSBhc3Nl
bWJsZXIgd2hlcmUgYWxsIHRoZSBsb29wDQpjb250cm9sIGluc3RydWN0aW9ucyBoYXBwZW4gaW4g
cGFyYWxsZWwgd2l0aCB0aGUgbWVtb3J5DQphY2Nlc3NlcyAtIHdoaWNoIGNhbm5vdCBiZSBhdm9p
ZGVkLg0KTG9vcCB1bnJvbGxpbmcgaXMgc28gMTk3MHMuDQoNClNvbWV0aW1lcyB5b3UgbmVlZCB0
byB1bnJvbGwgb25jZS4NCkFuZCBtYXliZSBpbnRlcmxlYXZlIHRoZSBsb2FkcyBhbmQgc3RvcmVz
Lg0KQnV0IGFmdGVyIHRoYXQgeW91IGNhbiBqdXN0IGJlIHRyYXNoaW5nIHRoZSBpLWNhY2hlLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

