Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F126417883
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347394AbhIXQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:30:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15611 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbhIXQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632500912; x=1664036912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/MuNZIFL8T6FfSyf5qyBIEBQRoAmkVs4MN5QIDFeIo=;
  b=UCbCVETE9PqMtwTS/xxzENWmoUjXHU21WOpDiMdhDiRiqMscub1yOn+W
   KDaB7X08mRhtxLhePDabKib9TfJYWMCUnomsOPzzSdHXfpvONB76PKk2c
   Rq5p16qhAzQuKGrf+fg69ciGuRxij45m/9jdjT3PbFMz8WUTnoghlK4EI
   FZ7nSCC1dATIQRnCcrWHMHeRR6QqyC65Mofg6evcr5MMesfzG0PH80FBG
   ncSgRAFsq0EtBVTAU5BFn2WKVwgtd4mwC7MMooRPSVtwmFdKGJe41AhKr
   K698VWY11YKxKtCu/z1Aj3nN4xDe96XMmbUHzSdcqNdsxb7BWdnZy6X6s
   g==;
IronPort-SDR: V9BqGbrbfxifDT6NbeIOgv9iUPrUlCO51A+IAxQoda+jCa8OLcvlpkGngnNSi6OaNfAHUp+tiQ
 IGjioA73S4etldHu6uUBE2cukaZPZdNWpKbOguxhJEUU9Vfko7TU7iIZbHu3herDqdrQd4KF2+
 7K0KV/rLs38eko+KeUlVXY2OQ0DCu/rj4FiYlreqX4imKyPlB6XFWLWB9BYe2RvP5aSjoQtXbq
 F8t3yt63IF6f/HROMizqMDx8s+X3BpK3VIpdqmYfy9W/CPzyQ1Yo1JIbqU3TQck6BJFLNMKJVf
 cyIUQtiQ1Ixm4FJtAEoiJ80n
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="137875637"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 09:28:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 09:28:31 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 09:28:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: microchip,eic: add bindings
Date:   Fri, 24 Sep 2021 19:28:16 +0300
Message-ID: <20210924162817.2135056-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924162817.2135056-1-claudiu.beznea@microchip.com>
References: <20210924162817.2135056-1-claudiu.beznea@microchip.com>
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

