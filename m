Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9440F763
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbhIQMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:23:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26758 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbhIQMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631881347; x=1663417347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QaeyoBiXXMSjWzTQIcjpjaH9meMo8WgiifrLMl2FpHY=;
  b=KNTCcoflPn2hHyfxhsQ5xRr+oLzO+Ku17ghA6Jf13pmKg5bXSTeB9SG9
   HcjHtry/fJomMIW5XlCfgqdwNAXFTto42AT5dgnqQEWbFaA3snQu1GJqO
   D2HRneLCmZTt+yP71NZEd8IobvucFuxYGMTebzoFvUAM5HDxhY2Z4E7CM
   R4hLARfOr2/O00gAcrsk7cdQXFmWokLMuMNxP8UkLUGjG8hfBvXVExzHa
   GZGvggfubB1bGajh3yDE7lfELahE/4bKibNeOck6CIvn3agp0sj2f4zDW
   iflkTScZAoItjNaTAlyjvpbKIy6vOhEsZtYIcw+xP9NalVUe5NI03/b1P
   w==;
IronPort-SDR: Q45hX1ez+G8hjmLfKB2fBWCfOzJlZlRcXF5AB8UaPYJ4T99S1X8ZsIDkZ3+wepK0sKje1c/ruJ
 egU/hcKnGgSiLCQCQw22KZkTR75SrYRNCQiI0Dya7KCJJJxpN5JtVFVdfIi5PrYRqyx/GAaGz3
 jevHS0f2vnv+1KV/q/vWSXZjK6pTc7D1/4iRjbBtPr6yfl+pKTg3jQyrInzAU27k3PI/w84La4
 rdmlZd1kasDAf1usMm4IV4s20xa0Bu9EPVbh4JyC0nbgYo9fHJswEF2eXlfQ9BclyUnY5NFWkN
 vP8RL+LODPmiI/EPQc9pmhak
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="69666030"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:22:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:22:26 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:22:22 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Fri, 17 Sep 2021 17:51:56 +0530
Message-ID: <20210917122157.557-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917122157.557-1-kavyasree.kotagiri@microchip.com>
References: <20210917122157.557-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v3 -> v4:
- Updated "clocks" description.
- Added "clock-names".

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated example provided for clk controller DT node.

 .../bindings/clock/microchip,lan966x-gck.yaml | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
new file mode 100644
index 000000000000..214a2bea35cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
@@ -0,0 +1,55 @@
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
+      - const: cpu_clk
+      - const: ddr_clk
+      - const: sys_clk
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
+    clks: clock-controller@e00c00a8 {
+        compatible = "microchip,lan966x-gck";
+        #clock-cells = <1>;
+        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+        reg = <0xe00c00a8 0x38>;
+    };
+...
-- 
2.17.1

