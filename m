Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7814C4317DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhJRLtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:49:39 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50448 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231167AbhJRLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:49:33 -0400
X-UUID: 92cd70f2146745aaaebaee69d67176e4-20211018
X-UUID: 92cd70f2146745aaaebaee69d67176e4-20211018
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1718341955; Mon, 18 Oct 2021 19:47:19 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 18 Oct 2021 19:47:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Oct
 2021 19:47:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Oct 2021 19:47:17 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        "Weiyi Lu" <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH v5 1/5] dt-bindings: clock: mediatek: document clk bindings for mediatek mt7986 SoC
Date:   Mon, 18 Oct 2021 19:46:57 +0800
Message-ID: <20211018114701.13984-2-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211018114701.13984-1-sam.shih@mediatek.com>
References: <20211018114701.13984-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for topckgen, apmixedsys,
infracfg, and ethernet subsystem clocks.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v4: separate clock part into a single patch series

Original thread:
https://lore.kernel.org/linux-arm-kernel/20210914085137.31761-2-sam.shih@mediatek.com/

v3: Added an Acked-by tag
v2: remove compatiable string 'mt7986-sgmiisys'
---
 .../devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt    | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,ethsys.txt        | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,infracfg.txt      | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt      | 2 ++
 .../devicetree/bindings/arm/mediatek/mediatek,topckgen.txt      | 1 +
 5 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index ea827e8763de..3fa755866528 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt7629-apmixedsys"
+	- "mediatek,mt7986-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8167-apmixedsys", "syscon"
 	- "mediatek,mt8173-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 6b7e8067e7aa..0502db73686b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- "mediatek,mt7622-ethsys", "syscon"
 	- "mediatek,mt7623-ethsys", "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7629-ethsys", "syscon"
+	- "mediatek,mt7986-ethsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index eb3523c7a7be..f66bd720571d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt7629-infracfg", "syscon"
+	- "mediatek,mt7986-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8167-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
index 30cb645c0e54..29ca7a10b315 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -8,6 +8,8 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-sgmiisys", "syscon"
 	- "mediatek,mt7629-sgmiisys", "syscon"
+	- "mediatek,mt7986-sgmiisys_0", "syscon"
+	- "mediatek,mt7986-sgmiisys_1", "syscon"
 - #clock-cells: Must be 1
 
 The SGMIISYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index 5ce7578cf274..b82422bb717f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt7629-topckgen"
+	- "mediatek,mt7986-topckgen", "syscon"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8167-topckgen", "syscon"
 	- "mediatek,mt8173-topckgen"
-- 
2.29.2

