Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9E438323
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJWKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 06:16:48 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53984 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231327AbhJWKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:16:37 -0400
X-UUID: fd55ac1fe7424618950b1605d4b687e3-20211023
X-UUID: fd55ac1fe7424618950b1605d4b687e3-20211023
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 583282819; Sat, 23 Oct 2021 18:14:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 23 Oct 2021 18:14:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Oct 2021 18:14:15 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        "Chun-Jie Chen" <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 4/7] dt-bindings: soc: mediatek: apusys: Add new document for APU power domain
Date:   Sat, 23 Oct 2021 18:13:31 +0800
Message-ID: <20211023101334.27686-5-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211023101334.27686-1-flora.fu@mediatek.com>
References: <20211023101334.27686-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for APU power domain on MediaTek SoC.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../soc/mediatek/mediatek,apu-pm.yaml         | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
new file mode 100644
index 000000000000..5530a8be88ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# # Copyright 2021 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,apu-pm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek APU Power Domains
+
+maintainers:
+  - Flora Fu <flora.fu@mediatek.com>
+
+description: |
+  Mediatek AI Process Unit (APU) include support for power domains which can be
+  powered up/down by software.
+  APU subsys belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for apuspm node representing the domain.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-apu-pm
+      - const: syscon
+
+  reg:
+    description: Address range of the APU power domain controller.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#power-domain-cells':
+    const: 1
+
+  vsram-supply:
+    description: apu sram regulator supply.
+
+  mediatek,scpsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys register range.
+
+  mediatek,apu-conn:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys apu conn register range.
+
+  mediatek,apu-conn1:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys apu conn1 register range.
+
+  mediatek,apu-vcore:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys apu vcore register range.
+
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: |
+      Represents the power domains within the power controller node as
+      documented in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+      reg:
+        description: Power domain index.
+        maxItems: 1
+
+      '#power-domain-cells':
+        description: |
+          Must be 0 for nodes representing a single PM domain and 1 for nodes
+          providing multiple PM.
+
+      clocks:
+        description: |
+          List of phandles of clocks list. Specify by order according to
+          power-up sequence.
+
+      clock-names:
+        description: |
+          List of names of clocks. Specify by order according to power-up
+          sequence.
+
+      assigned-clocks:
+        maxItems: 2
+
+      assigned-clock-parents:
+        maxItems: 2
+
+      domain-supply:
+        description: domain regulator supply.
+
+    required:
+      - reg
+      - '#power-domain-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#power-domain-cells'
+  - vsram-supply
+  - mediatek,scpsys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8192-clk.h>
+    apuspm: power-domain@190f0000 {
+        compatible = "mediatek,mt8192-apu-pm", "syscon";
+        reg = <0x190f0000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #power-domain-cells = <1>;
+        vsram-supply = <&mt6359_vsram_md_ldo_reg>;
+        mediatek,scpsys = <&scpsys>;
+        mediatek,apu-conn = <&apu_conn>;
+        mediatek,apu-vcore = <&apu_vcore>;
+
+        apu_top: power-domain@0 {
+            reg = <0>;
+            #power-domain-cells = <0>;
+            clocks = <&topckgen CLK_TOP_DSP_SEL>,
+                     <&topckgen CLK_TOP_IPU_IF_SEL>,
+                     <&clk26m>,
+                     <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
+            clock-names = "clk_top_conn",
+                          "clk_top_ipu_if",
+                          "clk_off",
+                          "clk_on_default";
+            assigned-clocks = <&topckgen CLK_TOP_DSP_SEL>,
+                              <&topckgen CLK_TOP_IPU_IF_SEL>;
+            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
+                                     <&topckgen CLK_TOP_UNIVPLL_D6_D2>;
+            domain-supply = <&mt6359_vproc1_buck_reg>;
+        };
+    };
-- 
2.18.0

