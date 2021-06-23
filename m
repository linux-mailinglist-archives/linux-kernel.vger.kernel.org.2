Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E23B1B02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFWNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:25:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30513 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhFWNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:25:12 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-206-aLBAZPbBMtOpePwVytsljw-1; Wed, 23 Jun 2021 14:22:51 +0100
X-MC-Unique: aLBAZPbBMtOpePwVytsljw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 14:22:51 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 23 Jun 2021 14:22:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hans-Gert Dahmen' <hans-gert.dahmen@immu.ne>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Thread-Topic: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Thread-Index: AQHXZ3I2QVY8Y0IZxk6JOQtZcZz8kKsgmXGQgADafQCAACJ5oA==
Date:   Wed, 23 Jun 2021 13:22:51 +0000
Message-ID: <6c6b6888e9994791a8044c8d8ad1fee5@AcuMS.aculab.com>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
 <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
In-Reply-To: <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
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

RnJvbTogSGFucy1HZXJ0IERhaG1lbg0KPiBTZW50OiAyMyBKdW5lIDIwMjEgMTM6MTgNCj4gDQo+
IHRoZXNlIGFyZSBzb21lIGdvb2QgcG9pbnRzLg0KPiANCj4gT24gMjMuMDYuMjEgMDA6MTgsIERh
dmlkIExhaWdodCB3cm90ZToNCj4gPiBBcmUgeW91IHNheWluZyB0aGF0IG15IDE1IHllYXIgb2xk
IDY0Yml0IEF0aGxvbiBjcHUgYW5kIGJpb3MNCj4gPiBoYXZlIHRoaXMgbGFyZ2UgU1BJIGZsYXNo
DQo+IA0KPiBOby4gVGhlIHJlYWRzIHdpbGwgd3JhcCwgaS5lLiBpZiB5b3VyIGZsYXNoIGlzIDJN
QiB0aGVuIGl0IHdvdWxkIGJlDQo+IHJlcGVhdGVkIDggdGltZXMgaW4gdGhlIDE2TUIgd2luZG93
Lg0KPiANCj4gPiBhbmQgdGhlIHJlcXVpcmVkIGhhcmR3YXJlIHRvDQo+ID4gY29udmVydCBidXMg
Y3ljbGVzIHRvIHNlcmlhbCBzcGkgcmVhZHM/DQo+IA0KPiBZZXMuIFRoZSB3aW5kb3cgaXMgcGFy
dCBvZiB0aGUgRE1JIGludGVyZmFjZSBhbmQgdGhlIHNvdXRoIGJyaWRnZSBvciBQQ0gNCj4gY29u
dmVydHMgdGhlIGJ1cyBjeWNsZXMgdG8gU1BJIHJlYWRzLiBJdCBpcyBiZWNhdXNlIHRoaXMgcmVn
aW9uIGNvbnRhaW5zDQo+IHRoZSByZXNldCB2ZWN0b3IgYWRkcmVzcyBvZiB5b3VyIENQVSBhbmQg
dGhlIHZlcnkgZmlyc3QgaW5zdHJ1Y3Rpb24gaXQNCj4gZXhlY3V0ZXMgYWZ0ZXIgYSByZXNldCB3
aGVuIHRoZSBpbnRlcm5hbCBzZXR1cCBpcyBkb25lIHdpbGwgYWN0dWFsbHkgYmUNCj4gbG9hZGVk
IGZyb20gdGhlIHNlcmlhbCBTUEkgYnVzLiBJdCBpcyBBRkFJSyBwYXJ0IG9mIEFNRCdzIG9yaWdp
bmFsDQo+IDY0LWJpdCBzcGVjaWZpY2F0aW9uLg0KPiANCj4gSG93ZXZlciwgYWZ0ZXIgcmVhZGlu
ZyB5b3VyIG1haWwgSSB1bmRlcnN0YW5kIHRoYXQgSSBzaG91bGQgaGF2ZSBsb29rZWQNCj4gdXAg
dGhlIGV4YWN0IGV4cGxhbmF0aW9ucyBpbiB0aGUgcmVzcGVjdGl2ZSBzcGVjcy4gU28gdG8gZGVm
aW5pdGl2ZWx5DQo+IGFuc3dlciB5b3VyIHF1ZXN0aW9uIEkgbmVlZCB0byBrbm93IHdoaWNoIHNv
dXRoIGJyaWRnZSB0aGVyZSBpcyBpbiB5b3VyDQo+IDE1IHllYXIgb2xkIHN5c3RlbSBhbmQgaGF2
ZSBhIGxvb2sgaW50byBpdHMgZGF0YXNoZWV0LiBEbyB5b3Uga25vdyB3aGljaA0KPiBvbmUgaXQg
aXMgYnkgYW55IGNoYW5jZT8NCg0KQWJzb2x1dGVseSBubyBpZGVhLg0KVGhhdCBwYXJ0aWN1bGFy
IHN5c3RlbSBkb2Vzbid0IGFjdHVhbGx5IGJvb3QgYW55IG1vcmUNCndpdGggZWl0aGVyIGNwdSBJ
IGhhdmUgZm9yIGl0IHBsdWdnZWQgaXQuDQpJIHN1c3BlY3QgdGhlIHBzdSB2b2x0YWdlcyBhcmUg
b3V0IG9mIHJhbmdlIGFuZCBoYXZlIGJyb2tlbiBpdC4NCg0KQnV0IHRoYXQgaXNuJ3QgdGhlIHBv
aW50Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

