Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044303B35F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhFXSoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:44:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37778 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:43:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfV7G074555;
        Thu, 24 Jun 2021 13:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560091;
        bh=lE8uqMNlgLnwsszNwjvpZ+AZedBtAVUQi0xPbsblvEk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AcMq85NPaa/ckP57K8gcZAclBvAyP1qQMPxOfb7K3N7/Zc5QXKFVOm7PzOsD+f3cn
         qf+dbN1lYfM7vt1pFYYdRQgz8hABgU3LOR61pd5gEytdS9G/SlrPyYo1W9yMMN+HWN
         MtjYO4E4EjIOiIrLjnLAuR+/BAcy1zTclAXuEE9U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfVDY107523
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:31 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9I2041395;
        Thu, 24 Jun 2021 13:41:28 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 5/7] phy: dt-bindings: Convert Cadence DPHY binding to YAML
Date:   Fri, 25 Jun 2021 00:11:06 +0530
Message-ID: <20210624184108.21312-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210624184108.21312-1-p.yadav@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Cadence DPHY binding to YAML.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
- Add Rob's R-by.

Changes in v2:
- Drop reg description.
- Add a description for each DPHY clock.
- Rename dphy@... to phy@... in example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 .../devicetree/bindings/phy/cdns,dphy.txt     | 20 --------
 .../devicetree/bindings/phy/cdns,dphy.yaml    | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
deleted file mode 100644
index 1095bc4e72d9..000000000000
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Cadence DPHY
-============
-
-Cadence DPHY block.
-
-Required properties:
-- compatible: should be set to "cdns,dphy".
-- reg: physical base address and length of the DPHY registers.
-- clocks: DPHY reference clocks.
-- clock-names: must contain "psm" and "pll_ref".
-- #phy-cells: must be set to 0.
-
-Example:
-	dphy0: dphy@fd0e0000{
-		compatible = "cdns,dphy";
-		reg = <0x0 0xfd0e0000 0x0 0x1000>;
-		clocks = <&psm_clk>, <&pll_ref_clk>;
-		clock-names = "psm", "pll_ref";
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
new file mode 100644
index 000000000000..b90a58773bf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/cdns,dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence DPHY Device Tree Bindings
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: cdns,dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PMA state machine clock
+      - description: PLL reference clock
+
+  clock-names:
+    items:
+      - const: psm
+      - const: pll_ref
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+
+    dphy0: phy@fd0e0000{
+        compatible = "cdns,dphy";
+        reg = <0xfd0e0000 0x1000>;
+        clocks = <&psm_clk>, <&pll_ref_clk>;
+        clock-names = "psm", "pll_ref";
+        #phy-cells = <0>;
+    };
-- 
2.30.0

