Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0663F41BD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhHVVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 17:31:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46413 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbhHVVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 17:31:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127-MHgroe1XPKuE3JQrTB65_A-1; Sun, 22 Aug 2021 22:30:46 +0100
X-MC-Unique: MHgroe1XPKuE3JQrTB65_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sun, 22 Aug 2021 22:30:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sun, 22 Aug 2021 22:30:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Thread-Topic: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Thread-Index: AQHXlgydrPam5lbK9UGqx5Eu5gVI9auADXtg
Date:   Sun, 22 Aug 2021 21:30:45 +0000
Message-ID: <05aafb94be1b4e609250313709cd668d@AcuMS.aculab.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
 <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
In-Reply-To: <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
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

RnJvbTogTGFycnkgRmluZ2VyDQo+IFNlbnQ6IDIwIEF1Z3VzdCAyMDIxIDIyOjQ1DQo+IA0KPiBP
biA4LzE5LzIxIDM6MTcgQU0sIEFha2FzaCBIZW1hZHJpIHdyb3RlOg0KPiA+IEZpeCBzcGFyc2Ug
d2FybmluZzoNCj4gPj4gcnR3X2JyX2V4dC5jOjgzNjo1NDogd2FybmluZzogY2FzdCB0byByZXN0
cmljdGVkIF9fYmUzMg0KPiA+DQo+ID4gVW5uZWNlc3NhcnkgZG91YmxlIGNhc3QsIHJlbW92ZSB0
aGVtLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWFrYXNoIEhlbWFkcmkgPGFha2FzaGhlbWFk
cmkxMjNAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUv
Y29yZS9ydHdfYnJfZXh0LmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdp
bmcvcjgxODhldS9jb3JlL3J0d19icl9leHQuYyBiL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2Nv
cmUvcnR3X2JyX2V4dC5jDQo+ID4gaW5kZXggNDA0ZmE4OTA0ZTQ3Li42YTA0NjJjZTYyMzAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfYnJfZXh0LmMN
Cj4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19icl9leHQuYw0KPiA+
IEBAIC02NzEsNyArNjcxLDcgQEAgdm9pZCBkaGNwX2ZsYWdfYmNhc3Qoc3RydWN0IGFkYXB0ZXIg
KnByaXYsIHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gICAJCQkJICAgICh1ZHBoLT5kZXN0ID09
IF9fY29uc3RhbnRfaHRvbnMoU0VSVkVSX1BPUlQpKSkgeyAvKiAgREhDUCByZXF1ZXN0ICovDQo+
ID4gICAJCQkJCXN0cnVjdCBkaGNwTWVzc2FnZSAqZGhjcGggPQ0KPiA+ICAgCQkJCQkJKHN0cnVj
dCBkaGNwTWVzc2FnZSAqKSgoc2l6ZV90KXVkcGggKyBzaXplb2Yoc3RydWN0IHVkcGhkcikpOw0K
PiA+IC0JCQkJCXUzMiBjb29raWUgPSBiZTMyX3RvX2NwdSgoX19iZTMyKWRoY3BoLT5jb29raWUp
Ow0KPiA+ICsJCQkJCXUzMiBjb29raWUgPSBkaGNwaC0+Y29va2llOw0KPiA+DQo+ID4gICAJCQkJ
CWlmIChjb29raWUgPT0gREhDUF9NQUdJQykgeyAvKiAgbWF0Y2ggbWFnaWMgd29yZCAqLw0KPiA+
ICAgCQkJCQkJaWYgKCEoZGhjcGgtPmZsYWdzICYgaHRvbnMoQlJPQURDQVNUX0ZMQUcpKSkgew0K
PiA+DQo+IA0KPiBUaGlzIHBhdGNoIGlzIHdyb25nLiBBbGwgdGhlIGRvY3VtZW50YXRpb24gSSBj
b3VsZCBmaW5kIHRlbGxzIG1lIHRoYXQgdGhlDQo+IG11bHRpLWJ5dGUgZW50cmllcyBpbiBkaGNw
aCBhcmUgYmlnLWVuZGlhbiwgdGh1cyB0aGUgbmV3IGxpbmUgc2hvdWxkIHJlYWQ6DQo+IA0KPiAJ
CQkJCXUzMiBjb29raWUgPSBiZTMyX3RvX2NwdShkaGNwaC0+Y29va2llKTsNCg0KTW9kdWxvIGFu
eXRoaW5nIHRoYXQgcmVhbGx5IG1lYW5zIGl0IHNob3VsZCBnZXRfdW5hbGlnbmVkX2JlMzIoKS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

