Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA943C3B2C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhGKI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:27:47 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22833 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229758AbhGKI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:27:46 -0400
X-UUID: 66a7c42800e84741b6958cdd7e6f108b-20210711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iEJdw0JyYUyniYoye3JWNvieJPx3fB4KYOOg4DQ+F4M=;
        b=lOk4xUSh/as6K/L/wz/k/CSbenuIjRq5JLfC0Mx62sMvirx+QqunyMcqx1bQTOwUx5buHTFd3GZIBT0JO9oDjDKvm94B8m+Pwm1ggYXUMNn9GNqbnGr/Az4eBL54PnCRqUUr4UUFtvVKOCoqkvMmcSi1FvU+uTxuyZye1NCxFTk=;
X-UUID: 66a7c42800e84741b6958cdd7e6f108b-20210711
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 265461227; Sun, 11 Jul 2021 16:24:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Jul
 2021 16:24:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 16:24:52 +0800
Message-ID: <1625991892.22309.10.camel@mhfsdcap03>
Subject: Re: [PATCH 4/9] memory: mtk-smi: Rename smi_gen to smi_type
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Sun, 11 Jul 2021 16:24:52 +0800
In-Reply-To: <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
         <20210616114346.18812-5-yong.wu@mediatek.com>
         <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B01E0EC6D5C0AC2DAEDDFBE2800052CB3386659EA74D944E43EC036F416268192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTA4IGF0IDExOjM0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wNi8yMDIxIDEzOjQzLCBZb25nIFd1IHdyb3RlOg0KPiA+IFRoaXMgaXMg
YSBwcmVwYXJpbmcgcGF0Y2ggZm9yIGFkZGluZyBzbWkgc3ViIGNvbW1vbi4NCj4gDQo+IERvbid0
IHdyaXRlICJUaGlzIHBhdGNoIi4gVXNlIHNpbXBsZSBpbXBlcmF0aXZlOg0KPiAiUHJlcGFyZSBm
b3IgYWRkaW5nIHNtaSBzdWIgY29tbW9uLiINCj4gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y1LjEzL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLnJzdCNMODkNCg0KVGhhbmtzIHZlcnkgbXVjaC4gSSBkaWRuJ3Qgbm90aWNlIHRoaXMg
YmVmb3JlLg0KDQo+ICANCj4gPiBBYm91dCB0aGUgcHJldmlvdSBzbWlfZ2VuLCB3ZSBoYXZlIGdl
bjEvZ2VuMiB0aGF0IHN0YW5kIGZvciB0aGUgZ2VuZXJhdGlvbg0KPiA+IG51bWJlciBmb3IgSFcu
IEkgcGxhbiB0byBhZGQgYSBuZXcgdHlwZShzdWJfY29tbW9uKSwgdGhlbiB0aGUgImdlbiIgaXMg
bm90DQo+ID4gcHJvYmVyLiB0aGlzIHBhdGNoIG9ubHkgY2hhbmdlIGl0IHRvICJ0eXBlIiwgTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UuDQo+IA0KPiBTYW1lLg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tZW1vcnkvbXRrLXNtaS5jIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxp
c3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

