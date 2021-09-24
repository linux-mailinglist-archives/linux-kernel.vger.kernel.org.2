Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF95417402
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbhIXNBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:01:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22033 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbhIXM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632488231; x=1664024231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Zao4UOBlLNeVZqF3H1dCA4pt43+XyydP+64fP11XpgY=;
  b=YFkEPpWisvnJk3EZDm8jNXEKZ6qCo2nRcRdEbQ7wLz8nicTQb2zKTBAB
   wMohsWkSgd/6zKW/emmKo9VSS7bY7hsfvHDgND+JMWBs12BvvnxzTBcOT
   LxxI4TrHizJkNPxrcT2JRPW2qUj+ENn83qCYzbw9wp6P7+MdZnr5XJ1wI
   +iKNAR5KzV/YWWphlHIZgxFlO60xxM/4gZs14zRolIq9NKVGD9qA/W9Hr
   SSpKrX9A+dEZKzJvcMhuZX+I+5MtMtDN7Wcciv8FvTJv3d3XxTV+4AuXA
   3ltA2txZstSItHFf90ISQJ6PsIOJYMqGoytVPzgl/Etv8YlJBBfB5vKx5
   A==;
IronPort-SDR: vt4tPlJ6eOnk1/lJJ36yqz0wQcvW2rJFmxl6FIfKnoLLAi6J8BQvSA40BfnQIgLatLrhgRtB8k
 ENthExuhLyezdMDG83aHBDtLXspIvpwBVUu8vtLOsXkmAbhMeou5wjD23l9T+J6acHM0FjfgGg
 8e1QhI8Yw6wbpAIsRKJWzsCME+OUJqV/VuFLFsHXlYCPZgMYlfEJO8IzTG3xumfIZWMscnhDYy
 P+wgipjKAsffmxbMSCf3OKNafhrcSwh8lVmGlmmz1hZ51Hz3BqCCfXfrrVF66QHlu2YiBmZzli
 xZygWvz07caermdk5w1HnJEF
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="70525011"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 05:57:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 05:57:08 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 05:57:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v6 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Fri, 24 Sep 2021 18:26:52 +0530
Message-ID: <20210924125653.2955-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210924125653.2955-1-kavyasree.kotagiri@microchip.com>
References: <20210924125653.2955-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v5 -> v6:
- Removed "_clk" in clock-names.
- Added Reviewed-by.

v4 -> v5:
- In v4 dt-bindings, missed adding "clock-names" in required
  properties and example. So, added them.

v3 -> v4:
- Updated "clocks" description.
- Added "clock-names".

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated example provided for clk controller DT node.

 .../bindings/clock/microchip,lan966x-gck.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..fca83bd68e26
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,57 @@
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
+    items:
+      - description: CPU clock source
+      - description: DDR clock source
+      - description: System clock source
+
+  clock-names:
+    items:
+      - const: cpu
+      - const: ddr
+      - const: sys
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+        clock-names = "cpu", "ddr", "sys";
+        reg = <0xe00c00a8 0x38>;
+    };
+...
-- 
2.17.1

