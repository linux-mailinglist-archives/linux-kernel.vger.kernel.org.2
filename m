Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A79325EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:25:25 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:50492 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBZIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:25:07 -0500
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id D8F71D0163;
        Fri, 26 Feb 2021 16:22:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5973T140596920432384S1614327760837004_;
        Fri, 26 Feb 2021 16:22:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ecab0b2770332ce99c8666412609fbf3>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: mturquette@baylibre.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 1/4] dt-binding: clock: Document rockchip,rk3568-cru bindings
Date:   Fri, 26 Feb 2021 16:22:31 +0800
Message-Id: <20210226082234.1733-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210226082234.1733-1-zhangqing@rock-chips.com>
References: <20210226082234.1733-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device tree bindings of the rockchip Rk3568 SoC
clock driver in Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,rk3568-cru.yaml   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
new file mode 100644
index 000000000000..612da341ea67
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3568-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROCKCHIP rk3568 Family Clock Control Module Binding
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+
+description: |
+  The RK3568 clock controller generates and supplies clock to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-cru
+      - rockchip,rk3568-pmucru
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
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
+  # Clock Control Module node:
+  - |
+    pmucru: clock-controller@fdd00000 {
+      compatible = "rockchip,rk3568-pmucru";
+      reg = <0x0 0xfdd00000 0x0 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
+  - |
+    cru: clock-controller@fdd20000 {
+      compatible = "rockchip,rk3568-cru";
+      reg = <0x0 0xfdd20000 0x0 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.17.1



