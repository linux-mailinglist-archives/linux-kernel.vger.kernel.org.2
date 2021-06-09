Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6043A1368
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhFILun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:50:43 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:46654 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbhFILtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:20 -0400
Received: by mail-wm1-f42.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so3978190wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfLtTNNJiGvr55qHsiqGqf0rsZ8IwtangtgE/TkYmbA=;
        b=PxwsGurI5LFbUdiMPG9tgAXg/8gJkbrklsARX0YrESmDqzg6Giwj6Ut6rot1PKCt4E
         aD1LIVB+Uurn8Ru5PNApppk9cwb3h6OkwReNFU/sDhTQWJ522pGRzUWOeULX6gb1URRn
         g+JbL5fxWEdlt0noA4O1TjtDticVjl18SSCLZLj6zCjtQHVJMZokEzktYRjJqD4K0Bmv
         fFxMG68paOZROr0To5WxUqzVo1evTKIsM27EuX6jJeWeW0S6XSDnNqZ5Nyi0ikVKjkDj
         oE8REk5PKUNLUGWbQIJbj6yr22X2WvNncYhIItSONDlxn+qFWXfLAWI6fR+RpBNnRnV5
         EF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cfLtTNNJiGvr55qHsiqGqf0rsZ8IwtangtgE/TkYmbA=;
        b=DMEmfmpoZ+GUZEhSoXTAzjAYd4jsB5mYKTyaUSOv/18zQVrDnRNcJoRlptZB35lYVe
         fE/Dz43iMfmaie2pTR7Ma1CkHdqytTxSa1FfjddsEDEWyN4mWVvqle2HNKMtr/Tgi7pD
         KWDRgKh/CWjALA4ycZhDtgNybsNmJ6mLcObjeMWcA7Lx8sCRdpEkMD5vQxJibvt2h3oU
         QOl1HbOeilGTJOOONfSR403ZjCvvi0UoRPq5+QG0N/F4mhY1fPwDiytj52vXoXhaI8fS
         527V3Dnriwxv/XouG5LHy54ht4ibABc1DL2cyre6sXvScjtC4h2pWJzv4sEJZNAnjnx0
         K0ng==
X-Gm-Message-State: AOAM531KVzz5iKYi/RKsyo1f5P8Yi6F9P0fEcIU0hcZAUndS9o3zDXgT
        iSFcT0lO8n3U95c3bClyVL2C5vqf3tXsObZI
X-Google-Smtp-Source: ABdhPJyJRp2Y6BxdlZM8cR6adUoUx48/QEolsI59RFFzti4bjUtPbC8CZ1cRMROJilEWIYMzMQPdZA==
X-Received: by 2002:a1c:7210:: with SMTP id n16mr9104082wmc.75.1623239174183;
        Wed, 09 Jun 2021 04:46:14 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id p10sm11635975wrr.33.2021.06.09.04.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:13 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 31/31] arm64: zynqmp: Add support for Xilinx Kria SOM board
Date:   Wed,  9 Jun 2021 13:45:07 +0200
Message-Id: <ea3944deffedd8a09f097a54016bf9f2e9ddcb0e.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of revisions of SOMs (k26) and associated carrier cards
(kv260).
SOM itself has two major versions:
sm-k26 - SOM with EMMC
smk-k26 - SOM without EMMC used on starter kit with preprogrammed firmware
in QSPI.

SOMs are describing only devices available on the SOM or connections which
are described in specification (for example UART, fwuen).

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

https://www.xilinx.com/products/som/kria.html
---
 .../devicetree/bindings/arm/xilinx.yaml       |  31 ++
 arch/arm64/boot/dts/xilinx/Makefile           |  11 +
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 371 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 351 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 ++++++++++++++
 .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 +
 6 files changed, 1074 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index a0b1ae6e3e71..1a4a03dfaf7f 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -116,6 +116,37 @@ properties:
           - const: xlnx,zynqmp-zcu111
           - const: xlnx,zynqmp
 
+      - description: Xilinx Kria SOMs
+        items:
+          - const: xlnx,zynqmp-sm-k26-rev1
+          - const: xlnx,zynqmp-sm-k26-revB
+          - const: xlnx,zynqmp-sm-k26-revA
+          - const: xlnx,zynqmp-sm-k26
+          - const: xlnx,zynqmp
+
+      - description: Xilinx Kria SOMs (starter)
+        items:
+          - const: xlnx,zynqmp-smk-k26-rev1
+          - const: xlnx,zynqmp-smk-k26-revB
+          - const: xlnx,zynqmp-smk-k26-revA
+          - const: xlnx,zynqmp-smk-k26
+          - const: xlnx,zynqmp
+
+      - description: Xilinx Kria Carrier Cards (revA/Y/Z)
+        items:
+          - const: xlnx,zynqmp-sk-kv260-revZ
+          - const: xlnx,zynqmp-sk-kv260-revY
+          - const: xlnx,zynqmp-sk-kv260-revA
+          - const: xlnx,zynqmp-sk-k260
+          - const: xlnx,zynqmp
+
+      - description: Xilinx Kria Carrier Cards (revB/1)
+        items:
+          - const: xlnx,zynqmp-sk-kv260-rev1
+          - const: xlnx,zynqmp-sk-kv260-revB
+          - const: xlnx,zynqmp-sk-k260
+          - const: xlnx,zynqmp
+
 additionalProperties: true
 
 ...
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 083ed52337fd..bd7747770674 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -17,3 +17,14 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
+
+
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
+
+som-AA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+som-AB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+starter-AA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+starter-AB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+
+dtb-$(CONFIG_ARCH_ZYNQMP) += som-AA.dtb som-AB.dtb starter-AA.dtb starter-AB.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
new file mode 100644
index 000000000000..3c2918bf9897
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KV260 revA Carrier Card
+ *
+ * (C) Copyright 2020, Xilinx, Inc.
+ *
+ * SD level shifter:
+ * "A" – A01 board un-modified (NXP)
+ * "Y" – A01 board modified with legacy interposer (Nexperia)
+ * "Z" – A01 board modified with Diode interposer
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+ #include <dt-bindings/gpio/gpio.h>
+ #include <dt-bindings/net/ti-dp83867.h>
+ #include <dt-bindings/phy/phy.h>
+ #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-sk-kv260-revA",
+		     "xlnx,zynqmp-sk-kv260-revY",
+		     "xlnx,zynqmp-sk-kv260-revZ",
+		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
+
+	fragment1 {
+		target = <&i2c1>; /* I2C_SCK C23/C24 - MIO from SOM */
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&pinctrl_i2c1_default>;
+			pinctrl-1 = <&pinctrl_i2c1_gpio>;
+			scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+			sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+
+			u14: ina260@40 { /* u14 */
+				compatible = "ti,ina260";
+				#io-channel-cells = <1>;
+				label = "ina260-u14";
+				reg = <0x40>;
+			};
+			/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+		};
+	};
+
+	fragment1a {
+		target = <&amba>;
+		__overlay__ {
+			ina260-u14 {
+				compatible = "iio-hwmon";
+				io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+			};
+
+			si5332_0: si5332_0 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <125000000>;
+			};
+
+			si5332_1: si5332_1 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <25000000>;
+			};
+
+			si5332_2: si5332_2 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <48000000>;
+			};
+
+			si5332_3: si5332_3 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <24000000>;
+			};
+
+			si5332_4: si5332_4 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <26000000>;
+			};
+
+			si5332_5: si5332_5 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <27000000>;
+			};
+		};
+	};
+
+/* DP/USB 3.0 and SATA */
+	fragment2 {
+		target = <&psgtr>;
+		__overlay__ {
+			status = "okay";
+			/* pcie, usb3, sata */
+			clocks = <&si5332_5>, <&si5332_4>, <&si5332_0>;
+			clock-names = "ref0", "ref1", "ref2";
+		};
+	};
+
+	fragment3 {
+		target = <&sata>;
+		__overlay__ {
+			status = "okay";
+			/* SATA OOB timing settings */
+			ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+			ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+			ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+			ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+			ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+			ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+			ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+			ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+			phy-names = "sata-phy";
+			phys = <&psgtr 3 PHY_TYPE_SATA 1 2>;
+		};
+	};
+
+	fragment4 {
+		target = <&zynqmp_dpsub>;
+		__overlay__ {
+			status = "disabled";
+			phy-names = "dp-phy0", "dp-phy1";
+			phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
+		};
+	};
+
+	fragment9 {
+		target = <&zynqmp_dpdma>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+
+	fragment10 {
+		target = <&usb0>;
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0_default>;
+			usbhub: usb5744 { /* u43 */
+				compatible = "microchip,usb5744";
+				reset-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+			};
+		};
+	};
+
+	fragment11 {
+		target = <&dwc3_0>;
+		__overlay__ {
+			status = "okay";
+			dr_mode = "host";
+			snps,usb3_lpm_capable;
+			phy-names = "usb3-phy";
+			phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
+			maximum-speed = "super-speed";
+		};
+	};
+
+	fragment12 {
+		target = <&sdhci1>; /* on CC with tuned parameters */
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sdhci1_default>;
+			/*
+			 * SD 3.0 requires level shifter and this property
+			 * should be removed if the board has level shifter and
+			 * need to work in UHS mode
+			 */
+			no-1-8-v;
+			disable-wp;
+			xlnx,mio-bank = <1>;
+		};
+	};
+
+	fragment13 {
+		target = <&gem3>; /* required by spec */
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_gem3_default>;
+			phy-handle = <&phy0>;
+			phy-mode = "rgmii-id";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
+				reset-delay-us = <2>;
+
+				phy0: ethernet-phy@1 {
+					#phy-cells = <1>;
+					reg = <1>;
+					ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+					ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+					ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+					ti,dp83867-rxctrl-strap-quirk;
+				};
+			};
+		};
+	};
+
+	fragment14 {
+		target = <&pinctrl0>; /* required by spec */
+		__overlay__ {
+			status = "okay";
+
+			pinctrl_uart1_default: uart1-default {
+				conf {
+					groups = "uart1_9_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					drive-strength = <12>;
+				};
+
+				conf-rx {
+					pins = "MIO37";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO36";
+					bias-disable;
+				};
+
+				mux {
+					groups = "uart1_9_grp";
+					function = "uart1";
+				};
+			};
+
+			pinctrl_i2c1_default: i2c1-default {
+				conf {
+					groups = "i2c1_6_grp";
+					bias-pull-up;
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux {
+					groups = "i2c1_6_grp";
+					function = "i2c1";
+				};
+			};
+
+			pinctrl_i2c1_gpio: i2c1-gpio {
+				conf {
+					groups = "gpio0_24_grp", "gpio0_25_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux {
+					groups = "gpio0_24_grp", "gpio0_25_grp";
+					function = "gpio0";
+				};
+			};
+
+			pinctrl_gem3_default: gem3-default {
+				conf {
+					groups = "ethernet3_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO70", "MIO72", "MIO74";
+					bias-high-impedance;
+					low-power-disable;
+				};
+
+				conf-bootstrap {
+					pins = "MIO71", "MIO73", "MIO75";
+					bias-disable;
+					low-power-disable;
+				};
+
+				conf-tx {
+					pins = "MIO64", "MIO65", "MIO66",
+					       "MIO67", "MIO68", "MIO69";
+					bias-disable;
+					low-power-enable;
+				};
+
+				conf-mdio {
+					groups = "mdio3_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					bias-disable;
+				};
+
+				mux-mdio {
+					function = "mdio3";
+					groups = "mdio3_0_grp";
+				};
+
+				mux {
+					function = "ethernet3";
+					groups = "ethernet3_0_grp";
+				};
+			};
+
+			pinctrl_usb0_default: usb0-default {
+				conf {
+					groups = "usb0_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO52", "MIO53", "MIO55";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+					"MIO60", "MIO61", "MIO62", "MIO63";
+					bias-disable;
+				};
+
+				mux {
+					groups = "usb0_0_grp";
+					function = "usb0";
+				};
+			};
+
+			pinctrl_sdhci1_default: sdhci1-default {
+				conf {
+					groups = "sdio1_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					bias-disable;
+				};
+
+				conf-cd {
+					groups = "sdio1_cd_0_grp";
+					bias-high-impedance;
+					bias-pull-up;
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux-cd {
+					groups = "sdio1_cd_0_grp";
+					function = "sdio1_cd";
+				};
+
+				mux {
+					groups = "sdio1_0_grp";
+					function = "sdio1";
+				};
+			};
+		};
+	};
+	fragment15 {
+		target = <&uart1>;
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1_default>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
new file mode 100644
index 000000000000..62d175cf3d5d
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KV260 revA Carrier Card
+ *
+ * (C) Copyright 2020, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+ #include <dt-bindings/gpio/gpio.h>
+ #include <dt-bindings/net/ti-dp83867.h>
+ #include <dt-bindings/phy/phy.h>
+ #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-sk-kv260-rev1",
+		     "xlnx,zynqmp-sk-kv260-revB",
+		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
+
+	fragment1 {
+		target = <&i2c1>; /* I2C_SCK C23/C24 - MIO from SOM */
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&pinctrl_i2c1_default>;
+			pinctrl-1 = <&pinctrl_i2c1_gpio>;
+			scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+			sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+
+			u14: ina260@40 { /* u14 */
+				compatible = "ti,ina260";
+				#io-channel-cells = <1>;
+				label = "ina260-u14";
+				reg = <0x40>;
+			};
+			usbhub: usb5744@2d { /* u43 */
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+				reset-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+			};
+			/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+		};
+	};
+
+	fragment1a {
+		target = <&amba>;
+		__overlay__ {
+			ina260-u14 {
+				compatible = "iio-hwmon";
+				io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+			};
+
+			si5332_0: si5332_0 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <125000000>;
+			};
+
+			si5332_1: si5332_1 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <25000000>;
+			};
+
+			si5332_2: si5332_2 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <48000000>;
+			};
+
+			si5332_3: si5332_3 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <24000000>;
+			};
+
+			si5332_4: si5332_4 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <26000000>;
+			};
+
+			si5332_5: si5332_5 { /* u17 */
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <27000000>;
+			};
+		};
+	};
+
+/* DP/USB 3.0 */
+	fragment2 {
+		target = <&psgtr>;
+		__overlay__ {
+			status = "okay";
+			/* pcie, usb3, sata */
+			clocks = <&si5332_5>, <&si5332_4>, <&si5332_0>;
+			clock-names = "ref0", "ref1", "ref2";
+		};
+	};
+
+	fragment4 {
+		target = <&zynqmp_dpsub>;
+		__overlay__ {
+			status = "disabled";
+			phy-names = "dp-phy0", "dp-phy1";
+			phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
+		};
+	};
+
+	fragment9 {
+		target = <&zynqmp_dpdma>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+
+	fragment10 {
+		target = <&usb0>;
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0_default>;
+		};
+	};
+
+	fragment11 {
+		target = <&dwc3_0>;
+		__overlay__ {
+			status = "okay";
+			dr_mode = "host";
+			snps,usb3_lpm_capable;
+			phy-names = "usb3-phy";
+			phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
+			maximum-speed = "super-speed";
+		};
+	};
+
+	fragment12 {
+		target = <&sdhci1>; /* on CC with tuned parameters */
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sdhci1_default>;
+			/*
+			 * SD 3.0 requires level shifter and this property
+			 * should be removed if the board has level shifter and
+			 * need to work in UHS mode
+			 */
+			no-1-8-v;
+			disable-wp;
+			xlnx,mio-bank = <1>;
+			clk-phase-sd-hs = <126>, <60>;
+			clk-phase-uhs-sdr25 = <120>, <60>;
+			clk-phase-uhs-ddr50 = <126>, <48>;
+		};
+	};
+
+	fragment13 {
+		target = <&gem3>; /* required by spec */
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_gem3_default>;
+			phy-handle = <&phy0>;
+			phy-mode = "rgmii-id";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
+				reset-delay-us = <2>;
+
+				phy0: ethernet-phy@1 {
+					#phy-cells = <1>;
+					reg = <1>;
+					ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+					ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+					ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+					ti,dp83867-rxctrl-strap-quirk;
+				};
+			};
+		};
+	};
+
+	fragment14 {
+		target = <&pinctrl0>; /* required by spec */
+		__overlay__ {
+			status = "okay";
+
+			pinctrl_uart1_default: uart1-default {
+				conf {
+					groups = "uart1_9_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					drive-strength = <12>;
+				};
+
+				conf-rx {
+					pins = "MIO37";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO36";
+					bias-disable;
+				};
+
+				mux {
+					groups = "uart1_9_grp";
+					function = "uart1";
+				};
+			};
+
+			pinctrl_i2c1_default: i2c1-default {
+				conf {
+					groups = "i2c1_6_grp";
+					bias-pull-up;
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux {
+					groups = "i2c1_6_grp";
+					function = "i2c1";
+				};
+			};
+
+			pinctrl_i2c1_gpio: i2c1-gpio {
+				conf {
+					groups = "gpio0_24_grp", "gpio0_25_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux {
+					groups = "gpio0_24_grp", "gpio0_25_grp";
+					function = "gpio0";
+				};
+			};
+
+			pinctrl_gem3_default: gem3-default {
+				conf {
+					groups = "ethernet3_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO70", "MIO72", "MIO74";
+					bias-high-impedance;
+					low-power-disable;
+				};
+
+				conf-bootstrap {
+					pins = "MIO71", "MIO73", "MIO75";
+					bias-disable;
+					low-power-disable;
+				};
+
+				conf-tx {
+					pins = "MIO64", "MIO65", "MIO66",
+					       "MIO67", "MIO68", "MIO69";
+					bias-disable;
+					low-power-enable;
+				};
+
+				conf-mdio {
+					groups = "mdio3_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					bias-disable;
+				};
+
+				mux-mdio {
+					function = "mdio3";
+					groups = "mdio3_0_grp";
+				};
+
+				mux {
+					function = "ethernet3";
+					groups = "ethernet3_0_grp";
+				};
+			};
+
+			pinctrl_usb0_default: usb0-default {
+				conf {
+					groups = "usb0_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO52", "MIO53", "MIO55";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+					"MIO60", "MIO61", "MIO62", "MIO63";
+					bias-disable;
+				};
+
+				mux {
+					groups = "usb0_0_grp";
+					function = "usb0";
+				};
+			};
+
+			pinctrl_sdhci1_default: sdhci1-default {
+				conf {
+					groups = "sdio1_0_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+					bias-disable;
+				};
+
+				conf-cd {
+					groups = "sdio1_cd_0_grp";
+					bias-high-impedance;
+					bias-pull-up;
+					slew-rate = <SLEW_RATE_SLOW>;
+					power-source = <IO_STANDARD_LVCMOS18>;
+				};
+
+				mux-cd {
+					groups = "sdio1_cd_0_grp";
+					function = "sdio1_cd";
+				};
+
+				mux {
+					groups = "sdio1_0_grp";
+					function = "sdio1";
+				};
+			};
+		};
+	};
+	fragment15 {
+		target = <&uart1>;
+		__overlay__ {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1_default>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
new file mode 100644
index 000000000000..0051f41a59bf
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
+ *
+ * (C) Copyright 2020, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk-ccf.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	model = "ZynqMP SM-K26 Rev1/B/A";
+	compatible = "xlnx,zynqmp-sm-k26-rev1", "xlnx,zynqmp-sm-k26-revB",
+		     "xlnx,zynqmp-sm-k26-revA", "xlnx,zynqmp-sm-k26",
+		     "xlnx,zynqmp";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		nvmem0 = &eeprom;
+		nvmem1 = &eeprom_cc;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &dcc;
+		spi0 = &qspi;
+		spi1 = &spi0;
+		spi2 = &spi1;
+		usb0 = &usb0;
+		usb1 = &usb1;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory"; /* 4GB */
+		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		fwuen {
+			label = "fwuen";
+			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ds35 {
+			label = "heartbeat";
+			gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		ds36 {
+			label = "vbus_det";
+			gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&uart1 { /* MIO36/MIO37 */
+	status = "okay";
+};
+
+&qspi { /* MIO 0-5 - U143 */
+	status = "okay";
+	flash@0 { /* MT25QU512A */
+		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <40000000>; /* 40MHz */
+		partition@0 {
+			label = "Image Selector";
+			reg = <0x0 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@80000 {
+			label = "Image Selector Golden";
+			reg = <0x80000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@100000 {
+			label = "Persistent Register";
+			reg = <0x100000 0x20000>; /* 128KB */
+		};
+		partition@120000 {
+			label = "Persistent Register Backup";
+			reg = <0x120000 0x20000>; /* 128KB */
+		};
+		partition@140000 {
+			label = "Open_1";
+			reg = <0x140000 0xC0000>; /* 768KB */
+		};
+		partition@200000 {
+			label = "Image A (FSBL, PMU, ATF, U-Boot)";
+			reg = <0x200000 0xD00000>; /* 13MB */
+		};
+		partition@f00000 {
+			label = "ImgSel Image A Catch";
+			reg = <0xF00000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@f80000 {
+			label = "Image B (FSBL, PMU, ATF, U-Boot)";
+			reg = <0xF80000 0xD00000>; /* 13MB */
+		};
+		partition@1c80000 {
+			label = "ImgSel Image B Catch";
+			reg = <0x1C80000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@1d00000 {
+			label = "Open_2";
+			reg = <0x1D00000 0x100000>; /* 1MB */
+		};
+		partition@1e00000 {
+			label = "Recovery Image";
+			reg = <0x1E00000 0x200000>; /* 2MB */
+			read-only;
+			lock;
+		};
+		partition@2000000 {
+			label = "Recovery Image Backup";
+			reg = <0x2000000 0x200000>; /* 2MB */
+			read-only;
+			lock;
+		};
+		partition@2200000 {
+			label = "U-Boot storage variables";
+			reg = <0x2200000 0x20000>; /* 128KB */
+		};
+		partition@2220000 {
+			label = "U-Boot storage variables backup";
+			reg = <0x2220000 0x20000>; /* 128KB */
+		};
+		partition@2240000 {
+			label = "SHA256";
+			reg = <0x2240000 0x10000>; /* 256B but 64KB sector */
+			read-only;
+			lock;
+		};
+		partition@2250000 {
+			label = "User";
+			reg = <0x2250000 0x1db0000>; /* 29.5 MB */
+		};
+	};
+};
+
+&sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A*/
+	status = "okay";
+	non-removable;
+	disable-wp;
+	bus-width = <8>;
+	xlnx,mio-bank = <0>;
+};
+
+&spi1 { /* MIO6, 9-11 */
+	status = "okay";
+	label = "TPM";
+	num-cs = <1>;
+	tpm@0 { /* slm9670 - U144 */
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+
+	eeprom: eeprom@50 { /* u46 - also at address 0x58 */
+		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
+		reg = <0x50>;
+		/* WP pin EE_WP_EN connected to slg7x644092@68 */
+	};
+
+	eeprom_cc: eeprom@51 { /* required by spec - also at address 0x59 */
+		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
+		reg = <0x51>;
+	};
+
+	/* da9062@30 - u170 - also at address 0x31 */
+	/* da9131@33 - u167 */
+	da9131: pmic@33 {
+		compatible = "dlg,da9131";
+		reg = <0x33>;
+		regulators {
+			da9131_buck1: buck1 {
+				regulator-name = "da9131_buck1";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			da9131_buck2: buck2 {
+				regulator-name = "da9131_buck2";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	/* da9130@32 - u166 */
+	da9130: pmic@32 {
+		compatible = "dlg,da9130";
+		reg = <0x32>;
+		regulators {
+			da9130_buck1: buck1 {
+				regulator-name = "da9130_buck1";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	/* slg7x644091@70 - u168 NOT accessible due to address conflict with stdp4320 */
+	/*
+	 * stdp4320 - u27 FW has below two issues to be fixed in next board revision.
+	 * Device acknowledging to addresses 0x5C, 0x5D, 0x70, 0x72, 0x76.
+	 * Address conflict with slg7x644091@70 making both the devices NOT accessible.
+	 * With the FW fix, stdp4320 should respond to address 0x73 only.
+	 */
+	/* slg7x644092@68 - u169 */
+	/* Also connected via JA1C as C23/C24 */
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "QSPI_CLK", "QSPI_DQ1", "QSPI_DQ2", "QSPI_DQ3", "QSPI_DQ0", /* 0 - 4 */
+			  "QSPI_CS_B", "SPI_CLK", "LED1", "LED2", "SPI_CS_B", /* 5 - 9 */
+			  "SPI_MISO", "SPI_MOSI", "FWUEN", "EMMC_DAT0", "EMMC_DAT1", /* 10 - 14 */
+			  "EMMC_DAT2", "EMMC_DAT3", "EMMC_DAT4", "EMMC_DAT5", "EMMC_DAT6", /* 15 - 19 */
+			  "EMMC_DAT7", "EMMC_CMD", "EMMC_CLK", "EMMC_RST", "I2C1_SCL", /* 20 - 24 */
+			  "I2C1_SDA", "", "", "", "", /* 25 - 29 */
+			  "", "", "", "", "", /* 30 - 34 */
+			  "", "", "", "", "", /* 35 - 39 */
+			  "", "", "", "", "", /* 40 - 44 */
+			  "", "", "", "", "", /* 45 - 49 */
+			  "", "", "", "", "", /* 50 - 54 */
+			  "", "", "", "", "", /* 55 - 59 */
+			  "", "", "", "", "", /* 60 - 64 */
+			  "", "", "", "", "", /* 65 - 69 */
+			  "", "", "", "", "", /* 70 - 74 */
+			  "", "", "", /* 75 - 77, MIO end and EMIO start */
+			  "", "", /* 78 - 79 */
+			  "", "", "", "", "", /* 80 - 84 */
+			  "", "", "", "", "", /* 85 - 89 */
+			  "", "", "", "", "", /* 90 - 94 */
+			  "", "", "", "", "", /* 95 - 99 */
+			  "", "", "", "", "", /* 100 - 104 */
+			  "", "", "", "", "", /* 105 - 109 */
+			  "", "", "", "", "", /* 110 - 114 */
+			  "", "", "", "", "", /* 115 - 119 */
+			  "", "", "", "", "", /* 120 - 124 */
+			  "", "", "", "", "", /* 125 - 129 */
+			  "", "", "", "", "", /* 130 - 134 */
+			  "", "", "", "", "", /* 135 - 139 */
+			  "", "", "", "", "", /* 140 - 144 */
+			  "", "", "", "", "", /* 145 - 149 */
+			  "", "", "", "", "", /* 150 - 154 */
+			  "", "", "", "", "", /* 155 - 159 */
+			  "", "", "", "", "", /* 160 - 164 */
+			  "", "", "", "", "", /* 165 - 169 */
+			  "", "", "", ""; /* 170 - 174 */
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
new file mode 100644
index 000000000000..300edc880093
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
+ *
+ * (C) Copyright 2020, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+#include "zynqmp-sm-k26-revA.dts"
+
+/ {
+	model = "ZynqMP SMK-K26 Rev1/B/A";
+	compatible = "xlnx,zynqmp-smk-k26-rev1", "xlnx,zynqmp-smk-k26-revB",
+		     "xlnx,zynqmp-smk-k26-revA", "xlnx,zynqmp-smk-k26",
+		     "xlnx,zynqmp";
+};
+
+&sdhci0 {
+	status = "disabled";
+};
-- 
2.31.1

