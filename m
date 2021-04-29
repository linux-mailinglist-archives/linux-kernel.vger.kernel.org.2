Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705DC36E33F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhD2CaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:30:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3474 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229624AbhD2CaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:30:08 -0400
X-UUID: ffb48340dfc04859b15c06d6cc6d2c0c-20210429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o2p9JhCaBswcUrlrtgSrIfMJfhrFP72dGtfQIVy7kuA=;
        b=Nk+POdjl+28R5hv3z4M9USpXfHwIoN//SqEhyz9DDj6wePk6lczWFMeVJZ0Vl1Sf+CbB8k1FzqdNUrdhMpLpQxBFP/VJFsoQHVwlqrg5jkNd/AwamoHt9PQT6WeVOHVzDzhxbOKiNI0jevmEE92Nz7lpR9BgC2C25uYjmCkg/co=;
X-UUID: ffb48340dfc04859b15c06d6cc6d2c0c-20210429
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 87765780; Thu, 29 Apr 2021 10:23:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Apr 2021 10:23:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Apr 2021 10:23:46 +0800
Message-ID: <21aa84ce0681ebc0682d9b9cad5b6180f3b0ea5b.camel@mediatek.com>
Subject: Re: [v2,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Date:   Thu, 29 Apr 2021 10:23:46 +0800
In-Reply-To: <a1ffcce8-621e-7493-22d4-e28ff09c31a4@baylibre.com>
References: <1618407316-10042-1-git-send-email-rex-bc.chen@mediatek.com>
         <1618407316-10042-2-git-send-email-rex-bc.chen@mediatek.com>
         <a1ffcce8-621e-7493-22d4-e28ff09c31a4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 079D6E7CD5DAD064F57F9898547CAB31CF76F7775DBE867A0942E66CFC3EBF782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTE5IGF0IDA5OjM2ICswMjAwLCBOZWlsIEFybXN0cm9uZyB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiAxNC8wNC8yMDIxIDE1OjM1LCBSZXgtQkMgQ2hlbiB3cm90ZToNCj4g
PiBEUEkgY2FuIHNhbXBsZSBvbiBmYWxsaW5nLCByaXNpbmcgb3IgYm90aCBlZGdlLg0KPiA+IFdo
ZW4gRFBJIHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KPiA+
IEl0IGNhbiByZWR1Y2UgaGFsZiBkYXRhIGlvIHBpbnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJleC1CQyBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxMiArKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYw0KPiA+IGluZGV4IGIwNWY5MDBkOTMyMi4uMjFhM2E3Yjc4ODM1
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gQEAgLTgzLDYg
KzgzLDcgQEAgc3RydWN0IG10a19kcGkgew0KPiA+ICAJc3RydWN0IHBpbmN0cmwgKnBpbmN0cmw7
DQo+ID4gIAlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KPiA+ICAJc3RydWN0IHBp
bmN0cmxfc3RhdGUgKnBpbnNfZHBpOw0KPiA+ICsJYm9vbCBkZHJfZWRnZV9zZWw7DQo+ID4gIAlp
bnQgcmVmY291bnQ7DQo+ID4gIH07DQo+ID4gIA0KPiA+IEBAIC0xMjEsNiArMTIyLDcgQEAgc3Ry
dWN0IG10a19kcGlfY29uZiB7DQo+ID4gIAl1bnNpZ25lZCBpbnQgKCpjYWxfZmFjdG9yKShpbnQg
Y2xvY2spOw0KPiA+ICAJdTMyIHJlZ19oX2ZyZV9jb247DQo+ID4gIAlib29sIGVkZ2Vfc2VsX2Vu
Ow0KPiA+ICsJYm9vbCBkdWFsX2VkZ2U7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9p
ZCBtdGtfZHBpX21hc2soc3RydWN0IG10a19kcGkgKmRwaSwgdTMyIG9mZnNldCwgdTMyIHZhbCwN
Cj4gPiB1MzIgbWFzaykNCj4gPiBAQCAtMzgwLDYgKzM4MiwxNSBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHBpX2NvbmZpZ19jb2xvcl9mb3JtYXQoc3RydWN0DQo+ID4gbXRrX2RwaSAqZHBpLA0KPiA+ICAJ
fQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfZHBpX2R1YWxfZWRnZShzdHJ1
Y3QgbXRrX2RwaSAqZHBpKQ0KPiA+ICt7DQo+ID4gKwlpZiAoZHBpLT5jb25mLT5kdWFsX2VkZ2Up
IHsNCj4gPiArCQltdGtfZHBpX21hc2soZHBpLCBEUElfRERSX1NFVFRJTkcsIEREUl9FTiB8IERE
Ul80UEhBU0UsDQo+ID4gKwkJCSAgICAgRERSX0VOIHwgRERSXzRQSEFTRSk7DQo+ID4gKwkJbXRr
X2RwaV9tYXNrKGRwaSwgRFBJX09VVFBVVF9TRVRUSU5HLCBkcGktPmRkcl9lZGdlX3NlbCANCj4g
PiA/IEVER0VfU0VMIDogMCwgRURHRV9TRUwpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiAN
Cj4gQnkgdXNpbmcgdGhlIGRvd25zdHJlYW0gY29kZSBhcyByZWZlcmVuY2U6DQo+IA0KPiAtICAg
ICAgIGNsa19zZXRfcmF0ZShkcGktPnBpeGVsX2Nsaywgdm0ucGl4ZWxjbG9jayk7DQo+ICsgICAg
ICAgY2xrX3NldF9yYXRlKGRwaS0+cGl4ZWxfY2xrLCB2bS5waXhlbGNsb2NrICogKGRwaS0+Y29u
Zi0NCj4gPmR1YWxfZWRnZSA/IDIgOiAxKSk7DQo+IA0KPiBpcyBtaXNzaW5nIGluIG10a19kcGlf
c2V0X2Rpc3BsYXlfbW9kZSgpDQo+IA0KSGVsbG8gTmVpbCwNCg0KVGhhbmtzIGZvciBoZWxwaW5n
IGNoZWNraW5nIHRoaXMuDQpJIHdpbGwgYWRkIHRoaXMgbW9kaWZpY2F0aW9uIGZvciBuZXh0IHBh
dGNoLg0KDQpCUnMsDQpSZXgtQkMgQ2hlbg0KPiA+ICBzdGF0aWMgdm9pZCBtdGtfZHBpX3Bvd2Vy
X29mZihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KPiA+ICB7DQo+ID4gIAlpZiAoV0FSTl9PTihkcGkt
PnJlZmNvdW50ID09IDApKQ0KPiA+IEBAIC01MTgsNiArNTI5LDcgQEAgc3RhdGljIGludCBtdGtf
ZHBpX3NldF9kaXNwbGF5X21vZGUoc3RydWN0DQo+ID4gbXRrX2RwaSAqZHBpLA0KPiA+ICAJbXRr
X2RwaV9jb25maWdfeWNfbWFwKGRwaSwgZHBpLT55Y19tYXApOw0KPiA+ICAJbXRrX2RwaV9jb25m
aWdfY29sb3JfZm9ybWF0KGRwaSwgZHBpLT5jb2xvcl9mb3JtYXQpOw0KPiA+ICAJbXRrX2RwaV9j
b25maWdfMm5faF9mcmUoZHBpKTsNCj4gPiArCW10a19kcGlfZHVhbF9lZGdlKGRwaSk7DQo+ID4g
IAltdGtfZHBpX2NvbmZpZ19kaXNhYmxlX2VkZ2UoZHBpKTsNCj4gPiAgCW10a19kcGlfc3dfcmVz
ZXQoZHBpLCBmYWxzZSk7DQo+ID4gIA0KPiA+IA0KPiANCj4gTmVpbA0K

