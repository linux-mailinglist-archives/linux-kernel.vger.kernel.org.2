Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE03BB5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhGEDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:44:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38958 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229652AbhGEDoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:44:06 -0400
X-UUID: fce8d3ac968b44ffa35e3a26cf4f25c5-20210705
X-UUID: fce8d3ac968b44ffa35e3a26cf4f25c5-20210705
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1849710250; Mon, 05 Jul 2021 11:41:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Jul 2021 11:41:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Jul 2021 11:41:24 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v12 02/20] dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
Date:   Mon, 5 Jul 2021 11:38:06 +0800
Message-ID: <20210705033824.1934-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210705033824.1934-1-chun-jie.chen@mediatek.com>
References: <20210705033824.1934-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the mmsys document binding for MT8192 SoC.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 78c50733985c..9712a6831fab 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -16,6 +16,7 @@ Required Properties:
 	- "mediatek,mt8167-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
 	- "mediatek,mt8183-mmsys", "syscon"
+	- "mediatek,mt8192-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 For the clock control, the mmsys controller uses the common clk binding from
-- 
2.18.0

