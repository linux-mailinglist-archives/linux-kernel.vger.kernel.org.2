Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949D42CDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJMWRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:17:41 -0400
Received: from aposti.net ([89.234.176.197]:40004 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhJMWRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:17:40 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: Rename Ingenic CGU headers to ingenic,*.h
Date:   Wed, 13 Oct 2021 23:08:14 +0100
Message-Id: <20211013220815.38692-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up a bit the tree, by prefixing all include/dt-bindings/clock/ files
related to Ingenic SoCs with 'ingenic,'.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml      | 2 +-
 Documentation/devicetree/bindings/display/ingenic,ipu.yaml    | 2 +-
 Documentation/devicetree/bindings/display/ingenic,lcd.yaml    | 4 ++--
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml        | 2 +-
 Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml        | 2 +-
 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml    | 2 +-
 .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml  | 2 +-
 .../devicetree/bindings/mips/ingenic/ingenic,cpu.yaml         | 2 +-
 Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml        | 2 +-
 Documentation/devicetree/bindings/mtd/ingenic,nand.yaml       | 2 +-
 Documentation/devicetree/bindings/net/ingenic,mac.yaml        | 2 +-
 .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml       | 2 +-
 Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml    | 2 +-
 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml | 2 +-
 Documentation/devicetree/bindings/rng/ingenic,trng.yaml       | 2 +-
 Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml        | 2 +-
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 +-
 Documentation/devicetree/bindings/sound/ingenic,aic.yaml      | 2 +-
 Documentation/devicetree/bindings/sound/ingenic,codec.yaml    | 2 +-
 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml   | 2 +-
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2 +-
 Documentation/devicetree/bindings/usb/ingenic,musb.yaml       | 2 +-
 arch/mips/boot/dts/ingenic/jz4725b.dtsi                       | 2 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi                        | 2 +-
 arch/mips/boot/dts/ingenic/jz4770.dtsi                        | 2 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi                        | 2 +-
 arch/mips/boot/dts/ingenic/x1000.dtsi                         | 2 +-
 arch/mips/boot/dts/ingenic/x1830.dtsi                         | 2 +-
 drivers/clk/ingenic/jz4725b-cgu.c                             | 2 +-
 drivers/clk/ingenic/jz4740-cgu.c                              | 2 +-
 drivers/clk/ingenic/jz4760-cgu.c                              | 2 +-
 drivers/clk/ingenic/jz4770-cgu.c                              | 2 +-
 drivers/clk/ingenic/jz4780-cgu.c                              | 2 +-
 drivers/clk/ingenic/x1000-cgu.c                               | 2 +-
 drivers/clk/ingenic/x1830-cgu.c                               | 2 +-
 .../clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h}            | 0
 .../dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h}  | 0
 .../dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h}  | 0
 .../dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h}  | 0
 .../dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h}  | 0
 include/dt-bindings/clock/{x1000-cgu.h => ingenic,x1000.h}    | 0
 include/dt-bindings/clock/{x1830-cgu.h => ingenic,x1830.h}    | 0
 42 files changed, 36 insertions(+), 36 deletions(-)
 rename include/dt-bindings/clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h} (100%)
 rename include/dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h} (100%)
 rename include/dt-bindings/clock/{x1000-cgu.h => ingenic,x1000.h} (100%)
 rename include/dt-bindings/clock/{x1830-cgu.h => ingenic,x1830.h} (100%)

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 6e80dbc8b8b9..aa1df03ef4a6 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -104,7 +104,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4770-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4770-cgu.h>
     cgu: clock-controller@10000000 {
       compatible = "ingenic,jz4770-cgu", "simple-mfd";
       reg = <0x10000000 0x100>;
diff --git a/Documentation/devicetree/bindings/display/ingenic,ipu.yaml b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
index e679f48a3886..3f93def2c5a2 100644
--- a/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
+++ b/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
@@ -45,7 +45,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4770-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4770-cgu.h>
     ipu@13080000 {
       compatible = "ingenic,jz4770-ipu", "ingenic,jz4760-ipu";
       reg = <0x13080000 0x800>;
diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.yaml b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
index 50d2b0a50e8a..0049010b37ca 100644
--- a/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
@@ -88,7 +88,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     lcd-controller@13050000 {
       compatible = "ingenic,jz4740-lcd";
       reg = <0x13050000 0x1000>;
@@ -107,7 +107,7 @@ examples:
     };
 
   - |
-    #include <dt-bindings/clock/jz4725b-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4725b-cgu.h>
     lcd-controller@13050000 {
       compatible = "ingenic,jz4725b-lcd";
       reg = <0x13050000 0x1000>;
diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index ac4d59494fc8..dc059d6fd037 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -68,7 +68,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     dma: dma-controller@13420000 {
       compatible = "ingenic,jz4780-dma";
       reg = <0x13420000 0x400>, <0x13421000 0x40>;
diff --git a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
index e1e65eb4f795..febde6cc5f69 100644
--- a/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
@@ -60,7 +60,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     #include <dt-bindings/dma/jz4780-dma.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     i2c@10054000 {
diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
index 3eb7aa8822c3..698beb896f76 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -74,7 +74,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     #include <dt-bindings/iio/adc/ingenic,adc.h>
 
     adc@10070000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index fe0ce191a851..24f9e1982028 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -84,7 +84,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     #include <dt-bindings/gpio/gpio.h>
     nemc: memory-controller@13410000 {
       compatible = "ingenic,jz4780-nemc";
diff --git a/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
index 6df1a9470d8f..b7e7fa715437 100644
--- a/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
+++ b/Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
@@ -44,7 +44,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
 
     cpus {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
index 546480f41141..01d5c6da0eeb 100644
--- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
@@ -61,7 +61,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     #include <dt-bindings/dma/jz4780-dma.h>
     mmc0: mmc@13450000 {
       compatible = "ingenic,jz4780-mmc";
diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index 89aa3ceda592..9de8ef6e59ca 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -55,7 +55,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     memory-controller@13410000 {
       compatible = "ingenic,jz4780-nemc";
       reg = <0x13410000 0x10000>;
diff --git a/Documentation/devicetree/bindings/net/ingenic,mac.yaml b/Documentation/devicetree/bindings/net/ingenic,mac.yaml
index d08a88125a5c..8e52b2e683b8 100644
--- a/Documentation/devicetree/bindings/net/ingenic,mac.yaml
+++ b/Documentation/devicetree/bindings/net/ingenic,mac.yaml
@@ -58,7 +58,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/x1000-cgu.h>
+    #include <dt-bindings/clock/ingenic,x1000-cgu.h>
 
     mac: ethernet@134b0000 {
         compatible = "ingenic,x1000-mac";
diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
index 1485d3fbabfd..bf84768228f5 100644
--- a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
@@ -33,7 +33,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
 
     efuse@134100d0 {
         compatible = "ingenic,jz4780-efuse";
diff --git a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
index 0fd93d71fe5a..5cab21648632 100644
--- a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
+++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
@@ -46,7 +46,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4770-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4770-cgu.h>
     otg_phy: usb-phy@3c {
       compatible = "ingenic,jz4770-phy";
       reg = <0x3c 0x10>;
diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
index d0aa91bbf5e5..aaaaabad46ea 100644
--- a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
@@ -58,7 +58,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4770-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4770-cgu.h>
 
     vpu: video-decoder@132a0000 {
       compatible = "ingenic,jz4770-vpu-rproc";
diff --git a/Documentation/devicetree/bindings/rng/ingenic,trng.yaml b/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
index 808f247c8421..044d9a065650 100644
--- a/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
+++ b/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
@@ -32,7 +32,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/x1830-cgu.h>
+    #include <dt-bindings/clock/ingenic,x1830-cgu.h>
 
     dtrng: trng@10072000 {
         compatible = "ingenic,x1830-dtrng";
diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
index 60e93e86ad9d..b235b2441997 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
@@ -72,7 +72,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     rtc_dev: rtc@10003000 {
       compatible = "ingenic,jz4740-rtc";
       reg = <0x10003000 0x40>;
diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index b432d4dff730..9ca7a18ecd8b 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -71,7 +71,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4780-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
     #include <dt-bindings/dma/jz4780-dma.h>
     #include <dt-bindings/gpio/gpio.h>
     serial@10032000 {
diff --git a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
index cdc0fdaab30a..d607325f2f15 100644
--- a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
+++ b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
@@ -71,7 +71,7 @@ required:
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     aic: audio-controller@10020000 {
       compatible = "ingenic,jz4740-i2s";
       reg = <0x10020000 0x38>;
diff --git a/Documentation/devicetree/bindings/sound/ingenic,codec.yaml b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
index 97d5f3819b27..48aae54dd643 100644
--- a/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
+++ b/Documentation/devicetree/bindings/sound/ingenic,codec.yaml
@@ -48,7 +48,7 @@ required:
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     codec: audio-codec@10020080 {
       compatible = "ingenic,jz4740-codec";
       reg = <0x10020080 0x8>;
diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index df3eb76045e0..98648bf9e151 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -46,7 +46,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/x1000-cgu.h>
+    #include <dt-bindings/clock/ingenic,x1000-cgu.h>
 
     ost: timer@12000000 {
         compatible = "ingenic,x1000-ost";
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index 8165df4599cf..7fb37eae9da7 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -237,7 +237,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4770-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4770-cgu.h>
     #include <dt-bindings/clock/ingenic,tcu.h>
     tcu: timer@10002000 {
       compatible = "ingenic,jz4770-tcu", "ingenic,jz4760-tcu", "simple-mfd";
diff --git a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
index f506225a4d57..59212358fcce 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
+++ b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
@@ -58,7 +58,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/clock/ingenic,jz4740-cgu.h>
     usb_phy: usb-phy {
       compatible = "usb-nop-xceiv";
       #phy-cells = <0>;
diff --git a/arch/mips/boot/dts/ingenic/jz4725b.dtsi b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
index a1f0b71c9223..0c6a5a4266f4 100644
--- a/arch/mips/boot/dts/ingenic/jz4725b.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/clock/jz4725b-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4725b-cgu.h>
 #include <dt-bindings/clock/ingenic,tcu.h>
 
 / {
diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index c1afdfdaa8a3..772542e1f266 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/clock/jz4740-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4740-cgu.h>
 #include <dt-bindings/clock/ingenic,tcu.h>
 
 / {
diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index 05c00b93088e..dfe74328ae5d 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4770-cgu.h>
 #include <dt-bindings/clock/ingenic,tcu.h>
 
 / {
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9e34f433b9b5..72032080e701 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4780-cgu.h>
 #include <dt-bindings/clock/ingenic,tcu.h>
 #include <dt-bindings/dma/jz4780-dma.h>
 
diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index dec7909d4baa..8bd27edef216 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/ingenic,tcu.h>
-#include <dt-bindings/clock/x1000-cgu.h>
+#include <dt-bindings/clock/ingenic,x1000-cgu.h>
 #include <dt-bindings/dma/x1000-dma.h>
 
 / {
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index 215257f8bb1a..2595df8671c7 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/ingenic,tcu.h>
-#include <dt-bindings/clock/x1830-cgu.h>
+#include <dt-bindings/clock/ingenic,x1830-cgu.h>
 #include <dt-bindings/dma/x1830-dma.h>
 
 / {
diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 5154b0cf8ad6..744d136b721b 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/jz4725b-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4725b-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index cd878f08aca3..43ffb62c42bb 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/jz4740-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4740-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 14483797a4db..080d492ac95c 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -12,7 +12,7 @@
 
 #include <linux/clk.h>
 
-#include <dt-bindings/clock/jz4760-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4760-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 2321742b3471..8c6c1208f462 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4770-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 0268d23ebe2e..e357c228e0f1 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -13,7 +13,7 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/clock/ingenic,jz4780-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 9aa20b52e1c3..3c4d5a77ccbd 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/x1000-cgu.h>
+#include <dt-bindings/clock/ingenic,x1000-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index 950aee243364..e01ec2dc7a1a 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <dt-bindings/clock/x1830-cgu.h>
+#include <dt-bindings/clock/ingenic,x1830-cgu.h>
 
 #include "cgu.h"
 #include "pm.h"
diff --git a/include/dt-bindings/clock/jz4725b-cgu.h b/include/dt-bindings/clock/ingenic,jz4725b-cgu.h
similarity index 100%
rename from include/dt-bindings/clock/jz4725b-cgu.h
rename to include/dt-bindings/clock/ingenic,jz4725b-cgu.h
diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/ingenic,jz4740-cgu.h
similarity index 100%
rename from include/dt-bindings/clock/jz4740-cgu.h
rename to include/dt-bindings/clock/ingenic,jz4740-cgu.h
diff --git a/include/dt-bindings/clock/jz4760-cgu.h b/include/dt-bindings/clock/ingenic,jz4760-cgu.h
similarity index 100%
rename from include/dt-bindings/clock/jz4760-cgu.h
rename to include/dt-bindings/clock/ingenic,jz4760-cgu.h
diff --git a/include/dt-bindings/clock/jz4770-cgu.h b/include/dt-bindings/clock/ingenic,jz4770-cgu.h
similarity index 100%
rename from include/dt-bindings/clock/jz4770-cgu.h
rename to include/dt-bindings/clock/ingenic,jz4770-cgu.h
diff --git a/include/dt-bindings/clock/jz4780-cgu.h b/include/dt-bindings/clock/ingenic,jz4780-cgu.h
similarity index 100%
rename from include/dt-bindings/clock/jz4780-cgu.h
rename to include/dt-bindings/clock/ingenic,jz4780-cgu.h
diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/ingenic,x1000.h
similarity index 100%
rename from include/dt-bindings/clock/x1000-cgu.h
rename to include/dt-bindings/clock/ingenic,x1000.h
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/ingenic,x1830.h
similarity index 100%
rename from include/dt-bindings/clock/x1830-cgu.h
rename to include/dt-bindings/clock/ingenic,x1830.h
-- 
2.33.0

