Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10218360202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhDOFxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:53:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230389AbhDOFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:53:20 -0400
X-UUID: 3d412a9cbf6a40e68afa68c0c432fe99-20210415
X-UUID: 3d412a9cbf6a40e68afa68c0c432fe99-20210415
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 31349367; Thu, 15 Apr 2021 13:52:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 13:52:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 13:52:51 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v2 4/7] dt-bindings: soc: mediatek: apusys: Add new document for APU power domain
Date:   Thu, 15 Apr 2021 13:52:37 +0800
Message-ID: <1618465960-3013-5-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
References: <1618465960-3013-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for APU power domain on MediaTek SoC.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
Note:
This patch depends on MT8192 clock[1] patches which haven't yet been accepted.
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210324104110.13383-7-chun-jie.chen@mediatek.com/
---
 .../soc/mediatek/mediatek,apu-pm.yaml         | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
new file mode 100644
index 000000000000..6ff966920917
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+        description: |
+          Power domain index. Valid values are defined in:
+          "include/dt-bindings/power/mt8182-apu-power.h"
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

