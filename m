Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4406E3D3697
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhGWHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:42:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234263AbhGWHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:42:47 -0400
X-UUID: 5e3aceeea4dd4036aedac74bcfae7582-20210723
X-UUID: 5e3aceeea4dd4036aedac74bcfae7582-20210723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 595526317; Fri, 23 Jul 2021 16:23:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Jul 2021 16:23:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 16:23:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v4 1/3] dt-bindings: phy: mediatek: tphy: add support hardware version 3
Date:   Fri, 23 Jul 2021 16:22:40 +0800
Message-ID: <1627028562-23584-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHYA architecture is updated, and doesn't support slew rate
calibration anymore on 7nm or advanced process, add a new version
number to support it.
Due to the FreqMeter bank is not used but reserved, it's backward
with v2 until now.
For mt8195, no function changes when use generic v2 or v3 compatible,
but prefer to use v3's compatible, it will not waste the time to
calibrate the slew rate, and also correspond with hardware version.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v4: no changes
v3: add Acked-by Rob
v2: add more commit log suggested by Rob
---
 .../devicetree/bindings/phy/mediatek,tphy.yaml     | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index ef9d9d4e6875..838852cb8527 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -15,7 +15,7 @@ description: |
   controllers on MediaTek SoCs, includes USB2.0, USB3.0, PCIe and SATA.
 
   Layout differences of banks between T-PHY V1 (mt8173/mt2701) and
-  T-PHY V2 (mt2712) when works on USB mode:
+  T-PHY V2 (mt2712) / V3 (mt8195) when works on USB mode:
   -----------------------------------
   Version 1:
   port        offset    bank
@@ -34,7 +34,7 @@ description: |
   u2 port2    0x1800    U2PHY_COM
               ...
 
-  Version 2:
+  Version 2/3:
   port        offset    bank
   u2 port0    0x0000    MISC
               0x0100    FMREG
@@ -59,7 +59,8 @@ description: |
 
   SPLLC shared by u3 ports and FMREG shared by u2 ports on V1 are put back
   into each port; a new bank MISC for u2 ports and CHIP for u3 ports are
-  added on V2.
+  added on V2; the FMREG bank for slew rate calibration is not used anymore
+  and reserved on V3;
 
 properties:
   $nodename:
@@ -79,8 +80,11 @@ properties:
               - mediatek,mt2712-tphy
               - mediatek,mt7629-tphy
               - mediatek,mt8183-tphy
-              - mediatek,mt8195-tphy
           - const: mediatek,generic-tphy-v2
+      - items:
+          - enum:
+              - mediatek,mt8195-tphy
+          - const: mediatek,generic-tphy-v3
       - const: mediatek,mt2701-u3phy
         deprecated: true
       - const: mediatek,mt2712-u3phy
@@ -91,7 +95,7 @@ properties:
     description:
       Register shared by multiple ports, exclude port's private register.
       It is needed for T-PHY V1, such as mt2701 and mt8173, but not for
-      T-PHY V2, such as mt2712.
+      T-PHY V2/V3, such as mt2712.
     maxItems: 1
 
   "#address-cells":
-- 
2.18.0

