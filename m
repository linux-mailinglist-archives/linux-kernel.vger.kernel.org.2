Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAC3F87B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhHZMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:39:49 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:52018 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbhHZMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:39:47 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06472B2CBA;
        Thu, 26 Aug 2021 20:38:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32763T139761010153216S1629981525980003_;
        Thu, 26 Aug 2021 20:38:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <873f58238d50a8cc07e4d0550ef12971>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 12
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v1 1/3] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Thu, 26 Aug 2021 20:38:42 +0800
Message-Id: <20210826123844.8464-2-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210826123844.8464-1-yifeng.zhao@rock-chips.com>
References: <20210826123844.8464-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

 .../phy/phy-rockchip-naneng-combphy.yaml      | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
new file mode 100644
index 000000000000..69908614609c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-naneng-combphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: reference clock
+      - description: apb clock
+      - description: pipe clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ref
+      - const: apb
+      - const: pipe
+
+  '#phy-cells':
+    const: 1
+
+  resets:
+    minItems: 1
+    items:
+      - description: exclusive apb reset line
+      - description: exclusive PHY reset line
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: combphy-apb
+      - const: combphy
+
+  rockchip,pipe-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional phy settings are access through GRF regs.
+
+  rockchip,pipe-phy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional pipe settings are access through GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#phy-cells'
+  - resets
+  - reset-names
+  - rockchip,pipe-grf
+  - rockchip,pipe-phy-grf
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/clock/rk3568-cru.h>
+
+    pipegrf: syscon@fdc50000 {
+      compatible = "rockchip,rk3568-pipegrf", "syscon";
+      reg = <0xfdc50000 0x1000>;
+    };
+
+    pipe_phy_grf0: syscon@fdc70000 {
+      compatible = "rockchip,pipe-phy-grf", "syscon";
+      reg = <0xfdc70000 0x1000>;
+    };
+
+    combphy0_us: phy@fe820000 {
+      compatible = "rockchip,rk3568-naneng-combphy";
+      reg = <0xfe820000 0x100>;
+      #phy-cells = <1>;
+      clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
+        <&cru PCLK_PIPE>;
+      clock-names = "ref", "apb", "pipe";
+      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
+      assigned-clock-rates = <100000000>;
+      resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
+      reset-names = "combphy-apb", "combphy";
+      rockchip,pipe-grf = <&pipegrf>;
+      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
+    };
-- 
2.17.1



