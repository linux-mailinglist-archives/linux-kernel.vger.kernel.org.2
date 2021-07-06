Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A172D3BC672
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGFGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:23:01 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:40958 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230285AbhGFGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:23:00 -0400
X-UUID: 10987ded823e46739cdc42633f6ddbd7-20210706
X-UUID: 10987ded823e46739cdc42633f6ddbd7-20210706
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1366420746; Tue, 06 Jul 2021 14:20:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Jul 2021 14:20:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Jul 2021 14:20:16 +0800
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
Subject: [v13 03/21] dt-bindings: ARM: Mediatek: Add audsys document binding for MT8192
Date:   Tue, 6 Jul 2021 14:19:02 +0800
Message-ID: <20210706061920.16013-4-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210706061920.16013-1-chun-jie.chen@mediatek.com>
References: <20210706061920.16013-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the audsys document binding for MT8192 SoC.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,audsys.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index b32d374193c7..699776be1dd3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt8167-audiosys", "syscon"
 	- "mediatek,mt8183-audiosys", "syscon"
+	- "mediatek,mt8192-audsys", "syscon"
 	- "mediatek,mt8516-audsys", "syscon"
 - #clock-cells: Must be 1
 
-- 
2.18.0

