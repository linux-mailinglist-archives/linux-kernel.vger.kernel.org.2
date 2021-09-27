Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AEF418F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhI0GjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:39:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19895 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhI0GjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632724662; x=1664260662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKmNRuq9lM9GBTcAbv7Iz7CF9S0F0tlziIF0rhzCyWk=;
  b=ISi6XapDlnxnliIWrJ8h1Xdz5M2fwKSzCVCZKUTcvrEeyZtMtajzgiBO
   qvr5gmV+Lr5VovxD5mXEeMD88EsVSXNb22vfTrr1EXYIAZ7368ZQpkc54
   8m5CfbbUOP23gI/+TJ1HI89sqEWqCE8LUg2K7goeyN5av3z3C7NhNpk0f
   J2is0T7sDqurNi2J3QXLm/wNp87WT1gvxxyCVoH+kfrkVz2mXX3wV7nGM
   Uzn2LDx4L7y6UShPze9maP6e6ut9rd30Ea6H0Bf2aYlX6LcDMgyihXxJp
   r0L4m6HChB1pV/BkC3FuPFc0MX92QJmtKsL3yVPz3L+HBPIdkfE1696td
   g==;
IronPort-SDR: /oayIDBq8CbMfPZbdtxvDMJYsFultMHBU8XByMFSN25UPTOKMOS3+slvAv4nY1V3vi8rHlJZZ4
 CGTV3Q/To9GJBDF+CGA+3fbZHeM5zmX8ikoE84DaS52VC6CdNf4INzeHLPSP8MLovXbDd9rbNv
 n9cbYddrzN050p4I6JoZpiaDXb19bJF3Pr2EYfctL858RLSVtgHGxgJ8884BzIMNk7Cr+Zw3zx
 HHWS/EWLDRYAvklu56R6h4LvMBcj+qGFggS7N1WmagnPFXz+n8w7TnURYfZipA2/bH31FykOg5
 oJOa1Ra8wAnfX4JCWB9KlkHk
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="70720783"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2021 23:37:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Sep 2021 23:37:41 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Sep 2021 23:37:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: microchip,eic: add bindings
Date:   Mon, 27 Sep 2021 09:36:56 +0300
Message-ID: <20210927063657.2157676-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
References: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
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

