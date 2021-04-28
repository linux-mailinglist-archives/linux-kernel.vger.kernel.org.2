Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312236D1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhD1F6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1F6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:58:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FBC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:57:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so8489324wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyqVcvI+/S8KEaKfrGlCQPbNV8YgveGyOziG0j9Xalc=;
        b=SGQ4kNE+wZUsoYqh8k5m0T0WDqas74ArlJMbbFm5N57Icfvaf/y53AnUwvaDjpYM2u
         x2Yl1ngFMcQTy94YmvSDfm4sD1LJdflRH73AblAeyFP08akL6velv886aVIFdjL0SLqd
         r1STg9FqrhD6l9G73x5fRzVUJSoq5wN9bAmyHCqpa6VdGb/ZsGtwpjXgwaKYWhK/6KUf
         CvJO/xoaQ7iM69ADtZDM/3Iy0oTNKRnHNA/CZopzztiwBrU649mQU0JkfJagcOy67xjt
         okOWQldfu2QOwd+KJwPtLwxwQ/tBGhACXEx90lPk7iAlB84EaOzZXQgNyXKx33USEB3M
         yJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyqVcvI+/S8KEaKfrGlCQPbNV8YgveGyOziG0j9Xalc=;
        b=WPisEMQ0lH4qUHBx/VgxQBqrVR1PWiR/GSRHaDr/P58pDToWuMx+VMfMIRnR3aNUIN
         I/csh7l2TkZJduUzJBasrlhdfFMTOYNqnKtztk4SscC7Bn54eAmNI6z8r9cUWHpkyN52
         oXi1CEVP7zFXbriUvUNKchkKw6Gv4O5PXTQrzaT4EwFtkC191G1JQPGN3JQa4CkhssnP
         zH1Q1nLrMR4x3xgAvZMIRn6RSZqebIONdWjMPUI+0r9wMM97j47NZrnV2ucpJwkWOtO9
         vA4LUB2q+5D07A7rauv832CCg7mrKnYp++q3OcoU3MsE/pQrKhwE734YbrWChg4bGVGB
         Pwaw==
X-Gm-Message-State: AOAM5339sLFjfIZ2XjHZ5vGY6aylPZDd9j8MYMBzBG2b+PVEXp00ql5y
        w1Twb7b0Ji9OUEC12oE1OAeSjg==
X-Google-Smtp-Source: ABdhPJxDo2A83JSDicnAQ2q4BMDOgMNbuDV45FoTYSmU5fUHJTe5Y6k4Jwcv2xdlQhAXh+qTPRUrJA==
X-Received: by 2002:a5d:570e:: with SMTP id a14mr20472819wrv.254.1619589476731;
        Tue, 27 Apr 2021 22:57:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f8sm116417wmg.43.2021.04.27.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 22:57:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     robh+dt@kernel.org, vkoul@kernel.org
Cc:     linus.walleij@linaro.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFC] dt-bindings: dma: convert arm-pl08x to yaml
Date:   Wed, 28 Apr 2021 05:57:50 +0000
Message-Id: <20210428055750.683963-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts dma/arm-pl08x.txt to yaml.
In the process, I add an example for the faraday variant.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
 .../devicetree/bindings/dma/arm-pl08x.yaml    | 127 ++++++++++++++++++
 2 files changed, 127 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.txt b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
deleted file mode 100644
index 0ba81f79266f..000000000000
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* ARM PrimeCells PL080 and PL081 and derivatives DMA controller
-
-Required properties:
-- compatible: "arm,pl080", "arm,primecell";
-	      "arm,pl081", "arm,primecell";
-	      "faraday,ftdmac020", "arm,primecell"
-- arm,primecell-periphid: on the FTDMAC020 the primecell ID is not hard-coded
-  in the hardware and must be specified here as <0x0003b080>. This number
-  follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
-  for Faraday Technology.
-- reg: Address range of the PL08x registers
-- interrupt: The PL08x interrupt number
-- clocks: The clock running the IP core clock
-- clock-names: Must contain "apb_pclk"
-- lli-bus-interface-ahb1: if AHB master 1 is eligible for fetching LLIs
-- lli-bus-interface-ahb2: if AHB master 2 is eligible for fetching LLIs
-- mem-bus-interface-ahb1: if AHB master 1 is eligible for fetching memory contents
-- mem-bus-interface-ahb2: if AHB master 2 is eligible for fetching memory contents
-- #dma-cells: must be <2>. First cell should contain the DMA request,
-              second cell should contain either 1 or 2 depending on
-              which AHB master that is used.
-
-Optional properties:
-- dma-channels: contains the total number of DMA channels supported by the DMAC
-- dma-requests: contains the total number of DMA requests supported by the DMAC
-- memcpy-burst-size: the size of the bursts for memcpy: 1, 4, 8, 16, 32
-  64, 128 or 256 bytes are legal values
-- memcpy-bus-width: the bus width used for memcpy in bits: 8, 16 or 32 are legal
-  values, the Faraday FTDMAC020 can also accept 64 bits
-
-Clients
-Required properties:
-- dmas: List of DMA controller phandle, request channel and AHB master id
-- dma-names: Names of the aforementioned requested channels
-
-Example:
-
-dmac0: dma-controller@10130000 {
-	compatible = "arm,pl080", "arm,primecell";
-	reg = <0x10130000 0x1000>;
-	interrupt-parent = <&vica>;
-	interrupts = <15>;
-	clocks = <&hclkdma0>;
-	clock-names = "apb_pclk";
-	lli-bus-interface-ahb1;
-	lli-bus-interface-ahb2;
-	mem-bus-interface-ahb2;
-	memcpy-burst-size = <256>;
-	memcpy-bus-width = <32>;
-	#dma-cells = <2>;
-};
-
-device@40008000 {
-	...
-	dmas = <&dmac0 0 2
-		&dmac0 1 2>;
-	dma-names = "tx", "rx";
-	...
-};
diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
new file mode 100644
index 000000000000..ec2324d881f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PrimeCells PL080 and PL081 and derivatives DMA controller
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: "arm,pl080"
+        - const: "arm,primecell"
+      - items:
+        - const: "arm,pl081"
+        - const: "arm,primecell"
+      - items:
+        - const: faraday,ftdma020
+        - const: arm,pl080
+        - const: arm,primecell
+  arm,primecell-periphid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: on the FTDMAC020 the primecell ID is not hard-coded
+                 in the hardware and must be specified here as <0x0003b080>. This number
+                 follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
+                 for Faraday Technology.
+  reg:
+    minItems: 1
+    description: Address range of the PL08x registers
+  interrupts:
+    minItems: 1
+    description: The PL08x interrupt number
+  clocks:
+    minItems: 1
+    description: The clock running the IP core clock
+  clock-names:
+    const: "apb_pclk"
+  lli-bus-interface-ahb1:
+    type: boolean
+    description: if AHB master 1 is eligible for fetching LLIs
+  lli-bus-interface-ahb2:
+    type: boolean
+    description: if AHB master 2 is eligible for fetching LLIs
+  mem-bus-interface-ahb1:
+    type: boolean
+    description: if AHB master 1 is eligible for fetching memory contents
+  mem-bus-interface-ahb2:
+    type: boolean
+    description: if AHB master 2 is eligible for fetching memory contents
+  "#dma-cells":
+    const: 2
+    description: must be <2>. First cell should contain the DMA request,
+                 second cell should contain either 1 or 2 depending on
+                 which AHB master that is used.
+
+  memcpy-burst-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+        - 1
+        - 4
+        - 8
+        - 16
+        - 32
+        - 64
+        - 128
+        - 256
+    description: the size of the bursts for memcpy
+  memcpy-bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+        - 8
+        - 16
+        - 32
+        - 64
+    description: |
+                 the bus width used for memcpy in bits: 8, 16 or 32 are legal
+                 values, the Faraday FTDMAC020 can also accept 64 bits
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dmac0: dma-controller@10130000 {
+      compatible = "arm,pl080", "arm,primecell";
+      reg = <0x10130000 0x1000>;
+      interrupt-parent = <&vica>;
+      interrupts = <15>;
+      clocks = <&hclkdma0>;
+      clock-names = "apb_pclk";
+      lli-bus-interface-ahb1;
+      lli-bus-interface-ahb2;
+      mem-bus-interface-ahb2;
+      memcpy-burst-size = <256>;
+      memcpy-bus-width = <32>;
+      #dma-cells = <2>;
+    };
+  - |
+    dma-controller@67000000 {
+      compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
+      /* Faraday Technology FTDMAC020 variant */
+      arm,primecell-periphid = <0x0003b080>;
+      reg = <0x67000000 0x1000>;
+      interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+      resets = <&syscon GEMINI_RESET_DMAC>;
+      clocks = <&syscon GEMINI_CLK_AHB>;
+      clock-names = "apb_pclk";
+      /* Bus interface AHB1 (AHB0) is totally tilted */
+      lli-bus-interface-ahb2;
+      mem-bus-interface-ahb2;
+      memcpy-burst-size = <256>;
+      memcpy-bus-width = <32>;
+      #dma-cells = <2>;
+    };
-- 
2.26.3

