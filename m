Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8CF404678
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbhIIHlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:1546 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352768AbhIIHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631173224; x=1662709224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mldQ2ZtpurxzxxUnfSFvo7AgruO4s1DAL8f7MWFvmx8=;
  b=vgQwP2n83cAmC0FVuwWU+GhvQ/GXbH9y7zoRS2E407f1kX3E+0UngZWO
   kLQfwTr87T9XPu6WVrSJYgUFqsLvgnLZ9V+frhM1eyklwrN8jRo1bX0lB
   Bn1xBYPIiBfqxnH5ex8bFa5DZKXa5e1TilEYvGrAjDmInUEP5DdyCYfdb
   STqHtV3a7cK+9sIiGhS6s1gLTea7CdlKughDbRbKKDaROJCg2FGJavaA1
   r/fXx9QOc7M84PmRhh2fGkM96wPvKGHAm0uPfLQAXfjXh15CgXKHMg3MN
   sBl1XtxRUvqBWhDFq+feJkww7JZA01u9FAmn7u+IxcvOPtg1O1oG5ccc6
   g==;
IronPort-SDR: vDiTPCFEeexK/ieHcYgdk+B3VbPDhFXlIMS+3a1vE9aoRpDdqaKnFBa2ORzG+f1jSeK1MAkgWP
 BKe/5xXDiLa3s49OqOZydBoiFtQyeJPzCBH8PDpIG4N9dn1w4i2L9HZhS+pnbdWWY19lut1M2m
 PnzL2Mfbrs69f7LelmZgd2umnc3yI1tARuNMgQ/zqv0qritTcumDY3cKeZ8QdaYrFw8Y+D615B
 qnOk2IrG7Kjrv6EpEyAkKPEVkJbYxBFd68f/wfAeAKLA+blSDuPCP7cpVKKIdMTDf1FhdkbOA3
 LE3M5JYsbNDPY06y3ToWu0yx
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="131213230"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 00:40:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 00:40:22 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 00:40:18 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v3 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Thu, 9 Sep 2021 13:09:47 +0530
Message-ID: <20210909073947.17438-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
References: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated example provided for clk controller DT node.

 .../bindings/clock/microchip,lan966x-gck.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..d353d42c3dc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966X Generic Clock Controller
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description: |
+  The LAN966X Generic clock controller contains 3 PLLs - cpu_clk,
+  ddr_clk and sys_clk. This clock controller generates and supplies
+  clock to various peripherals within the SoC.
+
+properties:
+  compatible:
+    const: microchip,lan966x-gck
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    cpu_clk: cpu_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <600000000>;
+    };
+
+    ddr_clk: ddr_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <300000000>;
+    };
+
+    sys_clk: sys_clk {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <162500000>;
+    };
+
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+        reg = <0xe00c00a8 0x38>;
+    };
+...
-- 
2.17.1

