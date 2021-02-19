Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D319C31F63F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBSJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:08:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:47419 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhBSJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:05:46 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-qCYCaDnfMe-HUtdo3zZNoQ-1; Fri, 19 Feb 2021 09:03:59 +0000
X-MC-Unique: qCYCaDnfMe-HUtdo3zZNoQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 19 Feb 2021 09:03:59 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 19 Feb 2021 09:03:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Abbott' <abbotti@mev.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Atul Gopinathan <atulgopinathan@gmail.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: comedi: cast to (unsigned int *)
Thread-Topic: [PATCH] staging: comedi: cast to (unsigned int *)
Thread-Index: AQHXBghs86N7pNMIM0eNnSVMq+7RAqpfL5hQ
Date:   Fri, 19 Feb 2021 09:03:59 +0000
Message-ID: <21a953261eb44e7ba302cfe74d8efa2d@AcuMS.aculab.com>
References: <20210217165907.9777-1-atulgopinathan@gmail.com>
 <YC1T06VCh0K2BBW5@kroah.com> <20210217181000.GB10124@atulu-ubuntu>
 <YC1fzjVOwiqzO1nb@kroah.com> <3cfef23d-8d4a-205c-61e8-cbe8c9a0c0f4@mev.co.uk>
In-Reply-To: <3cfef23d-8d4a-205c-61e8-cbe8c9a0c0f4@mev.co.uk>
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

PiBJdCdzIGtpbmQgb2YgbW9vdCBhbnl3YXkgYmVjYXVzZSB0aGUgcGF0Y2ggaXMgb3V0ZGF0ZWQu
ICBCdXQgdGhlIHJlYXNvbg0KPiBmb3IgdGhlIF9fX2ZvcmNlIGlzIHRoYXQgdGhlIHNhbWUgYHN0
cnVjdCBjb21lZGlfY21kYCBpcyB1c2VkIGluIGJvdGgNCj4gdXNlciBhbmQga2VybmVsIGNvbnRl
eHRzLiAgSW4gdXNlciBjb250ZXh0cywgdGhlIGBjaGFubGlzdGAgbWVtYmVyDQo+IHBvaW50cyB0
byB1c2VyIG1lbW9yeSBhbmQgaW4ga2VybmVsIGNvbnRleHRzIGl0IHBvaW50cyB0byBrZXJuZWwg
bWVtb3J5DQo+IChjb3BpZWQgZnJvbSB1c2Vyc3BhY2UpLg0KDQpDYW4ndCB5b3UgdXNlIGEgdW5p
b24gb2YgdGhlIHVzZXIgYW5kIGtlcm5lbCBwb2ludGVycz8NCihQb3NzaWJseSBldmVuIGFub255
bW91cz8pDQpBbHRob3VnaCwgaWRlYWxseSwga2VlcGluZyB0aGVtIGluIHNlcGFyYXRlIGZpZWxk
cyBpcyBiZXR0ZXIuDQo4IGJ5dGVzIGZvciBhIHBvaW50ZXIgaXNuJ3QgZ29pbmcgbWFrZSBhIGZh
dCBsb3Qgb2YgZGlmZmVyZW5jZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

