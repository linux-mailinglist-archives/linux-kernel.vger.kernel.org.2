Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47331658A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBJLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:46:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:44644 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBJLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:43:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-114-K0rcHhlYNbmDFciqYAB-xA-1; Wed, 10 Feb 2021 11:41:36 +0000
X-MC-Unique: K0rcHhlYNbmDFciqYAB-xA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 10 Feb 2021 11:41:34 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 10 Feb 2021 11:41:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Lai Jiangshan" <jiangshanlai+lkml@gmail.com>
Subject: RE: [patch V2 03/13] x86/irq/64: Adjust the per CPU irq stack pointer
 by 8
Thread-Topic: [patch V2 03/13] x86/irq/64: Adjust the per CPU irq stack
 pointer by 8
Thread-Index: AQHW/1Hc/Ge+8Xn+UE+oxbMdwlawL6pRRBeg
Date:   Wed, 10 Feb 2021 11:41:34 +0000
Message-ID: <c7d8e27f99a5410dac934925e0f89a7c@AcuMS.aculab.com>
References: <20210209234041.127454039@linutronix.de>
 <20210210002512.354260928@linutronix.de>
In-Reply-To: <20210210002512.354260928@linutronix.de>
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

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQo+IFNlbnQ6IDA5IEZlYnJ1YXJ5IDIwMjEgMjM6NDENCj4g
RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IA0KPiBUaGUgcGVy
IENQVSBoYXJkaXJxX3N0YWNrX3B0ciBjb250YWlucyB0aGUgcG9pbnRlciB0byB0aGUgaXJxIHN0
YWNrIGluIHRoZQ0KPiBmb3JtIHRoYXQgaXQgaXMgcmVhZHkgdG8gYmUgYXNzaWduZWQgdG8gW0VS
XVNQIHNvIHRoYXQgdGhlIGZpcnN0IHB1c2ggZW5kcw0KPiB1cCBvbiB0aGUgdG9wIGVudHJ5IG9m
IHRoZSBzdGFjay4NCi4uLg0KPiBEbyB0aGUgLTggYWRqdXN0bWVudCByaWdodCB3aGVuIHN0b3Jp
bmcgdGhlIHBvaW50ZXIgYW5kIG1ha2UgdGhlIGRhdGEgdHlwZQ0KPiBhIHZvaWQgcG9pbnRlciB0
byBhdm9pZCBjb25mdXNpb24gdnMuIHRoZSBzdHJ1Y3QgaXJxX3N0YWNrIGRhdGEgdHlwZSB3aGlj
aA0KPiBpcyBvbiA2NGJpdCBvbmx5IHVzZWQgdG8gZGVjbGFyZSB0aGUgYmFja2luZyBzdG9yZS4u
Lg0KDQpJdCBtaWdodCBiZSBiZXR0ZXIgdG8gbWFrZSBpdCBhIHBvaW50ZXIgdG8gYW4gdW5kZWZp
bmVkIHN0cnVjdC4NClRoYXQgd2lsbCBzdG9wIGFsbCBhY2NpZGVudGFsIGFzc2lnbm1lbnRzIC0g
ZXhjZXB0IHRob3NlIHRoYXQNCmFyZSBhbHJlYWR5ICd2b2lkIConLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

