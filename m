Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1183C323093
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhBWSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:21:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18302 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhBWSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614104494; x=1645640494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EEtLwWSezY8Sf8ckHTwieMMidcPrRuv8Cp4CpEaGEc=;
  b=KQUDOoTaLuE0uX6t4xr/GhqE3PnHR2VtTgCSMiKG6QQabgwgZPQrz6VQ
   JOjXOmV0F84t9HCEfUIU8aox9ci3MINrjf4raKBbP7bu8aTngqBcQzrE0
   8bBnQwpWx5rndpsE8VjZ1iFgwLY4BvqB34H+e+2IO3vU4osrqHFJG9Amq
   kTjCBf7maFBRWcKsD+NO3nzBrg0t0H5SS9/ORWUyAGKRNeDe02c1FGBmN
   y7c9N7Z2KEaOVuIS3mpbhWklNTOUBTiJdVd+daV6hVDVdrS9FMjU4ObsX
   T3ldjaFMi7xB8XNyq9Ma5pHHHwPfKh7q3yB3fe+vwSRohScvn8XmYtyB4
   g==;
IronPort-SDR: dCcWn2EoPHAB3rGDXt78rb0hQIVFSosi7eMqHLOoWMRWEnDaxrE84b8ieSNbcBsHoHu4gPP044
 nhxfX3hpvf89IbVYmBVmunWtqTMO50EB3w3EuV4KKiA3cxvZWV34oF+R2GYFpZ7dcFB9YVZTYO
 jA/0Yq/A1FJ1rYk55s9Jb91S3ihmv+PMovpm1nv7DmkYsMjB7eUxX4kz/wTPwWj5OR1fbp85UU
 Tb95bZy4DWyBmHxzEP/N3vUTjtBUClhoEQLacHwpLreB42FdVByzB2yTxR0rOv6Vw1yjSylRbl
 2VU=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="110827424"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 11:20:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:20:01 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 23 Feb 2021 11:19:57 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Date:   Tue, 23 Feb 2021 20:19:23 +0200
Message-ID: <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the Microchip I2SMCC bindings to DT schema format
using json-schema.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp,i2s-mcc.yaml          | 86 +++++++++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 ----------
 2 files changed, 86 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
new file mode 100644
index 000000000000..79445f5f2804
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,i2s-mcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip I2S Multi-Channel Controller
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+  The I2SMCC complies with the Inter-IC Sound (I2S) bus specification and
+  supports a Time Division Multiplexed (TDM) interface with external
+  multi-channel audio codecs. It consists of a receiver, a transmitter and a
+  common clock generator that can be enabled separately to provide Adapter,
+  Client or Controller modes with receiver and/or transmitter active.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: microchip,sam9x60-i2smcc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock (Optional). Should be set mostly when Master
+          Mode is required.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+    minItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2s@f001c000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sam9x60-i2smcc";
+        reg = <0xf001c000 0x100>;
+        interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+        dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                       AT91_XDMAC_DT_PERID(36))>,
+               <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+                       AT91_XDMAC_DT_PERID(37))>;
+        dma-names = "tx", "rx";
+        clocks = <&i2s_clk>, <&i2s_gclk>;
+        clock-names = "pclk", "gclk";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i2s_default>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
deleted file mode 100644
index 91ec83a6faed..000000000000
--- a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Microchip I2S Multi-Channel Controller
-
-Required properties:
-- compatible:     Should be "microchip,sam9x60-i2smcc".
-- reg:            Should be the physical base address of the controller and the
-                  length of memory mapped region.
-- interrupts:     Should contain the interrupt for the controller.
-- dmas:           Should be one per channel name listed in the dma-names property,
-                  as described in atmel-dma.txt and dma.txt files.
-- dma-names:      Identifier string for each DMA request line in the dmas property.
-		  Two dmas have to be defined, "tx" and "rx".
-- clocks:         Must contain an entry for each entry in clock-names.
-                  Please refer to clock-bindings.txt.
-- clock-names:    Should be one of each entry matching the clocks phandles list:
-                  - "pclk" (peripheral clock) Required.
-                  - "gclk" (generated clock) Optional (1).
-
-Optional properties:
-- pinctrl-0:      Should specify pin control groups used for this controller.
-- princtrl-names: Should contain only one value - "default".
-
-
-(1) : Only the peripheral clock is required. The generated clock is optional
-      and should be set mostly when Master Mode is required.
-
-Example:
-
-	i2s@f001c000 {
-		compatible = "microchip,sam9x60-i2smcc";
-		reg = <0xf001c000 0x100>;
-		interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
-		dmas = <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(36))>,
-		       <&dma0
-			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
-			 AT91_XDMAC_DT_PERID(37))>;
-		dma-names = "tx", "rx";
-		clocks = <&i2s_clk>, <&i2s_gclk>;
-		clock-names = "pclk", "gclk";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_i2s_default>;
-	};
-- 
2.27.0

