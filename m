Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7530B088
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhBATmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhBATl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:41:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC758C061573;
        Mon,  1 Feb 2021 11:41:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so20299324edd.5;
        Mon, 01 Feb 2021 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vudz7Jq3CovoiOUmAZDu7pX1ATasm53I9HD8Bq8Ch+U=;
        b=uRRkmtSb0gkM4AwKwMZrg0TnMdgcY+sOAQP5H0Fgg6DCU/zZ+a03NzSE+iRuYcT0zh
         3TmaXRqIJijh6ZUxMY/gKL6NfU6RZAmNm2BO+9WnFeqcON1TgvuIG0R7mnYbWyV2aOwS
         ccNJCoVu3YMd3prw7pg9vYw8Cc2+UJtNtT2WqLetlTKigTmmg91QPm3bDHVyd0E2i20s
         +wD81KaOSpoinlgmaaW97zaW248dDcGmVyV4zIjpds20LwjuuIdo87Cm7OdUwG0DDTWQ
         91Ya4IFiC/VjouZG7rHa0T60S93zO/AkxgDs6yfWE+fClD+Cag/g1QNheHM9+ZqFqFsd
         RVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vudz7Jq3CovoiOUmAZDu7pX1ATasm53I9HD8Bq8Ch+U=;
        b=evcQGXTfQlh7gR8f5z9nMh0vNATlKbUmThhQRtWTOwhqaG1sC7SeFExE+l0ry4ieAZ
         WfO7kwT4vlBOtgV2WVknUWGS91oD4ykru/kfdf9JXeSTEq5uujf+cacYSSNhvV3WF+Qz
         Fuv7qgySm/n+5v5uJ/8FoKvp1+MLTornAsMkvFNkS74GsIG+SXUz1SmLZG7aKEsZSSxo
         2vJFgswuk66DLmaRjBOlDxNgYNRf/PwrZ+woCgksfnj+u2X4f8szPvd2TTlDhBOxqP68
         FNKkXHxNR0am/aTlKbCUPSXwHchDe4xjHkeEGVq5/xcfB0pQNVs36r0k3zL3OuNAU+HO
         aH3g==
X-Gm-Message-State: AOAM532oHFTLk5QhBLKuVVn5t+Gh3ox7kDhg8S03ur1TA57+dujqNA8l
        qp+XhLWYAgtEsr/8u338njU=
X-Google-Smtp-Source: ABdhPJxSZTnKN9WR55MOnNEgcHmJn9O9hya7WEb4ex42obOcKRcFi5f4yDoWnP2PHvnNEchyZtNDKg==
X-Received: by 2002:a05:6402:1bde:: with SMTP id ch30mr20541649edb.151.1612208477429;
        Mon, 01 Feb 2021 11:41:17 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id du6sm6702799ejc.78.2021.02.01.11.41.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:41:16 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Mon,  1 Feb 2021 20:41:01 +0100
Message-Id: <20210201194105.32673-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past Rockchip dwc3 usb nodes were manually checked.
With the conversion of snps,dwc3.yaml as common document
we now can convert rockchip,dwc3.txt to yaml as well.

Added properties for rk3399 are:
  resets
  reset-names

Generic properties that are now also filtered:
  "#address-cells"
  "#size-cells"
  ranges

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 107 +++++++++++++++++++++
 2 files changed, 107 insertions(+), 56 deletions(-)
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
index 000000000..681086fa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -0,0 +1,107 @@
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
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3399-dwc3
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
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: usb3-otg
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^usb@[a-f0-9]+$":
+    type: object
+
+    $ref: "snps,dwc3.yaml"
+
+    description:
+      A child node must exist to represent the core DWC3 IP block.
+      The content of the node is defined in snps,dwc3.yaml.
+
+      Phy documentation is provided in the following places.
+
+      USB2.0 PHY
+      Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+
+      Type-C PHY
+      Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    usbdrd3_0: usb@fe800000 {
+      compatible = "rockchip,rk3399-dwc3";
+      clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+               <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+               <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+      clock-names = "ref_clk", "suspend_clk",
+                    "bus_clk", "aclk_usb3_rksoc_axi_perf",
+                    "aclk_usb3", "grf_clk";
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges;
+      usbdrd_dwc3_0: usb@fe800000 {
+        compatible = "snps,dwc3";
+        reg = <0x0 0xfe800000 0x0 0x100000>;
+        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+        dr_mode = "otg";
+      };
+    };
-- 
2.11.0

