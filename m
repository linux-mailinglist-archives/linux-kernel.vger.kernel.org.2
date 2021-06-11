Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F83A443C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhFKOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:41:53 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:45761 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFKOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:41:45 -0400
Received: by mail-ej1-f51.google.com with SMTP id k7so4878948ejv.12;
        Fri, 11 Jun 2021 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nmqEyZ54OhBEBBcmee1UQUHGUD3d/Q2BaAjXAvBAmL4=;
        b=oF7Q52AmnrNW3h7eE8bn8PCuawjlbs/jANnH2QJoPQvv8LXVjXKlHW/r5iDtV/FgPn
         bqRGzkUChtDPIvdClRe6FUgMXvQ/35ZHIXSsLnakzLhN9gFKvCltOG6thG6h5SZX03MS
         rZGdxaI2GourazTZIDrA+9SjStnBYsPf/1P6ThowHACqOA0x2FJLTQxCHHf+44delUkl
         TaObxQf2GZdf2KAeNJeEJg/IBmUcMP6+yv1AduVWNT9rbk3kDycqxw2Vt5KOhBHe+33m
         HGacNCm6k/qt2V7GLRur6wk8rSivFMCG7ude2mCAjHw3TIY6gN8rdOKawiqOM3EkFJeW
         tDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nmqEyZ54OhBEBBcmee1UQUHGUD3d/Q2BaAjXAvBAmL4=;
        b=OokRuU8RTctAUQMETsdGxJ/LjHEPMuhS6Oes5Bqa6uROgrhRNgR6y/xLx1pIQ1kk0d
         yg3NotR5rm8chiySDbvy02W2BkWXcviHNv65OsPW6qAzsHDJu3igh63oTmjGCRAaUKtL
         p+tH0Z83JGpYxBopf7Jk/sk/pw6kDAO4ktlUYlOjKZjcaAP1pSfuTh0h1L8fUGnmOhdC
         LsjVbCtZg8hInf94b4yzmHpj9FWPdADyRjm/YcRaHKmV7PD8HhpFMchDVxrFeO0C1bmi
         2/wRy/ApXxkxYdvTE9cI0hJBvP1BKp+LOg9iXjlh7c7w0nWy4dSubVKzdSMb9Vl9X0Ei
         kmcg==
X-Gm-Message-State: AOAM531nZ1qjRi6A9ayCwA7I3tlgJ4K+k6XPJZKLYTy64zMji2RC9kqP
        D5CqZNLhaIjbG+vS1sfkxOY=
X-Google-Smtp-Source: ABdhPJzDgsnOya7kTkH2szRwT6iyZmhySb3b/GJphFmkFbtqxBMV4vNTMk7T6q5yjfss2qZKMq+f5Q==
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr4038897ejc.387.1623422312278;
        Fri, 11 Jun 2021 07:38:32 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p14sm2671008eds.19.2021.06.11.07.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:38:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/3] dt-bindings: power: convert rockchip-io-domain.txt to YAML
Date:   Fri, 11 Jun 2021 16:38:19 +0200
Message-Id: <20210611143821.13057-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'io-domains' nodes are manually verified.
In order to automate this process rockchip-io-domain.txt has to be
converted to YAML.

Changed:
  Add supply properties for:
    rockchip,rk3328-io-voltage-domain
    rockchip,rv1108-io-voltage-domain
    rockchip,rv1108-pmu-io-voltage-domain

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Due to the lack of a rv1108 TRM changes
to grf.yaml or rv1108.dtsi not verified.

---

Note for rob+dt:

The driver is located in:
drivers/soc/rockchip/io-domain.c

The document is located in:
Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

Is that still OK or should we move to:
/Documentation/devicetree/bindings/soc/rockchip/rockchip-io-domain.yaml

===

This document is not able to correctly check for bogus properties.
Adding more [additionalProperties: false] to [then:] gives warnings like this:
('status', 'compatible', '$nodename' were unexpected)
Is there a way to do that in one document?
---
 .../bindings/power/rockchip-io-domain.txt          | 135 ---------
 .../bindings/power/rockchip-io-domain.yaml         | 307 +++++++++++++++++++++
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  18 +-
 3 files changed, 319 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
deleted file mode 100644
index e66fd4eab..000000000
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-Rockchip SRAM for IO Voltage Domains:
--------------------------------------
-
-IO domain voltages on some Rockchip SoCs are variable but need to be
-kept in sync between the regulators and the SoC using a special
-register.
-
-A specific example using rk3288:
-- If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
-  bit 7 of GRF_IO_VSEL needs to be 0.  If the regulator hooked up to
-  that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.
-
-Said another way, this driver simply handles keeping bits in the SoC's
-general register file (GRF) in sync with the actual value of a voltage
-hooked up to the pins.
-
-Note that this driver specifically doesn't include:
-- any logic for deciding what voltage we should set regulators to
-- any logic for deciding whether regulators (or internal SoC blocks)
-  should have power or not have power
-
-If there were some other software that had the smarts of making
-decisions about regulators, it would work in conjunction with this
-driver.  When that other software adjusted a regulator's voltage then
-this driver would handle telling the SoC about it.  A good example is
-vqmmc for SD.  In that case the dw_mmc driver simply is told about a
-regulator.  It changes the regulator between 3.3V and 1.8V at the
-right time.  This driver notices the change and makes sure that the
-SoC is on the same page.
-
-
-Required properties:
-- compatible: should be one of:
-  - "rockchip,px30-io-voltage-domain" for px30
-  - "rockchip,px30-pmu-io-voltage-domain" for px30 pmu-domains
-  - "rockchip,rk3188-io-voltage-domain" for rk3188
-  - "rockchip,rk3228-io-voltage-domain" for rk3228
-  - "rockchip,rk3288-io-voltage-domain" for rk3288
-  - "rockchip,rk3328-io-voltage-domain" for rk3328
-  - "rockchip,rk3368-io-voltage-domain" for rk3368
-  - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
-  - "rockchip,rk3399-io-voltage-domain" for rk3399
-  - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
-  - "rockchip,rv1108-io-voltage-domain" for rv1108
-  - "rockchip,rv1108-pmu-io-voltage-domain" for rv1108 pmu-domains
-
-Deprecated properties:
-- rockchip,grf: phandle to the syscon managing the "general register files"
-    Systems should move the io-domains to a sub-node of the grf simple-mfd.
-
-You specify supplies using the standard regulator bindings by including
-a phandle the relevant regulator.  All specified supplies must be able
-to report their voltage.  The IO Voltage Domain for any non-specified
-supplies will be not be touched.
-
-Possible supplies for PX30:
-- vccio6-supply: The supply connected to VCCIO6.
-- vccio1-supply: The supply connected to VCCIO1.
-- vccio2-supply: The supply connected to VCCIO2.
-- vccio3-supply: The supply connected to VCCIO3.
-- vccio4-supply: The supply connected to VCCIO4.
-- vccio5-supply: The supply connected to VCCIO5.
-- vccio-oscgpi-supply: The supply connected to VCCIO_OSCGPI.
-
-Possible supplies for PX30 pmu-domains:
-- pmuio1-supply: The supply connected to PMUIO1.
-- pmuio2-supply: The supply connected to PMUIO2.
-
-Possible supplies for rk3188:
-- ap0-supply:    The supply connected to AP0_VCC.
-- ap1-supply:    The supply connected to AP1_VCC.
-- cif-supply:    The supply connected to CIF_VCC.
-- flash-supply:  The supply connected to FLASH_VCC.
-- lcdc0-supply:  The supply connected to LCD0_VCC.
-- lcdc1-supply:  The supply connected to LCD1_VCC.
-- vccio0-supply: The supply connected to VCCIO0.
-- vccio1-supply: The supply connected to VCCIO1.
-                 Sometimes also labeled VCCIO1 and VCCIO2.
-
-Possible supplies for rk3228:
-- vccio1-supply: The supply connected to VCCIO1.
-- vccio2-supply: The supply connected to VCCIO2.
-- vccio3-supply: The supply connected to VCCIO3.
-- vccio4-supply: The supply connected to VCCIO4.
-
-Possible supplies for rk3288:
-- audio-supply:  The supply connected to APIO4_VDD.
-- bb-supply:     The supply connected to APIO5_VDD.
-- dvp-supply:    The supply connected to DVPIO_VDD.
-- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eMMC
-- flash1-supply: The supply connected to FLASH1_VDD.  Also known as SDIO1.
-- gpio30-supply: The supply connected to APIO1_VDD.
-- gpio1830       The supply connected to APIO2_VDD.
-- lcdc-supply:   The supply connected to LCDC_VDD.
-- sdcard-supply: The supply connected to SDMMC0_VDD.
-- wifi-supply:   The supply connected to APIO3_VDD.  Also known as SDIO0.
-
-Possible supplies for rk3368:
-- audio-supply:  The supply connected to APIO3_VDD.
-- dvp-supply:    The supply connected to DVPIO_VDD.
-- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eMMC
-- gpio30-supply: The supply connected to APIO1_VDD.
-- gpio1830       The supply connected to APIO4_VDD.
-- sdcard-supply: The supply connected to SDMMC0_VDD.
-- wifi-supply:   The supply connected to APIO2_VDD.  Also known as SDIO0.
-
-Possible supplies for rk3368 pmu-domains:
-- pmu-supply:    The supply connected to PMUIO_VDD.
-- vop-supply:    The supply connected to LCDC_VDD.
-
-Possible supplies for rk3399:
-- bt656-supply:  The supply connected to APIO2_VDD.
-- audio-supply:  The supply connected to APIO5_VDD.
-- sdmmc-supply:  The supply connected to SDMMC0_VDD.
-- gpio1830       The supply connected to APIO4_VDD.
-
-Possible supplies for rk3399 pmu-domains:
-- pmu1830-supply:The supply connected to PMUIO2_VDD.
-
-Example:
-
-	io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcc18_codec>;
-		bb-supply = <&vcc33_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc18_flashio>;
-		gpio1830-supply = <&vcc33_io>;
-		gpio30-supply = <&vcc33_pmuio>;
-		lcdc-supply = <&vcc33_lcd>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vcc18_wl>;
-	};
diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
new file mode 100644
index 000000000..3d47ad3ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
@@ -0,0 +1,307 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/rockchip-io-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SRAM for IO Voltage Domains
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  IO domain voltages on some Rockchip SoCs are variable but need to be
+  kept in sync between the regulators and the SoC using a special
+  register.
+
+  A specific example using rk3288
+    If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
+    bit 7 of GRF_IO_VSEL needs to be 0. If the regulator hooked up to
+    that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.
+
+  Said another way, this driver simply handles keeping bits in the SoCs
+  General Register File (GRF) in sync with the actual value of a voltage
+  hooked up to the pins.
+
+  Note that this driver specifically does not include
+    any logic for deciding what voltage we should set regulators to
+    any logic for deciding whether regulators (or internal SoC blocks)
+    should have power or not have power
+
+  If there were some other software that had the smarts of making
+  decisions about regulators, it would work in conjunction with this
+  driver. When that other software adjusted a regulators voltage then
+  this driver would handle telling the SoC about it. A good example is
+  vqmmc for SD. In that case the dw_mmc driver simply is told about a
+  regulator. It changes the regulator between 3.3V and 1.8V at the
+  right time. This driver notices the change and makes sure that the
+  SoC is on the same page.
+
+  You specify supplies using the standard regulator bindings by including
+  a phandle the relevant regulator. All specified supplies must be able
+  to report their voltage. The IO Voltage Domain for any non-specified
+  supplies will be not be touched.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-io-voltage-domain
+      - rockchip,px30-pmu-io-voltage-domain
+      - rockchip,rk3188-io-voltage-domain
+      - rockchip,rk3228-io-voltage-domain
+      - rockchip,rk3288-io-voltage-domain
+      - rockchip,rk3328-io-voltage-domain
+      - rockchip,rk3368-io-voltage-domain
+      - rockchip,rk3368-pmu-io-voltage-domain
+      - rockchip,rk3399-io-voltage-domain
+      - rockchip,rk3399-pmu-io-voltage-domain
+      - rockchip,rv1108-io-voltage-domain
+      - rockchip,rv1108-pmu-io-voltage-domain
+
+required:
+  - compatible
+
+patternProperties:
+  ".*-supply$": true
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,px30-io-voltage-domain
+
+    then:
+      properties:
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio4-supply:
+          description: The supply connected to VCCIO4.
+        vccio5-supply:
+          description: The supply connected to VCCIO5.
+        vccio6-supply:
+          description: The supply connected to VCCIO6.
+        vccio-oscgpi-supply:
+          description: The supply connected to VCCIO_OSCGPI.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,px30-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmuio1-supply:
+          description: The supply connected to PMUIO1.
+        pmuio2-supply:
+          description: The supply connected to PMUIO2.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3188-io-voltage-domain
+
+    then:
+      properties:
+        ap0-supply:
+          description: The supply connected to AP0_VCC.
+        ap1-supply:
+          description: The supply connected to AP1_VCC.
+        cif-supply:
+          description: The supply connected to CIF_VCC.
+        flash-supply:
+          description: The supply connected to FLASH_VCC.
+        lcdc0-supply:
+          description: The supply connected to LCD0_VCC.
+        lcdc1-supply:
+          description: The supply connected to LCD1_VCC.
+        vccio0-supply:
+          description: The supply connected to VCCIO0.
+        vccio1-supply:
+          description: The supply connected to VCCIO1. Also labeled as VCCIO2.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3228-io-voltage-domain
+
+    then:
+      properties:
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio4-supply:
+          description: The supply connected to VCCIO4.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-io-voltage-domain
+
+    then:
+      properties:
+        audio-supply:
+          description: The supply connected to APIO4_VDD.
+        bb-supply:
+          description: The supply connected to APIO5_VDD.
+        dvp-supply:
+          description: The supply connected to DVPIO_VDD.
+        flash0-supply:
+          description: The supply connected to FLASH0_VDD. Typically for eMMC.
+        flash1-supply:
+          description: The supply connected to FLASH1_VDD. Also known as SDIO1.
+        gpio30-supply:
+          description: The supply connected to APIO1_VDD.
+        gpio1830-supply:
+          description: The supply connected to APIO2_VDD.
+        lcdc-supply:
+          description: The supply connected to LCDC_VDD.
+        sdcard-supply:
+          description: The supply connected to SDMMC0_VDD.
+        wifi-supply:
+          description: The supply connected to APIO3_VDD. Also known as SDIO0.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-io-voltage-domain
+
+    then:
+      properties:
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio4-supply:
+          description: The supply connected to VCCIO4.
+        vccio5-supply:
+          description: The supply connected to VCCIO5.
+        vccio6-supply:
+          description: The supply connected to VCCIO6.
+        pmuio-supply:
+          description: The supply connected to PMUIO.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3368-io-voltage-domain
+
+    then:
+      properties:
+        audio-supply:
+          description: The supply connected to APIO3_VDD.
+        dvp-supply:
+          description: The supply connected to DVPIO_VDD.
+        flash0-supply:
+          description: The supply connected to FLASH0_VDD. Typically for eMMC.
+        gpio30-supply:
+          description: The supply connected to APIO1_VDD.
+        gpio1830-supply:
+          description: The supply connected to APIO4_VDD.
+        sdcard-supply:
+          description: The supply connected to SDMMC0_VDD.
+        wifi-supply:
+          description: The supply connected to APIO2_VDD. Also known as SDIO0.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3368-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmu-supply:
+          description: The supply connected to PMUIO_VDD.
+        vop-supply:
+          description: The supply connected to LCDC_VDD.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-io-voltage-domain
+
+    then:
+      properties:
+        audio-supply:
+          description: The supply connected to APIO5_VDD.
+        bt656-supply:
+          description: The supply connected to APIO2_VDD.
+        gpio1830-supply:
+          description: The supply connected to APIO4_VDD.
+        sdmmc-supply:
+          description: The supply connected to SDMMC0_VDD.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmu1830-supply:
+          description: The supply connected to PMUIO2_VDD.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rv1108-io-voltage-domain
+
+    then:
+      properties:
+        vccio1-supply:
+          description: The supply connected to VCCIO1.
+        vccio2-supply:
+          description: The supply connected to VCCIO2.
+        vccio3-supply:
+          description: The supply connected to VCCIO3.
+        vccio5-supply:
+          description: The supply connected to VCCIO5.
+        vccio6-supply:
+          description: The supply connected to VCCIO6.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rv1108-pmu-io-voltage-domain
+
+    then:
+      properties:
+        pmu-supply:
+          description: The supply connected to PMUIO.
+
+examples:
+  - |
+    io-domains {
+      compatible = "rockchip,rk3288-io-voltage-domain";
+      audio-supply = <&vcc18_codec>;
+      bb-supply = <&vcc33_io>;
+      dvp-supply = <&vcc_18>;
+      flash0-supply = <&vcc18_flashio>;
+      gpio1830-supply = <&vcc33_io>;
+      gpio30-supply = <&vcc33_pmuio>;
+      lcdc-supply = <&vcc33_lcd>;
+      sdcard-supply = <&vccio_sd>;
+      wifi-supply = <&vcc18_wl>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 62fa72cfe..fa010df51 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,7 +15,6 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
-              - rockchip,rv1108-pmugrf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
@@ -41,6 +40,7 @@ properties:
               - rockchip,rk3568-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
+              - rockchip,rv1108-pmugrf
           - const: syscon
           - const: simple-mfd
 
@@ -198,21 +198,27 @@ allOf:
         compatible:
           contains:
             enum:
-              - rockchip,px30-pmugrf
               - rockchip,px30-grf
+              - rockchip,px30-pmugrf
+              - rockchip,rk3188-grf
               - rockchip,rk3228-grf
               - rockchip,rk3288-grf
               - rockchip,rk3328-grf
-              - rockchip,rk3368-pmugrf
               - rockchip,rk3368-grf
-              - rockchip,rk3399-pmugrf
+              - rockchip,rk3368-pmugrf
               - rockchip,rk3399-grf
+              - rockchip,rk3399-pmugrf
+              - rockchip,rv1108-grf
+              - rockchip,rv1108-pmugrf
 
     then:
       properties:
         io-domains:
-          description:
-            Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+          type: object
+
+          $ref: "/schemas/power/rockchip-io-domain.yaml#"
+
+          unevaluatedProperties: false
 
 examples:
   - |
-- 
2.11.0

