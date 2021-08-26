Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245D3F85FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbhHZLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:00:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:37927 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231485AbhHZLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:00:04 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-134-nqs-ywOzPm6iLEti_q1Q6w-1; Thu, 26 Aug 2021 11:59:15 +0100
X-MC-Unique: nqs-ywOzPm6iLEti_q1Q6w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 26 Aug 2021 11:59:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 26 Aug 2021 11:59:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Skripkin' <paskripkin@gmail.com>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
Thread-Topic: [PATCH v3 5/6] staging: r8188eu: add error handling of
 rtw_read32
Thread-Index: AQHXmLmWEBrRSWSvqkChOMAmAhSABKuFfA1QgAAL0aSAAA6eAP//+O+AgAAR02A=
Date:   Thu, 26 Aug 2021 10:59:14 +0000
Message-ID: <6e864f9d133d4db3923190f5acacc32a@AcuMS.aculab.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
 <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
 <20210826122221.5d2b0f37@gmail.com>
 <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
 <64112dfd8e8b472ab78ca8b4837dc9e9@AcuMS.aculab.com>
 <0eb2bbc6-9d35-9ff3-acde-fd89bbe0ca27@gmail.com>
In-Reply-To: <0eb2bbc6-9d35-9ff3-acde-fd89bbe0ca27@gmail.com>
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

RnJvbTogUGF2ZWwgU2tyaXBraW4NCj4gU2VudDogMjYgQXVndXN0IDIwMjEgMTE6NTUNCj4gDQo+
IE9uIDgvMjYvMjEgMToyMiBQTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IFBhdmVs
IFNrcmlwa2luDQo+ID4+IFNlbnQ6IDI2IEF1Z3VzdCAyMDIxIDEwOjI4DQo+ID4+DQo+ID4+IE9u
IDgvMjYvMjEgMTI6MjIgUE0sIFBhdmVsIFNrcmlwa2luIHdyb3RlOg0KPiA+PiA+IE9uIFRodSwg
MjYgQXVnIDIwMjEgMDg6NTE6MjMgKzAwMDANCj4gPj4gPiBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBBQ1VMQUIuQ09NPiB3cm90ZToNCj4gPiAuLi4NCj4gPj4gPj4gLi4uDQo+ID4+ID4+ID4g
LXN0YXRpYyB1MzIgdXNiX3JlYWQzMihzdHJ1Y3QgaW50Zl9oZGwgKnBpbnRmaGRsLCB1MzIgYWRk
cikNCj4gPj4gPj4gPiArc3RhdGljIGludCB1c2JfcmVhZDMyKHN0cnVjdCBpbnRmX2hkbCAqcGlu
dGZoZGwsIHUzMiBhZGRyLCB1MzINCj4gPj4gPj4gPiAqZGF0YSkgew0KPiA+PiA+PiA+ICAJdTgg
cmVxdWVzdHR5cGU7DQo+ID4+ID4+ID4gIAl1MTYgd3ZhbHVlOw0KPiA+PiA+PiA+ICAJdTE2IGxl
bjsNCj4gPj4gPj4gPiAtCV9fbGUzMiBkYXRhOw0KPiA+PiA+PiA+ICsJaW50IHJlczsNCj4gPj4g
Pj4gPiArCV9fbGUzMiB0bXA7DQo+ID4+ID4+ID4gKw0KPiA+PiA+PiA+ICsJaWYgKFdBUk5fT04o
dW5saWtlbHkoIWRhdGEpKSkNCj4gPj4gPj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4gPj4g
Pg0KPiA+PiA+Pg0KPiA+PiA+PiBLaWxsIHRoZSBOVUxMIGNoZWNrIC0gaXQgaXMgYSBzaWxseSBj
b2RpbmcgZXJyb3IuDQo+ID4+ID4+IEFuIE9PUFMgaXMganVzdCBhcyBlYXN5IHRvIGRlYnVnLg0K
PiA+PiA+Pg0KPiA+PiA+DQo+ID4+ID4NCj4gPj4gPiBJIGRvbid0IHRoaW5rIHRoYXQgb25lIHNp
bmdsZSBkcml2ZXIgc2hvdWxkIGtpbGwgdGhlIHdob2xlIHN5c3RlbS4gSXQncw0KPiA+PiA+IDEw
MCUgYW4gZXJyb3IsIGJ1dCBrZXJuZWwgY2FuIHJlY292ZXIgZnJvbSBpdCAoZm9yIGV4YW1wbGUg
ZGlzY29ubmVjdA0KPiA+PiA+IHRoZSBkcml2ZXIsIHNpbmNlIGl0J3MgYnJva2VuKS4NCj4gPj4g
Pg0KPiA+PiA+DQo+ID4+ID4gQUZJQUssIEdyZWcgYW5kIExpbnVzIGRvIG5vdCBsaWtlIEJVR19P
TnMgaW4gcmVjb3ZlcmFibGUgc3RhdGUuLi4NCj4gPj4gPiBDb3JyZWN0IG1lLCBpZiBJIGFtIHdy
b25nDQo+ID4+ID4NCj4gPj4gT29wcywgSSB0aG91Z2h0IGFib3V0IEJVR19PTigpIGluc3RlYWQg
b2YgV0FSTl9PTigpLCBzb3JyeSBmb3INCj4gPj4gY29uZnVzaW9uLiBNeSBwb2ludCBpcyAid2Ug
c2hvdWxkIG5vdCBsZXQgdGhlIGJveCBib29tIi4NCj4gPg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8g
cG9pbnQgY2hlY2tpbmcgZm9yIE5VTEwgdGhhdCBqdXN0IGNhbid0IGhhcHBlbi4NCj4gPiBJbiB0
aGlzIGNhc2UgYWxsIHRoZSBjYWxsZXJzIHdpbGwgcGFzcyB0aGUgYWRkcmVzcyBvZiBhIGxvY2Fs
Lg0KPiA+IFRoZXJlIHJlYWxseSBpcyBubyBwb2ludCBjaGVja2luZy4NCj4gPg0KPiANCj4gV2Ug
bm90IGFsd2F5cyByZWFkIGluIGxvY2FsIHZhcmlhYmxlLCB0aGVyZSBhcmUgZmV3IHBsYWNlcywg
d2hlcmUgd2UNCj4gcmVhZCBpbnRvIHBhc3NlZCBidWZmZXIuDQoNCkl0IGlzIHN0aWxsIGEgdmVy
eSBsb2NhbCBjb2RpbmcgYnVnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

