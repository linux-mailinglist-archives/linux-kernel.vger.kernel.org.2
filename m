Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8430A27B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhBAHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:07:13 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45011 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231701AbhBAHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:22 -0500
X-UUID: b6d8dad19918432a8f000628b8f87da8-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UOcuIaE9fm+4Jxy7zMfdKWA5Mhi3iBZSD6VumjX/YQk=;
        b=LrFUbkKL5hHOWT1bvwhCObsKLChv4FYQKCRVZYhr/9GCHyV7NK3Z/WoUPM0QQAu7Ka0P/ppDMsE6kKsWRdZs7KR2a8j1jZ3aXBIMjRYjOObVmgYGfwR7HCqoegZIuYDjJLIdCFlY6XhQhcia/ioyMEKFuLvmS0rw5TEocBc2fyM=;
X-UUID: b6d8dad19918432a8f000628b8f87da8-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 600100022; Mon, 01 Feb 2021 15:00:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:24 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:24 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v3 03/16] dt-bindings: phy: mediatek: dsi-phy: modify compatible dependence
Date:   Mon, 1 Feb 2021 15:00:03 +0800
Message-ID: <20210201070016.41721-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C08C911394D61AA5BFC4D0B71EFC82F98286D03A03BE2116698030A83F4CA37F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bXQ3NjIzLW1pcGktdHggaXMgY29tcGF0aWJsZSB0byBtdDI3MDEtbWlwaS10eCwgYW5kIHVzZQ0K
Im1lZGlhdGVrLG10MjcwMS1taXBpLXR4IiBpbnN0ZWFkIG9uIE1UNzYyMywgc28gbW9kaWZ5DQp0
aGUgY29tcGF0aWJsZSBpdGVtcyB0byBtYWtlIGRlcGVuZGVuY2UgY2xlYXIuDQoNCkNjOiBDaHVu
LUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCkNjOiBQaGlsaXBwIFphYmVsIDxw
LnphYmVsQHBlbmd1dHJvbml4LmRlPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MzogbW9kaWZ5IGNvbW1pdCBtZXNzYWdlIHN1
Z2dlc3RlZCBieSBDSw0KdjI6IHNlcGFyYXRlIHR3byBwYXRjaGVzIHN1Z2dlc3RlZCBieSBDSw0K
LS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbCAg
IHwgMTMgKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQppbmRleCA3MWQ0YWNlYTFmNjYu
LjZlNGQ3OTVmOWIwMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbA0KQEAgLTE5LDExICsxOSwx
NCBAQCBwcm9wZXJ0aWVzOg0KICAgICBwYXR0ZXJuOiAiXmRzaS1waHlAWzAtOWEtZl0rJCINCiAN
CiAgIGNvbXBhdGlibGU6DQotICAgIGVudW06DQotICAgICAgLSBtZWRpYXRlayxtdDI3MDEtbWlw
aS10eA0KLSAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgNCi0gICAgICAtIG1lZGlhdGVr
LG10ODE3My1taXBpLXR4DQotICAgICAgLSBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KKyAgICBv
bmVPZjoNCisgICAgICAtIGl0ZW1zOg0KKyAgICAgICAgICAtIGVudW06DQorICAgICAgICAgICAg
ICAtIG1lZGlhdGVrLG10NzYyMy1taXBpLXR4DQorICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVr
LG10MjcwMS1taXBpLXR4DQorICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1pcGktdHgN
CisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxNzMtbWlwaS10eA0KKyAgICAgIC0gY29uc3Q6
IG1lZGlhdGVrLG10ODE4My1taXBpLXR4DQogDQogICByZWc6DQogICAgIG1heEl0ZW1zOiAxDQot
LSANCjIuMTguMA0K

