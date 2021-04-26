Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA136B194
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhDZKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:23:08 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59722 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhDZKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:23:07 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2021 03:22:26 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2021 03:22:24 -0700
X-QCInternal: smtphost
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Apr 2021 15:51:59 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 1EF22218F3; Mon, 26 Apr 2021 15:51:58 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH] dt-bindings: media: venus: Add sc7280 dt schema
Date:   Mon, 26 Apr 2021 15:51:55 +0530
Message-Id: <1619432515-9060-1-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a schema description for the venus video encoder/decoder on the sc7280.

Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
---
 .../bindings/media/qcom,sc7280-venus.yaml          | 158 +++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
new file mode 100644
index 0000000..a258d97
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Venus video encode and decode accelerators
+
+maintainers:
+  - Stanimir Varbanov <stanimir.varbanov@linaro.org>
+
+description: |
+  The Venus IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+properties:
+  compatible:
+    const: qcom,sc7280-venus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    minItems: 2
+    maxItems: 3
+
+  power-domain-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      - const: venus
+      - const: vcodec0
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: core_clk
+      - const: video_cc_mvsc_ctl_axi
+      - const: iface_clk
+      - const: vcodec_clk
+      - const: video_cc_mvs0_ctl_axi
+
+  iommus:
+    maxItems: 2
+
+  memory-region:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+
+  video-decoder:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-decoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  video-encoder:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-encoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  video-firmware:
+    type: object
+
+    description: |
+      Firmware subnode is needed when the platform does not
+      have TrustZone.
+
+    properties:
+      iommus:
+        maxItems: 1
+
+    required:
+      - iommus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - power-domain-names
+  - clocks
+  - clock-names
+  - iommus
+  - memory-region
+  - video-decoder
+  - video-encoder
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/clock/qcom,videocc-sc7280.h>
+
+        venus: video-codec@aa00000 {
+                compatible = "qcom,sc7280-venus";
+                reg = <0x0aa00000 0xd0600>;
+                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+                clocks = <&videocc VIDEO_CC_MVSC_CORE_CLK>,
+                         <&videocc VIDEO_CC_MVSC_CTL_AXI_CLK>,
+                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                         <&videocc VIDEO_CC_MVS0_CORE_CLK>,
+                         <&videocc VIDEO_CC_MVS0_AXI_CLK>;
+                clock-names = "core_clk", "video_cc_mvsc_ctl_axi",
+                              "iface_clk", "vcodec_clk",
+                              "video_cc_mvs0_ctl_axi";
+
+                power-domains = <&videocc MVSC_GDSC>,
+                                <&videocc MVS0_GDSC>;
+                power-domain-names = "venus", "vcodec0";
+
+                interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_VENUS_CFG 0>
+                                <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
+                interconnect-names = "cpu-cfg", "video-mem";
+
+                iommus = <&apps_smmu 0x2180 0x20>,
+                         <&apps_smmu 0x2184 0x20>;
+
+                memory-region = <&video_mem>;
+
+                video-decoder {
+                        compatible = "venus-decoder";
+                };
+
+                video-encoder {
+                        compatible = "venus-encoder";
+                };
+
+                video-firmware {
+                        iommus = <&apps_smmu 0x21a2 0x0>;
+                };
+        };
-- 
2.7.4

