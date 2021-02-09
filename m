Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7F315B68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhBJAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhBIUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:39:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF36C061226;
        Tue,  9 Feb 2021 11:24:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l12so25372909edt.3;
        Tue, 09 Feb 2021 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4V4/+26zsQZ2u3jORNUZoR6RaMNMYHKRgtZ7++gnTVQ=;
        b=RlOyEWxUPx0hNNFrJ0DkMvgTbdW7WTaT3poNpKaI9Y2zrsbpPA1suK7o1EYyi+D3gP
         efpqeMF12k6rLTGoNZcCijq/qJx6dX2c+XI5KjlFAQT7ynvz1vzw1hw0tr6tXCBnmMZ0
         G2W+0zXQoYhg/sFualou4xb0fRIHP7zSCRqSgIcP4dIAU9IZxAxgasYmAOjuD9eD2+c+
         6nd2janVOktg+K5+tkjJ5czP8tnrK5e3v07bLzzfQs/uMbl+v4tSWt9E2xrE3eaRVTVf
         dF1PmYNSdl+3Ak9X+Vc4plaGBw61haTZmSHcQEyMbxqDXUcXaLyZbt33SQBX5Gpz4TyN
         4NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4V4/+26zsQZ2u3jORNUZoR6RaMNMYHKRgtZ7++gnTVQ=;
        b=DCb1sLMlTfmJs7B3Fl7Pnb95rY/tlCGn9FZTKr9TSqideOjLJ7fX0dFcpsNl49kHoy
         KjDAn1bk4GJW69Zv/eIhI4ViM5T3zfOu+u5zhXfY9H2y9/y7WkzylYtD3Kpb0ohgSSPj
         B/0FZpHxO9NmjCo/otdt2h7iitPuaerKkjZU608PEj4VXtsyvhm0Mwv/LVcL+OyTmAqO
         BRwGE55wNJiwxK+T3Y0kCQ2W3sBv536yiRX4UlpYKCKff8uUyX+G5pRVaHIF9lN/qI9J
         Sbm+KWZBtWC4IEip6iPlkxjY99L44RSRKQUVFXORrr+qa15rPMGx93e5vrJVLO+gwNUl
         kQeA==
X-Gm-Message-State: AOAM530eYT4cTNPOEAoNNiiJbXGXysbEYn0139hK/gIgEfgDK+HSeT4p
        Bq1BaG4JiNw/eZBXylePA/k=
X-Google-Smtp-Source: ABdhPJzQ95LGdKuV+f/YUrN0ggL7Ct6sBaX/OzVyRU1WmwijkdKR22tvrlllf21hzI/g7xEMabdXKQ==
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr5021169edv.252.1612898639175;
        Tue, 09 Feb 2021 11:23:59 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:23:58 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Tue,  9 Feb 2021 20:23:43 +0100
Message-Id: <20210209192350.7130-1-jbx6244@gmail.com>
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
Changed V5:
  add select

Changed V3:
  remove aclk_usb3_rksoc_axi_perf
  remove aclk_usb3

Changed V2:
  remove node wrapper
---
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 104 +++++++++++++++++++++
 2 files changed, 104 insertions(+), 56 deletions(-)
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
index 000000000..9908270a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -0,0 +1,104 @@
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
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rockchip,rk3399-dwc3
+  required:
+    - compatible
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

