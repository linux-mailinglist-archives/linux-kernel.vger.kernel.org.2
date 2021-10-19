Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC0432FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhJSHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:44:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3871 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJSHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634629319; x=1666165319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LBctFYEmop52j/yB8GPJ770XATJyF7x4GMjbnvi9M2A=;
  b=W5RaHqI//gt0q8WEEVdZKwaMANMnnChRbG10IomO3LAkm5zA9VN5+3kh
   +I6wuLhfi/6eEZLfKRkqsNYrolpYByRnoons7Iuj1prjoiAigQ0CrN9CJ
   nd057uz7p4eZP3GytmfnlfeLHavWKjUkigiszPg+pAfRMq0OEuzrptFQA
   N1ErW5or5OkzrCXVM80B8i5t4+yRMp5K3wRVtzoqYOwfs9fPHGAhpwBhH
   4yfee8HfDucWrTIycKMUsvDTK0Zjmrh/OqOe7g7JbpfF3lt9XDAB4CXMF
   aSY/JKUYL/DJLSPh28ivvceuwC10dOKSXsS2rgfiO9rtQ5S08x0CPbjzH
   g==;
IronPort-SDR: 6aUQVzAiX6pTIEVJH5gE92GdPMydIqYhBYKwn2m9XrOx61u0my+FKU0K5YnHqgwBfKJEPuURzw
 N+DV4WNJjbh5WY0B3wUuzAIQbJeR6Rsyet7j9x9oxFeBiEVv+Lubn03v845MS3x89sevqf4yb8
 djT/iVko3hGXacMfgsNEvJ0YCFFJUbmBPQE05VDg71pvmcJ1nRoKpcbzsQsxbKUBbSZairDJhL
 aZu0cumuP9nQTiKAtMMl+SV6XPqrGl5jApGlnat+dDZOWiYo18IzO//EvAXf2RInj9nw6sGSt2
 2XuQ3M61xdJCdZ9bNYv+OCxa
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="148666124"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 00:41:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 00:41:58 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 00:41:54 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v9 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Tue, 19 Oct 2021 13:10:29 +0530
Message-ID: <20211019074030.31294-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
References: <20211019074030.31294-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings documentation for lan966x SoC
generic clock controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
v8 -> v9:
- Added Acked-by: Nicolas Ferre.

v7 -> v8:
- No changes.

v6 -> v7:
- No changes.

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

