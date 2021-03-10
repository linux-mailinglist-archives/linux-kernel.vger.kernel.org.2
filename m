Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3887333B62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhCJL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:28:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhCJL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:28:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRuiM017775;
        Wed, 10 Mar 2021 05:27:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615375676;
        bh=txzXDqzah1cXMGc2Vrj1LgAlg8bE2NElSfqfoXqQoAc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RkuSJsA5JOjvz7Miv035Tt4Vf1IXG3FghStn5qsldS6NPvvCWNAJO2gOBEn7jF33n
         kLjNDR0Lo1Z0T0E3ImZd4WJyqtw3xHJ0o3U/hnYuX5ZbZG24Yk/hEB0x0NYhNzmXZw
         s6F1Ot5ugoUhB9eJmwkavpm4KRwYHSuZ3msqVlpw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12ABRuUJ049371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 05:27:56 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 05:27:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 05:27:55 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12ABRkvX075949;
        Wed, 10 Mar 2021 05:27:52 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/3] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES Wrapper
Date:   Wed, 10 Mar 2021 16:57:43 +0530
Message-ID: <20210310112745.3445-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310112745.3445-1-kishon@ti.com>
References: <20210310112745.3445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for AM64 SERDES Wrapper.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  4 ++++
 include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-ti.h

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index bbbd85501ada..57e1d013a502 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - ti,j721e-wiz-16g
       - ti,j721e-wiz-10g
+      - ti,am64-wiz-10g
 
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

