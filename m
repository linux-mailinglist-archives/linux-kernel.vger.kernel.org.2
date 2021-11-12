Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE844DFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhKLBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 20:20:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50424 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230386AbhKLBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:20:24 -0500
X-UUID: 8bef31ca734f4c7db15d5148442fd4cd-20211112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=J89u8ajOE7RnIe0Hf+cMtrKrCMlq2XyJUXaOQVwayHQ=;
        b=L3B38oRthqNSBzsV/ntQFDtKu8+u2+Usm+oFm+a8yw8z4Dg4QCEZS4nA02StJMQVK3bKby7dmZBOV+QCInQEm02ONMg+jaRgQ7DcHLdjyJatXuxycBJ965eCd2Eb1qYvdPRbPhIbwlaNlWUcNT2BzB8jv8F1bPBuhGU90RLPyjo=;
X-UUID: 8bef31ca734f4c7db15d5148442fd4cd-20211112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 824726951; Fri, 12 Nov 2021 09:17:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 09:17:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 09:17:28 +0800
Message-ID: <36653ae5c1e1babe314eabf070f3220a603d55c7.camel@mediatek.com>
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Fri, 12 Nov 2021 09:17:28 +0800
In-Reply-To: <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
         <1d72bac8-eb79-6f34-79ca-4c5c38d6d2bf@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciBoZWxwIHJl
dmlldy4NCg0KT24gVGh1LCAyMDIxLTExLTExIGF0IDE0OjQxICswMTAwLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDgvMTEvMjEgMDk6MjQsIFlvbmcgV3UgaGEgc2Ny
aXR0bzoNCj4gPiBXZSBhZGQgdGhlIG9zdGQgc2V0dGluZyBmb3IgbXQ4MTk1LiBJdCBpbnRyb2R1
Y2VzIGEgS0UgZm9yIHRoZQ0KPiA+IHByZXZpb3VzIFNvQyB3aGljaCBkb2Vzbid0IGhhdmUgb3N0
ZCBzZXR0aW5nLiBUaGlzIGlzIHRoZSBsb2c6DQo+ID4gDQo+ID4gVW5hYmxlIHRvIGhhbmRsZSBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcw0KPiA+IDAw
MDAwMDAwMDAwMDAwODANCj4gPiAuLi4NCj4gPiBwYyA6IG10a19zbWlfbGFyYl9jb25maWdfcG9y
dF9nZW4yX2dlbmVyYWwrMHg2NC8weDEzMA0KPiA+IGxyIDogbXRrX3NtaV9sYXJiX3Jlc3VtZSsw
eDU0LzB4OTgNCj4gPiAuLi4NCj4gPiBDYWxsIHRyYWNlOg0KPiA+ICAgbXRrX3NtaV9sYXJiX2Nv
bmZpZ19wb3J0X2dlbjJfZ2VuZXJhbCsweDY0LzB4MTMwDQo+ID4gICBwbV9nZW5lcmljX3J1bnRp
bWVfcmVzdW1lKzB4MmMvMHg0OA0KPiA+ICAgX19nZW5wZF9ydW50aW1lX3Jlc3VtZSsweDMwLzB4
YTgNCj4gPiAgIGdlbnBkX3J1bnRpbWVfcmVzdW1lKzB4OTQvMHgyYzgNCj4gPiAgIF9fcnBtX2Nh
bGxiYWNrKzB4NDQvMHgxNTANCj4gPiAgIHJwbV9jYWxsYmFjaysweDZjLzB4NzgNCj4gPiAgIHJw
bV9yZXN1bWUrMHgzMTAvMHg1NTgNCj4gPiAgIF9fcG1fcnVudGltZV9yZXN1bWUrMHgzYy8weDg4
DQo+ID4gDQo+ID4gSW4gdGhlIGNvZGU6IGxhcmJvc3RkID0gbGFyYi0+bGFyYl9nZW4tPm9zdGRb
bGFyYi0+bGFyYmlkXSwNCj4gPiBpZiAibGFyYi0+bGFyYl9nZW4tPm9zdGQiIGlzIG51bGwsIHRo
ZSAibGFyYm9zdGQiIGlzIHRoZQ0KPiA+IG9mZnNldChlLmcuDQo+ID4gMHg4MCBhYm92ZSksIGl0
J3MgYWxzbyBhIHZhbGlkIHZhbHVlLCB0aGVuIGFjY2Vzc2luZyAibGFyYm9zdGRbaV0iDQo+ID4g
aW4gdGhlDQo+ID4gImZvciIgbG9vcCB3aWxsIGNhdXNlIHRoZSBLRSBhYm92ZS4gVG8gYXZvaWQg
dGhpcyBpc3N1ZSwgaW5pdGlhbGl6ZQ0KPiA+ICJsYXJib3N0ZCIgdG8gTlVMTCB3aGVuIHRoZSBT
b0MgZG9lc24ndCBoYXZlIG9zdGQgc2V0dGluZy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
b25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2Ugbm90ZTog
UmV3b3JkIHRoZSBjb21taXQgbWVzc2FnZSB0byBzaG93IHdoeSBpdCBLRS4gYW5kDQo+ID4gdXBk
YXRlIHRoZQ0KPiA+IHNvbHV0aW9uIHZpYSBpbml0aWFsaXppbmcgImxhcmJvc3RkIiBpcyBOVUxM
IGV4cGxpY2l0bHkgaW4gdGhlIG5vbi0NCj4gPiBvc3RkDQo+ID4gY2FzZS4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiANCj4gVGhpcyBjb21taXQg
bmVlZHMgYSBGaXhlcyB0YWcuIFBsZWFzZSBhZGQgdGhlIHByb3BlciBvbmUuDQoNClRoaXMgc2hv
dWxkIGZpeCB0aGlzIG9uZToNCg0KZmU2ZGQyYTQwMTdkICgibWVtb3J5OiBtdGstc21pOiBtdDgx
OTU6IEFkZCBpbml0aWFsIHNldHRpbmcgZm9yIHNtaS0NCmxhcmIiKQ0KDQpCdXQgdGhlIGNvbW1p
dCBpZCBjb21lcyBmcm9tIGxpbnV4LW5leHQuIEknbSBub3Qgc3VyZSBpZiB0aGUgc2hhLWlkDQp3
aWxsIGJlIGNoYW5nZWQgYWdhaW4gd2hlbiBlbnRlciBtYWlubGluZS4gc28gSSBkaWRuJ3QgYWRk
IGl0Lg0KDQoNCg==

