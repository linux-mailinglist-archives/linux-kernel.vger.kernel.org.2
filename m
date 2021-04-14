Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C935FD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhDNVUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhDNVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388FC061574;
        Wed, 14 Apr 2021 14:19:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g17so24701186edm.6;
        Wed, 14 Apr 2021 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rg8Ro3c5ZQIGHLHh0GcQuOt3LeQAmrUUsoddQwTdRog=;
        b=PlP2Ws36JLSgxyXUywumJgOGFXHA6+MgzPaZ3gSw9IzcsDsQqYm6a6bT/MBbIffqeP
         MEeQufpeDx8lI/6XYh5sHlc4ukElHSCsfxRBrA+WcWyI1QyJBpcbxtryYVCqJY37IuNp
         OZORlkHJfz5O8BBjJ9X8gLyHh8ohrt3o1huyO8DzuadvYfKqjVVSqXfanHCssTH9Bnew
         evSo4Ffd8c3PpwR+eX8/11CS/8nrwYCiDqZDQnuuDEhKni4uNExiFyC0rqov7HOpAhe/
         bl5SgbI77afwwAkIGodOJ8Gqa1hHlIQbJruoQXniybVR+UHE5GJftN8V7mvv20G0IefD
         M2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rg8Ro3c5ZQIGHLHh0GcQuOt3LeQAmrUUsoddQwTdRog=;
        b=I8Ii+tdSiJLNlzQcKAJ1V2O7iAuQouMLVgAsL4DSce74r3xRQO9XjqqHJ49rbJ5zrw
         UyZFGIdGqvCIYC1OnsrBsND/t3l29JDNj9khdlWZCgmIzyzOCAyca8lecgtJJ3R2eA9P
         jjVyOmr9f2fdynBgtgqhuO3cGo1fSdNYSFxs/QQrOzBR67pPqWxZX0S+F6R6GfInMEgy
         0i/9Pj5GWx4rYLTOBny8RpBrZRobnC+BVPLG/zGmOevzF5Lq1VXisJiRzoZl3Rpub+om
         veuNGOkb8uyWHlh3WKht8uwsfZ/nXUbUxOdgKYPuFY7j0p75o8gOcL7Kq+IphBgV/x6P
         ksUg==
X-Gm-Message-State: AOAM532ly2SWt59JyEhpnns5CxluYwQP0Y1AS4LaIaYUcjLFakbuna/K
        nEnVoaK/UHLcpjl2HpFr2pc=
X-Google-Smtp-Source: ABdhPJwsK4DCvZNE9wyxPeesPN5PbnADgg7NF2CtYyW8zIF+Oo035eZEB340kZrGNCalm4r0ygnS2A==
X-Received: by 2002:a05:6402:5205:: with SMTP id s5mr231762edd.65.1618435155393;
        Wed, 14 Apr 2021 14:19:15 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:15 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/11] dt-bindings: power: rockchip: Convert to json-schema
Date:   Wed, 14 Apr 2021 23:18:54 +0200
Message-Id: <20210414211856.12104-10-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
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
Please have a look at it again.

For some SoC nodes this patch serie generates notifications
for undocumented "assigned-clocks" and "assigned-clock-parents"
properties till there is consensus of what to do with it.
---
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
 .../bindings/power/rockchip,power-controller.yaml  | 283 +++++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt         | 136 ----------
 2 files changed, 283 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
new file mode 100644
index 000000000..934308006
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -0,0 +1,283 @@
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
+  Rockchip processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenarios to save power.
+
+  Power domains contained within power-controller node are generic power domain
+  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+  IP cores belonging to a power domain should contain a "power-domains"
+  property that is a phandle for the power domain node representing the domain.
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
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: |
+      Represents the power domains within the power controller node as documented
+      in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+
+      "#power-domain-cells":
+        description:
+          Must be 0 for nodes representing a single PM domain and 1 for nodes
+          providing multiple PM domains.
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
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
+        description: |
+          A number of phandles to clocks that need to be enabled while power domain
+          switches state.
+
+      pm_qos:
+        description: |
+          A number of phandles to qos blocks which need to be saved and restored
+          while power domain switches state.
+
+    patternProperties:
+      "^power-domain@[0-9a-f]+$":
+        type: object
+        description: |
+          Represents a power domain child within a power domain parent node.
+
+        properties:
+
+          "#power-domain-cells":
+            description:
+              Must be 0 for nodes representing a single PM domain and 1 for nodes
+              providing multiple PM domains.
+
+          "#address-cells":
+            const: 1
+
+          "#size-cells":
+            const: 0
+
+          reg:
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled while power domain
+              switches state.
+
+          pm_qos:
+            description: |
+              A number of phandles to qos blocks which need to be saved and restored
+              while power domain switches state.
+
+        patternProperties:
+          "^power-domain@[0-9a-f]+$":
+            type: object
+            description: |
+              Represents a power domain child within a power domain parent node.
+
+            properties:
+
+              "#power-domain-cells":
+                description:
+                  Must be 0 for nodes representing a single PM domain and 1 for nodes
+                  providing multiple PM domains.
+
+              "#address-cells":
+                const: 1
+
+              "#size-cells":
+                const: 0
+
+              reg:
+                maxItems: 1
+
+              clocks:
+                description: |
+                  A number of phandles to clocks that need to be enabled while power domain
+                  switches state.
+
+              pm_qos:
+                description: |
+                  A number of phandles to qos blocks which need to be saved and restored
+                  while power domain switches state.
+
+            required:
+              - reg
+
+            additionalProperties: false
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - "#power-domain-cells"
+
+additionalProperties: false
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

