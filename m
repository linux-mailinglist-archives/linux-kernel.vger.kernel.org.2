Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8740FB01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbhIQPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:02:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29239 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243677AbhIQPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:02:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-118-P_YM_ZexMOSzGlbBMtakIg-1; Fri, 17 Sep 2021 16:01:29 +0100
X-MC-Unique: P_YM_ZexMOSzGlbBMtakIg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 17 Sep 2021 16:01:27 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 17 Sep 2021 16:01:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of
 rtw_read{8,16,32}()
Thread-Topic: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of
 rtw_read{8,16,32}()
Thread-Index: AQHXq9NTJLbXvqWt40ebp4CiR7TthquoUQPA
Date:   Fri, 17 Sep 2021 15:01:27 +0000
Message-ID: <0331c99f809449e88e5e5be9311aa5a9@AcuMS.aculab.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-18-fmdefrancesco@gmail.com>
 <YUSrIqW5WSYuoa14@kroah.com>
In-Reply-To: <YUSrIqW5WSYuoa14@kroah.com>
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

RnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuDQo+IFNlbnQ6IDE3IFNlcHRlbWJlciAyMDIxIDE1OjUw
DQouLi4NCj4gPiArc3RhdGljIGludCB1c2JfcmVhZChzdHJ1Y3QgaW50Zl9oZGwgKmludGZoZGws
IHUxNiBhZGRyLCB2b2lkICpkYXRhLCB1OCBzaXplKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWRh
cHRlciAqYWRhcHQgPSBpbnRmaGRsLT5wYWRhcHRlcjsNCj4gPiArCXN0cnVjdCBkdm9ial9wcml2
ICpkdm9ianByaXYgPSBhZGFwdGVyX3RvX2R2b2JqKGFkYXB0KTsNCj4gPiArCXN0cnVjdCB1c2Jf
ZGV2aWNlICp1ZGV2ID0gZHZvYmpwcml2LT5wdXNiZGV2Ow0KPiA+ICsJaW50IHN0YXR1czsNCj4g
PiArCXU4ICppb19idWY7IC8qIFBvaW50ZXIgdG8gSS9PIGJ1ZmZlciAqLw0KPiANCj4gQXMgeW91
ICJrbm93IiBzaXplIGlzIG5vdCBnb2luZyB0byBiZSBsYXJnZXIgdGhhbiA0IChoaW50LCB5b3Ug
c2hvdWxkDQo+IHByYm9hYmx5IGNoZWNrIGl0KSwganVzdCB1c2UgYnl0ZXMgb2ZmIG9mIHRoZSBz
dGFjayBoZXJlLCBhbmQgeW91IGNhbg0KPiBpZ25vcmUgdGhpcyBidWZmZXIgZW50aXJlbHkuICBU
aGF0IHdpbGwgaG9wZWZ1bGx5IGFsbG93IHlvdSBpbiB0aGUNCj4gZnV0dXJlIHRvIGdldCByaWQg
b2YgdGhhdCBidWZmZXIgYXMgb2RkcyBhcmUgaXQgd2lsbCBub3QgYmUgbmVlZGVkDQo+IGFueW1v
cmUuDQoNCklzbid0IHRoYXQgbGlrZWx5IHRvIGJlIHRoZSBidWZmZXIgdGhhdCBnZXRzIGRtYSdk
IHRvL2Zyb20/DQpJbiB3aGljaCBjYXNlIGl0IGNhbid0IGJlIG9uLXN0YWNrLg0KQ2VydGFpbmx5
IHRoYXQgaXMgYSBjb21tb24gcHJvYmxlbSB3aXRoIHVzYiBkcml2ZXJzLg0KDQpHaXZlIHRoZSBz
aXplIG9mIHRoZSB1cmI/IHN0cnVjdHVyZSBhbGxvY2F0ZWQgZm9yIGVhY2ggdHJhbnNmZXINCmFk
ZGluZyBhIGJvdW5jZSBidWZmZXIgYXJlYSBpbiBpdCBmb3Igc2hvcnQgdHJhbnNmZXJzIHdvdWxk
DQpzdXJlbHkgYmUgc2FuZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

