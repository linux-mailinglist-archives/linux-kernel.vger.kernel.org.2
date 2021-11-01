Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A96441251
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhKADS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:18:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34288 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230222AbhKADSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:18:55 -0400
X-UUID: 48e43b0dd3e4464dbcabdf5578280799-20211101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MplEKwNK6OAffXAWeN1ahMfbiWO2NiLp63P/1LmLGmw=;
        b=GwLjNXSy9y3R8TBI6qDXqnz80ODYYegeSsZ5xWIcRcMN8Yokk0J4LaCQDl0f28JyFayOUTiNri6legOvAlqbuq+DM2RutmdALU+y67KHM1r7/ObUKEvHUem5inSeOtYItalllV8E3F6cjf8ZyXwLtOerYKO5f+7KX5UiPB2r3Gg=;
X-UUID: 48e43b0dd3e4464dbcabdf5578280799-20211101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1647572588; Mon, 01 Nov 2021 11:16:17 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Nov 2021 11:16:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Nov
 2021 11:16:16 +0800
Received: from mszsdhlt06 (10.16.6.206) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Nov 2021 11:16:15 +0800
Message-ID: <a16150b6b10dca4bf961b8e02b5e4d940b98468c.camel@mediatek.com>
Subject: Re: [PATCH v7 3/3] drm/bridge: anx7625: config hs packets end
 aligned to avoid screen shift
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <shuijing.li@mediatek.com>
Date:   Mon, 1 Nov 2021 11:16:15 +0800
In-Reply-To: <20210915223117.7857-4-jitao.shi@mediatek.com>
References: <20210915223117.7857-1-jitao.shi@mediatek.com>
         <20210915223117.7857-4-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGluLA0KDQpQbGVhc2UgaGVscCB0byByZXZpZXcgdGhlIGNoYW5nZXMgaW4gYW54NzYyNS5j
DQoNCk9uIFRodSwgMjAyMS0wOS0xNiBhdCAwNjozMSArMDgwMCwgSml0YW8gU2hpIHdyb3RlOg0K
PiBUaGlzIGRldmljZSByZXF1aXJlcyB0aGUgcGFja2V0cyBvbiBsYW5lcyBhbGlnbmVkIGF0IHRo
ZSBlbmQgdG8gZml4DQo+IHNjcmVlbiBzaGlmdCBvciBzY3JvbGwuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9hbmFsb2dpeC9hbng3NjI1LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9i
cmlkZ2UvYW5hbG9naXgvYW54NzYyNS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9hbmFs
b2dpeC9hbng3NjI1LmMNCj4gaW5kZXggMTRkNzNmYjFkZDE1Li5kNzZmYjYzZmE5ZjcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYyNS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW54NzYyNS5jDQo+IEBAIC0xMzI3
LDYgKzEzMjcsNyBAQCBzdGF0aWMgaW50IGFueDc2MjVfYXR0YWNoX2RzaShzdHJ1Y3QNCj4gYW54
NzYyNV9kYXRhICpjdHgpDQo+ICAJCU1JUElfRFNJX01PREVfVklERU9fU1lOQ19QVUxTRQl8DQo+
ICAJCU1JUElfRFNJX01PREVfTk9fRU9UX1BBQ0tFVAl8DQo+ICAJCU1JUElfRFNJX01PREVfVklE
RU9fSFNFOw0KPiArCWRzaS0+aHNfcGFja2V0X2VuZF9hbGlnbmVkID0gdHJ1ZTsNCj4gIA0KPiAg
CWlmIChtaXBpX2RzaV9hdHRhY2goZHNpKSA8IDApIHsNCj4gIAkJRFJNX0RFVl9FUlJPUihkZXYs
ICJmYWlsIHRvIGF0dGFjaCBkc2kgdG8gaG9zdC5cbiIpOw0K

