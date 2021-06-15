Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA23A8B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFOVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:47:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33684 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhFOVrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:47:41 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-33-72N-gABBMLOshMFf5vULMw-1; Tue, 15 Jun 2021 22:45:31 +0100
X-MC-Unique: 72N-gABBMLOshMFf5vULMw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 22:45:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 15 Jun 2021 22:45:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Thread-Topic: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Thread-Index: AQHXYgmrMOUHbNNmBkylhf24FzI3QKsVmsuw
Date:   Tue, 15 Jun 2021 21:45:31 +0000
Message-ID: <aff02581e694421eba04afc2fc3644df@AcuMS.aculab.com>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
 <YMiX7LAEtL0uQuVl@kroah.com>
 <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk>
 <YMjMpQtLeP3xceYR@kroah.com>
 <alpine.DEB.2.21.2106151805460.61948@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2106151805460.61948@angie.orcam.me.uk>
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

RnJvbTogTWFjaWVqIFcuIFJvenlja2kNCj4gU2VudDogMTUgSnVuZSAyMDIxIDE4OjEzDQouLi4N
Cj4gIEFzIEkgaGF2ZSBub3RlZCBhYm92ZSB0aGVyZSBpcyBhIGRhdGEgdHlwZSBzaWduZWRuZXNz
IGRpZmZlcmVuY2UgYmV0d2Vlbg0KPiBgbWNyX21hc2snIGFuZCBVQVJUX01DUl9DTEtTRUwuICBT
byB3ZSBoYXZlIHRoZSB2YWx1ZSBvZiAweDgwICgxMjgpLg0KPiBPbmNlIGJpdHdpc2UtY29tcGxl
bWVudGVkIGl0IGJlY29tZXMgMHhmZmZmZmY3ZiAoLTEyOSkuICBPbmNlIGFzc2lnbmVkIHRvDQo+
IGBtY3JfbWFzaycgaG93ZXZlciBpdCBiZWNvbWVzIDB4N2YgKDEyNyksIHdoaWNoIGlzIGNvbnNp
ZGVyZWQgYW4gdW5zYWZlDQo+IGNvbnZlcnNpb24gYmV0d2VlbiBzaWduZWQgYW5kIHVuc2lnbmVk
IGludGVnZXJzIGJ5IEdDQywgd2hpY2ggaXMgd2h5IHRoZQ0KPiBjb21waWxlciBjb21wbGFpbnMg
YWJvdXQgaXQuDQoNCkJsYW1lIHRoZSBpc28gQyBzdGFuZGFyZHMgY29tbWl0dGVlIGZvciBtYWtp
bmcgaW50ZWdlciBwcm9tb3Rpb25zDQondmFsdWUgcHJlc2VydmluZycgaW5zdGVhZCBvZiAnc2ln
biBwcmVzZXJ2aW5nJyBhcyB0aGV5IHdlcmUgaW4gSyZSIEMuDQoNClRyeSB1c2luZyBeIDB4ZmZ1
IGluc3RlYWQgb2Ygfi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

