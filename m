Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2853A45B463
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhKXGld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:41:33 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42794 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230323AbhKXGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:41:32 -0500
X-UUID: 92a946024915494c9220abda374a6952-20211124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o8yAD43f7Yz8PJZDUhlY+smBs0eLQyqXHTEwNYJfPik=;
        b=HkkCjWwDSUMjeXQBupvQ+cjRExZxoI4T911DAURMyNtWhlXCi3QVvtDVKNQCJ0cbeEwWmREPmNsJ27k16PBmqiKe76usJ3ahZRpZZLaoajlodgwd+wfQn/muwbAOVeDrE0nIeNkQ72jR/FccoL4N0CPwfH22L65/BecSMX37bHs=;
X-UUID: 92a946024915494c9220abda374a6952-20211124
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 186994505; Wed, 24 Nov 2021 14:38:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 24 Nov 2021 14:38:18 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Nov 2021 14:38:17 +0800
Message-ID: <26704c3979b1c8936ab14d9ea7704166aca66887.camel@mediatek.com>
Subject: Re: [RFC PATCH] soc: mediatek: Add support always on flag
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Nov 2021 14:38:17 +0800
In-Reply-To: <e6ebf764-b94a-7b77-df17-1cb8e4b14635@collabora.com>
References: <20211102072058.4107-1-chunfeng.yun@mediatek.com>
         <e6ebf764-b94a-7b77-df17-1cb8e4b14635@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTExLTExIGF0IDE0OjU2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDIvMTEvMjEgMDg6MjAsIENodW5mZW5nIFl1biBoYSBzY3JpdHRv
Og0KPiA+IFRoZXJlIGlzIGEgdC1waHkgc2hhcmVkIGJ5IFBDSWUgYW5kIFVTQjMgb24gbXQ4MTk1
LCBpZiB0aGUgdC1waHkgaXMNCj4gPiB1c2VkIGJ5IFBDSWUsIHdoZW4gcG93ZXIgb2ZmIGl0cyBt
dGNtb3MsIG5lZWQgc29mdHdhcmUgcmVzZXQgaXQNCj4gPiAod29ya2Fyb3VuZCB3YXksIHVzdWFs
bHkgaGFyZHdhcmUgZG8gaXQsIGJ1dCBoYXMgYW4gaXNzdWUgb24NCj4gPiBtdDgxOTUpLA0KPiA+
IGJ1dCBpdCBoYXMgc2lkZSBlZmZlY3QgdG8gVVNCMiBwaHkod29ya3Mgd2l0aCBVU0IzIHBoeSB0
byBzdXBwb3J0DQo+ID4gVVNCMy4yIEdlbjEpLCBzbyBhZGQgc3VwcG9ydCBHRU5QRF9GTEFHX0FM
V0FZU19PTiBmbGFnLCBhbmQgbWFrZQ0KPiA+IGl0cw0KPiA+IHBvd2VyIGFsd2F5cyBvbjsNCj4g
PiBBbm90aGVyIHJlYXNvbiBpcyB0aGF0IFVTQjMuMiBHZW4xLzIgbmVlZCBrZWVwIHBvd2VyIGFs
d2F5cyBvbiB3aGVuDQo+ID4gc3VwcG9ydCBydW50aW1lLXBtIGR1ZSB0byBoYXJkd2FyZSBsaW1p
dGF0aW9uIHVudGlsIG5vdzsNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdDgxOTUtcG0tZG9tYWlucy5oIHwgMiArLQ0KPiA+ICAgZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyAgICB8IDIgKysNCj4gPiAgIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1wbS1kb21haW5zLmggICAgfCAxICsNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+IA0KPiBIZWxsbyBDaHVuZmVuZywN
Cj4gd2hhdCBhcmUgYXJlIHRoZSBzaWRlIGVmZmVjdHMgb24gdGhlIFVTQjIgUEhZPyBDYW4geW91
IHBsZWFzZSBleHBhbmQ/DQpTb3JyeSBmb3IgbGF0ZXIgcmVwbHksIEkgbWlzc2VkIHRoaXMgbWVz
c2FnZS4NCg0KdGhlIHNpZGUgZWZmZWN0IG9uIHUyIHBoeSBpcyB0aGF0IGl0IHdpbGwgY2F1c2Ug
dTIgcGh5IHBvd2VyIG9mZiBhbmQNCmNhdXNlIG90aGVyIGlzc3VlcywgZS5nLiBpZiB0aGVyZSBp
cyBhIGRldmljZSBwbHVnZ2VkIGluIHUyIHBvcnQsIGl0DQp3aWxsIGRpc2Nvbm5lY3QsIG1vcmUg
b3ZlciBpdCB3aWxsIG5vdCB3b3JrIHVudGlsIHJlYm9vdCBwbGF0Zm9ybS4NCg0KPiANCj4gQWxz
bywgd291bGRuJ3QgaXQgYmUgcG9zc2libGUgdG8gYWxzbyByZXNldCB0aGUgVVNCMiBQSFkgd2hl
bg0KPiByZXNldHRpbmcgdGhlIHQtcGh5DQo+IGluIG9yZGVyIHRvIGdldCBpdCBiYWNrIHVwIGFu
ZCBydW5uaW5nPw0KTm8sIHRoZSB1c2IgZHJpdmVyIGRvbid0IHJlc2V0IG9yIHJlaW5pdCBwaHkg
YWZ0ZXIgcHJvYmU7DQoNCj4gDQo+IE1vcmVvdmVyLCBhcyBmb3IgdGhlIFVTQjMuMiBoYXJkd2Fy
ZSBsaW1pdGF0aW9uLi4uIEkgd291bGQgc2F5IHRoYXQNCj4gdGhpcyBpcyBtb3JlDQo+IGxpa2Ug
c29tZXRoaW5nIHRoYXQgaGFzIHRvIGJlIGFjY291bnRlZCBmb3IgaW4gdGhlIFVTQiBkcml2ZXIs
DQo+IGluc3RlYWQgb2YgdGhlIFBNDQo+IGRvbWFpbnMgZHJpdmVyLi4uIHVubGVzcyB0aGVyZSdz
IHNvbWUgcmVhc29uIHRoYXQgc3RvcHMgeW91IGZyb20NCj4gZG9pbmcgdGhhdD8NClVzYiBkcml2
ZXIgaXRzZWxmIGNhbid0IGhhbmRsZSB0aGlzIGNhc2UuIGJ1dCBwb3dlciBkb21haW4ncyBkcml2
ZXIgY2FuDQpoYW5kbGUgaXQgZWFzaWx5Lg0KDQo+IA0KPiBUaGFua3MsDQo+IC0gQW5nZWxvDQo=

