Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143635B266
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhDKISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:18:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50AC061574;
        Sun, 11 Apr 2021 01:18:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6798731wma.0;
        Sun, 11 Apr 2021 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X57lDhMURWtVngLChsKd+Aat/tDZoWBZXkt8crzGoho=;
        b=A957Fjs8czIyVAofI1RQrgAg+Eu0mS9Pz+D5Lp5s/YVDXRSvF9yD1zb6pxPEM+wIfm
         zaWhbIgJqjhf2fsYzjneax/fl3eH71+TGcSrheeMiU1liEZ1tKIsAlFImH8aSUWsOl8R
         fa+98jbe9un2KGonKeg2Vz4PXrLl73Y5DT98q68PDh0mthw9q0GKhR73+eYO6ekN+yTK
         k7eICYHc6fSQ78gzQLgqVFIomQK2XLjyiLw21N/Avi415Ybu+bNN66GlfmSIAdxbOE4O
         ArXVfwrDe1pqn6Pw4Qj9Bub0axFZWVeTFGNGDYCOxG49/tP1d3q1xvnUmXEDJuKsqcLt
         s5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X57lDhMURWtVngLChsKd+Aat/tDZoWBZXkt8crzGoho=;
        b=oO/6Pmt6OsKIE7GuYTji5zwTeRO0pF6nCSpBZYzIvdLeX+ZF4SgxiDC9PU4H8ojJI3
         9+mPXib66l8d8GC/9mA3iuNaUGAsurZvdJfp1SynXJt/YZhTpeSwNeavvKCgnyTWrCVb
         SNqazoV0gIt9bj19OTam6ZU3ANjLAisIJRWuZrXdxmpN9sTK9hBvjul0y8pOKW1qcSur
         STeCMI8B8Ie8+r7QHWB8RzrHuypXvjLjb8HCgzY+sX/hDAQWwR461NjxfhPQR7BAXyLm
         2FpFGqc3dCZl210TW63SNA6xcMPPQhLkNifdgITmF9tlsu3YjzZFXTb9yhETCBwUOtWv
         7x7A==
X-Gm-Message-State: AOAM5306qROeF0kDyqJky8FNiwx+jFB6CvoVA2q+rvsXY3J8MuBFFUn9
        7vvC4NDqLb6qQtcee+TKhnM=
X-Google-Smtp-Source: ABdhPJzspswx48o5UUQ4KnbFd0B047NIe7yNXygDmu7vgsODsEwoBzExb3qFNvrKmM4zIqUWk54+Tw==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr7093032wmi.51.1618129100642;
        Sun, 11 Apr 2021 01:18:20 -0700 (PDT)
Received: from localhost.localdomain (225.red-83-57-119.dynamicip.rima-tde.net. [83.57.119.225])
        by smtp.gmail.com with ESMTPSA id 7sm11539916wry.60.2021.04.11.01.18.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 01:18:20 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pci: dt-bindings: update bindings to yaml format
Date:   Sun, 11 Apr 2021 10:18:18 +0200
Message-Id: <20210411081818.26926-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update bindings for this pci controller according to the current
device tree and driver code and prepare them to be mainlined
porting it to the YAML format.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---

Hi Rob,

Some concerns here. I was not be able to found any case similar to
this binding where sub-nodes describing each pcie port interface
are needed. I added them to the 'examples' directly without saying
nothing about properties in any other place since its properties
seems to be covered in 'pci-bus.yaml' schema definition. I don't
know if this is the way, I have copied them to its correct future
place in Documentation folder and check against schema and I noticed
I am forced to add 'device_type' property in each subnode because
schema checker complains that this is mandatory. So I have added
it and schema is properly being validated:

Before add the 'device_type' in each subnode:
/home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@0,0: 'device_type' is a required property
From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@1,0: 'device_type' is a required property
From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/sergio/staging/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml: pcie@2,0: 'device_type' is a required property
From schema: /home/sergio/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml

After adding it:
CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
DTEX    Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dts
DTC     Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml
CHECK   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.example.dt.yaml

Looks a bit redundant and maybe I am doing somethng wrong...

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos


 .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 -------------
 .../mt7621-pci/mediatek,mt7621-pci.yaml       | 144 ++++++++++++++++++
 2 files changed, 144 insertions(+), 104 deletions(-)
 delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
 create mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml

diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
deleted file mode 100644
index 327a68267309..000000000000
--- a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
+++ /dev/null
@@ -1,104 +0,0 @@
-MediaTek MT7621 PCIe controller
-
-Required properties:
-- compatible: "mediatek,mt7621-pci"
-- device_type: Must be "pci"
-- reg: Base addresses and lengths of the PCIe subsys and root ports.
-- bus-range: Range of bus numbers associated with this controller.
-- #address-cells: Address representation for root ports (must be 3)
-- pinctrl-names : The pin control state names.
-- pinctrl-0: The "default" pinctrl state.
-- #size-cells: Size representation for root ports (must be 2)
-- ranges: Ranges for the PCI memory and I/O regions.
-- #interrupt-cells: Must be 1
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties.
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- status: either "disabled" or "okay".
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
-  root ports.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
-  root ports.
-- reset-gpios: GPIO specs for the reset pins.
-
-In addition, the device tree node must have sub-nodes describing each PCIe port
-interface, having the following mandatory properties:
-
-Required properties:
-- reg: Only the first four bytes are used to refer to the correct bus number
-      and device number.
-- #address-cells: Must be 3
-- #size-cells: Must be 2
-- ranges: Sub-ranges distributed from the PCIe controller node. An empty
-  property is sufficient.
-- bus-range: Range of bus numbers associated with this port.
-
-Example for MT7621:
-
-	pcie: pcie@1e140000 {
-		compatible = "mediatek,mt7621-pci";
-        reg = <0x1e140000 0x100    /* host-pci bridge registers */
-               0x1e142000 0x100    /* pcie port 0 RC control registers */
-               0x1e143000 0x100    /* pcie port 1 RC control registers */
-               0x1e144000 0x100>;  /* pcie port 2 RC control registers */
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_pins>;
-
-		device_type = "pci";
-
-		bus-range = <0 255>;
-		ranges = <
-			0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
-			0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
-		>;
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xF0000 0 0 1>;
-		interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
-				<0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
-				<0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-
-		status = "disabled";
-
-		resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
-		reset-names = "pcie0", "pcie1", "pcie2";
-		clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
-		clock-names = "pcie0", "pcie1", "pcie2";
-
-		reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>,
-				<&gpio 8 GPIO_ACTIVE_LOW>,
-				<&gpio 7 GPIO_ACTIVE_LOW>;
-
-		pcie@0,0 {
-			reg = <0x0000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-
-		pcie@1,0 {
-			reg = <0x0800 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-
-		pcie@2,0 {
-			reg = <0x1000 0 0 0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-			bus-range = <0x00 0xff>;
-		};
-	};
-
diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml
new file mode 100644
index 000000000000..9c1d05d929a2
--- /dev/null
+++ b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7621 PCIe controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |+
+  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
+  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt7621-pci
+
+  reg:
+    items:
+      - description: host-pci bridge registers
+      - description: pcie port 0 RC control registers
+      - description: pcie port 1 RC control registers
+      - description: pcie port 2 RC control registers
+
+  ranges:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 3
+
+  resets:
+    items:
+      - description: pcie port 0 reset.
+      - description: pcie port 1 reset.
+      - description: pcie port 2 reset.
+
+  reset-names:
+    items:
+      - const: pcie0
+      - const: pcie1
+      - const: pcie2
+
+  clocks:
+    items:
+      - description: pcie port 0 clock.
+      - description: pcie port 1 clock.
+      - description: pcie port 2 clock.
+
+  clock-names:
+    items:
+      - const: pcie0
+      - const: pcie1
+      - const: pcie2
+
+  phys:
+    items:
+      - description: Dual-ported phy for pcie port 0 and 1.
+      - description: Phy for pcie port 2.
+
+  phy-names:
+    items:
+      - const: pcie-phy0
+      - const: pcie-phy2
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - interrupts
+  - resets
+  - reset-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    pcie: pcie@1e140000 {
+        compatible = "mediatek,mt7621-pci";
+        reg = <0x1e140000 0x100>,
+              <0x1e142000 0x100>,
+              <0x1e143000 0x100>,
+              <0x1e144000 0x100>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie_pins>;
+        device_type = "pci";
+        bus-range = <0 255>;
+        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
+                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
+        reset-names = "pcie0", "pcie1", "pcie2";
+        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
+        clock-names = "pcie0", "pcie1", "pcie2";
+        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
+        phy-names = "pcie-phy0", "pcie-phy2";
+        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+
+        pcie@0,0 {
+            reg = <0x0000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges;
+            bus-range = <0x00 0xff>;
+        };
+
+        pcie@1,0 {
+            reg = <0x0800 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges;
+            bus-range = <0x00 0xff>;
+        };
+
+        pcie@2,0 {
+            reg = <0x1000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges;
+            bus-range = <0x00 0xff>;
+        };
+    };
+...
-- 
2.25.1

