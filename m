Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3F329321
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbhCAVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:02:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47375 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhCARLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614618681; x=1646154681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KkYmeABURUpBJilVSbLXGkupR/elTsE8JTUDxIe7uI8=;
  b=mKByZ5IDLh8lfoVPZC2gP9jY7ywe50lPkMRFFACojll8oYxIveluABtj
   XO6qimZ05GOYYEyqRIrQECXizQJQmrLl+ajFJe//fnLFf1bYXne5qh0Fc
   yoMSQyWUdkRwq4Y39Rkx2JmOkecU4xOQvshRb8+ecthR5DnSv68pgKP7F
   /V7uc/L223cylo7zziuzrpcp4Ci1E9JQd0itMe43MRrsfq+zTe+t74gq7
   jEaLdNaaIyWZ5QAo7vIF2TSWBY5l+u5wye8Sqs3SqhbOjeDjw8vpxMxLW
   3MY/poT64a/cUIbVWeBGa9J4lydgB25RosXybGqrEBjy773dz3bx6unTN
   A==;
IronPort-SDR: RUAQQuKc8bU+YvOwwXbRPj8k/kX57It6Egh4uEsWodeZ68DE42ZAwMEEJBE2FVOVHFdouYL7t2
 5x72jHGkCUI+JTzJMU3bDwoEo7Pe9FT7ox5vudm3IP/AFnb8thbuoZN0NkbEkxgqXbyyi7i1lZ
 MF1WbASYralZrx3FQB8N6VmQsie6S3cmQBiLuXCJ38JuBFq2HXbYvBejPzqOkcC9fVo6Ptm/wR
 j16+A/4RJxrBM+G0Bgri0NC890cqI/t5gntUIU9tmJP9UK7iALBN1aRvQPj228mQryYEcofSXb
 BGE=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="108323788"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 10:10:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 10:10:00 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 10:09:57 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 7/7] ASoC: convert Microchip I2SMCC binding to yaml
Date:   Mon, 1 Mar 2021 19:09:05 +0200
Message-ID: <20210301170905.835091-8-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
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

Changes in v2:
- moved from the beginning to the end of the patch series;
- includes the changes (to yaml) from the rest of the patches that
  update the DT binding;

 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++++++++
 .../bindings/sound/mchp-i2s-mcc.txt           |  49 --------
 2 files changed, 108 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
new file mode 100644
index 000000000000..0481315cb5f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
@@ -0,0 +1,108 @@
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
+  On later I2SMCC versions (starting with Microchip's SAMA7G5) I2S
+  multi-channel is supported by using multiple data pins, output and
+  input, without TDM.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - microchip,sam9x60-i2smcc
+      - microchip,sama7g5-i2smcc
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
+  microchip,tdm-data-pair:
+    description:
+      Represents the DIN/DOUT pair pins that are used to receive/send
+      TDM data. It is optional and it is only needed if the controller
+      uses the TDM mode.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    enum: [0, 1, 2, 3]
+    default: 0
+
+if:
+  properties:
+    compatible:
+      const: microchip,sam9x60-i2smcc
+then:
+  properties:
+    microchip,tdm-data-pair: false
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
index af8fe3e657df..000000000000
--- a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* Microchip I2S Multi-Channel Controller
-
-Required properties:
-- compatible:     Should be "microchip,sam9x60-i2smcc" or
-		  "microchip,sama7g5-i2smcc".
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
-- microchip,tdm-data-pair: 8 bit value that represents the DIN/DOUT pair pins
-			   which are used to receive/send TDM data. It is optional
-			   and it is only needed if the controller uses the TDM
-			   mode. Not available for "microchip,sam9x60-i2smcc"
-			   compatible. If it's not present, the default value is 0,
-			   so the DIN/DOUT 0 pins are used.
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

