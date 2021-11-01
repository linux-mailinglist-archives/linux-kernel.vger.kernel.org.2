Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A57441A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKAKne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:43:34 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43956 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231560AbhKAKnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:43:33 -0400
X-UUID: 66bb92f5f0c74b52954d9f3d793eb446-20211101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0yNRMy91uWzpVLqngjuJ072kcSyVfPnPyUeqGNc4EY0=;
        b=XmxLfBfMTgKVUbsXbSZ52y2ZhsMdHCrO5NS23ZQDEa8JI/mphaIc08rVKsaE/vmTlawY+C8zQltUz9zPR//ZABAZbq2uXvkF+I0ZXBd2LBnBcilDgAZTTIzsxl1lxXDudS7pv82NdmfAq6ic745mnDVh4ksXrAYzQHteZKnr564=;
X-UUID: 66bb92f5f0c74b52954d9f3d793eb446-20211101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 276154276; Mon, 01 Nov 2021 18:40:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 1 Nov 2021 18:40:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 1 Nov 2021 18:40:55 +0800
Message-ID: <45cc8d0e25bdb73d8262f59166cac6ea3c80770b.camel@mediatek.com>
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
Date:   Mon, 1 Nov 2021 18:40:53 +0800
In-Reply-To: <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
         <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
         <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
         <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTAxIGF0IDA5OjQ1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwMS8xMS8yMDIxIDA3OjA5LCBZb25nIFd1IHdyb3RlOg0KPiA+IE9uIEZyaSwg
MjAyMS0xMC0yOSBhdCAxOTozNSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4g
PiA+IE9uIDI4LzEwLzIwMjEgMDc6NTAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+IFdlIGFkZCB0
aGUgb3N0ZCBzZXR0aW5nIGZvciBtdDgxOTUuIEl0IGludHJvZHVjZXMgYSBhYm9ydCBmb3INCj4g
PiA+ID4gdGhlDQo+ID4gPiA+IHByZXZpb3VzIFNvQyB3aGljaCBkb2Vzbid0IGhhdmUgb3N0ZCBz
ZXR0aW5nLiBUaGlzIGlzIHRoZSBsb2c6DQo+ID4gPiA+IA0KPiA+ID4gPiBVbmFibGUgdG8gaGFu
ZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbA0KPiA+ID4gPiBh
ZGRyZXNzDQo+ID4gPiA+IDAwMDAwMDAwMDAwMDAwODANCj4gPiA+ID4gLi4uDQo+ID4gPiA+IHBj
IDogbXRrX3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCsweDY0LzB4MTMwDQo+ID4g
PiA+IGxyIDogbXRrX3NtaV9sYXJiX3Jlc3VtZSsweDU0LzB4OTgNCj4gPiA+ID4gLi4uDQo+ID4g
PiA+IENhbGwgdHJhY2U6DQo+ID4gPiA+ICBtdGtfc21pX2xhcmJfY29uZmlnX3BvcnRfZ2VuMl9n
ZW5lcmFsKzB4NjQvMHgxMzANCj4gPiA+ID4gIHBtX2dlbmVyaWNfcnVudGltZV9yZXN1bWUrMHgy
Yy8weDQ4DQo+ID4gPiA+ICBfX2dlbnBkX3J1bnRpbWVfcmVzdW1lKzB4MzAvMHhhOA0KPiA+ID4g
PiAgZ2VucGRfcnVudGltZV9yZXN1bWUrMHg5NC8weDJjOA0KPiA+ID4gPiAgX19ycG1fY2FsbGJh
Y2srMHg0NC8weDE1MA0KPiA+ID4gPiAgcnBtX2NhbGxiYWNrKzB4NmMvMHg3OA0KPiA+ID4gPiAg
cnBtX3Jlc3VtZSsweDMxMC8weDU1OA0KPiA+ID4gPiAgX19wbV9ydW50aW1lX3Jlc3VtZSsweDNj
LzB4ODgNCj4gPiA+ID4gDQo+ID4gPiA+IEluIHRoZSBjb2RlOiBsYXJib3N0ZCA9IGxhcmItPmxh
cmJfZ2VuLT5vc3RkW2xhcmItPmxhcmJpZF0sDQo+ID4gPiA+IGlmICJsYXJiLT5sYXJiX2dlbi0+
b3N0ZCIgaXMgbnVsbCwgdGhlICJsYXJib3N0ZCIgaXMgdGhlDQo+ID4gPiA+IG9mZnNldCwgaXQN
Cj4gPiA+ID4gaXMNCj4gPiA+ID4gYWxzbyBhIHZhbGlkIHZhbHVlLCB0aHVzLCB1c2UgdGhlIGxh
cmItPmxhcmJfZ2VuLT5vc3RkIGFzIHRoZQ0KPiA+ID4gPiBjb25kaXRpb24NCj4gPiA+ID4gaW5z
aWRlIHRoZSAiZm9yIiBsb29wLg0KPiA+ID4gDQo+ID4gPiBZb3UgbmVlZCB0byB3cml0ZSBtb3Jl
IGNsZWFybHksIHdoYXQgeW91IGFyZSBmaXhpbmcgaGVyZS4NCj4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiBIaSBLcnp5c3p0b2YsDQo+ID4gPiA+IENvdWxkIHlvdSBoZWxwIHJl
dmlldyBhbmQgY29uc2lkZSB0aGlzIGFzIGEgZml4IGZvciB0aGUgbXQ4MTk1DQo+ID4gPiA+IHBh
dGNoc2V0Pw0KPiA+ID4gPiBUaGUgbXQ4MTk1IHBhdGNoc2V0IGFyZSBub3QgaW4gbWFpbmxpbmUs
IHRodXMsIEkgZG9uJ3Qga25vdyBpdHMNCj4gPiA+ID4gc2hhLWlkLA0KPiA+ID4gPiBhbmQgZG9u
J3QgYWRkIEZpeGVzIHRhZy4NCj4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMiArLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLQ0KPiA+
ID4gPiBzbWkuYw0KPiA+ID4gPiBpbmRleCBiODgzZGNjMGJiZmEuLjAyNjJhNTlhMmQ2ZSAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+ID4gPiBAQCAtMjU3LDcgKzI1Nyw3IEBAIHN0
YXRpYyB2b2lkDQo+ID4gPiA+IG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dlbmVyYWwo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiAgCWlmIChNVEtfU01JX0NBUFMoZmxhZ3NfZ2Vu
ZXJhbCwgTVRLX1NNSV9GTEFHX1NXX0ZMQUcpKQ0KPiA+ID4gPiAgCQl3cml0ZWxfcmVsYXhlZChT
TUlfTEFSQl9TV19GTEFHXzEsIGxhcmItPmJhc2UgKw0KPiA+ID4gPiBTTUlfTEFSQl9TV19GTEFH
KTsNCj4gPiA+ID4gIA0KPiA+ID4gPiAtCWZvciAoaSA9IDA7IGkgPCBTTUlfTEFSQl9QT1JUX05S
X01BWCAmJiBsYXJib3N0ZCAmJg0KPiA+ID4gPiAhIWxhcmJvc3RkW2ldOyBpKyspDQo+ID4gPiA+
ICsJZm9yIChpID0gMDsgaSA8IFNNSV9MQVJCX1BPUlRfTlJfTUFYICYmIGxhcmItPmxhcmJfZ2Vu
LQ0KPiA+ID4gPiA+b3N0ZCAmJg0KPiA+ID4gPiAhIWxhcmJvc3RkW2ldOyBpKyspDQo+ID4gPiA+
ICAJCXdyaXRlbF9yZWxheGVkKGxhcmJvc3RkW2ldLCBsYXJiLT5iYXNlICsNCj4gPiA+ID4gU01J
X0xBUkJfT1NURExfUE9SVHgoaSkpOw0KPiA+ID4gDQo+ID4gPiBUaGUgY29kZSBkb2VzIG5vdCBs
b29rIGdvb2QuIFlvdSBoYXZlIGFscmVhZHkgYSBkZXJlZmVyZW5jZSBhdA0KPiA+ID4gbGluZQ0K
PiA+ID4gMjQ0Og0KPiA+ID4gDQo+ID4gPiAJY29uc3QgdTggKmxhcmJvc3RkID0gbGFyYi0+bGFy
Yl9nZW4tPm9zdGRbbGFyYi0+bGFyYmlkXTsNCj4gPiANCj4gPiBpZiBsYXJiLT5sYXJiX2dlbi0+
b3N0ZCBpcyBudWxsLCBsYXJib3N0ZCBpcyB0aGUgb2Zmc2V0LCBlLmcuIDB4ODANCj4gPiBpbg0K
PiA+IHRoZSBsb2cgYWJvdmUuIHRodXMsIHdlIGNhbiBub3QgdXNlICJsYXJib3N0ZFtpXSIgaW4g
dGhlICJmb3IiDQo+ID4gbG9vcC4NCj4gPiANCj4gPiBzb3JyeSBmb3IgdGhlIHVucmVhZGFibGUu
IEluIHRoaXMgY2FzZSwgaXMgdGhlIGNoYW5nZSBvaz8NCj4gDQo+IE5vLCBpdCdzIG9rLCBJIGRp
ZCBub3QgY2hlY2sgdGhlIHR5cGUgb2Ygb3N0ZCBhbmQgaXQncyBjb25mdXNpbmcgYQ0KPiBiaXQN
Cj4gdGhhdCBpdCBpcyBkZWZpbmVkIGFzIGEgcG9pbnRlciB0byBhbiBhcnJheSBidXQgeW91IGFj
dHVhbGx5IHVzZSBpdA0KPiBhcw0KPiBhcnJheSBvZiBwb2ludGVycyB0byAzMi1lbGVtZW5ldCBh
cnJheXMuLi4gQW55d2F5IEkgd2FzIG1pc3Rha2VuIGFuZA0KPiB0aGVyZSB3aWxsIGJlIGluZGVl
ZCBubyBkZXJlZmVyZW5jZSBhdCB0aGUgYXNzaWdubWVudCwgYnV0IGZvciBjb2RlDQo+IGNsYXJp
dHkgSSB3b3VsZCBzdGlsbCBwcmVmZXIgdG8gZG8gdGhlIGNoZWNrIGVhcmxpZXIsIHNvOg0KPiAN
Cj4gPiANCj4gPiBvciBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gLWNvbnN0IHU4ICpsYXJib3N0ZCA9
IGxhcmItPmxhcmJfZ2VuLT5vc3RkW2xhcmItPmxhcmJpZF07DQo+ID4gK2NvbnN0IHU4ICpsYXJi
b3N0ZCA9IGxhcmItPmxhcmJfZ2VuLT5vc3RkID8gbGFyYi0+bGFyYl9nZW4tDQo+ID4gb3N0ZFts
YXJiLQ0KPiA+ID4gbGFyYmlkXSA6IE5VTEw7DQo+IA0KPiBBbHRob3VnaCBJIHRoaW5rIG5vdyB0
aGUgcHJvcGVyIHR5cGUgc2hvdWxkIGJlIGV4cGxpY2l0Lg0KPiBtdGtfc21pX2xhcmJfbXQ4MTk1
X29zdGQgaXMgYW4gMjgtZWxlbWVudCBhcnJheSBvZg0KPiBTTUlfTEFSQl9QT1JUX05SX01BWC1l
bGVtZW50IHU4IGFycmF5cywgdGhlcmVmb3JlIHN0cnVjdA0KPiBtdGtfc21pX2xhcmJfZ2VuIHNo
b3VsZCBiZToNCj4gCWNvbnN0IHU4ICgqb3N0ZClbXVtTTUlfTEFSQl9QT1JUX05SX01BWF07DQoN
Cm10ODE5NV9vc3RkIG9ubHkgaXMgYSAyIGRpbWVuc2lvbmFsIGFycmF5LA0Kc3RhdGljIGNvbnN0
IHU4IG10a19zbWlfbGFyYl9tdDgxOTVfb3N0ZFtdW1NNSV9MQVJCX1BPUlRfTlJfTUFYXTsNCg0K
SWYgdXNpbmcgdGhpcywgaXQgd2lsbCBjYXVzZSBidWlsZCBmYWlsOg0KDQouLi4vZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jOjM1OToyMzogZXJyb3I6IGluaXRpYWxpemF0aW9uIGZyb20NCmluY29t
cGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNd
DQogIC5vc3RkICAgICAgICAgICAgICA9IG10a19zbWlfbGFyYl9tdDgxOTVfb3N0ZCwNCiAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQoNCk1vcmUgYmFja2dy
b3VuZCBhYm91dCB0aGlzIDIgZGltZW5zaW9uYWwgYXJyYXk6DQpUaGUgcGxhdGZvcm0gaGF2ZSBt
YW55IGxhcmJzKHVwIHRvIE1US19MQVJCX05SX01BWCksIGVhY2ggYSBsYXJiIGhhdmUNCm1hbnkg
cG9ydHModXAgdG8gU01JX0xBUkJfUE9SVF9OUl9NQVgpLiBJbiB0aGUNCmZ1bmN0aW9uKCpfY29u
ZmlnX3BvcnRfZ2VuMl9nZW5lcmFsKSwgd2Ugd2lsbCB1cGRhdGUgdGhlIHZhbHVlIGZvciBlYWNo
DQphIHBvcnQgaW5zaWRlIGEgbGFyYiwgdGh1cyB3ZSBuZWVkIGEgcG9pbnRlciBwb2ludCB0byB0
aGUgbGluZSBvZiB0aGF0DQpsYXJiLg0KDQpJZiBJIG1pc3Mgc29tZXRoaW5nLCBwbGVhc2UgdGVs
bCBtZS4gb3IgaG93IHRvIG1hbmFnZSB0aGlzIHdpbGwgYmUNCmJldHRlci4NCg0KVGhhbmtzLg0K
DQo+IA0KPiBSaWdodD8NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

