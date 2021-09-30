Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C841DB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351454AbhI3Nac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:30:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49540 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351433AbhI3NaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633008521; x=1664544521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=s0z56KhLKO6MbP32TRs2TV8dX8ToFoXdejyMjuyrdXM=;
  b=QeXkDVNRGHohkVZLhDYqOjGqt4f5f2BsAfZYxUS7JyYkyn8TiSVMUipj
   gr5NgGLmp+jEf+3zISIItN6xLADUvmhJ65K8xWxrS/umrEsQv71kcqVuX
   5SwvnO8pAlQQ2MrPWWEHIJ4snOW1g4hRU6yG1a3amgdN7wYqD+lwwng1o
   pRZPIHkJdmH8cjIZ4JcJAqQhYHawKuhPnTIhdlHgEh6Q6tkefKqLX+y2b
   QaGmlG8jhakuJoyoy9SNVFzxK+jfpd9t8qabbBA78jmRDOHdmAKPX0Kfn
   idrLkZqlJMvbYphqChJGMlr0nB0PsoJZieaoiKBoTgRwq9JS0ysaYUrDP
   A==;
IronPort-SDR: 74ILhevK+Z8BzRYW72P8iiBRkxJE+TBIJzvTpBFI0yBRydAZy6+PSAx6MYmc5RscymafWxJhkU
 kfvRBF5gKzRipvh2jGvIZTirT6Jm1kXoVBBtfzCtHzGDbTa3W2AmkpHdhNehx9Djurb6N4SSlv
 GX1BfDWGfpMkfx4D6HIRs2nOM+bT/87YDHfZeaz3QVVf2PVxGKENgOrGds7TQUtIyGpximdQEk
 qEvQ3uWN8joYV7LbIwFqygsIHntGpRyiq5S0TnxcM6/eyiZVob0FobUobVHhaY9a/oahPMEW7X
 /B3t2puJ7ZJN+Au05lyNhBMC
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="146266145"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 06:28:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 06:28:30 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 06:28:27 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v7 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Thu, 30 Sep 2021 18:58:14 +0530
Message-ID: <20210930132815.15353-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
References: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
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

