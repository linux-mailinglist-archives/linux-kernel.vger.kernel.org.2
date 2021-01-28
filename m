Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40868307026
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhA1Htn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:49:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:43553 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231953AbhA1Ho5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:44:57 -0500
X-UUID: f6042306bb49404a8f74f8844c73edd6-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5vHOnzu1Slh2QZItzOh3bY2TFXG15jjC2a9A0egvloA=;
        b=KNoxHWZV+416mP3el6eosNWasj2VwUlFuxfHhHQXv+TQXaeS89oxzN8D5lxmGIBzsAHy8Lu1zWn1gofzW3zFpY+20MqMwbBK61OLHq7HAYCwsnTbnybQ9EAtl4JQ4rPaq4K52U2+54ZnEmO8w9PbF+egE3VYJlfSh1d/w5iNzq4=;
X-UUID: f6042306bb49404a8f74f8844c73edd6-20210128
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 732297563; Thu, 28 Jan 2021 15:42:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 15:42:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 15:42:46 +0800
Message-ID: <1611819766.16091.4.camel@mtksdaap41>
Subject: Re: [PATCH v11 7/9] drm/mediatek: enable dither function
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Thu, 28 Jan 2021 15:42:46 +0800
In-Reply-To: <20210128072802.830971-8-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
         <20210128072802.830971-8-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8A70314F22D8F0A6B6BFCADD8C97819AA697AC672BFA54AF2FF1F0D0FF62D6932000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFRodSwgMjAyMS0wMS0yOCBhdCAxNToyOCArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IGZvciA1IG9yIDYgYnBjIHBhbmVsLCB3ZSBuZWVkIGVuYWJsZSBkaXRo
ZXIgZnVuY3Rpb24NCj4gdG8gaW1wcm92ZSB0aGUgZGlzcGxheSBxdWFsaXR5DQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCA0NCArKysr
KysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMNCj4gaW5kZXggODE3M2Y3MDkyNzJiZS4uZTg1NjI1NzA0ZDYxMSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC01Myw3
ICs1Myw5IEBADQo+ICAjZGVmaW5lIERJVEhFUl9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgRElT
UF9ESVRIRVJfQ0ZHCQkJCTB4MDAyMA0KPiAgI2RlZmluZSBESVRIRVJfUkVMQVlfTU9ERQkJCUJJ
VCgwKQ0KPiArI2RlZmluZSBESVRIRVJfRU5HSU5FX0VOCQkJQklUKDEpDQo+ICAjZGVmaW5lIERJ
U1BfRElUSEVSX1NJWkUJCQkweDAwMzANCj4gKyNkZWZpbmUgRElUSEVSX1JFRyhpZHgpCQkJCSgw
eDEwMCArIChpZHgpICogNCkNCj4gIA0KPiAgI2RlZmluZSBMVVRfMTBCSVRfTUFTSwkJCQkweDAz
ZmYNCj4gIA0KPiBAQCAtMzEzLDggKzMxNSw0OCBAQCBzdGF0aWMgdm9pZCBtdGtfZGl0aGVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAgew0KPiAgCXN0cnVj
dCBtdGtfZGRwX2NvbXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICANCj4g
Kwlib29sIGVuYWJsZSA9IGZhbHNlOw0KPiArDQo+ICsJLyogZGVmYXVsdCB2YWx1ZSBmb3IgZGl0
aGVyIHJlZyA1IHRvIDE0ICovDQo+ICsJY29uc3QgdTMyIGRpdGhlcl9zZXR0aW5nW10gPSB7DQo+
ICsJCTB4MDAwMDAwMDAsIC8qIDUgKi8NCj4gKwkJMHgwMDAwMzAwMiwgLyogNiAqLw0KPiArCQkw
eDAwMDAwMDAwLCAvKiA3ICovDQo+ICsJCTB4MDAwMDAwMDAsIC8qIDggKi8NCj4gKwkJMHgwMDAw
MDAwMCwgLyogOSAqLw0KPiArCQkweDAwMDAwMDAwLCAvKiAxMCAqLw0KPiArCQkweDAwMDAwMDAw
LCAvKiAxMSAqLw0KPiArCQkweDAwMDAwMDExLCAvKiAxMiAqLw0KPiArCQkweDAwMDAwMDAwLCAv
KiAxMyAqLw0KPiArCQkweDAwMDAwMDAwLCAvKiAxNCAqLw0KDQpDb3VsZCB5b3UgZXhwbGFpbiB3
aGF0IGlzIHRoaXM/DQoNCj4gKwl9Ow0KPiArDQo+ICsJaWYgKGJwYyA9PSA1IHx8IGJwYyA9PSA2
KSB7DQo+ICsJCWVuYWJsZSA9IHRydWU7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsDQo+
ICsJCQkgICAgICBESVRIRVJfTFNCX0VSUl9TSElGVF9SKE1US19NQVhfQlBDIC0gYnBjKSB8DQo+
ICsJCQkgICAgICBESVRIRVJfQUREX0xTSElGVF9SKE1US19NQVhfQlBDIC0gYnBjKSB8DQo+ICsJ
CQkgICAgICBESVRIRVJfTkVXX0JJVF9NT0RFLA0KPiArCQkJICAgICAgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLCBESVRIRVJfUkVHKDE1KSk7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsDQo+ICsJCQkgICAgICBESVRIRVJfTFNCX0VSUl9TSElGVF9CKE1US19NQVhfQlBDIC0gYnBj
KSB8DQo+ICsJCQkgICAgICBESVRIRVJfQUREX0xTSElGVF9CKE1US19NQVhfQlBDIC0gYnBjKSB8
DQo+ICsJCQkgICAgICBESVRIRVJfTFNCX0VSUl9TSElGVF9HKE1US19NQVhfQlBDIC0gYnBjKSB8
DQo+ICsJCQkgICAgICBESVRIRVJfQUREX0xTSElGVF9HKE1US19NQVhfQlBDIC0gYnBjKSwNCg0K
VGhpcyByZXN1bHQgaW4gMHg1MDUwNTA1MCwgYnV0IHByZXZpb3VzIHZlcnNpb24gaXMgMHg1MDUw
NDA0MCwgc28gdGhpcw0KdmVyc2lvbiBpcyBjb3JyZWN0IGFuZCBwcmV2aW91cyB2ZXJzaW9uIGlz
IGluY29ycmVjdD8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkJCSAgICAgICZwcml2LT5jbWRxX3Jl
ZywgcHJpdi0+cmVncywgRElUSEVSX1JFRygxNikpOw0KPiArCX0NCj4gKw0KPiArDQo+ICsJaWYg
KGVuYWJsZSkgew0KPiArCQl1MzIgaWR4Ow0KPiArDQo+ICsJCWZvciAoaWR4ID0gMDsgaWR4IDwg
QVJSQVlfU0laRShkaXRoZXJfc2V0dGluZyk7IGlkeCsrKQ0KPiArCQkJbXRrX2RkcF93cml0ZShj
bWRxX3BrdCwgZGl0aGVyX3NldHRpbmdbaWR4XSwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdz
LA0KPiArCQkJCSAgICAgIERJVEhFUl9SRUcoaWR4ICsgNSkpOw0KPiArCX0NCj4gKw0KPiAgCW10
a19kZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYt
PnJlZ3MsIERJU1BfRElUSEVSX1NJWkUpOw0KPiAtCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIERJ
VEhFUl9SRUxBWV9NT0RFLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfRElUSEVS
X0NGRyk7DQo+ICsgICAgICAgIG10a19kZHBfd3JpdGUoY21kcV9wa3QsIGVuYWJsZSA/IERJVEhF
Ul9FTkdJTkVfRU4gOiBESVRIRVJfUkVMQVlfTU9ERSwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5y
ZWdzLCBESVNQX0RJVEhFUl9DRkcpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZGl0
aGVyX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCg0K

