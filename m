Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1F3459A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:25:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:32880 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCWIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:24:36 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C717BA87C9;
        Tue, 23 Mar 2021 16:24:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139928883160832S1616487860290898_;
        Tue, 23 Mar 2021 16:24:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <97706fb758a20b709f4327042ba8b7ab>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 2/3] dt-bindings: Convert the rockchip power_domain to YAML and extend
Date:   Tue, 23 Mar 2021 16:24:09 +0800
Message-Id: <20210323082410.22818-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210323082410.22818-1-zhangqing@rock-chips.com>
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the rockchip power domain family bindings to YAML schema,
and add binding documentation for the power domains found on Rockchip
RK3568 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
 .../rockchip/rockchip,power-controller.yaml   | 259 ++++++++++++++++++
 2 files changed, 259 insertions(+), 136 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
deleted file mode 100644
index 8304eceb62e4..000000000000
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ /dev/null
@@ -1,136 +0,0 @@
-* Rockchip Power Domains
-
-Rockchip processors include support for multiple power domains which can be
-powered up/down by software based on different application scenes to save power.
-
-Required properties for power domain controller:
-- compatible: Should be one of the following.
-	"rockchip,px30-power-controller" - for PX30 SoCs.
-	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
-	"rockchip,rk3066-power-controller" - for RK3066 SoCs.
-	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
-	"rockchip,rk3188-power-controller" - for RK3188 SoCs.
-	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
-	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
-	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
-	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
-	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
-	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
-- #power-domain-cells: Number of cells in a power-domain specifier.
-	Should be 1 for multiple PM domains.
-- #address-cells: Should be 1.
-- #size-cells: Should be 0.
-
-Required properties for power domain sub nodes:
-- reg: index of the power domain, should use macros in:
-	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
-	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
-	"include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
-	"include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
-	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
-	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
-	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
-	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
-	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
-	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
-- clocks (optional): phandles to clocks which need to be enabled while power domain
-	switches state.
-- pm_qos (optional): phandles to qos blocks which need to be saved and restored
-	while power domain switches state.
-
-Qos Example:
-
-	qos_gpu: qos_gpu@ffaf0000 {
-		compatible ="syscon";
-		reg = <0x0 0xffaf0000 0x0 0x20>;
-	};
-
-Example:
-
-	power: power-controller {
-		compatible = "rockchip,rk3288-power-controller";
-		#power-domain-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pd_gpu {
-			reg = <RK3288_PD_GPU>;
-			clocks = <&cru ACLK_GPU>;
-			pm_qos = <&qos_gpu>;
-		};
-	};
-
-	 power: power-controller {
-                compatible = "rockchip,rk3368-power-controller";
-                #power-domain-cells = <1>;
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                pd_gpu_1 {
-                        reg = <RK3368_PD_GPU_1>;
-                        clocks = <&cru ACLK_GPU_CFG>;
-                };
-        };
-
-Example 2:
-		power: power-controller {
-			compatible = "rockchip,rk3399-power-controller";
-			#power-domain-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			pd_vio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <RK3399_PD_VIO>;
-
-				pd_vo {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <RK3399_PD_VO>;
-
-					pd_vopb {
-						reg = <RK3399_PD_VOPB>;
-					};
-
-					pd_vopl {
-						reg = <RK3399_PD_VOPL>;
-					};
-				};
-			};
-		};
-
-Node of a device using power domains must have a power-domains property,
-containing a phandle to the power device node and an index specifying which
-power domain to use.
-The index should use macros in:
-	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
-	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
-	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
-	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
-	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
-	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
-
-Example of the node using power domain:
-
-	node {
-		/* ... */
-		power-domains = <&power RK3288_PD_GPU>;
-		/* ... */
-	};
-
-	node {
-                /* ... */
-                power-domains = <&power RK3368_PD_GPU_1>;
-                /* ... */
-        };
-
-	node {
-		/* ... */
-		power-domains = <&power RK3399_PD_VOPB>;
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
new file mode 100644
index 000000000000..6a7c3e25f3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
@@ -0,0 +1,259 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/rockchip/rockchip,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Generic PM domains
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  Rockchip processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+properties:
+  $nodename:
+    const: power-controller
+
+  compatible:
+    enum:
+      - rockchip,px30-power-controller
+      - rockchip,rk3036-power-controller
+      - rockchip,rk3066-power-controller
+      - rockchip,rk3128-power-controller
+      - rockchip,rk3188-power-controller
+      - rockchip,rk3228-power-controller
+      - rockchip,rk3288-power-controller
+      - rockchip,rk3328-power-controller
+      - rockchip,rk3366-power-controller
+      - rockchip,rk3368-power-controller
+      - rockchip,rk3399-power-controller
+      - rockchip,rk3568-power-controller
+
+  '#power-domain-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "(pd_npu|pd_gpu|pd_vi|pd_vo|pd_rga|pd_vpu|pd_rkvdec|pd_rkvenc|pd_pipe|pd_edp|pd_emmc|pd_gmac|pd_iep|pd_sdioaudio|pd_usb3|pd_vcodec|pd_vdu|pd_vio|pd_mmc_nand|pd_sdcard|pd_usb|pd_hevc|pd_video|pd_perihp|pd_sd|pd_tcpc0|pd_tcpc1)@[0-9a-f]+$":
+    type: object
+    description: |
+      Represents the power domains within the power controller node as documented
+      in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      reg:
+        maxItems: 1
+        description: |
+          Power domain index. Valid values are defined in:
+            "include/dt-bindings/power/px30-power.h"
+            "include/dt-bindings/power/rk3036-power.h"
+            "include/dt-bindings/power/rk3066-power.h"
+            "include/dt-bindings/power/rk3128-power.h"
+            "include/dt-bindings/power/rk3188-power.h"
+            "include/dt-bindings/power/rk3228-power.h"
+            "include/dt-bindings/power/rk3288-power.h"
+            "include/dt-bindings/power/rk3328-power.h"
+            "include/dt-bindings/power/rk3366-power.h"
+            "include/dt-bindings/power/rk3368-power.h"
+            "include/dt-bindings/power/rk3399-power.h"
+            "include/dt-bindings/power/rk3568-power.h"
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled during domain
+          power-up sequencing.
+
+      clock-names:
+        description: |
+          List of names of clocks, in order to match the power-up sequencing
+          for each power domain we need to group the clocks by name. BASIC
+          clocks need to be enabled before enabling the corresponding power
+          domain.
+
+      pm_qos:
+        description: |
+          QoS is an abriviation saved restored.
+
+    patternProperties:
+      "(pd_vo|pd_tcpc0|pd_tcpc1|pd_hdcp|pd_isp0|pd_isp1|pd_sd)@[0-9a-f]+$":
+        type: object
+        description: |
+          Represents a power domain child within a power domain parent node.
+
+        properties:
+
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+            const: 0
+
+          reg:
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled during domain
+              power-up sequencing.
+
+          clock-names:
+            description: |
+              List of names of clocks, in order to match the power-up sequencing
+              for each power domain we need to group the clocks by name. BASIC
+              clocks need to be enabled before enabling the corresponding power
+              domain.
+
+          pm_qos:
+            description: |
+              QoS is an abriviation saved restored.
+
+        patternProperties:
+          "(pd_vopb|pd_vopl)@[0-9a-f]+$":
+            type: object
+            description: |
+              Represents a power domain child within a power domain parent node.
+
+            properties:
+
+              '#address-cells':
+                const: 1
+
+              '#size-cells':
+                const: 0
+
+              reg:
+                maxItems: 1
+
+              clocks:
+                description: |
+                  A number of phandles to clocks that need to be enabled during domain
+                  power-up sequencing.
+
+              clock-names:
+                description: |
+                  List of names of clocks, in order to match the power-up sequencing
+                  for each power domain we need to group the clocks by name. BASIC
+                  clocks need to be enabled before enabling the corresponding power
+                  domain.
+
+              pm_qos:
+                description: |
+                  QoS is an abriviation saved restored.
+
+            additionalProperties: false
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/power/rk3568-power.h>
+
+    pmu: power-management@fdd90000 {
+        compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
+        reg = <0xfdd90000 0x1000>;
+
+        power: power-controller {
+            compatible = "rockchip,rk3568-power-controller";
+            #power-domain-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* These power domains are grouped by VD_NPU */
+            pd_npu@RK3568_PD_NPU {
+                reg = <RK3568_PD_NPU>;
+                clocks = <&cru ACLK_NPU_PRE>,
+                         <&cru HCLK_NPU_PRE>,
+                         <&cru PCLK_NPU_PRE>;
+                pm_qos = <&qos_npu>;
+            };
+            /* These power domains are grouped by VD_GPU */
+            pd_gpu@RK3568_PD_GPU {
+                reg = <RK3568_PD_GPU>;
+                clocks = <&cru ACLK_GPU_PRE>,
+                         <&cru PCLK_GPU_PRE>;
+                pm_qos = <&qos_gpu>;
+            };
+            /* These power domains are grouped by VD_LOGIC */
+            pd_vi@RK3568_PD_VI {
+                reg = <RK3568_PD_VI>;
+                clocks = <&cru HCLK_VI>,
+                         <&cru PCLK_VI>;
+                pm_qos = <&qos_isp>,
+                         <&qos_vicap0>,
+                         <&qos_vicap1>;
+            };
+            pd_vo@RK3568_PD_VO {
+                reg = <RK3568_PD_VO>;
+                clocks = <&cru HCLK_VO>,
+                         <&cru PCLK_VO>,
+                         <&cru ACLK_VOP_PRE>;
+                pm_qos = <&qos_hdcp>,
+                         <&qos_vop_m0>,
+                         <&qos_vop_m1>;
+            };
+            pd_rga@RK3568_PD_RGA {
+                reg = <RK3568_PD_RGA>;
+                clocks = <&cru HCLK_RGA_PRE>,
+                         <&cru PCLK_RGA_PRE>;
+                pm_qos = <&qos_ebc>,
+                         <&qos_iep>,
+                         <&qos_jpeg_dec>,
+                         <&qos_jpeg_enc>,
+                         <&qos_rga_rd>,
+                         <&qos_rga_wr>;
+            };
+            pd_vpu@RK3568_PD_VPU {
+                reg = <RK3568_PD_VPU>;
+                clocks = <&cru HCLK_VPU_PRE>;
+                pm_qos = <&qos_vpu>;
+            };
+            pd_rkvdec@RK3568_PD_RKVDEC {
+                clocks = <&cru HCLK_RKVDEC_PRE>;
+                reg = <RK3568_PD_RKVDEC>;
+                pm_qos = <&qos_rkvdec>;
+            };
+            pd_rkvenc@RK3568_PD_RKVENC {
+                reg = <RK3568_PD_RKVENC>;
+                clocks = <&cru HCLK_RKVENC_PRE>;
+                pm_qos = <&qos_rkvenc_rd_m0>,
+                <&qos_rkvenc_rd_m1>,
+                <&qos_rkvenc_wr_m0>;
+            };
+            pd_pipe@RK3568_PD_PIPE {
+                reg = <RK3568_PD_PIPE>;
+                clocks = <&cru PCLK_PIPE>;
+                pm_qos = <&qos_pcie2x1>,
+                         <&qos_pcie3x1>,
+                         <&qos_pcie3x2>,
+                         <&qos_sata0>,
+                         <&qos_sata1>,
+                         <&qos_sata2>,
+                         <&qos_usb3_0>,
+                         <&qos_usb3_1>;
+            };
+        };
+    };
-- 
2.17.1



