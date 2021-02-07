Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C13120E6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 03:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBGC2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 21:28:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229522AbhBGC2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 21:28:06 -0500
X-UUID: 427090c8fe45468bb75431dc3717c8b5-20210207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VLQS2kgvcrI9d6jQ5mQub6mDEUycbvfHKHDUC9bWkD4=;
        b=ZBcJVlW8Ug6o0RvuM6UBbpNtvRd/KcfaU2J/kbzSFXnXXqIbHXZgtzyAjUKCrM6demTCC4WSgxjsuTmmbBnaKTVU+6JqtNeMVi3I5wqTmycsV88mm95LaKj20enjw0SfP4b1ZWXOM0mU+zP6NfPRFAZiR6MZjyrm5iuAfWVlX34=;
X-UUID: 427090c8fe45468bb75431dc3717c8b5-20210207
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 157614869; Sun, 07 Feb 2021 10:27:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 7 Feb
 2021 10:27:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 7 Feb 2021 10:27:13 +0800
Message-ID: <1612664833.5147.30.camel@mhfsdcap03>
Subject: Re: [RFC PATCH v2 2/3] usb: xhci-mtk: modify the SOF/ITP interval
 for mt8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ikjoon Jang" <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 7 Feb 2021 10:27:13 +0800
In-Reply-To: <20210203102642.7353-2-chunfeng.yun@mediatek.com>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
         <20210203102642.7353-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1B014D2086C1D7CBBFCF7F12F97C71D0892D48B7553418545A58616630F2A3202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlhcywNCg0KT24gV2VkLCAyMDIxLTAyLTAzIGF0IDE4OjI2ICswODAwLCBDaHVuZmVu
ZyBZdW4gd3JvdGU6DQo+IFRoZXJlIGFyZSA0IFVTQiBjb250cm9sbGVycyBvbiBNVDgxOTUsIHRo
ZSBjb250cm9sbGVycyAoSVAxfklQMywNCj4gZXhjbHVkZSBJUDApIGhhdmUgYSB3cm9uZyBkZWZh
dWx0IFNPRi9JVFAgaW50ZXJ2YWwgd2hpY2ggaXMNCj4gY2FsY3VsYXRlZCBmcm9tIHRoZSBmcmFt
ZSBjb3VudGVyIGNsb2NrIDI0TWh6IGJ5IGRlZmF1bHQsIGJ1dA0KPiBpbiBmYWN0LCB0aGUgZnJh
bWUgY291bnRlciBjbG9jayBpcyA0OE1oeiwgc28gd2Ugc2hvdWxkIHNldA0KPiB0aGUgYWNjdXJh
dGUgaW50ZXJ2YWwgYWNjb3JkaW5nIHRvIDQ4TWh6IGZvciB0aG9zZSBjb250cm9sbGVycy4NCj4g
Tm90ZTogdGhlIGZpcnN0IGNvbnRyb2xsZXIgbm8gbmVlZCBzZXQgaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiB2MjogZml4IHR5cG8gb2YgY29tYXB0aWJsZQ0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuYyB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+
IGluZGV4IDhmMzIxZjM5YWI5Ni4uMGE2OGM0YWM4YjQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5j
DQo+IEBAIC02OCwxMSArNjgsNzEgQEANCj4gICNkZWZpbmUgU1NDX0lQX1NMRUVQX0VOCUJJVCg0
KQ0KPiAgI2RlZmluZSBTU0NfU1BNX0lOVF9FTgkJQklUKDEpDQo+ICANCkNhbiBJIFJlYWQvV3Jp
dGUgdGhlIGZvbGxvd2luZyB4SENJIGNvbnRyb2xsZXIncyByZWdpc3RlcnMgIGluDQp4aGNpLW10
ay5jPw0KDQpJZGVhbGx5LCB4aGNpLW10ay5jIHNob3VsZCBub3QgYWNjZXNzIHRoZW0sIGJlY2F1
c2UgeGhjaS1tdGsgaXMgb25seSBhDQpnbHVlIGRyaXZlciB1c2VkIHRvIGluaXRpYWxpemUgY2xv
Y2tzL3Bvd2VyIGFuZCBJUFBDIHJlZ2lzdGVycyB3aGljaA0KZG9uJ3QgYmVsb25nIHRvIHhIQ0kg
Y29udHJvbGxlci4NCg0KVGhhbmtzDQoNCj4gKy8qIHhIQ0kgY3NyICovDQo+ICsjZGVmaW5lIExT
X0VPRgkJCTB4OTMwDQo+ICsjZGVmaW5lIExTX0VPRl9PRkZTRVQJCTB4ODkNCj4gKw0KPiArI2Rl
ZmluZSBGU19FT0YJCQkweDkzNA0KPiArI2RlZmluZSBGU19FT0ZfT0ZGU0VUCQkweDJlDQo+ICsN
Cj4gKyNkZWZpbmUgU1NfR0VOMV9FT0YJCTB4OTNjDQo+ICsjZGVmaW5lIFNTX0dFTjFfRU9GX09G
RlNFVAkweDc4DQo+ICsNCj4gKyNkZWZpbmUgSEZDTlRSX0NGRwkJMHg5NDQNCj4gKyNkZWZpbmUg
SVRQX0RFTFRBX0NMSwkJKDB4YSA8PCAxKQ0KPiArI2RlZmluZSBJVFBfREVMVEFfQ0xLX01BU0sJ
R0VOTUFTSyg1LCAxKQ0KPiArI2RlZmluZSBGUk1DTlRfTEVWMV9SQU5HCSgweDEyYiA8PCA4KQ0K
PiArI2RlZmluZSBGUk1DTlRfTEVWMV9SQU5HX01BU0sJR0VOTUFTSygxOSwgOCkNCj4gKw0KPiAr
I2RlZmluZSBTU19HRU4yX0VPRgkJMHg5OTANCj4gKyNkZWZpbmUgU1NfR0VOMl9FT0ZfT0ZGU0VU
CTB4M2MNCj4gKyNkZWZpbmUgRU9GX09GRlNFVF9NQVNLCQlHRU5NQVNLKDExLCAwKQ0KPiArDQo+
ICBlbnVtIHNzdXNiX3V3a192ZXJzIHsNCj4gIAlTU1VTQl9VV0tfVjEgPSAxLA0KPiAgCVNTVVNC
X1VXS19WMiwNCj4gIH07DQo+ICANCj4gKy8qDQo+ICsgKiBNVDgxOTUgaGFzIDQgY29udHJvbGxl
cnMsIHRoZSBjb250cm9sbGVyMX4zJ3MgZGVmYXVsdCBTT0YvSVRQIGludGVydmFsDQo+ICsgKiBp
cyBjYWxjdWxhdGVkIGZyb20gdGhlIGZyYW1lIGNvdW50ZXIgY2xvY2sgMjRNLCBidXQgaW4gZmFj
dCwgdGhlIGNsb2NrDQo+ICsgKiBpcyA0OE0sIHNvIG5lZWQgY2hhbmdlIHRoZSBpbnRlcnZhbC4N
Cj4gKyAqLw0KPiArc3RhdGljIHZvaWQgeGhjaV9tdGtfc2V0X2ZyYW1lX2ludGVydmFsKHN0cnVj
dCB4aGNpX2hjZF9tdGsgKm10aykNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtdGst
PmRldjsNCj4gKwlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gbXRrLT5oY2Q7DQo+ICsJdTMyIHZhbHVl
Ow0KPiArDQo+ICsJaWYgKCFvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJt
ZWRpYXRlayxtdDgxOTUteGhjaSIpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwl2YWx1ZSA9IHJl
YWRsKGhjZC0+cmVncyArIEhGQ05UUl9DRkcpOw0KPiArCXZhbHVlICY9IH4oSVRQX0RFTFRBX0NM
S19NQVNLIHwgRlJNQ05UX0xFVjFfUkFOR19NQVNLKTsNCj4gKwl2YWx1ZSB8PSAoSVRQX0RFTFRB
X0NMSyB8IEZSTUNOVF9MRVYxX1JBTkcpOw0KPiArCXdyaXRlbCh2YWx1ZSwgaGNkLT5yZWdzICsg
SEZDTlRSX0NGRyk7DQo+ICsNCj4gKwl2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIExTX0VPRik7
DQo+ICsJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFTSzsNCj4gKwl2YWx1ZSB8PSBMU19FT0ZfT0ZG
U0VUOw0KPiArCXdyaXRlbCh2YWx1ZSwgaGNkLT5yZWdzICsgTFNfRU9GKTsNCj4gKw0KPiArCXZh
bHVlID0gcmVhZGwoaGNkLT5yZWdzICsgRlNfRU9GKTsNCj4gKwl2YWx1ZSAmPSB+RU9GX09GRlNF
VF9NQVNLOw0KPiArCXZhbHVlIHw9IEZTX0VPRl9PRkZTRVQ7DQo+ICsJd3JpdGVsKHZhbHVlLCBo
Y2QtPnJlZ3MgKyBGU19FT0YpOw0KPiArDQo+ICsJdmFsdWUgPSByZWFkbChoY2QtPnJlZ3MgKyBT
U19HRU4xX0VPRik7DQo+ICsJdmFsdWUgJj0gfkVPRl9PRkZTRVRfTUFTSzsNCj4gKwl2YWx1ZSB8
PSBTU19HRU4xX0VPRl9PRkZTRVQ7DQo+ICsJd3JpdGVsKHZhbHVlLCBoY2QtPnJlZ3MgKyBTU19H
RU4xX0VPRik7DQo+ICsNCj4gKwl2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIFNTX0dFTjJfRU9G
KTsNCj4gKwl2YWx1ZSAmPSB+RU9GX09GRlNFVF9NQVNLOw0KPiArCXZhbHVlIHw9IFNTX0dFTjJf
RU9GX09GRlNFVDsNCj4gKwl3cml0ZWwodmFsdWUsIGhjZC0+cmVncyArIFNTX0dFTjJfRU9GKTsN
Cj4gK30NCj4gKw0KPiAgc3RhdGljIGludCB4aGNpX210a19ob3N0X2VuYWJsZShzdHJ1Y3QgeGhj
aV9oY2RfbXRrICptdGspDQo+ICB7DQo+ICAJc3RydWN0IG11M2NfaXBwY19yZWdzIF9faW9tZW0g
KmlwcGMgPSBtdGstPmlwcGNfcmVnczsNCj4gQEAgLTQwNyw2ICs0NjcsOCBAQCBzdGF0aWMgaW50
IHhoY2lfbXRrX3NldHVwKHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ICAJCXJldCA9IHhoY2lfbXRr
X3NzdXNiX2NvbmZpZyhtdGspOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4g
Kw0KPiArCQl4aGNpX210a19zZXRfZnJhbWVfaW50ZXJ2YWwobXRrKTsNCj4gIAl9DQo+ICANCj4g
IAlyZXQgPSB4aGNpX2dlbl9zZXR1cChoY2QsIHhoY2lfbXRrX3F1aXJrcyk7DQo+IEBAIC02NTUs
NiArNzE3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIHhoY2lfbXRrX3BtX29w
cyA9IHsNCj4gICNpZmRlZiBDT05GSUdfT0YNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIG10a194aGNpX29mX21hdGNoW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxNzMteGhjaSJ9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1
LXhoY2kifSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay14aGNpIn0sDQo+ICAJ
eyB9LA0KPiAgfTsNCg0K

