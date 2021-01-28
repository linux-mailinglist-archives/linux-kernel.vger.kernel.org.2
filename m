Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE9306C57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhA1ElV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:41:21 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24214 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229545AbhA1ElU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:41:20 -0500
X-UUID: afd8b3a6c81349ff9dd899a845fd7306-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uGuQXo0nW5O+T24o3iGb5azbkRv5Uvu1w62Cl/E1ZV4=;
        b=n+xVLo9+Xjv+3ab7ohdxJPB6QeZodUWiwe0QzNnK3xicikxTiplqDBFQFMHT9b3KDrbwJNkSHkNMdRTKUJ05DG9qRXYKFMtcDb1r1n2FqJTa86MmxMFTx+LD7EvY+VsWSO7qy4owUzkjLmoKaDDsTm7k/KaT9D78HhKjvG2STdE=;
X-UUID: afd8b3a6c81349ff9dd899a845fd7306-20210128
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 483608009; Thu, 28 Jan 2021 12:39:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 12:39:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 12:39:13 +0800
Message-ID: <1611808753.19104.2.camel@mtksdaap41>
Subject: Re: [PATCH v10 4/9] drm/mediatek: generalize mtk_dither_set()
 function
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
Date:   Thu, 28 Jan 2021 12:39:13 +0800
In-Reply-To: <20210127045422.2418917-5-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
         <20210127045422.2418917-5-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2CBAB08F8393E6009EF02E9C4BAE18DDBE683539EF00AE0CC0DA31C1C09ABFBB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFdlZCwgMjAyMS0wMS0yNyBhdCAxMjo1NCArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBUaGVyZSBtYXkgYmUgZGF0YSBzdHJ1Y3R1cmUgb3RoZXIgdGhhbiBt
dGtfZGRwX2NvbXBfZGV2IHRoYXQgd291bGQgY2FsbA0KPiBtdGtfZGl0aGVyX3NldCgpLCBzbyB1
c2UgcmVncyBhcyBwYXJhbWV0ZXIgaW5zdGVhZCBvZiBkZXZpY2UuDQoNCllvdSBkb2VzIG5vdCBj
aGFuZ2UgdGhlIGludGVyZmFjZSBvZiBtdGtfZGl0aGVyX3NldCgpLiBZb3UgbW92ZSB0aGUNCmNv
bW1vbiBwYXJ0IGluIG10a19kaXRoZXJfc2V0KCkgdG8gYSBuZXcgZnVuY3Rpb24gd2hpY2ggY291
bGQgYmUgY2FsbGVkDQpieSBhbm90aGVyIGNhbGxlci4NCg0KUmVnYXJkcywNCkNLLg0KDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8ICA0ICsr
KysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAyNSAr
KysrKysrKysrKysrLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gaW5kZXggNDZkMTk5YjdiNGEyOS4uYzUwZDVmYzlmZDM0OSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAtMTcsNiArMTcsMTAgQEAg
dm9pZCBtdGtfY29sb3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcs
DQo+ICAJCSAgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3Qp
Ow0KPiAgdm9pZCBtdGtfY29sb3Jfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIA0KPiAr
dm9pZCBtdGtfZGl0aGVyX3NldF9jb21tb24odm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgY21k
cV9jbGllbnRfcmVnICpjbWRxX3JlZywNCj4gKwkJCSAgIHVuc2lnbmVkIGludCBicGMsIHVuc2ln
bmVkIGludCBDRkcsDQo+ICsJCQkgICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KTsNCj4gKw0K
PiAgdm9pZCBtdGtfZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19k
cGlfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBpbmRleCA3YjUyOTM0Mjk0MjZkLi41M2QyNTgy
M2EzN2NjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9j
b21wLmMNCj4gQEAgLTE1MSwzMyArMTUxLDQwIEBAIHN0YXRpYyB2b2lkIG10a19kZHBfY2xrX2Rp
c2FibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShwcml2
LT5jbGspOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBtdGtfZGl0aGVyX3NldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBicGMsDQo+IC0JCSAgICB1bnNpZ25lZCBpbnQgQ0ZH
LCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KPiAtew0KPiAtCXN0cnVjdCBtdGtfZGRwX2Nv
bXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICANCj4gK3ZvaWQgbXRrX2Rp
dGhlcl9zZXRfY29tbW9uKHZvaWQgX19pb21lbSAqcmVncywgc3RydWN0IGNtZHFfY2xpZW50X3Jl
ZyAqY21kcV9yZWcsDQo+ICsJCQkgICB1bnNpZ25lZCBpbnQgYnBjLCB1bnNpZ25lZCBpbnQgQ0ZH
LCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KPiArew0KPiAgCS8qIElmIGJwYyBlcXVhbCB0
byAwLCB0aGUgZGl0aGVyaW5nIGZ1bmN0aW9uIGRpZG4ndCBiZSBlbmFibGVkICovDQo+ICAJaWYg
KGJwYyA9PSAwKQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlpZiAoYnBjID49IE1US19NSU5fQlBD
KSB7DQo+IC0JCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJp
di0+cmVncywgRElTUF9ESVRIRVJfNSk7DQo+IC0JCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDAs
ICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9ESVRIRVJfNyk7DQo+ICsJCW10a19k
ZHBfd3JpdGUoY21kcV9wa3QsIDAsIGNtZHFfcmVnLCByZWdzLCBESVNQX0RJVEhFUl81KTsNCj4g
KwkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMCwgY21kcV9yZWcsIHJlZ3MsIERJU1BfRElUSEVS
XzcpOw0KPiAgCQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LA0KPiAgCQkJICAgICAgRElUSEVSX0xT
Ql9FUlJfU0hJRlRfUihNVEtfTUFYX0JQQyAtIGJwYykgfA0KPiAgCQkJICAgICAgRElUSEVSX0FE
RF9MU0hJRlRfUihNVEtfTUFYX0JQQyAtIGJwYykgfA0KPiAgCQkJICAgICAgRElUSEVSX05FV19C
SVRfTU9ERSwNCj4gLQkJCSAgICAgICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9E
SVRIRVJfMTUpOw0KPiArCQkJICAgICAgY21kcV9yZWcsIHJlZ3MsIERJU1BfRElUSEVSXzE1KTsN
Cj4gIAkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwNCj4gIAkJCSAgICAgIERJVEhFUl9MU0JfRVJS
X1NISUZUX0IoTVRLX01BWF9CUEMgLSBicGMpIHwNCj4gIAkJCSAgICAgIERJVEhFUl9BRERfTFNI
SUZUX0IoTVRLX01BWF9CUEMgLSBicGMpIHwNCj4gIAkJCSAgICAgIERJVEhFUl9MU0JfRVJSX1NI
SUZUX0coTVRLX01BWF9CUEMgLSBicGMpIHwNCj4gIAkJCSAgICAgIERJVEhFUl9BRERfTFNISUZU
X0coTVRLX01BWF9CUEMgLSBicGMpLA0KPiAtCQkJICAgICAgJnByaXYtPmNtZHFfcmVnLCBwcml2
LT5yZWdzLCBESVNQX0RJVEhFUl8xNik7DQo+IC0JCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIERJ
U1BfRElUSEVSSU5HLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIENGRyk7DQo+ICsJCQkg
ICAgICBjbWRxX3JlZywgcmVncywgRElTUF9ESVRIRVJfMTYpOw0KPiArCQltdGtfZGRwX3dyaXRl
KGNtZHFfcGt0LCBESVNQX0RJVEhFUklORywgY21kcV9yZWcsIHJlZ3MsIENGRyk7DQo+ICAJfQ0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBtdGtfZGl0aGVyX3NldChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHVuc2lnbmVkIGludCBicGMsDQo+ICsJCSAgICB1bnNpZ25lZCBpbnQgQ0ZHLCBzdHJ1Y3Qg
Y21kcV9wa3QgKmNtZHFfcGt0KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGRwX2NvbXBfZGV2ICpw
cml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwltdGtfZGl0aGVyX3NldF9jb21t
b24ocHJpdi0+cmVncywgJnByaXYtPmNtZHFfcmVnLCBicGMsIENGRywgY21kcV9wa3QpOw0KPiAr
fQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBtdGtfb2RfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwg
dW5zaWduZWQgaW50IHcsDQo+ICAJCQkgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJl
ZnJlc2gsDQo+ICAJCQkgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9w
a3QpDQoNCg==

