Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7CB317299
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhBJVnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:43:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47736 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhBJVnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:43:07 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l9xFZ-0006dd-HH; Wed, 10 Feb 2021 22:42:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     cmuellner@linux.com, robh+dt@kernel.org, heiko@sntech.de,
        ezequiel@collabora.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/2] dt-bindings: phy: add yaml binding for rockchip-inno-csi-dphy
Date:   Wed, 10 Feb 2021 22:42:04 +0100
Message-Id: <20210210214205.2496336-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210214205.2496336-1-heiko@sntech.de>
References: <20210210214205.2496336-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Some Rockchip SoCs like the rk3368, rk3326, px30 use a CSI dphy
based on an Innosilicon IP. Add a binding for them.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 .../bindings/phy/rockchip-inno-csi-dphy.yaml  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
new file mode 100644
index 000000000000..b7c5a4027684
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip-inno-csi-dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC MIPI RX0 D-PHY Device Tree Bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The Rockchip SoC has a MIPI CSI D-PHY based on an Innosilicon IP wich
+  connects to the ISP1 (Image Signal Processing unit v1.0) for CSI cameras.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-csi-dphy
+      - rockchip,rk1808-csi-dphy
+      - rockchip,rk3326-csi-dphy
+      - rockchip,rk3368-csi-dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+  '#phy-cells':
+    const: 0
+
+  power-domains:
+    description: Video in/out power domain.
+    maxItems: 1
+
+  resets:
+    items:
+      - description: exclusive PHY reset line
+
+  reset-names:
+    items:
+      - const: apb
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional phy settings are access through GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#phy-cells'
+  - power-domains
+  - resets
+  - reset-names
+  - rockchip,grf
+
+additionalProperties: false
+
+examples:
+  - |
+
+    csi_dphy: phy@ff2f0000 {
+        compatible = "rockchip,px30-csi-dphy";
+        reg = <0xff2f0000 0x4000>;
+        clocks = <&cru 1>;
+        clock-names = "pclk";
+        #phy-cells = <0>;
+        power-domains = <&power 1>;
+        resets = <&cru 1>;
+        reset-names = "apb";
+        rockchip,grf = <&grf>;
+    };
-- 
2.29.2

