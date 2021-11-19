Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EF4568C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhKSDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:49:31 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39328 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234255AbhKSDtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:49:22 -0500
X-UUID: 593a1fda4afe415ba546b219eab366b4-20211119
X-UUID: 593a1fda4afe415ba546b219eab366b4-20211119
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1485318739; Fri, 19 Nov 2021 11:46:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Nov 2021 11:46:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Nov 2021 11:46:15 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v16 2/4] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Fri, 19 Nov 2021 11:46:11 +0800
Message-ID: <20211119034613.32489-3-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211119034613.32489-1-james.lo@mediatek.com>
References: <20211119034613.32489-1-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the SPMI controller found on Mediatek SoCs.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml

diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
new file mode 100644
index 000000000000..2445c5e0b0ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/mtk,spmi-mtk-pmif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek SPMI Controller Device Tree Bindings
+
+maintainers:
+  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
+
+description: |+
+  On MediaTek SoCs the PMIC is connected via SPMI and the controller allows
+  for multiple SoCs to control a single SPMI master.
+
+allOf:
+  - $ref: "spmi.yaml"
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6873-spmi
+      - mediatek,mt8195-spmi
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: pmif
+      - const: spmimst
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pmif_sys_ck
+      - const: pmif_tmr_ck
+      - const: spmimst_clk_mux
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8192-clk.h>
+
+    spmi: spmi@10027000 {
+        compatible = "mediatek,mt6873-spmi";
+        reg = <0x10027000 0xe00>,
+              <0x10029000 0x100>;
+        reg-names = "pmif", "spmimst";
+        clocks = <&infracfg CLK_INFRA_PMIC_AP>,
+                 <&infracfg CLK_INFRA_PMIC_TMR>,
+                 <&topckgen CLK_TOP_SPMI_MST_SEL>;
+        clock-names = "pmif_sys_ck",
+                      "pmif_tmr_ck",
+                      "spmimst_clk_mux";
+        assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
+        assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
+    };
+...
-- 
2.18.0

