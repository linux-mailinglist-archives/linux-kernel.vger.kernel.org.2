Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0D306D39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhA1GCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:02:35 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229578AbhA1GCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:02:31 -0500
X-UUID: dd134fe4b4b44e07bd9b2520f7e93c9d-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7QDImCt5+7DsXFqewuf7SP758fb7EaUZc14iGwpvOW4=;
        b=MPG6B6AmYAq6XixUwzjw/cE2w/HImb3AY7X5dZfzsGyE5G3OaOGoT9jq17NRjefSoht0NkU3FGvsfdoaaOVO7i/B8C7wQzQronQu7ZzPdsR92lMSW+ZehxhUIJcwNB9kXOtSf0qkgpB3ciyAmJhyuPWew9mBwE22i8Ngq1xFwp8=;
X-UUID: dd134fe4b4b44e07bd9b2520f7e93c9d-20210128
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 368407118; Thu, 28 Jan 2021 14:01:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 14:01:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 14:01:09 +0800
Message-ID: <1611813669.28312.5.camel@mtksdaap41>
Subject: Re: [PATCH v10 7/9] drm/mediatek: enable dither function
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Thu, 28 Jan 2021 14:01:09 +0800
In-Reply-To: <20210127045422.2418917-8-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
         <20210127045422.2418917-8-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9AC874471A0D8550FCAE5680D29E0B57033CD9A5CB477339768C90370D8C92B12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFdlZCwgMjAyMS0wMS0yNyBhdCAxMjo1NCArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IGZvciA1IG9yIDYgYnBjIHBhbmVsLCB3ZSBuZWVkIGVuYWJsZSBkaXRo
ZXIgZnVuY3Rpb24NCj4gdG8gaW1wcm92ZSB0aGUgZGlzcGxheSBxdWFsaXR5DQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAzNyArKysr
KysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMNCj4gaW5kZXggODE3M2Y3MDkyNzJiZS4uZWU1NDUwNTQxMmRjZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC01Myw3
ICs1Myw5IEBADQo+ICAjZGVmaW5lIERJVEhFUl9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgRElT
UF9ESVRIRVJfQ0ZHCQkJCTB4MDAyMA0KPiAgI2RlZmluZSBESVRIRVJfUkVMQVlfTU9ERQkJCUJJ
VCgwKQ0KPiArI2RlZmluZSBESVRIRVJfRU5HSU5FX0VOCQkJQklUKDEpDQo+ICAjZGVmaW5lIERJ
U1BfRElUSEVSX1NJWkUJCQkweDAwMzANCj4gKyNkZWZpbmUgRElUSEVSX1JFRyhpZHgpCQkJCSgw
eDEwMCArIChpZHgpICogNCkNCj4gIA0KPiAgI2RlZmluZSBMVVRfMTBCSVRfTUFTSwkJCQkweDAz
ZmYNCj4gIA0KPiBAQCAtMzEzLDggKzMxNSw0MSBAQCBzdGF0aWMgdm9pZCBtdGtfZGl0aGVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAgew0KPiAgCXN0cnVj
dCBtdGtfZGRwX2NvbXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICANCj4g
Kwlib29sIGVuYWJsZSA9IHRydWU7DQo+ICsNCj4gKwljb25zdCB1MzIgZGl0aGVyX3NldHRpbmdb
XSA9IHsNCj4gKwkJMHgwMDAwMDAwMCwgLyogNSAqLw0KPiArCQkweDAwMDAzMDAyLCAvKiA2ICov
DQo+ICsJCTB4MDAwMDAwMDAsIC8qIDcgKi8NCj4gKwkJMHgwMDAwMDAwMCwgLyogOCAqLw0KPiAr
CQkweDAwMDAwMDAwLCAvKiA5ICovDQo+ICsJCTB4MDAwMDAwMDAsIC8qIDEwICovDQo+ICsJCTB4
MDAwMDAwMDAsIC8qIDExICovDQo+ICsJCTB4MDAwMDAwMTEsIC8qIDEyICovDQo+ICsJCTB4MDAw
MDAwMDAsIC8qIDEzICovDQo+ICsJCTB4MDAwMDAwMDAsIC8qIDE0ICovDQoNCkNvdWxkIHlvdSBl
eHBsYWluIHdoYXQgaXMgdGhpcz8NCg0KPiArCX07DQo+ICsNCj4gKwlpZiAoYnBjID09IDYpIHsN
Cj4gKwkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHg0MDQwMDAwMSwgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLCBESVRIRVJfUkVHKDE1KSk7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsIDB4NDA0MDQwNDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElUSEVSX1JFRygx
NikpOw0KPiArCX0gZWxzZSBpZiAoYnBjID09IDUpIHsNCj4gKwkJbXRrX2RkcF93cml0ZShjbWRx
X3BrdCwgMHg1MDUwMDAwMSwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLCBESVRIRVJfUkVH
KDE1KSk7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDB4NTA1MDQwNDAsICZwcml2LT5j
bWRxX3JlZywgcHJpdi0+cmVncywgRElUSEVSX1JFRygxNikpOw0KDQpUaGlzIGxvb2tzIHZlcnkg
c2ltaWxhciB0byB0aGUgY29kZSBpbiBtdGtfZGl0aGVyX3NldCgpLCBjb3VsZCB5b3UNCnN5bWJv
bGl6ZSB0aGlzIG1hZ2ljIG51bWJlciBsaWtlIG10a19kaXRoZXJfc2V0KCk/DQoNClJlZ2FyZHMs
DQpDSw0KDQo+ICsJfSBlbHNlIHsNCj4gKwkJZW5hYmxlID0gZmFsc2U7DQo+ICsJfQ0KPiArDQo+
ICsJaWYgKGVuYWJsZSkgew0KPiArCQl1MzIgaWR4Ow0KPiArDQo+ICsJCWZvciAoaWR4ID0gMDsg
aWR4IDwgQVJSQVlfU0laRShkaXRoZXJfc2V0dGluZyk7IGlkeCsrKQ0KPiArCQkJbXRrX2RkcF93
cml0ZShjbWRxX3BrdCwgZGl0aGVyX3NldHRpbmdbaWR4XSwgJnByaXYtPmNtZHFfcmVnLCBwcml2
LT5yZWdzLA0KPiArCQkJCSAgICAgIERJVEhFUl9SRUcoaWR4ICsgNSkpOw0KPiArCX0NCj4gKw0K
PiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmcHJpdi0+Y21kcV9yZWcs
IHByaXYtPnJlZ3MsIERJU1BfRElUSEVSX1NJWkUpOw0KPiAtCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsIERJVEhFUl9SRUxBWV9NT0RFLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1Bf
RElUSEVSX0NGRyk7DQo+ICsgICAgICAgIG10a19kZHBfd3JpdGUoY21kcV9wa3QsIGVuYWJsZSA/
IERJVEhFUl9FTkdJTkVfRU4gOiBESVRIRVJfUkVMQVlfTU9ERSwgJnByaXYtPmNtZHFfcmVnLCBw
cml2LT5yZWdzLCBESVNQX0RJVEhFUl9DRkcpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBt
dGtfZGl0aGVyX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCg0K

