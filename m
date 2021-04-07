Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224C3561EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348364AbhDGD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:29:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38924 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348348AbhDGD3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:29:07 -0400
X-UUID: fcb5b8f795774ee1aa04bb55a5d48dbd-20210407
X-UUID: fcb5b8f795774ee1aa04bb55a5d48dbd-20210407
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1024316135; Wed, 07 Apr 2021 11:28:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 11:28:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 11:28:53 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Flora Fu <flora.fu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 5/8] dt-bindings: soc: mediatek: apusys: Add new document for APU power domain
Date:   Wed, 7 Apr 2021 11:28:03 +0800
Message-ID: <1617766086-5502-6-git-send-email-flora.fu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 42B2CA7540249A853B4F08125BFC10E92DB4B6618A5B217123DDF2CF1714566A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for APU power domain on MediaTek SoC.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../soc/mediatek/mediatek,apu-pm.yaml         | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
new file mode 100644
index 000000000000..c99e812977f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
@@ -0,0 +1,146 @@
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
+  mediatek,apu_conn:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys apu conn register range.
+
+  mediatek,apu_conn1:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to the device containing the scpsys apu conn1 register range.
+
+  mediatek,apu_vcore:
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
+    #include <dt-bindings/power/mt8192-apu-power.h>
+    apuspm: power-domain@190f0000 {
+        compatible = "mediatek,mt8192-apu-pm", "syscon";
+        reg = <0x190f0000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #power-domain-cells = <1>;
+        vsram-supply = <&mt6359_vsram_md_ldo_reg>;
+        mediatek,scpsys = <&scpsys>;
+        mediatek,apu_conn = <&apu_conn>;
+        mediatek,apu_vcore = <&apu_vcore>;
+
+        power-domain@MT8192_POWER_DOMAIN_APUSYS_TOP {
+            reg = <MT8192_POWER_DOMAIN_APUSYS_TOP>;
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

