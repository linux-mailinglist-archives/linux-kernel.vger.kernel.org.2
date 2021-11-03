Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B44443D08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKCGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:22:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14518 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCGWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635920397; x=1667456397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eIDx8jrxIrNNdRkrJ9DzGMTOtWv0hiTMcOMNxXujCTg=;
  b=Js4JWbMDMP5nUCHxcODilpUkjrSmDqwnBKTpfQ0zQxGPx8U1staVUb6X
   qsiM6qJHdcWQDwT4jytaq463am20Pjdc4uzsNPfaK4Dvws+4QeIzhAtiv
   /sQTUXB53g//5D3HPYVmNXwfuiuRFeNxD2MTqieJgYiUuDtTFlPr3uzv3
   nRDno+HflSGo1SpkSkxc7eSc7eqBvOyp/S/4htu/FHj+VepPtjVCm8w9s
   yjKaaafSMz3JY6AEkKXNoVzmB/nkcCy5ITPlmTJcQpJJY28Ck5XmU6gZd
   fydY9BZ5lRozLoelDpjM0CaX4hAb5XfzPZsZ3WhQcr0brMFaHOjbTcYpH
   Q==;
IronPort-SDR: /n/1iYE7Q+FMsgPgm4wjkaulQGakl7fdNQb0RUuEd0g/WDDTaeEVDTZXt1tBOOrZjkB2MrLn+C
 dB6bvqXAwYsFdUbcrtuAWnnE/9q3anYK1HA0xS11/2nWUkJWG90RyEzbIOauf7OiRC99OPZhnH
 yarsSqau+YHyDkECxjZNQXcwRPWsSB7bGhLdahZeBYMcN/WKGe39n4CQqm8KfV+IZjW3yd/a0D
 oFhCqQzf5pK1/0AK+8gh3293hGa/2ZUGOBcA2AA0vNIbT2GqGhI12evJ79q+fS3+nWBTSunoii
 ZO8E7GLWSu7jQdeHLKp8Wb8Z
X-IronPort-AV: E=Sophos;i="5.87,204,1631602800"; 
   d="scan'208";a="150527021"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2021 23:19:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 23:19:56 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 2 Nov 2021 23:19:53 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <nicolas.ferre@microchip.com>, <Eugen.Hristev@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH v10 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Wed, 3 Nov 2021 11:49:34 +0530
Message-ID: <20211103061935.25677-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
References: <20211103061935.25677-1-kavyasree.kotagiri@microchip.com>
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
v9 -> v10:
- No changes.

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

