Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74953738AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhEEKmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:42:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56831 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhEEKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:42:48 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-gJphzZkLOp26gH2Db_oSXQ-1; Wed, 05 May 2021 11:41:45 +0100
X-MC-Unique: gJphzZkLOp26gH2Db_oSXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 11:41:44 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 11:41:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Vladislav K. Valtchev'" <vladislav.valtchev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gcc@vger.kernel.org" <linux-gcc@vger.kernel.org>
Subject: RE: GCC, unaligned access and UB in the Linux kernel
Thread-Topic: GCC, unaligned access and UB in the Linux kernel
Thread-Index: AQHXQRBnIBNbmTwiK0CwqzjE4VzA6arUr7NQ
Date:   Wed, 5 May 2021 10:41:44 +0000
Message-ID: <fbe611b513f140b5be570e9d3d94e84d@AcuMS.aculab.com>
References: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
In-Reply-To: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
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

RnJvbTogVmxhZGlzbGF2IEsuIFZhbHRjaGV2DQo+IFNlbnQ6IDA0IE1heSAyMDIxIDE5OjA4DQo+
IA0KPiBIaSBldmVyeW9uZSwNCj4gDQo+IEkgbm90aWNlZCB0aGF0IGluIHRoZSBMaW51eCBrZXJu
ZWwgd2UgaGF2ZSBhIGRlZmluZSBjYWxsZWQNCj4gQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJ
R05FRF9BQ0NFU1MgdGhhdCdzIHVzZWQgaW4gYSBmYWlyIGFtb3VudCBvZiBwbGFjZXMNCj4gd2l0
aCB0aGUgZm9sbG93aW5nIHB1cnBvc2U6IHdoZW4gaXQncyBzZXQsIHVuYWxpZ25lZCBhY2Nlc3Mg
aXMgc3VwcG9ydGVkIGJ5IHRoZQ0KPiBDUFUgc28gd2UgY2FuIGRvIGl0IGRpcmVjdGx5LCBvdGhl
cndpc2UgZmFsbC1iYWNrIHRvIHNvbWUgbG9naWMgd2hlcmUgYSBieXRlIGF0DQo+IHRoZSB0aW1l
IGlzIHJlYWQvd3JpdHRlbi4gRm9yIGV4YW1wbGUsIGNoZWNrIHRoZSBpbXBsZW1lbnRhdGlvbiBv
Zg0KPiBkb19zdHJuY3B5X2Zyb21fdXNlcigpOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC9sYXRlc3Qvc291cmNlL2xpYi9zdHJuY3B5X2Zyb21fdXNlci5jI0wxNQ0KPiANCj4g
DQo+IFRoYXQncyBuaWNlIGFuZCBzZWVtcyB0byB3b3JrIHRvZGF5IGFzIGV4cGVjdGVkLCBidXQg
dGhlcmUncyBvbmUgcHJvYmxlbToNCj4gdW5hbGlnbmVkIGFjY2VzcyBpcyBVQiBhY2NvcmRpbmcg
dG8gdGhlIElTTyBDIHN0YW5kYXJkLCAuLi4NCg0KVGhlIEMgc3RhbmRhcmQgaXNuJ3QgcmVsZXZh
bnQuDQoNCi4uLg0KPiANCj4gTWl0aWdhdGlvbnMNCj4gLS0tLS0tLS0tLS0tDQo+IEluIG15IHVu
ZGVyc3RhbmRpbmcsIHRoZSBzaW1wbGVzdCB3YXkgdG8gZm9yY2UgR0NDIHRvIGVtaXQgYSBzaW5n
bGUgTU9WDQo+IGluc3RydWN0aW9uIHdpdGggdW5hbGlnbmVkIGFjY2Vzcywgd2l0aG91dCByaXNr
aW5nIGFueSBraW5kIG9mIFVCLCBpcyB0byB1c2UNCj4gX19idWlsdGluX21lbWNweSgpLiBJdCB3
b3JrcyBncmVhdCwgYnV0IGl0IHJlcXVpcmVzIGZpeGluZyB0aGUgY29kZSBpbiBtYW55DQo+IHBs
YWNlcy4gQWxzbywgbWF5YmUgdXNpbmcgZ2V0X3VuYWxpZ25lZCgpL3B1dF91bmFsaWduZWQoKSBp
cyB0aGUgcmlnaHQgdGhpbmcgdG8NCj4gZG8/IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHB1dF91
bmFsaWduZWRfKiBpbmxpbmUgZnVuY3Rpb25zIGRvbid0IHVzZQ0KPiBfX2J1aWx0aW5fbWVtY3B5
KCkgYW5kIGFyZSBkZWZpbmVkIGxpa2U6DQo+IA0KPiAgICBzdGF0aWMgX19hbHdheXNfaW5saW5l
IHZvaWQgcHV0X3VuYWxpZ25lZF9sZTMyKHUzMiB2YWwsIHZvaWQgKnApDQo+ICAgIHsNCj4gICAg
CSooKF9fbGUzMiAqKXApID0gY3B1X3RvX2xlMzIodmFsKTsNCj4gICAgfQ0KPiANCj4gU28sIHN0
aWxsIFVCLiBUbyBtYWtlIHRoZSBjb21waWxlciBoYXBweSwgbWF5YmUgd2Ugc2hvdWxkIG1ha2Ug
dGhlbSB1c2UNCj4gX19idWlsdGluX21lbWNweSgpPw0KDQpUaGF0IGRvZXNuJ3QgaGVscCB5b3Ug
YXQgYWxsLg0KSWYgdGhlIGNvbXBpbGVyIGlzIGdpdmVuIGFueSBoaW50IHRoYXQgdGhlIGFkZHJl
c3MgaXMgYWxpZ25lZA0KaXQgd2lsbCB1c2UgcG90ZW50aWFsbHkgbWlzYWxpZ25lZCBtZW1vcnkg
YWNjZXNzZXMuDQpTbyBpZiB0aGUgYWJvdmUgd2FzOg0KCSooaW50IF9fYXR0cmlidXRlX18oKHBh
Y2tlZCkpICopcCA9IHZhbDsNCmFuZCB0aGUgY2FsbGVyIGhhZDoNCglpbnQgKnAgPSBtYXliZV91
bmFsaWduZWQoKTsNCglwdXRfdW5hbGlnbmVkX2xlMzIoMCwgcCk7DQoNClRoZW4gZ2NjIHdpbGwg
Z2VuZXJhdGUgYSAzMmJpdCB3cml0ZSBldmVuIG9uIHNwYXJjLg0KX19idWlsdGluX21lbWNweSgp
IHdpbGwgZXhwYW5kIHRvIGV4YWN0bHkgdGhlIHNhbWUgMzJiaXQgd3JpdGUuDQoNClRoaXMgaXMg
bm90aGluZyBuZXcgLSBhdCBsZWFzdCAyMCB5ZWFycy4NCg0KQmFzaWNhbGx5LCB0aGUgQyBzdGFu
ZGFyZCBvbmx5IGFsbG93cyB5b3UgdG8gY2FzdCBhIHBvaW50ZXINCnRvICd2b2lkIConIGFuZCB0
aGVuIGJhY2sgdG8gaXRzIG9yaWdpbmFsIHR5cGUuDQpHQ0MgbWFrZXMgdXNlIG9mIHRoaXMgZm9y
IHZhcmlvdXMgb3B0aW1pc2F0aW9ucyBhbmQgd2lsbA0KdHJhY2sgdGhlIGFsaWdubWVudCB0aHJv
dWdoICh2b2lkICopIGNhc3RzLg0KDQpJIGJlbGlldmUgdGhhdCwgZXZlbiBmb3IgdGhlIHNpbWQg
aW5zdHJ1Y3Rpb25zLCBnY2Mgd2lsbCBwaWNrDQp0aGUgJ21pc2FsaWduIHN1cHBvcnRpbmcnIHZl
cnNpb24gaWYgdGhlIGRhdGEgaXMgbWFya2VkDQp3aXRoIHRoZSByZWxldmFudCBhbGlnbm1lbnQu
DQoNCk9oIC0gYW5kIHRoZSBsb29wIHZlY3RvcmlzYXRpb24gY29kZSBpcyBhIHBpbGUgb2YgY3Jh
cC4NCllvdSBhbG1vc3QgbmV2ZXIgd2FudCBpdCAtIGxvb2sgYXQgdGhlIGNvZGUgaXQgZ2VuZXJh
dGVzDQpmb3IgYSBsb29wIHlvdSBnbyByb3VuZCBhIGZldyB0aW1lcy4NCkl0IHlvdSBhcmUgZG9p
bmcgMTAwMDAgaXRlcmFjdGlvbnMgeW91J2xsIG5lZWQgdG8gdW5yb2xsDQppdCB5b3Vyc2VsZiB0
byBnZXQgZGVjZW50IHBlcmZvcm1hbmNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

