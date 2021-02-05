Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A53117D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBFAbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhBELlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39372C0613D6;
        Fri,  5 Feb 2021 03:40:32 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id sa23so11536249ejb.0;
        Fri, 05 Feb 2021 03:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bP2TkjSLtuteWO1JClrvBULCopI78AgBBGVLp8X9jmQ=;
        b=WbEmw6/Vz1nLwAr+gdpAGswlyFhuvsApUtNAtIHCywpR0lXlNSV5ptZ8ME15lFgBFg
         zf9D2AP4+XBGWTGiIoIy6SZS2rHIrcTAiCekzUdSJVAPzOEVrTAJvKw8Weuef3bGmZrf
         BW38RM2o9HeAcvj4ky7bGvc5vMAOxKpHi4GYAwM0NyVn6Tpn4elFm2BZbbIQ1F0cERbK
         0as3Q1QsZpMY6lWX1ERV+JN4PY2BzhHI2ZSqY9mQ+jfFZKgcYMjS4l+p16tGCUdhspzx
         jBYUk9npifoO2jlbouI2ezr+lfz17A3YlcYaBAIMe/lZ5kTbV0NQ8htPVIQ+Rs1r+tM9
         Xclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bP2TkjSLtuteWO1JClrvBULCopI78AgBBGVLp8X9jmQ=;
        b=WCmEwMFk8Xx1dPk+eAdENu72NkmA/70igcj4l1gKKAfSI99k/IQhqrkXdY+DmESwVf
         lV/3lbyH6+VpAdymMWXHCsCPhN/A1+fgQzHsEHuGfwPV1NXMmM2v2oS5hXhmC/hFe4Zy
         cil1U3B5Ry9Hw8FQzIrN3zAalHxN0JUabDGvT0rBMGj9jml9ITRFBRlRXE4ET2xHvOkp
         61LFBs8hzNdY1BjMg32VHzbMVRNNMwA8eqnkekI4WW1apa4/R6UXmhNfoFDoF8lxrMNt
         BlLSsO1729RhEdKFD71VPwnWeXKQf75PB+t8x8O5Hh+Puv6/8bSX5+FhWDvT1iNTauZZ
         dTzg==
X-Gm-Message-State: AOAM532UXGKydeheVi4bmgsePVLU41jLsRYAbp0oaR29ewqyY6WosMJ9
        ovLYI8jLVZi9cWfo1t9vBMsmt/ZocsQ=
X-Google-Smtp-Source: ABdhPJy/0oDDNoKhXjsHBRIgx9GxBumXkGJoHcm/SEzx/UU3FS4jUNO9ItogkKaDjPFYZ1s9S4xg6g==
X-Received: by 2002:a17:906:f2ca:: with SMTP id gz10mr3523918ejb.285.1612525230965;
        Fri, 05 Feb 2021 03:40:30 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Fri,  5 Feb 2021 12:40:04 +0100
Message-Id: <20210205114011.10381-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past Rockchip dwc3 usb nodes were manually checked.
With the conversion of snps,dwc3.yaml as common document
we now can convert rockchip,dwc3.txt to yaml as well.
Remove node wrapper.

Added properties for rk3399 are:
  power-domains
  resets
  reset-names

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V3:
  remove aclk_usb3_rksoc_axi_perf
  remove aclk_usb3

Changed V2:
  remove node wrapper
---
 .../devicetree/bindings/usb/rockchip,dwc3.txt      | 56 -------------
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 95 ++++++++++++++++++++++
 2 files changed, 95 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
deleted file mode 100644
index 945204932..000000000
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Rockchip SuperSpeed DWC3 USB SoC controller
-
-Required properties:
-- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
-- clocks:	A list of phandle + clock-specifier pairs for the
-		clocks listed in clock-names
-- clock-names:	Should contain the following:
-  "ref_clk"	Controller reference clk, have to be 24 MHz
-  "suspend_clk"	Controller suspend clk, have to be 24 MHz or 32 KHz
-  "bus_clk"	Master/Core clock, have to be >= 62.5 MHz for SS
-		operation and >= 30MHz for HS operation
-  "grf_clk"	Controller grf clk
-
-Required child node:
-A child node must exist to represent the core DWC3 IP block. The name of
-the node is not important. The content of the node is defined in dwc3.txt.
-
-Phy documentation is provided in the following places:
-Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml - USB2.0 PHY
-Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     - Type-C PHY
-
-Example device nodes:
-
-	usbdrd3_0: usb@fe800000 {
-		compatible = "rockchip,rk3399-dwc3";
-		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
-			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
-		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		usbdrd_dwc3_0: dwc3@fe800000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfe800000 0x0 0x100000>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "otg";
-		};
-	};
-
-	usbdrd3_1: usb@fe900000 {
-		compatible = "rockchip,rk3399-dwc3";
-		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
-			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
-		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "grf_clk";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		usbdrd_dwc3_1: dwc3@fe900000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfe900000 0x0 0x100000>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-			dr_mode = "otg";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
new file mode 100644
index 000000000..d815aacfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/rockchip,dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  The common content of the node is defined in snps,dwc3.yaml.
+
+  Phy documentation is provided in the following places.
+
+  USB2.0 PHY
+  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+
+  Type-C PHY
+  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - rockchip,rk3399-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description:
+          Controller reference clock, must to be 24 MHz
+      - description:
+          Controller suspend clock, must to be 24 MHz or 32 KHz
+      - description:
+          Master/Core clock, must to be >= 62.5 MHz for SS
+          operation and >= 30MHz for HS operation
+      - description:
+          Controller grf clock
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: suspend_clk
+      - const: bus_clk
+      - const: grf_clk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: usb3-otg
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      usbdrd3_0: usb@fe800000 {
+        compatible = "rockchip,rk3399-dwc3", "snps,dwc3";
+        reg = <0x0 0xfe800000 0x0 0x100000>;
+        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
+        clock-names = "ref_clk", "suspend_clk",
+                      "bus_clk", "grf_clk";
+        dr_mode = "otg";
+      };
+    };
-- 
2.11.0

