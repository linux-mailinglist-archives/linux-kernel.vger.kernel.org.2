Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552623FDF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbhIAP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:58:58 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:47441 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbhIAP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:58:38 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3AF7E3F432;
        Wed,  1 Sep 2021 17:57:39 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        robh@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v7 6/6] dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
Date:   Wed,  1 Sep 2021 17:57:35 +0200
Message-Id: <20210901155735.629282-7-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901155735.629282-1-angelogioacchino.delregno@somainline.org>
References: <20210901155735.629282-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the CPR3 driver to the documentation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/soc/qcom/qcom,cpr3.yaml          | 241 ++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
new file mode 100644
index 000000000000..c22af61c12d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -0,0 +1,241 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
+
+description: |
+  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+  or other device. Each OPP of a device corresponds to a "corner" that has
+  a range of valid voltages for a particular frequency. While the device is
+  running at a particular frequency, CPR monitors dynamic factors such as
+  temperature, etc. and suggests or, in the CPR-Hardened case performs,
+  adjustments to the voltage to save power and meet silicon characteristic
+  requirements.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: CPRv3 controller
+        items:
+          - const: qcom,cpr3
+      - description: CPRv4 controller
+        items:
+          - const: qcom,cpr4
+      - description: CPRv4-Hardened controller
+        items:
+          - enum:
+              - qcom,msm8998-cprh
+              - qcom,sdm630-cprh
+          - const: qcom,cprh
+
+  reg:
+    description: Base address and size of the CPR controller(s)
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: "ref"
+
+  clocks:
+    items:
+      - description: CPR reference clock
+
+  vdd-supply:
+    description: Autonomous Phase Control (APC) or other power supply
+
+  '#power-domain-cells':
+    const: 1
+
+  acc-syscon:
+    description: phandle to syscon for writing ACC settings
+
+  nvmem-cells:
+    description: Cells containing the fuse corners and revision data
+    minItems: 10
+    maxItems: 32
+
+  nvmem-cell-names:
+    minItems: 10
+    maxItems: 32
+
+  operating-points-v2: true
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - "#power-domain-cells"
+  - nvmem-cells
+  - nvmem-cell-names
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu@0 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x0>;
+            operating-points-v2 = <&cpu_gold_opp_table>;
+            power-domains = <&apc_cprh 0>;
+            power-domain-names = "cprh";
+        };
+
+        cpu@100 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x0>;
+            operating-points-v2 = <&cpu_silver_opp_table>;
+            power-domains = <&apc_cprh 1>;
+            power-domain-names = "cprh";
+        };
+    };
+
+    cpu_gold_opp_table: opp-table-gold {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-2208000000 {
+            opp-hz = /bits/ 64 <2208000000>;
+            required-opps = <&cprh_opp3>;
+        };
+        opp-1113600000 {
+            opp-hz = /bits/ 64 <1113600000>;
+            required-opps = <&cprh_opp2>;
+        };
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cpu_silver_opp_table: opp-table-silver {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-1843200000 {
+            opp-hz = /bits/ 64 <1843200000>;
+            required-opps = <&cprh_opp3>;
+        };
+        opp-1094400000 {
+            opp-hz = /bits/ 64 <1094400000>;
+            required-opps = <&cprh_opp2>;
+        };
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cprh_opp_table: opp-table-cprh {
+        compatible = "operating-points-v2-qcom-level";
+
+        cprh_opp1: opp1 {
+            opp-level = <1>;
+            qcom,opp-fuse-level = <1>;
+        };
+        cprh_opp2: opp2 {
+            opp-level = <2>;
+            qcom,opp-fuse-level = <2>;
+        };
+        cprh_opp3: opp3 {
+            opp-level = <3>;
+            qcom,opp-fuse-level = <2 3>;
+        };
+    };
+
+    apc_cprh: power-controller@179c8000 {
+        compatible = "qcom,msm8998-cprh", "qcom,cprh";
+        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
+        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+        clock-names = "ref";
+
+        #power-domain-cells = <1>;
+        operating-points-v2 = <&cprh_opp_table>;
+
+        nvmem-cells = <&cpr_efuse_speedbin>,
+                      <&cpr_fuse_revision>,
+                      <&cpr_quot0_pwrcl>,
+                      <&cpr_quot1_pwrcl>,
+                      <&cpr_quot2_pwrcl>,
+                      <&cpr_quot3_pwrcl>,
+                      <&cpr_quot_offset1_pwrcl>,
+                      <&cpr_quot_offset2_pwrcl>,
+                      <&cpr_quot_offset3_pwrcl>,
+                      <&cpr_init_voltage0_pwrcl>,
+                      <&cpr_init_voltage1_pwrcl>,
+                      <&cpr_init_voltage2_pwrcl>,
+                      <&cpr_init_voltage3_pwrcl>,
+                      <&cpr_ro_sel0_pwrcl>,
+                      <&cpr_ro_sel1_pwrcl>,
+                      <&cpr_ro_sel2_pwrcl>,
+                      <&cpr_ro_sel3_pwrcl>,
+                      <&cpr_quot0_perfcl>,
+                      <&cpr_quot1_perfcl>,
+                      <&cpr_quot2_perfcl>,
+                      <&cpr_quot3_perfcl>,
+                      <&cpr_quot_offset1_perfcl>,
+                      <&cpr_quot_offset2_perfcl>,
+                      <&cpr_quot_offset3_perfcl>,
+                      <&cpr_init_voltage0_perfcl>,
+                      <&cpr_init_voltage1_perfcl>,
+                      <&cpr_init_voltage2_perfcl>,
+                      <&cpr_init_voltage3_perfcl>,
+                      <&cpr_ro_sel0_perfcl>,
+                      <&cpr_ro_sel1_perfcl>,
+                      <&cpr_ro_sel2_perfcl>,
+                      <&cpr_ro_sel3_perfcl>;
+
+        nvmem-cell-names = "cpr_speed_bin",
+                           "cpr_fuse_revision",
+                           "cpr0_quotient1",
+                           "cpr0_quotient2",
+                           "cpr0_quotient3",
+                           "cpr0_quotient4",
+                           "cpr0_quotient_offset2",
+                           "cpr0_quotient_offset3",
+                           "cpr0_quotient_offset4",
+                           "cpr0_init_voltage1",
+                           "cpr0_init_voltage2",
+                           "cpr0_init_voltage3",
+                           "cpr0_init_voltage4",
+                           "cpr0_ring_osc1",
+                           "cpr0_ring_osc2",
+                           "cpr0_ring_osc3",
+                           "cpr0_ring_osc4",
+                           "cpr1_quotient1",
+                           "cpr1_quotient2",
+                           "cpr1_quotient3",
+                           "cpr1_quotient4",
+                           "cpr1_quotient_offset2",
+                           "cpr1_quotient_offset3",
+                           "cpr1_quotient_offset4",
+                           "cpr1_init_voltage1",
+                           "cpr1_init_voltage2",
+                           "cpr1_init_voltage3",
+                           "cpr1_init_voltage4",
+                           "cpr1_ring_osc1",
+                           "cpr1_ring_osc2",
+                           "cpr1_ring_osc3",
+                           "cpr1_ring_osc4";
+    };
+...
-- 
2.32.0

