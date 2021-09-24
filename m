Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286F34178EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347472AbhIXQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:38:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43021 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347559AbhIXQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632501307; x=1664037307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/MuNZIFL8T6FfSyf5qyBIEBQRoAmkVs4MN5QIDFeIo=;
  b=f1qR68+ksVPH8F8lmYPdQzRrXYhEWIqmT52DGsdh0rLzeRmduXds2n2Y
   p2x8BgOabVpmR0hyarwHO+L26nGKhfAGnPAoA7DC4EUtPNZ8vqDiqhlTB
   2cl9zlAHPxGenGKKGhQYZwHe3xiOi0Uy3nLJOSh2fGVosdLo9g0bhmtxT
   NgzqIP1M4Mbp6RlwJAMkyApJuxTQHFxJZItwv4KaSD4njQJ5j/1llRhUK
   SCyCGfZHlH2Gsu39MSAbABr6IvZrP9ZlhdYZxaLgJKfNdVZiYzA6pVgh+
   HsKBSWMnZzPW7n4Qh/fau+y4s/9BaPhjWstyFqqzbs8Nh+58I2IRpAjRu
   A==;
IronPort-SDR: ZJXkM1ma+rogxSWZPLA0nqm0Bdk2F56QL4nb4oKcYD2PC8avbjrgEZSkn/cGBjli1aiPzDYgGx
 3WTg8dDOUIQaSN8jGGXsquSUnXVZUoevyHxSbzPTNJRNLe+yt3w1rzW17gQ84sqpxwxd2huBgn
 CmJTdN83n4WUlw9CUnhemtt4vDbGrEh0oB7+zsROPPAx3KV5UhHn80OI8ox2Oj1HVc6b8zrhcI
 5hWBrGkKEeYLDf5VLVB/9Anl8zHQZ83KNKSKXgDy5hmapKIKMGBjKjMghogQTWFwew5VidC3hK
 MsF1W2M8NDmeUXka0lvzroFO
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="145529425"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 09:35:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 09:35:07 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 09:35:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: microchip,eic: add bindings
Date:   Fri, 24 Sep 2021 19:34:57 +0300
Message-ID: <20210924163458.2135247-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924163458.2135247-1-claudiu.beznea@microchip.com>
References: <20210924163458.2135247-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Microchip External Interrupt Controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/microchip,eic.yaml   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
new file mode 100644
index 000000000000..917a35e97b7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,eic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip External Interrupt Controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  This interrupt controller is found in Microchip SoCs (SAMA7G5) and provides
+  support for handling up to 2 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - microchip,sama7g5-eic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number (between 0 and 1), the second cell
+      is the trigger type as defined in interrupt.txt present in this directory.
+
+  interrupts:
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines. They
+      should be specified sequentially from output 0 to output 1.
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    eic: interrupt-controller@e1628000 {
+      compatible = "microchip,sama7g5-eic";
+      reg = <0xe1628000 0x100>;
+      interrupt-parent = <&gic>;
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+      clock-names = "pclk";
+    };
+
+...
-- 
2.25.1

