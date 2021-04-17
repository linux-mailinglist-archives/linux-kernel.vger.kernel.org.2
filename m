Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB35362F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhDQLbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhDQLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930EC061574;
        Sat, 17 Apr 2021 04:30:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so35224084edv.5;
        Sat, 17 Apr 2021 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FTCIfq44OBYbKyD7nneDppgFgNG6j53mdedOTUJHnj4=;
        b=ZaHto2f76n2rt2ugudn2HsfFf3mUX4N9BKEyp2ELb2f/d40zdcErfOy8VlcmlQwPpx
         tFd2+se0pX1ImQhHmoBoGeFJJlnpVp7oSb8SiXrKY5AjStewGhQq4/fEeYUCbCmA08KR
         2GKmsox9ntxz0TYDEU3lkmuOVgwiATm4o7HixPRRPW4p38FrlzVG6lWbEsLmE7V85iOi
         KaGvpV0lhGNiZF37cEnHtEgzorL+As3H2C5PcEAQTOxYH4KDNKbiD+Bqy+fUGCf8GIoL
         Alzn6cm137XNWGtsYdAFl+DlyU/UlP99T+Qy3NnJDoTSKOtJF0qVgDme7IiTk0sVeVt0
         YU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FTCIfq44OBYbKyD7nneDppgFgNG6j53mdedOTUJHnj4=;
        b=X3G4hG2i06qGBICHO72FoZXvt+5LkPKkYsqbUVIzCNcD2Vv7q6rNY99/DYKFvocBdA
         k/LE/M1FjVh2Af5aI6bKwtee+VIMe7EQ4XGVUwGQLTq33ZUh5dtM+r9B9LoI0w2s/oPE
         NJZRUmKr5bYwARPO2fDlCskP84HaqVZptatafeHpINSjMEbWlo24HtWwgwx5aatwtoAp
         AYCcdFCyF2d1rRXMNE1qIDKXUPbrDpUMyjOsd22Jo+fHHTEw7A4WG2bQWMRuT7r8KJmb
         32Mf7uHjTDbpsu4Rr+LO2OrpQnvub6kjiG38AmAyrA4eUNj8nfuxWoenyROIcd6pC6lY
         ZMrA==
X-Gm-Message-State: AOAM533aSXX9f5kKbCHVcAlF7lQAUD/ab2t6ywmfqC1Tihb26cn2osLF
        Wgz0pEmzWJaDzqIdeWcn+k/pRjmRUl0zb2Tc
X-Google-Smtp-Source: ABdhPJyC8pJxtu9Jro308u980qg+HB6odGuJEss0sfQy9reMThKtXjbDAI3rmQo5CXKQZJtpmlkbxA==
X-Received: by 2002:a05:6402:3495:: with SMTP id v21mr14979691edc.117.1618659019661;
        Sat, 17 Apr 2021 04:30:19 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:19 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/15] dt-bindings: power: rockchip: Convert to json-schema
Date:   Sat, 17 Apr 2021 13:29:50 +0200
Message-Id: <20210417112952.8516-14-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Convert the soc/rockchip/power_domain.txt binding document to
json-schema and move to the power bindings directory.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Note for rob+dt:
A tag was not added on purpose, because:
  Add "rockchip," prefix to the qos compatible name
  in example.
  Changed maintainers.
  Size reg description is reduced.
  Little style changes '' to ""
  Restyle patternProperties
Please have a look at it again.

For some SoC nodes this patch serie generates notifications
for undocumented "assigned-clocks" and "assigned-clock-parents"
properties till there is consensus of what to do with it.
---
Changed V9:
  Rename definitions to $defs
  Restyle patternProperties
Changed V8:
  Add pd-node ref schema
Changed V7:
  Fix commit message and author format
  Changed SPDX-License-Identifier back to GPL-2.0
  Remove "clocks", "assigned-clocks" and "assigned-clock-parents"
  Fix indent example
Changed V6:
  Changed author
Changed V5:
  Change SPDX-License-Identifier to  GPL-2.0-only OR BSD-2-Clause
  Remove a maintainer
  Changed patternProperties to power-domain
  Add "clocks", "assigned-clocks" and "assigned-clock-parents"
Changed V4:
  Remove new compatible string
  Style changes '' to ""
Changed V3:
  Use Enric's conversion with rk3399 example
Changed V2:
  Convert power_domain.txt to YAML with rk3568 example
---
 .../bindings/power/rockchip,power-controller.yaml  | 246 +++++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt         | 136 ------------
 2 files changed, 246 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
new file mode 100644
index 000000000..f71569de9
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -0,0 +1,246 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Power Domains
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  Rockchip processors include support for multiple power domains
+  which can be powered up/down by software based on different
+  application scenarios to save power.
+
+  Power domains contained within power-controller node are
+  generic power domain providers documented in
+  Documentation/devicetree/bindings/power/power-domain.yaml.
+
+  IP cores belonging to a power domain should contain a
+  "power-domains" property that is a phandle for the
+  power domain node representing the domain.
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
+
+  "#power-domain-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+
+    $ref: "#/$defs/pd-node"
+
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^power-domain@[0-9a-f]+$":
+
+        $ref: "#/$defs/pd-node"
+
+        unevaluatedProperties: false
+
+        properties:
+          "#address-cells":
+            const: 1
+
+          "#size-cells":
+            const: 0
+
+        patternProperties:
+          "^power-domain@[0-9a-f]+$":
+
+            $ref: "#/$defs/pd-node"
+
+            unevaluatedProperties: false
+
+            properties:
+              "#power-domain-cells":
+                const: 0
+
+$defs:
+  pd-node:
+    type: object
+    description: |
+      Represents the power domains within the power controller node.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: |
+          Power domain index. Valid values are defined in
+          "include/dt-bindings/power/px30-power.h"
+          "include/dt-bindings/power/rk3036-power.h"
+          "include/dt-bindings/power/rk3066-power.h"
+          "include/dt-bindings/power/rk3128-power.h"
+          "include/dt-bindings/power/rk3188-power.h"
+          "include/dt-bindings/power/rk3228-power.h"
+          "include/dt-bindings/power/rk3288-power.h"
+          "include/dt-bindings/power/rk3328-power.h"
+          "include/dt-bindings/power/rk3366-power.h"
+          "include/dt-bindings/power/rk3368-power.h"
+          "include/dt-bindings/power/rk3399-power.h"
+
+      clocks:
+        minItems: 1
+        maxItems: 30
+        description: |
+          A number of phandles to clocks that need to be enabled
+          while power domain switches state.
+
+      pm_qos:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: |
+          A number of phandles to qos blocks which need to be saved and restored
+          while power domain switches state.
+
+      "#power-domain-cells":
+        enum: [0, 1]
+        description:
+          Must be 0 for nodes representing a single PM domain and 1 for nodes
+          providing multiple PM domains.
+
+    required:
+      - reg
+      - "#power-domain-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/power/rk3399-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        qos_hdcp: qos@ffa90000 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffa90000 0x0 0x20>;
+        };
+
+        qos_iep: qos@ffa98000 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffa98000 0x0 0x20>;
+        };
+
+        qos_rga_r: qos@ffab0000 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffab0000 0x0 0x20>;
+        };
+
+        qos_rga_w: qos@ffab0080 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffab0080 0x0 0x20>;
+        };
+
+        qos_video_m0: qos@ffab8000 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffab8000 0x0 0x20>;
+        };
+
+        qos_video_m1_r: qos@ffac0000 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffac0000 0x0 0x20>;
+        };
+
+        qos_video_m1_w: qos@ffac0080 {
+            compatible = "rockchip,rk3399-qos", "syscon";
+            reg = <0x0 0xffac0080 0x0 0x20>;
+        };
+
+        power-management@ff310000 {
+            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
+            reg = <0x0 0xff310000 0x0 0x1000>;
+
+            power-controller {
+                compatible = "rockchip,rk3399-power-controller";
+                #power-domain-cells = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* These power domains are grouped by VD_CENTER */
+                power-domain@RK3399_PD_IEP {
+                    reg = <RK3399_PD_IEP>;
+                    clocks = <&cru ACLK_IEP>,
+                             <&cru HCLK_IEP>;
+                    pm_qos = <&qos_iep>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@RK3399_PD_RGA {
+                    reg = <RK3399_PD_RGA>;
+                    clocks = <&cru ACLK_RGA>,
+                             <&cru HCLK_RGA>;
+                    pm_qos = <&qos_rga_r>,
+                             <&qos_rga_w>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@RK3399_PD_VCODEC {
+                    reg = <RK3399_PD_VCODEC>;
+                    clocks = <&cru ACLK_VCODEC>,
+                             <&cru HCLK_VCODEC>;
+                    pm_qos = <&qos_video_m0>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@RK3399_PD_VDU {
+                    reg = <RK3399_PD_VDU>;
+                    clocks = <&cru ACLK_VDU>,
+                             <&cru HCLK_VDU>;
+                    pm_qos = <&qos_video_m1_r>,
+                             <&qos_video_m1_w>;
+                    #power-domain-cells = <0>;
+                };
+                power-domain@RK3399_PD_VIO {
+                    reg = <RK3399_PD_VIO>;
+                    #power-domain-cells = <1>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    power-domain@RK3399_PD_HDCP {
+                        reg = <RK3399_PD_HDCP>;
+                        clocks = <&cru ACLK_HDCP>,
+                                 <&cru HCLK_HDCP>,
+                                 <&cru PCLK_HDCP>;
+                        pm_qos = <&qos_hdcp>;
+                        #power-domain-cells = <0>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
deleted file mode 100644
index 8304eceb6..000000000
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
-- 
2.11.0

