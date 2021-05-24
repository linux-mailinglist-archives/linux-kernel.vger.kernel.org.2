Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3238E6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhEXMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:39:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:48583 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232515AbhEXMjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:39:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-zm-lfFzsPZO-pC4i18khew-1; Mon, 24 May 2021 13:38:22 +0100
X-MC-Unique: zm-lfFzsPZO-pC4i18khew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 24 May 2021 13:38:19 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 24 May 2021 13:38:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Price' <steven.price@arm.com>,
        Amanieu d'Antras <amanieu@gmail.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
Thread-Topic: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
Thread-Index: AQHXUI7V2V8LHoAybE2lBVUPxoeiSarykJcA
Date:   Mon, 24 May 2021 12:38:19 +0000
Message-ID: <f0d09966f7714c54aee1bb0260a6193d@AcuMS.aculab.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
 <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
 <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com>
 <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com>
 <CA+y5pbRwgpctUOBzzscT9XMN9LM2qraPNg6K6onFcpQaaFDYkQ@mail.gmail.com>
 <1c2bd27a-1c96-f154-ed18-f33630b109b1@arm.com>
 <CA+y5pbSbky2kS+O5j9bn57nROdYaYeHcd2R-46X1cc388PKOvg@mail.gmail.com>
 <419f410f-21b3-a4c6-3cd8-025007e9c31e@arm.com>
In-Reply-To: <419f410f-21b3-a4c6-3cd8-025007e9c31e@arm.com>
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

RnJvbTogU3RldmVuIFByaWNlDQo+IFNlbnQ6IDI0IE1heSAyMDIxIDEyOjIxDQouLi4NCj4gU28g
YSAiZ2VuZXJpYyIgd2F5IG9mIHJlcXVlc3RlZCB0aGUga2VybmVsIGxpbWl0IHRoZSBhZGRyZXNz
IHNwYWNlIGZvcg0KPiBhbGxvY2F0aW9ucyB3b3VsZCBiZSBwb3RlbnRpYWxseSB1c2VmdWwgZm9y
IG90aGVyIHB1cnBvc2VzLiBBZGRpbmcgYSBuZXcNCj4gc3lzY2FsbCBmb3IgdGhpcyBwdXJwb3Nl
IHdvdWxkIGJlIHNlbnNpYmxlLiBXZSBhbHJlYWR5IGhhdmUgKGF0IGxlYXN0KQ0KPiB0d28gImhh
Y2tzIiBpbiBtbWFwIGZvciBjb250cm9sbGluZyB0aGUgYWRkcmVzcyByYW5nZSB0aGF0IGNhbiBi
ZSB1c2VkOg0KPiANCj4gICogTUFQXzMyQklUIC0geDg2IG9ubHksIGFuZCByZWFsbHkgIjMxIGJp
dCINCj4gDQo+ICAqIFByb3ZpZGluZyBhIG1tYXAoKSBoaW50IHdpdGggdGhlIHRvcCBiaXRzIHNl
dCB0byBvcHQtaW4gdG8gNTItYml0IFZBcy4NCj4gDQo+IEEgd2VsbCBkZWZpbmVkIG1lY2hhbmlz
bSBmb3IgY29udHJvbGxpbmcgdGhlIHZhbGlkIFZBIHJhbmdlIGZvcg0KPiBhbGxvY2F0aW9ucyB3
b3VsZCBiZSBtdWNoIGJldHRlciB0aGFuIGFkZGluZyBtb3JlIGhhY2tzIC0gYW5kIGJvbnVzDQo+
IHBvaW50cyBpZiBpdCB3b3JrcyBmb3IgYWxsIHRoZSBkaWZmZXJlbnQgdHlwZXMgb2YgYWxsb2Nh
dGlvbiB1bmxpa2UgdGhlDQo+IGFib3ZlLg0KDQpJJ2QgaGF2ZSB0aG91Z2h0IGEgJ01BUF9CRUxP
VycgZmxhZyAoY2YgTUFQX0ZJWEVEKSB3b3VsZCBzdWZmaWNlLg0KSSdtIHNvcnQgb2Ygc3VycHJp
c2VkIE1BUF8zMkJJVCB3YXNuJ3QgaW1wbGVtZW50ZWQgdGhhdCB3YXkuDQonbWFuIG1tYXAnIHNh
eXMgTUFQXzMyQklUIHdhcyBhZGRlZCBmb3IgeDY0IHRocmVhZCBzdGFja3MgLSBJIHRob3VnaA0K
dGhlIHJlcXVpcmVtZW50IGNhbiBmcm9tIDMyYml0IHdpbmUgKHdpbmRvd3MgaGFzIGEgMkcgdXNl
ci9rZXJuZWwgYm91bmRhcnkpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

