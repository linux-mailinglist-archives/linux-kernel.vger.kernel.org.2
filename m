Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF781424C00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 05:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhJGDCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 23:02:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34072 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229867AbhJGDCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:02:15 -0400
X-UUID: b042151d92b5446492c6733a6cb81a1e-20211007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JFzGo/WxNZB+Ws19Df4O4JzpkbbM9zmDRpzU+60snW8=;
        b=P1WfJPTiCRORPrzv8PKqLG5Bb7JH3+uSwGUZed8BBYmRP8W93XyN9WGWHmPo5PaFC5CphRlOsVxCBMOKwQS4fBuXLdwhumhYPeDUT2rBwI/ypfmGzZP77pAi6yEAgtMCeNhkQ3UfgAP2/BkzOY0OGhKo1w8rENFZwBKCXSJx3mc=;
X-UUID: b042151d92b5446492c6733a6cb81a1e-20211007
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1664456728; Thu, 07 Oct 2021 11:00:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Oct 2021 11:00:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 11:00:15 +0800
Message-ID: <111c6f3905f4349e6e30cde60bdc70672ee036b3.camel@mediatek.com>
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while
 tlb flush
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>
Date:   Thu, 7 Oct 2021 11:00:19 +0800
In-Reply-To: <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
         <20210813065324.29220-12-yong.wu@mediatek.com>
         <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTMwIGF0IDEzOjI2ICswMjAwLCBEYWZuYSBIaXJzY2hmZWxkIHdyb3Rl
Og0KPiANCj4gT24gMTMuMDguMjEgMDg6NTMsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gUHJlcGFyZSBm
b3IgMiBIV3MgdGhhdCBzaGFyaW5nIHBndGFibGUgaW4gZGlmZmVyZW50IHBvd2VyLWRvbWFpbnMu
DQo+ID4gDQo+ID4gVGhlIHByZXZpb3VzIFNvQyBkb24ndCBoYXZlIFBNLiBPbmx5IG10ODE5MiBo
YXMgcG93ZXItZG9tYWluLA0KPiA+IGFuZCBpdCBpcyBkaXNwbGF5J3MgcG93ZXItZG9tYWluIHdo
aWNoIG5lYXJseSBhbHdheXMgaXMgZW5hYmxlZC4NCj4gDQo+IGhpLCBJIHNlZSB0aGF0IGluIG10
MTg3My5kdHNpLCBtYW55IGRldmljZXMgdGhhdCB1c2VzIHRoZSBpb21tdSBoYXZlDQo+IHRoZQ0K
PiAncG93ZXItZG9tYWlucycgcHJvcGVydHkuDQoNClNvcnJ5LCBJIGRpZG4ndCBjbGFyaWZ5IHRo
aXMgY2xlYXIuIEkgbWVhbiB0aGUgaW9tbXUgZGV2aWNlIGRvbid0IGhhdmUNCnRoaXMgcHJvcGVy
dHkgcmF0aGVyIHRoYW4gdGhlIG90aGVyIGRldmljZS4NCg0KPiANCj4gPiANCj4gPiBXaGVuIHRo
ZXJlIGFyZSAyIE00VSBIV3MsIGl0IG1heSBoYXMgcHJvYmxlbS4NCj4gPiBJbiB0aGlzIGZ1bmN0
aW9uLCB3ZSBnZXQgdGhlIHBtX3N0YXR1cyB2aWEgdGhlIG00dSBkZXYsIGJ1dCBpdA0KPiA+IGRv
bid0DQo+ID4gcmVmbGVjdCB0aGUgcmVhbCBwb3dlci1kb21haW4gc3RhdHVzIG9mIHRoZSBIVyBz
aW5jZSB0aGVyZSBtYXkgYmUNCj4gPiBvdGhlcg0KPiA+IEhXIGFsc28gdXNlIHRoYXQgcG93ZXIt
ZG9tYWluLg0KPiA+IA0KPiA+IEN1cnJlbnRseSB3ZSBjb3VsZCBub3QgZ2V0IHRoZSByZWFsIHBv
d2VyLWRvbWFpbiBzdGF0dXMsIHRodXMNCj4gPiBhbHdheXMNCj4gPiBwbV9ydW50aW1lX2dldCBo
ZXJlLg0KPiA+IA0KPiA+IFByZXBhcmUgZm9yIG10ODE5NSwgdGh1cywgbm8gbmVlZCBmaXggdGFn
cyBoZXJlLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggbWF5IGRyb3AgdGhlIHBlcmZvcm1hbmNlLCB3
ZSBleHBlY3QgdGhlIHVzZXIgY291bGQNCj4gPiBwbV9ydW50aW1lX2dldF9zeW5jIGJlZm9yZSBk
bWFfYWxsb2NfYXR0cnMgd2hpY2ggbmVlZCB0bGIgb3BzLg0KPiA+IA0KPiANCj4gQ291bGQgeW91
IGV4cGxhaW4gdGhpcyBzZW50ZW5jZSBhIGJpdD8gc2hvdWxkIHRoZSB1c2VyIGNhbGwNCj4gcG1f
cnVudGltZV9nZXRfc3luYw0KPiBiZWZvcmUgY2FsbGluZyBkbWFfYWxsb2NfYXR0cnM/DQoNCklu
IHYzLCBJIGhhdmUgcmVtb3ZlZCB0aGlzIHBhdGNoLiBVc2UgWzFdIGluc3RlYWQuDQoNClsxXSAN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1lZGlhdGVrLzIwMjEwOTIzMTE1ODQwLjE3
ODEzLTEzLXlvbmcud3VAbWVkaWF0ZWsuY29tLw0KDQpUaGFua3MuDQoNCj4gDQo+IFRoYW5rcywN
Cj4gRGFmbmENCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNSArKysr
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IGFkZDIzYTM2YTVlMi4uYWJjNzIxYTFkYTIx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTIzOCw4ICsyMzgsMTEgQEAgc3RhdGlj
IHZvaWQNCj4gPiBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWduZWQgbG9uZyBp
b3ZhLCBzaXplX3Qgc2l6ZSwNCj4gPiAgIA0KPiA+ICAgCWZvcl9lYWNoX200dShkYXRhLCBoZWFk
KSB7DQo+ID4gICAJCWlmIChoYXNfcG0pIHsNCj4gPiAtCQkJaWYgKHBtX3J1bnRpbWVfZ2V0X2lm
X2luX3VzZShkYXRhLT5kZXYpIDw9IDApDQo+ID4gKwkJCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1l
X2FuZF9nZXQoZGF0YS0+ZGV2KTsNCj4gPiArCQkJaWYgKHJldCA8IDApIHsNCj4gPiArCQkJCWRl
dl9lcnIoZGF0YS0+ZGV2LCAidGxiIGZsdXNoOiBwbSBnZXQNCj4gPiBmYWlsICVkLlxuIiwgcmV0
KTsNCj4gPiAgIAkJCQljb250aW51ZTsNCj4gPiArCQkJfQ0KPiA+ICAgCQl9DQo+ID4gICANCj4g
PiAgIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBmbGFncyk7DQo+ID4gDQo=

