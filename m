Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7153839306D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhE0OHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:07:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20069 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235830AbhE0OHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:07:48 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-_LxrmOtvOk6JvNjGgzt_rQ-1; Thu, 27 May 2021 15:06:11 +0100
X-MC-Unique: _LxrmOtvOk6JvNjGgzt_rQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 15:06:10 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 27 May 2021 15:06:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Russell King' <linux@armlinux.org.uk>,
        =?utf-8?B?S3J6eXN6dG9mIEhhxYJhc2E=?= <khalasa@piap.pl>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: Data corruption on i.MX6 IPU in arm_copy_from_user()
Thread-Topic: Data corruption on i.MX6 IPU in arm_copy_from_user()
Thread-Index: AQHXUjGwIzSVMSwtw06DpfGoZiumlar3XR+w
Date:   Thu, 27 May 2021 14:06:10 +0000
Message-ID: <eb842382ac2d472d858d6daa3dc345bd@AcuMS.aculab.com>
References: <m3y2c1uchh.fsf@t19.piap.pl>
 <20210526100843.GD30436@shell.armlinux.org.uk> <m3r1htu19o.fsf@t19.piap.pl>
 <20210526131853.GE30436@shell.armlinux.org.uk>
In-Reply-To: <20210526131853.GE30436@shell.armlinux.org.uk>
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

RnJvbTogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+IFNlbnQ6IDI2IE1h
eSAyMDIxIDE0OjE5DQo+IA0KPiBPbiBXZWQsIE1heSAyNiwgMjAyMSBhdCAwMjoyOTowN1BNICsw
MjAwLCBLcnp5c3p0b2YgSGHFgmFzYSB3cm90ZToNCj4gPiAiUnVzc2VsbCBLaW5nIChPcmFjbGUp
IiA8bGludXhAYXJtbGludXgub3JnLnVrPiB3cml0ZXM6DQo+ID4NCj4gPiA+IFN1cmVseSBzb21l
b25lIGlzIG5vdCB1c2luZyBjb3B5XypfdXNlcigpIHRvIGNvcHkgZGF0YSBmcm9tIHVzZXJzcGFj
ZQ0KPiA+ID4gZGlyZWN0IHRvIE1NSU8gc3BhY2UuLi4gdGhhdCB3b3VsZCBiZSBjcmF6eS4NCj4g
Pg0KPiA+IE5vLCBpdCdzIHRoZSBvdGhlciB3YXkgYXJvdW5kOiByZWFkaW5nIE1NSU8gbWFwcGVk
IHRvIHVzZXJzcGFjZSAobW1hcA0KPiA+IG9uIC9kZXYvbWVtKSBhbmQgY29weWluZyBpdCB0byBz
aW1wbGUga2VybmVsIGJ1ZmZlciAoZS5nLiBwaXBlIGJ1ZmZlcikuDQo+ID4gSS5lLiwgdGhlIE1N
SU8gaXMgdGhlIHVzZXJzcGFjZSBoZXJlICh0aHVzIGNvcHlfZnJvbV91c2VyKCkpLg0KPiANCj4g
QWguIEkgdGhpbmsgd2UgYXNzdW1lIGNvcHlfZnJvbV91c2VyKCkgd2lsbCBiZSB1c2VkIG9uIG1l
bW9yeSBvbmx5IGFuZA0KPiBub3QgZGV2aWNlIG1hcHBpbmdzLg0KPiANCj4gSW4gYW55IGNhc2Us
IGxvb2tpbmcgYXQgdGhlIGFyY2hpdGVjdHVyZSByZWZlcmVuY2UgbWFudWFsLCBMRE0gaXMNCj4g
cGVybWl0dGVkIG9uIGRldmljZSBhbmQgc3Ryb25nbHkgb3JkZXJlZCBtYXBwaW5ncywgYW5kIHRo
ZSBtZW1vcnkNCj4gc3Vic3lzdGVtIGlzIHJlcXVpcmVkIHRvIGRlY29tcG9zZSBpdCBpbnRvIGEg
c2VyaWVzIG9mIDMyLWJpdCBhY2Nlc3Nlcy4NCj4gU28sIGl0IHNvdW5kcyB0byBtZSBsaWtlIHRo
ZXJlIGNvdWxkIGJlIGEgaGFyZHdhcmUgYnVnIGluIHRoZSBidXNlcy9JUFUNCj4gY2F1c2luZyB0
aGlzLg0KPiANCj4gQ2FuIHlvdSB0cnkgdXNpbmcgTERNIGRpcmVjdGx5IGluc2lkZSB0aGUga2Vy
bmVsIGFuZCBzZWVpbmcgd2hhdCBlZmZlY3QNCj4gaXQgaGFzIHdoZW4gcmVhZGluZyB0aGUgSVBV
PyBBIHNpbXBsZSB0ZXN0IG1vZHVsZSBzaG91bGQgYmUgc3VmZmljaWVudC4NCj4gSSBzdXNwZWN0
IGl0J2xsIHNob3cgdGhlIHNhbWUgdGhpbmcgLSBiYXNpY2FsbHksIHRoYXQgdXNpbmcgTERNIHRv
IHRoZQ0KPiBJUFUgaXMgYnJva2VuLg0KDQpJIHdhcyB3b25kZXJpbmcgaWYgdGhlcmUgaXMgc29t
ZSBraW5kIG9mIHBhZ2UgZmF1bHQgb24gdGhlIGZpcnN0IGFjY2Vzcz8NCg0KV2hhdCBoYXBwZW5z
IGlmIHlvdSByZXBlYXQgdGhlIHdyaXRlKCkgPw0KDQpGV0lXIHlvdSBkb24ndCB3YW50IHRvIHRy
eSB0aGlzIG9uIHg4Ni4NClRoZSBNTUlPIGFkZHJlc3NlcyBhcmUgbGlrZWx5IHRvIGJlIHVuY2Fj
aGVkIGJ1dCB0aGUgY29weQ0KZnVuY3Rpb24gaXMgbGlrZWx5IHRvIGRlY2lkZSB0byB1c2UgdGhl
IEVSTVMgJ3JlcCBtb3ZzYicgc28NCnN1ZGRlbmx5IHlvdSBnZXQgc2luZ2xlIGJ5dGUgUENJZSBy
ZWFkcyENCldoYXQgeW91IHJlYWxseSB3YW50IGlzIHRoZSBsYXJnZXN0IEFWWCByZWdpc3RlciBh
dmFpbGFibGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

