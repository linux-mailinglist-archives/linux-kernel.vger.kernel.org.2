Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B32406714
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhIJGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:10:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42651 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631254152; x=1662790152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79y9TXD3dcFgndpcLNjdDOfeh8j5FX06J40EZLTDGN0=;
  b=0sl/isql8xdRYgO6KqztC93EjTsCFbThdFPyEdK7uLm8rhF19UA7zC24
   8u63/P2OIWdFJR+lwoKJjntIAj6YpE9G2CHKeChKo7d8ii0yhv0WlGHIJ
   nXaTodF4avl438atjYKdZufT9RJ8EJuDb4fWjsMaj6C8abZfCHY8QDtih
   lT8zRk+JW/1/15weTREulSLv2tTmF7GgVG/vMI00ZHgeOYnOVPdzgghLP
   NlHwIjbkHvCR42iR8BSgRNQg7cBNsM5BZdLjf8dBx6oFqe5mL3BP51RDb
   dpglibGygOnxH7AKFM5qKlvUz3Yt/njiV5MtUwShlQX/YiOaO/aOuOOOx
   g==;
IronPort-SDR: NLRIAwBnJaxNjQ5MzNE6QYfygnbpkuz/2Ak6gB4x9xKsK1H5EsTJ+wgTxNqHt/Ej+Zbts+OcnO
 x773hmut2G0hHrlcqNV4ZvHBbim7/gyN7NOTJ8iatDQijaTHkRUeqMJliat70DvMLVz/lgvOvZ
 8pmMdEBUWWEnGRh8d9JFSF37c9KuT27U2xtWAjoRmr2Zj+Am6nZ3xhe0zxdbqEgCfKUtRVRxyi
 sObmOfxrGm4tN/bgsEFLouRqQYLMcN2Dg2YZzYDqvWf2eOZ3sq3kHe/Lqt/WEVD7vk3akoqiDm
 pF+00oLdaIV5NdhjM0l5wTfL
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="143607058"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2021 23:09:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Sep 2021 23:09:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Sep 2021 23:09:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: microchip,eic: add bindings
Date:   Fri, 10 Sep 2021 09:06:55 +0300
Message-ID: <20210910060656.1061234-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910060656.1061234-1-claudiu.beznea@microchip.com>
References: <20210910060656.1061234-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Microchip External Interrupt Controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../interrupt-controller/microchip,eic.yaml   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
new file mode 100644
index 000000000000..50003880ee6f
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
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+      clock-names = "pclk";
+    };
+
+...
-- 
2.25.1

