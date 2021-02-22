Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760932150D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBVLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:25:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59000 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhBVLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:24:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNbmn035081;
        Mon, 22 Feb 2021 05:23:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613993017;
        bh=NLb9VikzuEC/eyCmeIli0+Vydm/e4xaj3++s8WQCSn4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FIdGd74bL66F3bfU6zdNDXC1NOOhvUaNVjCo/GCMp2Djh9TOBrMMrjTZnlXzt9tIG
         5WRxEi5LB3OOyBAXEBidWoZiurHs7MTdnbEiUN495YrbDsIhzrkc5W3GJgQI5bBeFA
         UoEoGfsiAL+cDY50hD5errO2Ey9I30zv3k+xEayU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBNb62050208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:23:37 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:23:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:23:36 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBNFDa088010;
        Mon, 22 Feb 2021 05:23:34 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v2 1/9] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES Wrapper
Date:   Mon, 22 Feb 2021 16:53:06 +0530
Message-ID: <20210222112314.10772-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222112314.10772-1-kishon@ti.com>
References: <20210222112314.10772-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for AM64 SERDES Wrapper.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 10 ++++++---
 include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-ti.h

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index c33e9bc79521..bf431f98e6ea 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -12,9 +12,10 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-wiz-16g
-      - ti,j721e-wiz-10g
+    oneOf:
+      - const: ti,j721e-wiz-16g
+      - const: ti,j721e-wiz-10g
+      - const: ti,am64-wiz-10g
 
   power-domains:
     maxItems: 1
@@ -42,6 +43,9 @@ properties:
   "#reset-cells":
     const: 1
 
+  "#clock-cells":
+    const: 1
+
   ranges: true
 
   assigned-clocks:
diff --git a/include/dt-bindings/phy/phy-ti.h b/include/dt-bindings/phy/phy-ti.h
new file mode 100644
index 000000000000..ad955d3a56b4
--- /dev/null
+++ b/include/dt-bindings/phy/phy-ti.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for TI SERDES.
+ */
+
+#ifndef _DT_BINDINGS_TI_SERDES
+#define _DT_BINDINGS_TI_SERDES
+
+/* Clock index for output clocks from WIZ */
+
+/* MUX Clocks */
+#define TI_WIZ_PLL0_REFCLK	0
+#define TI_WIZ_PLL1_REFCLK	1
+#define TI_WIZ_REFCLK_DIG	2
+
+/* Reserve index here for future additions */
+
+/* MISC Clocks */
+#define TI_WIZ_PHY_EN_REFCLK	16
+
+#endif /* _DT_BINDINGS_TI_SERDES */
-- 
2.17.1

