Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50E30A27C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBAHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:07:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19250 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229897AbhBAHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:01:20 -0500
X-UUID: 947004dd04ad4d00a3dd3a46c559b4c8-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RAvCKqYoW44PP996a5qjU2HirehW034YhLthlljVjjk=;
        b=DykwpZbUBFujrZiT087jma9LWvdvC1IoiTD8nIo55HP2s760xgqCxYX5nST5Sh+YztdDsdFE6w4j/RV/s0dtTvqDVqCFb6F2OvlHWVY5GhTFur9916P0ZBPyklrfTBiKX17PGq+Y0nZHABE1IuKlPCC2CpMZkF4rCVAIWdbB9Y8=;
X-UUID: 947004dd04ad4d00a3dd3a46c559b4c8-20210201
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1684700480; Mon, 01 Feb 2021 15:00:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 15:00:27 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 15:00:27 +0800
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
Subject: [PATCH next v3 08/16] dt-bindings: usb: mediatek: musb: add mt8516 compatbile
Date:   Mon, 1 Feb 2021 15:00:08 +0800
Message-ID: <20210201070016.41721-8-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7573AB0B7C86EF67596372DF535D13C72BEE81706ADCBB3029D3D196CFAAF8A72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHN1cHBvcnQgbXQ4NTE2IGNvbXBhdGJpbGUNCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52Mzogbm8gY2hhbmdlcw0K
LS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNi
LnlhbWwgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNi
LnlhbWwNCmluZGV4IGE1MTVjOWYzMGI5Ni4uZTAyZDhmNWQ1M2RjIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdXNiLnlhbWwNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXVzYi55
YW1sDQpAQCAtMTcsNiArMTcsNyBAQCBwcm9wZXJ0aWVzOg0KICAgY29tcGF0aWJsZToNCiAgICAg
aXRlbXM6DQogICAgICAgLSBlbnVtOg0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODUxNi1tdXNi
DQogICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLW11c2INCiAgICAgICAtIGNvbnN0OiBtZWRp
YXRlayxtdGstbXVzYg0KIA0KLS0gDQoyLjE4LjANCg==

