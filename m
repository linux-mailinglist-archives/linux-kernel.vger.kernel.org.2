Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702DE3B9459
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGAP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:57:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47670 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233898AbhGAP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:57:23 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-37-FRSMqvYvOqKvjMCW5DM9EA-1; Thu, 01 Jul 2021 16:54:49 +0100
X-MC-Unique: FRSMqvYvOqKvjMCW5DM9EA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 1 Jul
 2021 16:54:49 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Thu, 1 Jul 2021 16:54:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Fabio M. De Francesco'" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Topic: [PATCH] staging: rtl8188eu: Replace a custom function with
 crc32_le()
Thread-Index: AQHXbn5ab3Zj0XkM6U+MISzKcNjhyasuNAtw///4VgCAABkjQA==
Date:   Thu, 1 Jul 2021 15:54:49 +0000
Message-ID: <190cf86a4b8a40d2b672327e26cceace@AcuMS.aculab.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com>
 <2fac9d8813374e95bcc04134a0f40f45@AcuMS.aculab.com>
 <2058378.BL2Rai63ie@linux.local>
In-Reply-To: <2058378.BL2Rai63ie@linux.local>
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

RnJvbTogRmFiaW8gTS4gRGUgRnJhbmNlc2NvDQo+IFNlbnQ6IDAxIEp1bHkgMjAyMSAxNjoyNA0K
PiANCj4gT24gVGh1cnNkYXksIEp1bHkgMSwgMjAyMSA0OjUyOjA4IFBNIENFU1QgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiA+IEZyb206IEZhYmlvIE0uIERlIEZyYW5jZXNjbw0KPiA+DQo+ID4gPiBT
ZW50OiAwMSBKdWx5IDIwMjEgMTQ6MzgNCj4gPiA+DQo+ID4gPiBVc2UgY3JjMzJfbGUgaW4gcGxh
Y2Ugb2YgdGhlIGN1c3RvbSBnZXRjcmMzMi4gVGhpcyBjaGFuZ2UgbWFrZXMgR0NDDQo+ID4gPiB0
byB3YXJuIGFib3V0IGluY29ycmVjdCBjYXN0aW5ncyB0byB0aGUgcmVzdHJpY3RlZCB0eXBlIF9f
bGUzMiwgYnV0DQo+ID4gPiB0aGV5IGNhbiBiZSBzYWZlbHkgaWdub3JlZCBiZWNhdXNlIGNyYzMy
X2xlIGNhbGN1bGF0ZXMgYml0d2lzZQ0KPiA+ID4gbGl0dGxlLWVuZGlhbiBFdGhlcm5ldCBBVVRP
RElOIElJIENSQzMyLg0KPiA+DQo+ID4gLi4uDQo+ID4NCj4gPiA+IC0JCQkJCSooKF9fbGUzMiAq
KWNyYykgPQ0KPiBnZXRjcmMzMihwYXlsb2FkLCBsZW5ndGgpOy8qIG1vZGlmaWVkIGJ5IEFteSov
DQo+ID4gPiArCQkJCQkqKChfX2xlMzIgKiljcmMpID0NCj4gfmNyYzMyX2xlKH4wLCBwYXlsb2Fk
LCBsZW5ndGgpOw0KPiA+DQo+ID4gSGF2ZW4ndCB3ZSBiZWVuIHJvdW5kIHRoaXMgYmVmb3JlPw0K
PiA+DQo+IE5vLCBJIGRvbid0IHRoaW5rIHNvLiBBdCBsZWFzdCwgbm90IHlvdSBhbmQgSS4NCj4g
DQoNClRoYXQgd2FzIHJ0MTg3MiB0aGlzIGlzIHJ0bDgxODggYnV0IEkgdGhpbmsgaXQgaXMgdGhl
IHNhbWUgY3JhcC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

