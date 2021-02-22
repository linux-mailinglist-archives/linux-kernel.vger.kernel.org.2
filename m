Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A532108D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBVFvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:51:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31650 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhBVFvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:51:12 -0500
X-UUID: 38c129b314da4a69957d86c22d7d5fe2-20210222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nqKImsvcZdKwTXpwc5QzWpqx3pFjWlmpqLQWHoUe6n8=;
        b=Hhvx7Zpn5gNnuT+99B7xw9lsgH6AMGaf9kkrw9bRJHrNGwv+F8WWg43jARh0UUcGSej5WOjGlkiWrh/m+VtOLdi+4wF2MEZgS3aJdgyNaR1dlgakSXbJIVe++pRAa15hRKNV1WenUwzHFOMf40bS7Qg8MG6n3v3EHbO8MKjt4iI=;
X-UUID: 38c129b314da4a69957d86c22d7d5fe2-20210222
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 378039218; Mon, 22 Feb 2021 13:50:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Feb
 2021 13:50:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Feb 2021 13:50:17 +0800
Message-ID: <1613973017.31669.5.camel@mhfsdcap03>
Subject: Re: [RFC PATCH v2 2/3] usb: xhci-mtk: modify the SOF/ITP interval
 for mt8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ikjoon Jang" <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 22 Feb 2021 13:50:17 +0800
In-Reply-To: <c0a65a3b-aec9-e27e-9110-9713596b9ecd@linux.intel.com>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
         <20210203102642.7353-2-chunfeng.yun@mediatek.com>
         <1612664833.5147.30.camel@mhfsdcap03>
         <c0a65a3b-aec9-e27e-9110-9713596b9ecd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FAE0441427E52403E8BEE5458F274B90BF2277165CA50BE675B433B94E9E2C372000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTA4IGF0IDEzOjQzICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiA3LjIuMjAyMSA0LjI3LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gSGkgTWF0aGlhcywN
Cj4gPiANCj4gPiBPbiBXZWQsIDIwMjEtMDItMDMgYXQgMTg6MjYgKzA4MDAsIENodW5mZW5nIFl1
biB3cm90ZToNCj4gPj4gVGhlcmUgYXJlIDQgVVNCIGNvbnRyb2xsZXJzIG9uIE1UODE5NSwgdGhl
IGNvbnRyb2xsZXJzIChJUDF+SVAzLA0KPiA+PiBleGNsdWRlIElQMCkgaGF2ZSBhIHdyb25nIGRl
ZmF1bHQgU09GL0lUUCBpbnRlcnZhbCB3aGljaCBpcw0KPiA+PiBjYWxjdWxhdGVkIGZyb20gdGhl
IGZyYW1lIGNvdW50ZXIgY2xvY2sgMjRNaHogYnkgZGVmYXVsdCwgYnV0DQo+ID4+IGluIGZhY3Qs
IHRoZSBmcmFtZSBjb3VudGVyIGNsb2NrIGlzIDQ4TWh6LCBzbyB3ZSBzaG91bGQgc2V0DQo+ID4+
IHRoZSBhY2N1cmF0ZSBpbnRlcnZhbCBhY2NvcmRpbmcgdG8gNDhNaHogZm9yIHRob3NlIGNvbnRy
b2xsZXJzLg0KPiA+PiBOb3RlOiB0aGUgZmlyc3QgY29udHJvbGxlciBubyBuZWVkIHNldCBpdC4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KPiA+PiAtLS0NCj4gPj4gdjI6IGZpeCB0eXBvIG9mIGNvbWFwdGlibGUNCj4g
Pj4gLS0tDQo+ID4+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCA2MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNjMgaW5z
ZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4+IGluZGV4IDhmMzIxZjM5
YWI5Ni4uMGE2OGM0YWM4YjQ4IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktbXRrLmMNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4+IEBA
IC02OCwxMSArNjgsNzEgQEANCj4gPj4gICNkZWZpbmUgU1NDX0lQX1NMRUVQX0VOCUJJVCg0KQ0K
PiA+PiAgI2RlZmluZSBTU0NfU1BNX0lOVF9FTgkJQklUKDEpDQo+ID4+ICANCj4gPiBDYW4gSSBS
ZWFkL1dyaXRlIHRoZSBmb2xsb3dpbmcgeEhDSSBjb250cm9sbGVyJ3MgcmVnaXN0ZXJzICBpbg0K
PiA+IHhoY2ktbXRrLmM/DQo+ID4gDQo+ID4gSWRlYWxseSwgeGhjaS1tdGsuYyBzaG91bGQgbm90
IGFjY2VzcyB0aGVtLCBiZWNhdXNlIHhoY2ktbXRrIGlzIG9ubHkgYQ0KPiA+IGdsdWUgZHJpdmVy
IHVzZWQgdG8gaW5pdGlhbGl6ZSBjbG9ja3MvcG93ZXIgYW5kIElQUEMgcmVnaXN0ZXJzIHdoaWNo
DQo+ID4gZG9uJ3QgYmVsb25nIHRvIHhIQ0kgY29udHJvbGxlci4NCj4gPiANCj4gDQo+IFRoZXNl
ICpfRU9GIHJlZ2lzdGVycyBsb29rIGxpa2UgdGhleSBhcmUgTWVkaWF0ZWsgdmVuZG9yIHNwZWNp
ZmljIHJlZ2lzdGVycw0KPiBhbmQgbm90IHBhcnQgb2YgcHVibGljIHhIQ0kgcmVnaXN0ZXItbGV2
ZWwgc3BlYy4gDQo+IFNvIEkgdGhpbmsgYWNjZXNzaW5nIHRoZW0gZnJvbSB4aGNpLW10ay5jIG1h
a2VzIHNlbnNlLg0KPiANCj4gSWYgdGhvc2UgcmVnaXN0ZXIgb2Zmc2V0cyBhcmUgaGFyZGNvZGVk
IGxpa2UgdGhpcyBpbiB0aGUgTWVkaWF0ZWsgc3BlYyB0aGVuDQo+IHRoaXMgaXMgZmluZSwgDQpD
aGVjayBpdCB3aXRoIG91ciBERSwgaXQncyB0aGlzIGNhc2UuDQo+IGJ1dCBpZiB0aG9zZSBvZmZz
ZXRzIGFyZSBmb3VuZCBmcm9tIGEgdmVuZG9yIHNwZWNpZmljIHhIQ0kNCj4gZXh0ZW5kZWQgY2Fw
YWJpbGl0eSBlbnRyeSAoc2VlIHhoY2kgc3BlYyBzZWN0aW9uIDcpIHRoZW4gd2Ugc2hvdWxkIGRp
ZyB0aGVtIG91dA0KPiBmcm9tIHRoZXJlLiANCj4gPj4gKy8qIHhIQ0kgY3NyICovDQo+ID4+ICsj
ZGVmaW5lIExTX0VPRgkJCTB4OTMwDQo+ID4+ICsjZGVmaW5lIExTX0VPRl9PRkZTRVQJCTB4ODkN
Cj4gPj4gKw0KPiA+PiArI2RlZmluZSBGU19FT0YJCQkweDkzNA0KPiA+PiArI2RlZmluZSBGU19F
T0ZfT0ZGU0VUCQkweDJlDQo+ID4+ICsNCj4gPj4gKyNkZWZpbmUgU1NfR0VOMV9FT0YJCTB4OTNj
DQo+ID4+ICsjZGVmaW5lIFNTX0dFTjFfRU9GX09GRlNFVAkweDc4DQo+ID4+ICsNCj4gPj4gKyNk
ZWZpbmUgSEZDTlRSX0NGRwkJMHg5NDQNCj4gPj4gKyNkZWZpbmUgSVRQX0RFTFRBX0NMSwkJKDB4
YSA8PCAxKQ0KPiA+PiArI2RlZmluZSBJVFBfREVMVEFfQ0xLX01BU0sJR0VOTUFTSyg1LCAxKQ0K
PiA+PiArI2RlZmluZSBGUk1DTlRfTEVWMV9SQU5HCSgweDEyYiA8PCA4KQ0KPiA+PiArI2RlZmlu
ZSBGUk1DTlRfTEVWMV9SQU5HX01BU0sJR0VOTUFTSygxOSwgOCkNCj4gPj4gKw0KPiA+PiArI2Rl
ZmluZSBTU19HRU4yX0VPRgkJMHg5OTANCj4gPj4gKyNkZWZpbmUgU1NfR0VOMl9FT0ZfT0ZGU0VU
CTB4M2MNCj4gPj4gKyNkZWZpbmUgRU9GX09GRlNFVF9NQVNLCQlHRU5NQVNLKDExLCAwKQ0KPiA+
PiArDQo+ID4+ICBlbnVtIHNzdXNiX3V3a192ZXJzIHsNCj4gPj4gIAlTU1VTQl9VV0tfVjEgPSAx
LA0KPiA+PiAgCVNTVVNCX1VXS19WMiwNCj4gPj4gIH07DQo+ID4+ICANCj4gPj4gKy8qDQo+ID4+
ICsgKiBNVDgxOTUgaGFzIDQgY29udHJvbGxlcnMsIHRoZSBjb250cm9sbGVyMX4zJ3MgZGVmYXVs
dCBTT0YvSVRQIGludGVydmFsDQo+ID4+ICsgKiBpcyBjYWxjdWxhdGVkIGZyb20gdGhlIGZyYW1l
IGNvdW50ZXIgY2xvY2sgMjRNLCBidXQgaW4gZmFjdCwgdGhlIGNsb2NrDQo+ID4+ICsgKiBpcyA0
OE0sIHNvIG5lZWQgY2hhbmdlIHRoZSBpbnRlcnZhbC4NCj4gPj4gKyAqLw0KPiA+PiArc3RhdGlj
IHZvaWQgeGhjaV9tdGtfc2V0X2ZyYW1lX2ludGVydmFsKHN0cnVjdCB4aGNpX2hjZF9tdGsgKm10
aykNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtdGstPmRldjsNCj4gPj4g
KwlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gbXRrLT5oY2Q7DQo+ID4+ICsJdTMyIHZhbHVlOw0KPiA+
PiArDQo+ID4+ICsJaWYgKCFvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJt
ZWRpYXRlayxtdDgxOTUteGhjaSIpKQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gKwl2
YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIEhGQ05UUl9DRkcpOw0KPiA+PiArCXZhbHVlICY9IH4o
SVRQX0RFTFRBX0NMS19NQVNLIHwgRlJNQ05UX0xFVjFfUkFOR19NQVNLKTsNCj4gPj4gKwl2YWx1
ZSB8PSAoSVRQX0RFTFRBX0NMSyB8IEZSTUNOVF9MRVYxX1JBTkcpOw0KPiA+PiArCXdyaXRlbCh2
YWx1ZSwgaGNkLT5yZWdzICsgSEZDTlRSX0NGRyk7DQo+ID4+ICsNCj4gPj4gKwl2YWx1ZSA9IHJl
YWRsKGhjZC0+cmVncyArIExTX0VPRik7DQo+ID4+ICsJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFT
SzsNCj4gPj4gKwl2YWx1ZSB8PSBMU19FT0ZfT0ZGU0VUOw0KPiA+PiArCXdyaXRlbCh2YWx1ZSwg
aGNkLT5yZWdzICsgTFNfRU9GKTsNCj4gPj4gKw0KPiA+PiArCXZhbHVlID0gcmVhZGwoaGNkLT5y
ZWdzICsgRlNfRU9GKTsNCj4gPj4gKwl2YWx1ZSAmPSB+RU9GX09GRlNFVF9NQVNLOw0KPiA+PiAr
CXZhbHVlIHw9IEZTX0VPRl9PRkZTRVQ7DQo+ID4+ICsJd3JpdGVsKHZhbHVlLCBoY2QtPnJlZ3Mg
KyBGU19FT0YpOw0KPiA+PiArDQo+ID4+ICsJdmFsdWUgPSByZWFkbChoY2QtPnJlZ3MgKyBTU19H
RU4xX0VPRik7DQo+ID4+ICsJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFTSzsNCj4gPj4gKwl2YWx1
ZSB8PSBTU19HRU4xX0VPRl9PRkZTRVQ7DQo+ID4+ICsJd3JpdGVsKHZhbHVlLCBoY2QtPnJlZ3Mg
KyBTU19HRU4xX0VPRik7DQo+ID4+ICsNCj4gPj4gKwl2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyAr
IFNTX0dFTjJfRU9GKTsNCj4gPj4gKwl2YWx1ZSAmPSB+RU9GX09GRlNFVF9NQVNLOw0KPiA+PiAr
CXZhbHVlIHw9IFNTX0dFTjJfRU9GX09GRlNFVDsNCj4gPj4gKwl3cml0ZWwodmFsdWUsIGhjZC0+
cmVncyArIFNTX0dFTjJfRU9GKTsNCj4gDQo+IE1pbm9yIG5pdCBhYm91dCBuYW1lcywNCj4gUmVn
aXN0ZXIgb2Zmc2V0cyBmcm9tIE1NSU8gc3RhcnQgYXJlIG5hbWVkICpfRU9GIHdoaWxlIGNsb2Nr
IG11bHRpcGxpZXJzPyBhcmUgbmFtZWQgKl9FT0ZfT0ZGU0VULg0KPiBUaGlzIHdhcyBhIGJpdCBj
b25mdXNpbmcNCkdvb2QgcG9pbnQsIHRoZSBuYW1lcyBjb21lIGZyb20gcmVnaXN0ZXIgbWFwIGRv
Y3MsIEknbGwgbW9kaWZ5IGl0LA0KdGhhbmtzIGEgbG90DQo+IA0KPiBUaGFua3MNCj4gLU1hdGhp
YXMNCg0K

