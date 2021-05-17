Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF52382414
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhEQGTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:19:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhEQGT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:19:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H6IAft082570;
        Mon, 17 May 2021 01:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621232290;
        bh=R/0F7pphVOdZqiyrB8g6r3CAB4b7jbOdSzabES4FrJo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o1+CctbpHdrjKetxejmV4OspDyRUOtI2KVU1/WVuGScYVcLXgjNTGFykWl/a97287
         ZEMjoRHdzg6ppFyLhME7uBZTpAY5eXABxMAZ2lknbklWdRV+icN3Fh4F7IhsKl96xH
         iS8Cj5L3MNWvpqE+2qpBeZEcSj8Xxs+xR7QN6k/0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H6IAt9006656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 01:18:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 01:18:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 01:18:09 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H6Hpl1003911;
        Mon, 17 May 2021 01:18:00 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v2 1/6] dt-bindings: mux: Convert reg-mux DT bindings to YAML
Date:   Mon, 17 May 2021 11:47:34 +0530
Message-ID: <20210517061739.5762-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517061739.5762-1-kishon@ti.com>
References: <20210517061739.5762-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert reg-mux DT bindings to YAML. Move the examples provided in
reg-mux.txt to mux-controller.txt and remove reg-mux.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/mux/mux-controller.txt           | 113 ++++++++++++++-
 .../devicetree/bindings/mux/reg-mux.txt       | 129 ------------------
 .../devicetree/bindings/mux/reg-mux.yaml      |  47 +++++++
 3 files changed, 159 insertions(+), 130 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
 create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml

diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
index 4f47e4bd2fa0..6f1e83367d52 100644
--- a/Documentation/devicetree/bindings/mux/mux-controller.txt
+++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
@@ -38,7 +38,7 @@ mux-ctrl-specifier typically encodes the chip-relative mux controller number.
 If the mux controller chip only provides a single mux controller, the
 mux-ctrl-specifier can typically be left out.
 
-Example:
+Example 1:
 
 	/* One consumer of a 2-way mux controller (one GPIO-line) */
 	mux: mux-controller {
@@ -64,6 +64,8 @@ because there is only one mux controller in the list. However, if the driver
 for the consumer node in fact asks for a named mux controller, that name is of
 course still required.
 
+Example 2:
+
 	/*
 	 * Two consumers (one for an ADC line and one for an i2c bus) of
 	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
@@ -116,6 +118,115 @@ course still required.
 		};
 	};
 
+Example 3:
+
+The parent device of mux controller is not a syscon device.
+
+&i2c0 {
+	fpga@66 { // fpga connected to i2c
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
+			     "simple-mfd";
+		reg = <0x66>;
+
+		mux: mux-controller {
+			compatible = "reg-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
+					<0x54 0x07>; /* 1: reg 0x54, bits 2:0 */
+		};
+	};
+};
+
+mdio-mux-1 {
+	compatible = "mdio-mux-multiplexer";
+	mux-controls = <&mux 0>;
+	mdio-parent-bus = <&emdio1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mdio@0 {
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	mdio@8 {
+		reg = <0x8>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	..
+	..
+};
+
+mdio-mux-2 {
+	compatible = "mdio-mux-multiplexer";
+	mux-controls = <&mux 1>;
+	mdio-parent-bus = <&emdio2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mdio@0 {
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	mdio@1 {
+		reg = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	..
+	..
+};
+
+Example 4:
+
+The parent device of mux controller is syscon device.
+
+syscon {
+	compatible = "syscon";
+
+	mux: mux-controller {
+		compatible = "mmio-mux";
+		#mux-control-cells = <1>;
+
+		mux-reg-masks = <0x3 0x30>, /* 0: reg 0x3, bits 5:4 */
+				<0x3 0x40>, /* 1: reg 0x3, bit 6 */
+		idle-states = <MUX_IDLE_AS_IS>, <0>;
+	};
+};
+
+video-mux {
+	compatible = "video-mux";
+	mux-controls = <&mux 0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		/* inputs 0..3 */
+		port@0 {
+			reg = <0>;
+		};
+		port@1 {
+			reg = <1>;
+		};
+		port@2 {
+			reg = <2>;
+		};
+		port@3 {
+			reg = <3>;
+		};
+
+		/* output */
+		port@4 {
+			reg = <4>;
+		};
+	};
+};
 
 Mux controller nodes
 --------------------
diff --git a/Documentation/devicetree/bindings/mux/reg-mux.txt b/Documentation/devicetree/bindings/mux/reg-mux.txt
deleted file mode 100644
index 4afd7ba73d60..000000000000
--- a/Documentation/devicetree/bindings/mux/reg-mux.txt
+++ /dev/null
@@ -1,129 +0,0 @@
-Generic register bitfield-based multiplexer controller bindings
-
-Define register bitfields to be used to control multiplexers. The parent
-device tree node must be a device node to provide register r/w access.
-
-Required properties:
-- compatible : should be one of
-	"reg-mux" : if parent device of mux controller is not syscon device
-	"mmio-mux" : if parent device of mux controller is syscon device
-- #mux-control-cells : <1>
-- mux-reg-masks : an array of register offset and pre-shifted bitfield mask
-                  pairs, each describing a single mux control.
-* Standard mux-controller bindings as decribed in mux-controller.txt
-
-Optional properties:
-- idle-states : if present, the state the muxes will have when idle. The
-		special state MUX_IDLE_AS_IS is the default.
-
-The multiplexer state of each multiplexer is defined as the value of the
-bitfield described by the corresponding register offset and bitfield mask
-pair in the mux-reg-masks array.
-
-Example 1:
-The parent device of mux controller is not a syscon device.
-
-&i2c0 {
-	fpga@66 { // fpga connected to i2c
-		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
-			     "simple-mfd";
-		reg = <0x66>;
-
-		mux: mux-controller {
-			compatible = "reg-mux";
-			#mux-control-cells = <1>;
-			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
-					<0x54 0x07>; /* 1: reg 0x54, bits 2:0 */
-		};
-	};
-};
-
-mdio-mux-1 {
-	compatible = "mdio-mux-multiplexer";
-	mux-controls = <&mux 0>;
-	mdio-parent-bus = <&emdio1>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	mdio@0 {
-		reg = <0x0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	mdio@8 {
-		reg = <0x8>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	..
-	..
-};
-
-mdio-mux-2 {
-	compatible = "mdio-mux-multiplexer";
-	mux-controls = <&mux 1>;
-	mdio-parent-bus = <&emdio2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	mdio@0 {
-		reg = <0x0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	mdio@1 {
-		reg = <0x1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	..
-	..
-};
-
-Example 2:
-The parent device of mux controller is syscon device.
-
-syscon {
-	compatible = "syscon";
-
-	mux: mux-controller {
-		compatible = "mmio-mux";
-		#mux-control-cells = <1>;
-
-		mux-reg-masks = <0x3 0x30>, /* 0: reg 0x3, bits 5:4 */
-				<0x3 0x40>, /* 1: reg 0x3, bit 6 */
-		idle-states = <MUX_IDLE_AS_IS>, <0>;
-	};
-};
-
-video-mux {
-	compatible = "video-mux";
-	mux-controls = <&mux 0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	ports {
-		/* inputs 0..3 */
-		port@0 {
-			reg = <0>;
-		};
-		port@1 {
-			reg = <1>;
-		};
-		port@2 {
-			reg = <2>;
-		};
-		port@3 {
-			reg = <3>;
-		};
-
-		/* output */
-		port@4 {
-			reg = <4>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
new file mode 100644
index 000000000000..54583aafa9de
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mux/reg-mux.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Generic register bitfield-based multiplexer controller bindings
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+properties:
+  compatible:
+    enum:
+      - reg-mux
+      - mmio-mux
+
+  "#mux-control-cells": true
+
+  mux-reg-masks:
+    minItems: 2
+    maxItems: 32
+    description:
+      An array of register offset and pre-shifted bitfield mask pairs, each describing a
+      single mux control.
+
+  idle-states:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+
+required:
+  - compatible
+  - mux-reg-masks
+
+additionalProperties: false
+
+examples:
+  - |
+    serdes_ln_ctrl: mux {
+      compatible = "mmio-mux";
+      #mux-control-cells = <1>;
+      mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+                      <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
+                      <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
+                      <0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
+                      <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
+    };
-- 
2.17.1

