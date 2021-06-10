Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F33A3293
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFJR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:59:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE0C061574;
        Thu, 10 Jun 2021 10:57:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14c:1a9:2978:fdf4:5e57:8aee:5d72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 301EF1F437D3;
        Thu, 10 Jun 2021 18:57:33 +0100 (BST)
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com
Subject: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema
Date:   Thu, 10 Jun 2021 14:56:13 -0300
Message-Id: <20210610175613.167601-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rockchip,rk3399-cru binding to DT schema format.
Tested with
ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

One caveat is that this node expects certain external clocks, mainly 'xin24m'.
From what I read of clock-bindings.txt, it seems the way to make this dependency
explicit would be to add 'clocks' and 'clock-names' properties to both the DT
and the binding. But since I'm not sure changing the DT ABI is desirable, I just
moved that information to the binding description for now.

 .../bindings/clock/rockchip,rk3399-cru.txt    | 68 --------------
 .../bindings/clock/rockchip,rk3399-cru.yaml   | 92 +++++++++++++++++++
 2 files changed, 92 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
deleted file mode 100644
index 3bc56fae90ac..000000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-* Rockchip RK3399 Clock and Reset Unit
-
-The RK3399 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: PMU for CRU should be "rockchip,rk3399-pmucru"
-- compatible: CRU should be "rockchip,rk3399-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files".
-  It is used for GRF muxes, if missing any muxes present in the GRF will not
-  be available.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3399-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "clkin_gmac" - external GMAC clock - optional,
- - "clkin_i2s" - external I2S clock - optional,
- - "pclkin_cif" - external ISP clock - optional,
- - "clk_usbphy0_480m" - output clock of the pll in the usbphy0
- - "clk_usbphy1_480m" - output clock of the pll in the usbphy1
-
-Example: Clock controller node:
-
-	pmucru: pmu-clock-controller@ff750000 {
-		compatible = "rockchip,rk3399-pmucru";
-		reg = <0x0 0xff750000 0x0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-	cru: clock-controller@ff760000 {
-		compatible = "rockchip,rk3399-cru";
-		reg = <0x0 0xff760000 0x0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff1a0000 {
-		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
-		reg = <0x0 0xff180000 0x0 0x100>;
-		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
-		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
new file mode 100644
index 000000000000..72b286a1beba
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3399-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3399 Clock and Reset Unit
+
+maintainers:
+  - Xing Zheng <zhengxing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3399 clock controller generates and supplies clock to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3399-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m" - crystal input - required,
+    - "xin32k" - rtc clock - optional,
+    - "clkin_gmac" - external GMAC clock - optional,
+    - "clkin_i2s" - external I2S clock - optional,
+    - "pclkin_cif" - external ISP clock - optional,
+    - "clk_usbphy0_480m" - output clock of the pll in the usbphy0
+    - "clk_usbphy1_480m" - output clock of the pll in the usbphy1
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3399-pmucru
+      - rockchip,rk3399-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    minItems: 1
+
+  assigned-clocks:
+    minItems: 1
+    maxItems: 64
+
+  assigned-clock-parents:
+    minItems: 1
+    maxItems: 64
+
+  assigned-clock-rates:
+    minItems: 1
+    maxItems: 64
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      phandle to the syscon managing the "general register files". It is used
+      for GRF muxes, if missing any muxes present in the GRF will not be
+      available.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pmucru: pmu-clock-controller@ff750000 {
+      compatible = "rockchip,rk3399-pmucru";
+      reg = <0xff750000 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+  - |
+    cru: clock-controller@ff760000 {
+      compatible = "rockchip,rk3399-cru";
+      reg = <0xff760000 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.32.0

