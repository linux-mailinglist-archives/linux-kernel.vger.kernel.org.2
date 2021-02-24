Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87213235BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhBXCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBXCcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:32:05 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B684C06174A;
        Tue, 23 Feb 2021 18:31:25 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z128so820084qkc.12;
        Tue, 23 Feb 2021 18:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNlPGBrBmQEGfGvvIqq94eLCgAYa7qCblYspH9x9rtk=;
        b=iT0UqgEqaQ+ghiwYQcZjHAjRi+G9mc6ph/250tQEojh47HWlhlaDHvsc56xyqfxy2m
         Van0Kz/lss+TAgFhAia9hTE+A3huiCCY3FpI20McqHua6msxU3F55Gcbov4eO6LViPwY
         4bi33dLfYI1DeEt0QcJC73UVzdvtMkPJ20kluoy0KUf0K0Mdj7snIMC07WczATPUaZ8C
         PHBHUbZSR9hRMjcDxhCPVV1bGAWFBKQrAs9HkBcyUWzaTH35yf1sViQIPr2Mqwj8ye+c
         l8Kd9wnC1Qha/sG1G0KqA8p0ATWusC2Jy4BSVh4YMkq63/ETAXTSyl/K/OLg6x7T/m4d
         N1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNlPGBrBmQEGfGvvIqq94eLCgAYa7qCblYspH9x9rtk=;
        b=r2t5nQ5Rc/b96Ab9UBep6JdkQthhahGOIrw8WkvVUO3AMIa/eotituAZy4PicEo8EP
         LEoXOlukrb+6NIiJmX8Bh09+qNKLIO0tfbzeqhaBvRA+L+zlrR1X51Eh1LCgrsQirr9y
         iSHNZfk67FO8lVyw8EEcN8AXoQfrvWz33J6SEY/4Mvjy7KzlTv04pYk0/OAY3uu33Ia3
         0J2whkm3lm4lmLpLLD6yhHpoEBLB8gDMdmMl7MoCRbaOkXeU9oKAlNYiyMzhYFhMPPUl
         S51l0R59fObBXDd3p0FLCntk4u+U+5TCNkcQnB1WNtv1nlxzLdZBOcdskVAnzU1eC2G4
         AQSA==
X-Gm-Message-State: AOAM530ZvJyrY7ecx1C8AZQe+vrI/+oCLViQQCVEC+25LHz0e1kV+Nhp
        HY82a69o/7UAcvNF7qPx9qzs4eYnBzmgz+6v
X-Google-Smtp-Source: ABdhPJxWx+DSCwYXwsbc8QClG50dYhORqWjnHZcI+w8osOeJgCw9l86feTXTVXxj1JPAybxw/juNyA==
X-Received: by 2002:a37:e31a:: with SMTP id y26mr4506206qki.178.1614133884276;
        Tue, 23 Feb 2021 18:31:24 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p25sm529500qkh.79.2021.02.23.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 18:31:23 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 0/3]  add support for the lmk04832
Date:   Tue, 23 Feb 2021 21:31:13 -0500
Message-Id: <20210224023116.571718-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Hi,

The LMK04832 is an ultra-high performance clock conditioner with JEDEC
JESD204B support and is also pin compatible with the LMK0482x family of
devices.

This driver adds initial support to configure the LMK04832 clocks using
the clock framework.

This has been tested on a system using JESD204B subclass 1.

At the moment, the VCO rate has to be set manually from the devicetree
and a dclk (or sclk) rate change isn't propagated to the VCO
automatically.

Changes since v1:
- add yaml devicetree documentation,
- add links to datasheet,
- use {u8,u16,u32} instead of Uint_ variants,
- drop redundant debugfs code,
- use a pointer to device_info instead of struct copy,
- add of_device_id table,
- add support for SYSREF digital delay and JESD204B subclass 1

Changes since v2:
- fix dt-bindings documentation, apologies for the broken build
- fix property vendor prefixes
- split dt-bindings into a separate patch

Thanks for your time,
Liam

Liam Beguin (3):
  clk: add support for the lmk04832
  clk: lmk04832: add support for digital delay
  dt-bindings: clock: add ti,lmk04832 bindings

 .../bindings/clock/ti,lmk04832.yaml           |  198 ++
 drivers/clk/Kconfig                           |    7 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-lmk04832.c                    | 1595 +++++++++++++++++
 4 files changed, 1801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
 create mode 100644 drivers/clk/clk-lmk04832.c

Interdiff against v2:
diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
index 9c56e37214e4..c0d9ab650e80 100644
--- a/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
@@ -27,44 +27,38 @@ properties:
     const: 1
 
   clocks:
-    maxItems: 1
     items:
       - description: PLL2 reference clock.
 
   clock-names:
-    maxItems: 1
     items:
       - const: oscin
 
   reset-gpios:
-    description: A connection of the 'reset' gpio line.
     maxItems: 1
 
-  lmk,spi-4wire-rdbk:
+  ti,spi-4wire-rdbk:
     description: |
       Select SPI 4wire readback pin configuration.
       Available readback pins are,
         CLKin_SEL0 0
         CLKin_SEL1 1
         RESET 2
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2]
-      - default: 1
-
-  lmk,vco-rate:
-    description: VCO rate to use (in Hz).
     $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
 
-  lmk,sysref-ddly:
+  ti,vco-hz:
+    description: Optional to set VCO frequency of the PLL in Hertz.
+
+  ti,sysref-ddly:
     description: SYSREF digital delay value.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 8
-      - maximum: 8191
-      - default: 8
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 8191
+    default: 8
 
-  lmk,sysref-mux:
+  ti,sysref-mux:
     description: |
       SYSREF Mux configuration.
       Available options are,
@@ -72,28 +66,25 @@ properties:
         Re-clocked 1
         SYSREF Pulser 2
         SYSREF Continuous 3
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2, 3]
-      - default: 3
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 3
 
-  lmk,sync-mode:
+  ti,sync-mode:
     description: SYNC pin configuration.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [0, 1, 2]
-      - default: 1
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
 
-  lmk,sysref-pulse-count:
+  ti,sysref-pulse-count:
     description:
       Number of SYSREF pulses to send when SYSREF is not in continuous mode.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 2, 4, 8]
-      - default: 4
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+    default: 4
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "@[0-9a-d]+$":
     type: object
     description:
       Child nodes used to configure output clocks.
@@ -105,7 +96,7 @@ patternProperties:
         minimum: 0
         maximum: 13
 
-      lmk,clkout-fmt:
+      ti,clkout-fmt:
         description:
           Clock output format.
           Available options are,
@@ -125,12 +116,11 @@ patternProperties:
             CMOS (Inverted/Normal) 0x0d
             CMOS (Normal/Inverted) 0x0e
             CMOS (Normal/Normal) 0x0f
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/uint32
-          - minimum: 0
-          - maximum: 15
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 15
 
-      lmk,clkout-sysref:
+      ti,clkout-sysref:
         description:
           Select SYSREF clock path for output clock.
         type: boolean
@@ -142,6 +132,8 @@ required:
   - compatible
   - reg
   - '#clock-cells'
+  - clocks
+  - clock-names
 
 additionalProperties: false
 
@@ -157,45 +149,50 @@ examples:
         };
     };
 
-    lmk04832: lmk04832@0 {
-        reg = <0>;
+    spi0 {
         #address-cells = <1>;
         #size-cells = <0>;
 
-        compatible = "ti,lmk04832";
-        spi-max-frequency = <781250>;
-
-        reset-gpios = <&gpio_lmk 0 0 0>;
-
-        #clock-cells = <1>;
-        clocks = <&lmk04832_oscin>;
-        clock-names = "oscin";
-
-        lmk,spi-4wire-rdbk = <0>;
-        lmk,vco-rate = <2457600000>;
-
-        assigned-clocks =
-            <&lmk04832 0>, <&lmk04832 1>,
-            <&lmk04832 2>, <&lmk04832 3>,
-            <&lmk04832 4>,
-            <&lmk04832 6>, <&lmk04832 7>,
-            <&lmk04832 10>, <&lmk04832 11>;
-      assigned-clock-rates =
-            <122880000>, <384000>,
-            <122880000>, <384000>,
-            <122880000>,
-            <153600000>, <384000>,
-            <614400000>, <384000>;
-
-      clkout0@0 {
-          reg = <0>;
-          lmk,clkout-fmt = <0x01>; // LVDS
-      };
-
-      clkout1@1 {
-          reg = <1>;
-          lmk,clkout-fmt = <0x01>; // LVDS
-          lmk,clkout-sysref;
-      };
-  };
-
+        lmk04832: clock-controller@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reg = <0>;
+
+            compatible = "ti,lmk04832";
+            spi-max-frequency = <781250>;
+
+            reset-gpios = <&gpio_lmk 0 0 0>;
+
+            #clock-cells = <1>;
+            clocks = <&lmk04832_oscin>;
+            clock-names = "oscin";
+
+            ti,spi-4wire-rdbk = <0>;
+            ti,vco-hz = <2457600000>;
+
+            assigned-clocks =
+                <&lmk04832 0>, <&lmk04832 1>,
+                <&lmk04832 2>, <&lmk04832 3>,
+                <&lmk04832 4>,
+                <&lmk04832 6>, <&lmk04832 7>,
+                <&lmk04832 10>, <&lmk04832 11>;
+            assigned-clock-rates =
+                <122880000>, <384000>,
+                <122880000>, <384000>,
+                <122880000>,
+                <153600000>, <384000>,
+                <614400000>, <384000>;
+
+            clkout0@0 {
+                reg = <0>;
+                ti,clkout-fmt = <0x01>; // LVDS
+            };
+
+            clkout1@1 {
+                reg = <1>;
+                ti,clkout-fmt = <0x01>; // LVDS
+                ti,clkout-sysref;
+            };
+        };
+    };
diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index e0f01aacc8f4..5393088fa68e 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1444,21 +1444,21 @@ static int lmk04832_probe(struct spi_device *spi)
 		goto err_disable_oscin;
 	}
 
-	device_property_read_u32(lmk->dev, "lmk,vco-rate", &lmk->vco_rate);
+	device_property_read_u32(lmk->dev, "ti,vco-hz", &lmk->vco_rate);
 
 	lmk->sysref_ddly = 8;
-	device_property_read_u32(lmk->dev, "lmk,sysref-ddly", &lmk->sysref_ddly);
+	device_property_read_u32(lmk->dev, "ti,sysref-ddly", &lmk->sysref_ddly);
 
 	lmk->sysref_mux = LMK04832_VAL_SYSREF_MUX_CONTINUOUS;
-	device_property_read_u32(lmk->dev, "lmk,sysref-mux",
+	device_property_read_u32(lmk->dev, "ti,sysref-mux",
 				 &lmk->sysref_mux);
 
 	lmk->sync_mode = LMK04832_VAL_SYNC_MODE_OFF;
-	device_property_read_u32(lmk->dev, "lmk,sync-mode",
+	device_property_read_u32(lmk->dev, "ti,sync-mode",
 				 &lmk->sync_mode);
 
 	lmk->sysref_pulse_cnt = 4;
-	device_property_read_u32(lmk->dev, "lmk,sysref-pulse-count",
+	device_property_read_u32(lmk->dev, "ti,sysref-pulse-count",
 				 &lmk->sysref_pulse_cnt);
 
 	for_each_child_of_node(lmk->dev->of_node, child) {
@@ -1471,7 +1471,7 @@ static int lmk04832_probe(struct spi_device *spi)
 			goto err_disable_oscin;
 		}
 
-		of_property_read_u32(child, "lmk,clkout-fmt",
+		of_property_read_u32(child, "ti,clkout-fmt",
 				     &lmk->clkout[reg].format);
 
 		if (lmk->clkout[reg].format >= 0x0a && reg % 2 == 0
@@ -1480,7 +1480,7 @@ static int lmk04832_probe(struct spi_device *spi)
 				reg);
 
 		lmk->clkout[reg].sysref =
-			of_property_read_bool(child, "lmk,clkout-sysref");
+			of_property_read_bool(child, "ti,clkout-sysref");
 	};
 
 	lmk->regmap = devm_regmap_init_spi(spi, &regmap_config);
@@ -1495,7 +1495,7 @@ static int lmk04832_probe(struct spi_device *spi)
 	regmap_write(lmk->regmap, LMK04832_REG_RST3W, LMK04832_BIT_RESET);
 
 	if (!(spi->mode & SPI_3WIRE)) {
-		device_property_read_u32(lmk->dev, "lmk,spi-4wire-rdbk",
+		device_property_read_u32(lmk->dev, "ti,spi-4wire-rdbk",
 					 &rdbk_pin);
 		ret = lmk04832_set_spi_rdbk(lmk, rdbk_pin);
 		if (ret)

base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.30.1.489.g328c10930387

