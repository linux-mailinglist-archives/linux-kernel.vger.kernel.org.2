Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178C944139D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 07:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKAGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 02:11:56 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35312 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229827AbhKAGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 02:11:52 -0400
X-UUID: 42d66bd2313546df99e5b8fda1e34e51-20211101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xVKTQc7OPGqCgUqaW4iGQjm4T5FKiIv77uCXhzrHMa4=;
        b=CRD3SrYzD9KnCvotD60fVLwRPs3gABLwpazhe5BwqAmJyFapMvlYpLvVOGELXnh6zrk+lwEdVzAjoyzad/Lh9QX5ulwJQj9r82SYlNWBeTTS1GfRXcodE2LuyXlqO/NI7Rexm1xpFprvhmMzohJuaFaDLDI1/SBfYa/zfPHdaJw=;
X-UUID: 42d66bd2313546df99e5b8fda1e34e51-20211101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 902528883; Mon, 01 Nov 2021 14:09:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 1 Nov 2021 14:09:15 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Nov 2021 14:09:14 +0800
Message-ID: <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
Date:   Mon, 1 Nov 2021 14:09:14 +0800
In-Reply-To: <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
         <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTI5IGF0IDE5OjM1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyOC8xMC8yMDIxIDA3OjUwLCBZb25nIFd1IHdyb3RlOg0KPiA+IFdlIGFkZCB0
aGUgb3N0ZCBzZXR0aW5nIGZvciBtdDgxOTUuIEl0IGludHJvZHVjZXMgYSBhYm9ydCBmb3IgdGhl
DQo+ID4gcHJldmlvdXMgU29DIHdoaWNoIGRvZXNuJ3QgaGF2ZSBvc3RkIHNldHRpbmcuIFRoaXMg
aXMgdGhlIGxvZzoNCj4gPiANCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4gMDAwMDAwMDAwMDAwMDA4MA0K
PiA+IC4uLg0KPiA+IHBjIDogbXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCsw
eDY0LzB4MTMwDQo+ID4gbHIgOiBtdGtfc21pX2xhcmJfcmVzdW1lKzB4NTQvMHg5OA0KPiA+IC4u
Lg0KPiA+IENhbGwgdHJhY2U6DQo+ID4gIG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dl
bmVyYWwrMHg2NC8weDEzMA0KPiA+ICBwbV9nZW5lcmljX3J1bnRpbWVfcmVzdW1lKzB4MmMvMHg0
OA0KPiA+ICBfX2dlbnBkX3J1bnRpbWVfcmVzdW1lKzB4MzAvMHhhOA0KPiA+ICBnZW5wZF9ydW50
aW1lX3Jlc3VtZSsweDk0LzB4MmM4DQo+ID4gIF9fcnBtX2NhbGxiYWNrKzB4NDQvMHgxNTANCj4g
PiAgcnBtX2NhbGxiYWNrKzB4NmMvMHg3OA0KPiA+ICBycG1fcmVzdW1lKzB4MzEwLzB4NTU4DQo+
ID4gIF9fcG1fcnVudGltZV9yZXN1bWUrMHgzYy8weDg4DQo+ID4gDQo+ID4gSW4gdGhlIGNvZGU6
IGxhcmJvc3RkID0gbGFyYi0+bGFyYl9nZW4tPm9zdGRbbGFyYi0+bGFyYmlkXSwNCj4gPiBpZiAi
bGFyYi0+bGFyYl9nZW4tPm9zdGQiIGlzIG51bGwsIHRoZSAibGFyYm9zdGQiIGlzIHRoZSBvZmZz
ZXQsIGl0DQo+ID4gaXMNCj4gPiBhbHNvIGEgdmFsaWQgdmFsdWUsIHRodXMsIHVzZSB0aGUgbGFy
Yi0+bGFyYl9nZW4tPm9zdGQgYXMgdGhlDQo+ID4gY29uZGl0aW9uDQo+ID4gaW5zaWRlIHRoZSAi
Zm9yIiBsb29wLg0KPiANCj4gWW91IG5lZWQgdG8gd3JpdGUgbW9yZSBjbGVhcmx5LCB3aGF0IHlv
dSBhcmUgZml4aW5nIGhlcmUuDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3Ug
PHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IEhpIEtyenlzenRvZiwNCj4gPiBD
b3VsZCB5b3UgaGVscCByZXZpZXcgYW5kIGNvbnNpZGUgdGhpcyBhcyBhIGZpeCBmb3IgdGhlIG10
ODE5NQ0KPiA+IHBhdGNoc2V0Pw0KPiA+IFRoZSBtdDgxOTUgcGF0Y2hzZXQgYXJlIG5vdCBpbiBt
YWlubGluZSwgdGh1cywgSSBkb24ndCBrbm93IGl0cw0KPiA+IHNoYS1pZCwNCj4gPiBhbmQgZG9u
J3QgYWRkIEZpeGVzIHRhZy4NCj4gPiBUaGFua3MNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZW1v
cnkvbXRrLXNtaS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkvbXRr
LXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5kZXggYjg4M2RjYzBiYmZh
Li4wMjYyYTU5YTJkNmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
DQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gQEAgLTI1Nyw3ICsyNTcs
NyBAQCBzdGF0aWMgdm9pZA0KPiA+IG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dlbmVy
YWwoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJaWYgKE1US19TTUlfQ0FQUyhmbGFnc19nZW5l
cmFsLCBNVEtfU01JX0ZMQUdfU1dfRkxBRykpDQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQoU01JX0xB
UkJfU1dfRkxBR18xLCBsYXJiLT5iYXNlICsNCj4gPiBTTUlfTEFSQl9TV19GTEFHKTsNCj4gPiAg
DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgU01JX0xBUkJfUE9SVF9OUl9NQVggJiYgbGFyYm9zdGQg
JiYNCj4gPiAhIWxhcmJvc3RkW2ldOyBpKyspDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgU01JX0xB
UkJfUE9SVF9OUl9NQVggJiYgbGFyYi0+bGFyYl9nZW4tPm9zdGQgJiYNCj4gPiAhIWxhcmJvc3Rk
W2ldOyBpKyspDQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQobGFyYm9zdGRbaV0sIGxhcmItPmJhc2Ug
Kw0KPiA+IFNNSV9MQVJCX09TVERMX1BPUlR4KGkpKTsNCj4gDQo+IFRoZSBjb2RlIGRvZXMgbm90
IGxvb2sgZ29vZC4gWW91IGhhdmUgYWxyZWFkeSBhIGRlcmVmZXJlbmNlIGF0IGxpbmUNCj4gMjQ0
Og0KPiANCj4gCWNvbnN0IHU4ICpsYXJib3N0ZCA9IGxhcmItPmxhcmJfZ2VuLT5vc3RkW2xhcmIt
PmxhcmJpZF07DQoNCmlmIGxhcmItPmxhcmJfZ2VuLT5vc3RkIGlzIG51bGwsIGxhcmJvc3RkIGlz
IHRoZSBvZmZzZXQsIGUuZy4gMHg4MCBpbg0KdGhlIGxvZyBhYm92ZS4gdGh1cywgd2UgY2FuIG5v
dCB1c2UgImxhcmJvc3RkW2ldIiBpbiB0aGUgImZvciIgbG9vcC4NCg0Kc29ycnkgZm9yIHRoZSB1
bnJlYWRhYmxlLiBJbiB0aGlzIGNhc2UsIGlzIHRoZSBjaGFuZ2Ugb2s/DQoNCm9yIGxpa2UgdGhp
czoNCg0KLWNvbnN0IHU4ICpsYXJib3N0ZCA9IGxhcmItPmxhcmJfZ2VuLT5vc3RkW2xhcmItPmxh
cmJpZF07DQorY29uc3QgdTggKmxhcmJvc3RkID0gbGFyYi0+bGFyYl9nZW4tPm9zdGQgPyBsYXJi
LT5sYXJiX2dlbi1vc3RkW2xhcmItDQo+bGFyYmlkXSA6IE5VTEw7DQoNCm9yIGFkZCBhIGV4cGxp
Y2l0ICJpZiI6DQogaWYgKGxhcmItPmxhcmJfZ2VuLT5vc3RkKQ0KICAgbGFyYm9zdGQgPSB4eHgu
DQoNCldoaWNoIG9uZSBkbyB5b3UgcHJlZmVyPw0KDQpUaGFua3MuDQoNCj4gDQo+IFlvdSBhcmUg
bm90IGZpeGluZyB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KPiANCj4gPiAgDQo+ID4g
IAlmb3JfZWFjaF9zZXRfYml0KGksICh1bnNpZ25lZCBsb25nICopbGFyYi0+bW11LCAzMikgew0K
PiA+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

