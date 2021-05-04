Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422E83724D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhEDEL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:11:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41147 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229499AbhEDEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:11:58 -0400
X-UUID: ba70794388d84390b8715bdd006084f9-20210504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/cbVo2HXM2EBR6+XgYLdg2qe+Xrids+DQpIfN0W+BU8=;
        b=nW5JXRJR4HBHHZUE7Cd/pIt2oHMIw8AMNsx/SU2FuutBl6KpISLn3GkCfaxZCtDNBczMeTcsw4Pz77JEo0LAy5K72plc2ilItC8HZYo8ATxc7cYlULk5RpSB1qi3EYO/YvkbDO1PtDBT4Zy6G9/tH5rz4bGxJ+CEmhftMqQBjgw=;
X-UUID: ba70794388d84390b8715bdd006084f9-20210504
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 100049445; Tue, 04 May 2021 12:11:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 May 2021 12:10:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 12:10:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 May 2021 12:10:59 +0800
Message-ID: <1620101459.15918.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 2/2] dt-bindings: mediatek: Add optional mediatek,
 gce-events property
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 4 May 2021 12:10:59 +0800
In-Reply-To: <20210503050523.2571758-2-hsinyi@chromium.org>
References: <20210503050523.2571758-1-hsinyi@chromium.org>
         <20210503050523.2571758-2-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4teWk6DQoNCk9uIE1vbiwgMjAyMS0wNS0wMyBhdCAxMzowNSArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBtZWRpYXRlayxnY2UtZXZlbnRzIHByb3BlcnR5IGlzIHVzZWQgYnkg
Z2NlIGNsaWVudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2luLVlpIFdhbmcgPGhzaW55aUBj
aHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxkaXNwLnR4dCAgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlz
cC50eHQNCj4gaW5kZXggZmJiNTljOWRkZGE2Li45MzliMmRhM2JkYzUgMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLGRpc3AudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQo+IEBAIC03NSw2ICs3NSwxMCBAQCBP
cHRpb25hbCBwcm9wZXJ0aWVzIChSRE1BIGZ1bmN0aW9uIGJsb2Nrcyk6DQo+ICAgIG1lZGlhdGVr
LHJkbWEtZmlmby1zaXplIG9mIG10ODE4My1yZG1hMCBpcyA1Sw0KPiAgICBtZWRpYXRlayxyZG1h
LWZpZm8tc2l6ZSBvZiBtdDgxODMtcmRtYTEgaXMgMksNCj4gIA0KPiArT3B0aW9uYWwgcHJvcGVy
dGllcyBmb3IgZGlzcGxheSBtdXRleDoNCj4gKy0gbWVkaWF0ZWssZ2NlLWV2ZW50czogR0NFIGV2
ZW50cyB1c2VkIGJ5IGNsaWVudHMuIFRoZSBldmVudCBudW1iZXJzIGFyZQ0KPiArICBkZWZpbmVk
IGluICdkdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oJy4NCg0KSSB0aGluayBtZWRpYXRlayxn
Y2UtZXZlbnRzIHNob3VsZCBiZSBmaXJzdCBkZWZpbmVkIGluIFsxXSwgYW5kIGhlcmUNCnJlZmVy
IHRvIFsxXS4NCg0KSW4gYWRkaXRpb24sIG10ay1tdXRleCBkcml2ZXIgaXMgbW92ZWQgaW50byBz
b2MgZm9sZGVyLCBzbyBJIHdvdWxkIGxpa2UNCnRvIG1vdmUgbXRrLW11dGV4IGJpbmRpbmcgb3V0
IG9mIGRpc3BsYXkgYmluZGluZy4gSXQncyB1cCB0byB5b3UuDQoNClsxXSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dA0KDQpSZWdhcmRzLA0KQ0sN
Cg0KPiArDQo+ICBFeGFtcGxlczoNCj4gIA0KPiAgbW1zeXM6IGNsb2NrLWNvbnRyb2xsZXJAMTQw
MDAwMDAgew0KPiBAQCAtMjA5LDYgKzIxMyw4IEBAIG11dGV4OiBtdXRleEAxNDAyMDAwMCB7DQo+
ICAJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2OSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiAgCXBv
d2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNfUE9XRVJfRE9NQUlOX01NPjsNCj4gIAljbG9j
a3MgPSA8Jm1tc3lzIENMS19NTV9NVVRFWF8zMks+Ow0KPiArCW1lZGlhdGVrLGdjZS1ldmVudHMg
PSA8Q01EUV9FVkVOVF9NVVRFWDBfU1RSRUFNX0VPRj4sDQo+ICsJCQkgICAgICA8Q01EUV9FVkVO
VF9NVVRFWDFfU1RSRUFNX0VPRj47DQo+ICB9Ow0KPiAgDQo+ICBvZEAxNDAyMzAwMCB7DQoNCg==

