Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61C838C64F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhEUMQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:16:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57419 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhEUMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:16:41 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-TrzBr211M3Cnv3d5GXg3XQ-1; Fri, 21 May 2021 13:15:14 +0100
X-MC-Unique: TrzBr211M3Cnv3d5GXg3XQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 21 May 2021 13:15:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Fri, 21 May 2021 13:15:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Austin Kim' <austindh.kim@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "tj@kernel.org" <tj@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Subject: RE: [PATCH] kernfs: move return value check after kmalloc()
Thread-Topic: [PATCH] kernfs: move return value check after kmalloc()
Thread-Index: AQHXTg5Q4cItJ5vgRU+eCMDVVUH1cqrt2WUA
Date:   Fri, 21 May 2021 12:15:12 +0000
Message-ID: <e755af9f0e104fb8b374d2a2c2bb854b@AcuMS.aculab.com>
References: <20210521025525.GA1379@raspberrypi> <YKc5jLVhw8+Oy165@kroah.com>
 <CADLLry5J5GqB_Rw7n0aKcWgYPJZDOQP89mvyWT-GnB8KAiQrBA@mail.gmail.com>
In-Reply-To: <CADLLry5J5GqB_Rw7n0aKcWgYPJZDOQP89mvyWT-GnB8KAiQrBA@mail.gmail.com>
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

RnJvbTogQXVzdGluIEtpbQ0KPiBTZW50OiAyMSBNYXkgMjAyMSAwNzo1NQ0KPiANCj4gMjAyMeuF
hCA17JuUIDIx7J28ICjquIgpIOyYpO2bhCAxOjM5LCBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz7ri5jsnbQg7J6R7ISxOg0KPiA+DQo+ID4gT24gRnJpLCBNYXkgMjEsIDIwMjEg
YXQgMDM6NTU6MjVBTSArMDEwMCwgQXVzdGluIEtpbSB3cm90ZToNCj4gPiA+IFdpdGggNDE0OTg1
YWUyM2MwICgic3lzZnMsIGtlcm5mczogbW92ZSBmaWxlIGNvcmUgY29kZSB0byBmcy9rZXJuZnMv
ZmlsZS5jIiksDQo+ID4gPiAncmV0dXJuIC1FTk9NRU0nIGlzIGV4ZWN1dGVkIHdoZW4ga21hbGxv
YygpIHJldHVybnMgTlVMTC4NCj4gPiA+DQo+ID4gPiBTaW5jZSAnY29tbWl0IDRlZjY3YThjOTVm
MyAoInN5c2ZzL2tlcm5mczogbWFrZSByZWFkIHJlcXVlc3RzIG9uIHByZS1hbGxvYw0KPiA+ID4g
ZmlsZXMgdXNlIHRoZSBidWZmZXIuIiknLCAncmV0dXJuIC1FTk9NRU0nIHN0YXRlbWVudCBpcyBu
b3QgcHJvcGVybHkgbG9jYXRlZC4NCj4gPiA+DQo+ID4gPiBGaXggaXQgYnkgbW92aW5nICdyZXR1
cm4gLUVOT01FTScgYWZ0ZXIgcmV0dXJuIGZyb20ga21hbGxvYygpLg0KPiA+ID4NCj4gPiA+IEZp
eGVzOiA0ZWY2N2E4Yzk1ZjMgKCJzeXNmcy9rZXJuZnM6IG1ha2UgcmVhZCByZXF1ZXN0cyBvbiBw
cmUtYWxsb2MgZmlsZXMgdXNlIHRoZSBidWZmZXIuIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEF1
c3RpbiBLaW0gPGF1c3RpbmRoLmtpbUBnbWFpbC5jb20+DQo+IFsuLi5dDQo+ID4NCj4gPiBMaWtl
IE5laWwgc2FpZCwgSSBkb24ndCBzZWUgdGhlICJidWciIHlvdSBhcmUgZml4aW5nIGhlcmUuICBX
aGF0IGlzDQo+ID4gY3VycmVudGx5IHdyb25nIHdpdGggdGhlIGV4aXN0aW5nIGNvZGU/DQouLi4N
Cg0KSWYgeW91IGxvb2sgYXQgdGhlIGdlbmVyYXRlZCBjb2RlIHlvdSdsbCBhbG1vc3QgY2VydGFp
bmx5DQpmaW5kIG5vIHNpZ25pZmljYW50IGRpZmZlcmVuY2VzLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

