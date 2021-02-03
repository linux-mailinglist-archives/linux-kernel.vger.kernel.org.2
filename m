Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56A330E02B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBCQxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhBCQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDEC0613ED;
        Wed,  3 Feb 2021 08:52:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s3so376619edi.7;
        Wed, 03 Feb 2021 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YTHvbCjsK4omUl0IWdkmKq6VQg+YpFZVHA+6d5ZU9mk=;
        b=dLlP1Rw8f9InY/ONO5KbGh4Qrp4V9j1Sl6zGeIjzqXvRtN1eIbpWEg6xEXNPo9PXW7
         eCzVSU9dF+vMckZbQiOV3/HO/jmk2H13S8JkLOFr5iI7E53VDBLKZMzbWBMegh50QdrE
         +Z5ExbqDh9Wxj+IEi5TOPRlCksfOfI6oS6ysd/T0zK/nkIH6ii1NlGyl2d4nHgFIJ8Wu
         f9d6CVjAMiPIygI2ZEeZhSuVu0bgT/Tlshb213briU8cnFbdWFagFtL/FpuFfNfxzPmh
         5OKcsh6MY3m573z+7HMUYv0vgo5P62FkNEg1C2E06tPSme1DqmiQ2YQJSyx7MIgKZtUB
         e0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YTHvbCjsK4omUl0IWdkmKq6VQg+YpFZVHA+6d5ZU9mk=;
        b=SpKYk0euM6BdMySMbCwFvTS8ib1IxyY2WnvsvZF+DGPzjpEOEp/vkavw8yY8XQ3EOq
         8kg8jMrO6+c8ZcQOxR/6i87+5oBbysLFs6/QZHLfpiK+OSkAVdWI0YVcjZ9acS1uiIRX
         hgDo+4N+G6jyj6BDMuNQOMKmdN8rabqfZWhVyUTgHujC02BdwBOK7CaV8HLf8u7FRgLH
         pnMc8AFrX1sYqhL/SBpxG2Stbrkp2B3ajpGP2eYOaed5iOxh+GlP2Cj/KO/UYRsOBoo+
         Skk+R2KXJPJLmaTg0ZbjkldrfeBd+Erqzf2+FeNYgqm/u/HKC37uMYS6J0j5jdd9ZZWl
         m8Kg==
X-Gm-Message-State: AOAM532Bb1E3LHZbit2Rtmt7DshN7U6ZSQzaUamxgnjdCpob3SBKu2sP
        1WyAri1U0lJIPnAm8MyyZnuR5NxR7do=
X-Google-Smtp-Source: ABdhPJy20Qd5tp6E67FLuATwBrfP19QrqbJ+90f7gWEVIWsDr5KHgPyNFDX/HfHywdP7MaLXxgJIdw==
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr3858988edd.242.1612371162281;
        Wed, 03 Feb 2021 08:52:42 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:41 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Wed,  3 Feb 2021 17:52:27 +0100
Message-Id: <20210203165233.22177-1-jbx6244@gmail.com>
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
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 103 +++++++++++++++++++++
 2 files changed, 103 insertions(+), 56 deletions(-)
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
index 000000000..fdf9497bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -0,0 +1,103 @@
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
+      The common content of the node is defined in snps,dwc3.yaml.
+
+      Phy documentation is provided in the following places.
+
+      USB2.0 PHY
+      Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+
+      Type-C PHY
+      Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
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
+          Controller aclk_usb3_rksoc_axi_perf clock
+      - description:
+          Controller aclk_usb3 clock
+      - description:
+          Controller grf clock
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: suspend_clk
+      - const: bus_clk
+      - const: aclk_usb3_rksoc_axi_perf
+      - const: aclk_usb3
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
+                 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+                 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+        clock-names = "ref_clk", "suspend_clk",
+                      "bus_clk", "aclk_usb3_rksoc_axi_perf",
+                      "aclk_usb3", "grf_clk";
+        dr_mode = "otg";
+      };
+    };
-- 
2.11.0

