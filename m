Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11E13F853E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhHZKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:23:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30453 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233654AbhHZKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:23:15 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-70-jdU_6h5gMCqvi412VMHH6Q-1; Thu, 26 Aug 2021 11:22:26 +0100
X-MC-Unique: jdU_6h5gMCqvi412VMHH6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 26 Aug 2021 11:22:25 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 26 Aug 2021 11:22:25 +0100
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
Thread-Index: AQHXmLmWEBrRSWSvqkChOMAmAhSABKuFfA1QgAAL0aSAAA6eAA==
Date:   Thu, 26 Aug 2021 10:22:25 +0000
Message-ID: <64112dfd8e8b472ab78ca8b4837dc9e9@AcuMS.aculab.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
 <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
 <20210826122221.5d2b0f37@gmail.com>
 <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
In-Reply-To: <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
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

RnJvbTogUGF2ZWwgU2tyaXBraW4NCj4gU2VudDogMjYgQXVndXN0IDIwMjEgMTA6MjgNCj4gDQo+
IE9uIDgvMjYvMjEgMTI6MjIgUE0sIFBhdmVsIFNrcmlwa2luIHdyb3RlOg0KPiA+IE9uIFRodSwg
MjYgQXVnIDIwMjEgMDg6NTE6MjMgKzAwMDANCj4gPiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBBQ1VMQUIuQ09NPiB3cm90ZToNCi4uLg0KPiA+PiAuLi4NCj4gPj4gPiAtc3RhdGljIHUzMiB1
c2JfcmVhZDMyKHN0cnVjdCBpbnRmX2hkbCAqcGludGZoZGwsIHUzMiBhZGRyKQ0KPiA+PiA+ICtz
dGF0aWMgaW50IHVzYl9yZWFkMzIoc3RydWN0IGludGZfaGRsICpwaW50ZmhkbCwgdTMyIGFkZHIs
IHUzMg0KPiA+PiA+ICpkYXRhKSB7DQo+ID4+ID4gIAl1OCByZXF1ZXN0dHlwZTsNCj4gPj4gPiAg
CXUxNiB3dmFsdWU7DQo+ID4+ID4gIAl1MTYgbGVuOw0KPiA+PiA+IC0JX19sZTMyIGRhdGE7DQo+
ID4+ID4gKwlpbnQgcmVzOw0KPiA+PiA+ICsJX19sZTMyIHRtcDsNCj4gPj4gPiArDQo+ID4+ID4g
KwlpZiAoV0FSTl9PTih1bmxpa2VseSghZGF0YSkpKQ0KPiA+PiA+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiA+PiA+DQo+ID4+DQo+ID4+IEtpbGwgdGhlIE5VTEwgY2hlY2sgLSBpdCBpcyBhIHNpbGx5
IGNvZGluZyBlcnJvci4NCj4gPj4gQW4gT09QUyBpcyBqdXN0IGFzIGVhc3kgdG8gZGVidWcuDQo+
ID4+DQo+ID4NCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhhdCBvbmUgc2luZ2xlIGRyaXZlciBz
aG91bGQga2lsbCB0aGUgd2hvbGUgc3lzdGVtLiBJdCdzDQo+ID4gMTAwJSBhbiBlcnJvciwgYnV0
IGtlcm5lbCBjYW4gcmVjb3ZlciBmcm9tIGl0IChmb3IgZXhhbXBsZSBkaXNjb25uZWN0DQo+ID4g
dGhlIGRyaXZlciwgc2luY2UgaXQncyBicm9rZW4pLg0KPiA+DQo+ID4NCj4gPiBBRklBSywgR3Jl
ZyBhbmQgTGludXMgZG8gbm90IGxpa2UgQlVHX09OcyBpbiByZWNvdmVyYWJsZSBzdGF0ZS4uLg0K
PiA+IENvcnJlY3QgbWUsIGlmIEkgYW0gd3JvbmcNCj4gPg0KPiBPb3BzLCBJIHRob3VnaHQgYWJv
dXQgQlVHX09OKCkgaW5zdGVhZCBvZiBXQVJOX09OKCksIHNvcnJ5IGZvcg0KPiBjb25mdXNpb24u
IE15IHBvaW50IGlzICJ3ZSBzaG91bGQgbm90IGxldCB0aGUgYm94IGJvb20iLg0KDQoNClRoZXJl
IGlzIG5vIHBvaW50IGNoZWNraW5nIGZvciBOVUxMIHRoYXQganVzdCBjYW4ndCBoYXBwZW4uDQpJ
biB0aGlzIGNhc2UgYWxsIHRoZSBjYWxsZXJzIHdpbGwgcGFzcyB0aGUgYWRkcmVzcyBvZiBhIGxv
Y2FsLg0KVGhlcmUgcmVhbGx5IGlzIG5vIHBvaW50IGNoZWNraW5nLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

