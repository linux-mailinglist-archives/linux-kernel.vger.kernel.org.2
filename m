Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85C32CB94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhCDEo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:44:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36714 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhCDEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:43:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244g9Ro101939;
        Wed, 3 Mar 2021 22:42:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614832929;
        bh=7JT1cqvwkft7bIfWWqmj+KOSHCAdRh24MWWOwaCY3/Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xg8G4OeNymc1Xitl3vn6IbQqhoiAL0avDePoH3i3YU7V8SCLaB0zNq4lobH7HkYRv
         /BT3lFqnDGOknGpAW2fGm/yLHFt4voOSKlQ5JV06v2OhVCYSDeE4HoxbrN7bGsT2HR
         piFYAKBucUI07yOo/xblKPnQeZpRFNCgSPAAyfgU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244g9gA068777
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:42:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:42:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:42:08 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244fQfs042911;
        Wed, 3 Mar 2021 22:42:05 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 11/13] dt-bindings: phy: phy-cadence-sierra: Add binding to model Sierra as clock provider
Date:   Thu, 4 Mar 2021 10:11:20 +0530
Message-ID: <20210304044122.15166-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304044122.15166-1-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #clock-cells binding to model Sierra as clock provider and include
clock IDs for PLL_CMNLC and PLL_CMNLC1.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/phy-cadence-sierra.yaml        | 17 ++++++++++++++++-
 include/dt-bindings/phy/phy-cadence.h           |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index d210843863df..84383e2e0b34 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -26,6 +26,9 @@ properties:
   '#size-cells':
     const: 0
 
+  '#clock-cells':
+    const: 1
+
   resets:
     minItems: 1
     maxItems: 2
@@ -49,12 +52,24 @@ properties:
     const: serdes
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 4
 
   clock-names:
+    minItems: 2
     items:
       - const: cmn_refclk_dig_div
       - const: cmn_refclk1_dig_div
+      - const: pll0_refclk
+      - const: pll1_refclk
+
+  assigned-clocks:
+    minItems: 1
+    maxItems: 2
+
+  assigned-clock-parents:
+    minItems: 1
+    maxItems: 2
 
   cdns,autoconf:
     type: boolean
diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 4a5ea52a856f..4652bcb86265 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -13,4 +13,8 @@
 
 #define CDNS_TORRENT_REFCLK_DRIVER      0
 
+/* Sierra */
+#define CDNS_SIERRA_PLL_CMNLC		0
+#define CDNS_SIERRA_PLL_CMNLC1		1
+
 #endif /* _DT_BINDINGS_CADENCE_SERDES_H */
-- 
2.17.1

