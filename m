Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC283167CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhBJNTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:19:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhBJNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:17:39 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ADGPi2023234;
        Wed, 10 Feb 2021 05:16:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=RCbzRrQfZoy1PRyGoidiL6eb4WsDaCJIb/4PrplG4A8=;
 b=N12lK20lLPMD9dfjGwtCSl4OTvfeVuRdC39j0Rsr3mQxK1TXmjJrRH4wKIyuR9poyPol
 Ezt7T92A+YA+SAnXwqlDeejc23ukTfX2iKuV0UyZ32PTuunClpqJJ/RNvvD7dXmNv7Tb
 ZqsUFB2gCZTF+QK/DD5sZd5H+2nUREPdyWkF7E4zA4XSWuKjSg6xp6CT1AzlQxt32Kv/
 UhLHsbAOrBlDRXlTOF8DZ8qfZXNaeZlwrJdCYlZnW5roBMFhJ+zVp2dpjES3gLlcZBno
 X7aKbWgH1qilAaFa0cJcyVYlrVwDXz2xwdyMbe+jWItVgHl1cQO6o6CASdpOpboDV5yU Kg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbn6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:16:28 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:16:25 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 426313F7040;
        Wed, 10 Feb 2021 05:16:21 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vladimir.vid@sartura.hr>, <tmn505@gmail.com>,
        <luka.kovacic@sartura.hr>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v5 3/5] arm64: dts: cn913x: add device trees for topology B boards
Date:   Wed, 10 Feb 2021 15:16:02 +0200
Message-ID: <20210210131604.28806-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210131604.28806-1-kostap@marvell.com>
References: <20210210131604.28806-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

The CN913x DB with topology B is similar to a regular setup (A)
boards, but uses NAND flash as a boot device, while topology A
boards are booting from SPI flash.
Since NAND and SPI on CN913x DB boards share some wires, they
cannot be activated simultaneously.
The DTS files for setup "B" are based on setup "A", in which the
CP0 NAND controller enabled and CP0 SPI1 disabled.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/Makefile        |   3 +
 arch/arm64/boot/dts/marvell/cn9130-db-B.dts |  22 ++
 arch/arm64/boot/dts/marvell/cn9130-db.dts   | 393 +------------------
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi  | 402 ++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9131-db-B.dts |  22 ++
 arch/arm64/boot/dts/marvell/cn9131-db.dts   | 192 +---------
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi  | 201 ++++++++++
 arch/arm64/boot/dts/marvell/cn9132-db-B.dts |  22 ++
 arch/arm64/boot/dts/marvell/cn9132-db.dts   | 211 +---------
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi  | 220 +++++++++++
 10 files changed, 910 insertions(+), 778 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 34efe0fb6f37..5e39f9774e68 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -16,5 +16,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin-singleshot.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-puzzle-m801.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9131-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db-B.dts b/arch/arm64/boot/dts/marvell/cn9130-db-B.dts
new file mode 100644
index 000000000000..57e41cacd483
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-db-B.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ *
+ * Device tree for the CN9130-DB board (setup "B").
+ */
+
+#include "cn9130-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9130-DB setup B";
+};
+
+/* Setup B has NAND flash as a boot device, while regular setup uses SPI flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When NAND controller is enabled, SPI1 should be disabled.
+ */
+
+&cp0_nand_controller {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index d24294888400..994f347f2973 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -5,399 +5,18 @@
  * Device tree for the CN9130-DB board.
  */
 
-#include "cn9130.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
+#include "cn9130-db.dtsi"
 
 / {
-	model = "Marvell Armada CN9130-DB";
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	aliases {
-		gpio1 = &cp0_gpio1;
-		gpio2 = &cp0_gpio2;
-		i2c0 = &cp0_i2c0;
-		ethernet0 = &cp0_eth0;
-		ethernet1 = &cp0_eth1;
-		ethernet2 = &cp0_eth2;
-		spi1 = &cp0_spi0;
-		spi2 = &cp0_spi1;
-	};
-
-	memory@00000000 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	ap0_reg_sd_vccq: ap0_sd_vccq@0 {
-		compatible = "regulator-gpio";
-		regulator-name = "ap0_sd_vccq";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1 3300000 0x0>;
-	};
-
-	cp0_reg_usb3_vbus0: cp0_usb3_vbus@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "cp0-xhci0-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
-	};
-
-	cp0_usb3_0_phy0: cp0_usb3_phy@0 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cp0_reg_usb3_vbus0>;
-	};
-
-	cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
-		compatible = "regulator-fixed";
-		regulator-name = "cp0-xhci1-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
-	};
-
-	cp0_usb3_0_phy1: cp0_usb3_phy@1 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cp0_reg_usb3_vbus1>;
-	};
-
-	cp0_reg_sd_vccq: cp0_sd_vccq@0 {
-		compatible = "regulator-gpio";
-		regulator-name = "cp0_sd_vccq";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&expander0 15 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1
-			  3300000 0x0>;
-	};
-
-	cp0_reg_sd_vcc: cp0_sd_vcc@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "cp0_sd_vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&expander0 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-	};
-
-	cp0_sfp_eth0: sfp-eth@0 {
-		compatible = "sff,sfp";
-		i2c-bus = <&cp0_sfpp0_i2c>;
-		los-gpio = <&cp0_module_expander1 11 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp0_module_expander1 10 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp0_module_expander1 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&cp0_module_expander1 8 GPIO_ACTIVE_HIGH>;
-		/*
-		 * SFP cages are unconnected on early PCBs because of an the I2C
-		 * lanes not being connected. Prevent the port for being
-		 * unusable by disabling the SFP node.
-		 */
-		status = "disabled";
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-/* on-board eMMC - U9 */
-&ap_sdhci0 {
-	pinctrl-names = "default";
-	bus-width = <8>;
-	vqmmc-supply = <&ap0_reg_sd_vccq>;
-	status = "okay";
+	model = "Marvell Armada CN9130-DB setup A";
 };
 
-&cp0_crypto {
-	status = "disabled";
-};
-
-&cp0_ethernet {
-	status = "okay";
-};
-
-/* SLM-1521-V2, CON9 */
-&cp0_eth0 {
-	status = "disabled";
-	phy-mode = "10gbase-kr";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp0_comphy4 0>;
-	managed = "in-band-status";
-	sfp = <&cp0_sfp_eth0>;
-};
-
-/* CON56 */
-&cp0_eth1 {
-	status = "okay";
-	phy = <&phy0>;
-	phy-mode = "rgmii-id";
-};
-
-/* CON57 */
-&cp0_eth2 {
-	status = "okay";
-	phy = <&phy1>;
-	phy-mode = "rgmii-id";
-};
-
-&cp0_gpio1 {
-	status = "okay";
-};
-
-&cp0_gpio2 {
-	status = "okay";
-};
-
-&cp0_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_i2c0_pins>;
-	clock-frequency = <100000>;
-
-	/* U36 */
-	expander0: pca953x@21 {
-		compatible = "nxp,pca9555";
-		pinctrl-names = "default";
-		gpio-controller;
-		#gpio-cells = <2>;
-		reg = <0x21>;
-		status = "okay";
-	};
-
-	/* U42 */
-	eeprom0: eeprom@50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-		pagesize = <0x20>;
-	};
-
-	/* U38 */
-	eeprom1: eeprom@57 {
-		compatible = "atmel,24c64";
-		reg = <0x57>;
-		pagesize = <0x20>;
-	};
-};
-
-&cp0_i2c1 {
-	status = "okay";
-	clock-frequency = <100000>;
-
-	/* SLM-1521-V2 - U3 */
-	i2c-mux@72 { /* verify address - depends on dpr */
-		compatible = "nxp,pca9544";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x72>;
-		cp0_sfpp0_i2c: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			/* U12 */
-			cp0_module_expander1: pca9555@21 {
-				compatible = "nxp,pca9555";
-				pinctrl-names = "default";
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x21>;
-			};
-
-		};
-	};
-};
-
-&cp0_mdio {
-	status = "okay";
-
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-	};
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-/* U54 */
-&cp0_nand_controller {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins &nand_rb>;
-
-	nand@0 {
-		reg = <0>;
-		label = "main-storage";
-		nand-rb = <0>;
-		nand-ecc-mode = "hw";
-		nand-on-flash-bbt;
-		nand-ecc-strength = <8>;
-		nand-ecc-step-size = <512>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "U-Boot";
-				reg = <0 0x200000>;
-			};
-			partition@200000 {
-				label = "Linux";
-				reg = <0x200000 0xe00000>;
-			};
-			partition@1000000 {
-				label = "Filesystem";
-				reg = <0x1000000 0x3f000000>;
-			};
-		};
-	};
-};
-
-/* SLM-1521-V2, CON6 */
-&cp0_pcie0 {
-	status = "okay";
-	num-lanes = <4>;
-	num-viewport = <8>;
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp0_comphy0 0
-		&cp0_comphy1 0
-		&cp0_comphy2 0
-		&cp0_comphy3 0>;
-};
-
-&cp0_sata0 {
-	status = "okay";
-
-	/* SLM-1521-V2, CON2 */
-	sata-port@1 {
-		status = "okay";
-		/* Generic PHY, providing serdes lanes */
-		phys = <&cp0_comphy5 1>;
-	};
-};
-
-/* CON 28 */
-&cp0_sdhci0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_sdhci_pins
-		     &cp0_sdhci_cd_pins>;
-	bus-width = <4>;
-	cd-gpios = <&cp0_gpio2 11 GPIO_ACTIVE_LOW>;
-	no-1-8-v;
-	vqmmc-supply = <&cp0_reg_sd_vccq>;
-	vmmc-supply = <&cp0_reg_sd_vcc>;
-};
+/* Setup A has SPI1 flash as a boot device, while setup B uses NAND flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When SPI controller is enabled, NAND should be disabled.
+ */
 
-/* U55 */
 &cp0_spi1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
-	reg = <0x700680 0x50>;
-
-	spi-flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		/* On-board MUX does not allow higher frequencies */
-		spi-max-frequency = <40000000>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "U-Boot-0";
-				reg = <0x0 0x200000>;
-			};
-
-			partition@400000 {
-				label = "Filesystem-0";
-				reg = <0x200000 0xe00000>;
-			};
-		};
-	};
-};
-
-&cp0_syscon0 {
-	cp0_pinctrl: pinctrl {
-		compatible = "marvell,cp115-standalone-pinctrl";
-
-		cp0_i2c0_pins: cp0-i2c-pins-0 {
-			marvell,pins = "mpp37", "mpp38";
-			marvell,function = "i2c0";
-		};
-		cp0_i2c1_pins: cp0-i2c-pins-1 {
-			marvell,pins = "mpp35", "mpp36";
-			marvell,function = "i2c1";
-		};
-		cp0_ge1_rgmii_pins: cp0-ge-rgmii-pins-0 {
-			marvell,pins = "mpp0", "mpp1", "mpp2",
-				       "mpp3", "mpp4", "mpp5",
-				       "mpp6", "mpp7", "mpp8",
-				       "mpp9", "mpp10", "mpp11";
-			marvell,function = "ge0";
-		};
-		cp0_ge2_rgmii_pins: cp0-ge-rgmii-pins-1 {
-			marvell,pins = "mpp44", "mpp45", "mpp46",
-				       "mpp47", "mpp48", "mpp49",
-				       "mpp50", "mpp51", "mpp52",
-				       "mpp53", "mpp54", "mpp55";
-			marvell,function = "ge1";
-		};
-		cp0_sdhci_cd_pins: cp0-sdhci-cd-pins-0 {
-			marvell,pins = "mpp43";
-			marvell,function = "gpio";
-		};
-		cp0_sdhci_pins: cp0-sdhi-pins-0 {
-			marvell,pins = "mpp56", "mpp57", "mpp58",
-				       "mpp59", "mpp60", "mpp61";
-			marvell,function = "sdio";
-		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
-			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
-			marvell,function = "spi1";
-		};
-		nand_pins: nand-pins {
-			marvell,pins = "mpp15", "mpp16", "mpp17", "mpp18",
-				       "mpp19", "mpp20", "mpp21", "mpp22",
-				       "mpp23", "mpp24", "mpp25", "mpp26",
-				       "mpp27";
-			marvell,function = "dev";
-		};
-		nand_rb: nand-rb {
-			marvell,pins = "mpp13";
-			marvell,function = "nf";
-		};
-	};
-};
-
-&cp0_usb3_0 {
-	status = "okay";
-	usb-phy = <&cp0_usb3_0_phy0>;
-	phy-names = "usb";
 };
 
-&cp0_usb3_1 {
-	status = "okay";
-	usb-phy = <&cp0_usb3_0_phy1>;
-	phy-names = "usb";
-};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
new file mode 100644
index 000000000000..8de3a552b806
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * Device tree for the CN9130-DB board.
+ */
+
+#include "cn9130.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		i2c0 = &cp0_i2c0;
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+		spi1 = &cp0_spi0;
+		spi2 = &cp0_spi1;
+	};
+
+	memory@00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	ap0_reg_sd_vccq: ap0_sd_vccq@0 {
+		compatible = "regulator-gpio";
+		regulator-name = "ap0_sd_vccq";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1 3300000 0x0>;
+	};
+
+	cp0_reg_usb3_vbus0: cp0_usb3_vbus@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp0-xhci0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp0_usb3_0_phy0: cp0_usb3_phy@0 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp0_reg_usb3_vbus0>;
+	};
+
+	cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp0-xhci1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp0_usb3_0_phy1: cp0_usb3_phy@1 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp0_reg_usb3_vbus1>;
+	};
+
+	cp0_reg_sd_vccq: cp0_sd_vccq@0 {
+		compatible = "regulator-gpio";
+		regulator-name = "cp0_sd_vccq";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&expander0 15 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
+
+	cp0_reg_sd_vcc: cp0_sd_vcc@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp0_sd_vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	cp0_sfp_eth0: sfp-eth@0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_sfpp0_i2c>;
+		los-gpio = <&cp0_module_expander1 11 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp0_module_expander1 10 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp0_module_expander1 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_module_expander1 8 GPIO_ACTIVE_HIGH>;
+		/*
+		 * SFP cages are unconnected on early PCBs because of an the I2C
+		 * lanes not being connected. Prevent the port for being
+		 * unusable by disabling the SFP node.
+		 */
+		status = "disabled";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* on-board eMMC - U9 */
+&ap_sdhci0 {
+	pinctrl-names = "default";
+	bus-width = <8>;
+	vqmmc-supply = <&ap0_reg_sd_vccq>;
+	status = "okay";
+};
+
+&cp0_crypto {
+	status = "disabled";
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SLM-1521-V2, CON9 */
+&cp0_eth0 {
+	status = "disabled";
+	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy4 0>;
+	managed = "in-band-status";
+	sfp = <&cp0_sfp_eth0>;
+};
+
+/* CON56 */
+&cp0_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+/* CON57 */
+&cp0_eth2 {
+	status = "okay";
+	phy = <&phy1>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_gpio1 {
+	status = "okay";
+};
+
+&cp0_gpio2 {
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+
+	/* U36 */
+	expander0: pca953x@21 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x21>;
+		status = "okay";
+	};
+
+	/* U42 */
+	eeprom0: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <0x20>;
+	};
+
+	/* U38 */
+	eeprom1: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <0x20>;
+	};
+};
+
+&cp0_i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	/* SLM-1521-V2 - U3 */
+	i2c-mux@72 { /* verify address - depends on dpr */
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x72>;
+		cp0_sfpp0_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* U12 */
+			cp0_module_expander1: pca9555@21 {
+				compatible = "nxp,pca9555";
+				pinctrl-names = "default";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x21>;
+			};
+
+		};
+	};
+};
+
+&cp0_mdio {
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+/* U54 */
+&cp0_nand_controller {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins &nand_rb>;
+
+	nand@0 {
+		reg = <0>;
+		label = "main-storage";
+		nand-rb = <0>;
+		nand-ecc-mode = "hw";
+		nand-on-flash-bbt;
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-Boot";
+				reg = <0 0x200000>;
+			};
+			partition@200000 {
+				label = "Linux";
+				reg = <0x200000 0xe00000>;
+			};
+			partition@1000000 {
+				label = "Filesystem";
+				reg = <0x1000000 0x3f000000>;
+			};
+		};
+	};
+};
+
+/* SLM-1521-V2, CON6 */
+&cp0_pcie0 {
+	status = "okay";
+	num-lanes = <4>;
+	num-viewport = <8>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy0 0
+		&cp0_comphy1 0
+		&cp0_comphy2 0
+		&cp0_comphy3 0>;
+};
+
+&cp0_sata0 {
+	status = "okay";
+
+	/* SLM-1521-V2, CON2 */
+	sata-port@1 {
+		status = "okay";
+		/* Generic PHY, providing serdes lanes */
+		phys = <&cp0_comphy5 1>;
+	};
+};
+
+/* CON 28 */
+&cp0_sdhci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_sdhci_pins
+		     &cp0_sdhci_cd_pins>;
+	bus-width = <4>;
+	cd-gpios = <&cp0_gpio2 11 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	vqmmc-supply = <&cp0_reg_sd_vccq>;
+	vmmc-supply = <&cp0_reg_sd_vcc>;
+};
+
+/* U55 */
+&cp0_spi1 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi0_pins>;
+	reg = <0x700680 0x50>;
+
+	spi-flash@0 {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		/* On-board MUX does not allow higher frequencies */
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-Boot-0";
+				reg = <0x0 0x200000>;
+			};
+
+			partition@400000 {
+				label = "Filesystem-0";
+				reg = <0x200000 0xe00000>;
+			};
+		};
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_i2c0_pins: cp0-i2c-pins-0 {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+		cp0_i2c1_pins: cp0-i2c-pins-1 {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+		cp0_ge1_rgmii_pins: cp0-ge-rgmii-pins-0 {
+			marvell,pins = "mpp0", "mpp1", "mpp2",
+				       "mpp3", "mpp4", "mpp5",
+				       "mpp6", "mpp7", "mpp8",
+				       "mpp9", "mpp10", "mpp11";
+			marvell,function = "ge0";
+		};
+		cp0_ge2_rgmii_pins: cp0-ge-rgmii-pins-1 {
+			marvell,pins = "mpp44", "mpp45", "mpp46",
+				       "mpp47", "mpp48", "mpp49",
+				       "mpp50", "mpp51", "mpp52",
+				       "mpp53", "mpp54", "mpp55";
+			marvell,function = "ge1";
+		};
+		cp0_sdhci_cd_pins: cp0-sdhci-cd-pins-0 {
+			marvell,pins = "mpp43";
+			marvell,function = "gpio";
+		};
+		cp0_sdhci_pins: cp0-sdhi-pins-0 {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61";
+			marvell,function = "sdio";
+		};
+		cp0_spi0_pins: cp0-spi-pins-0 {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+		nand_pins: nand-pins {
+			marvell,pins = "mpp15", "mpp16", "mpp17", "mpp18",
+				       "mpp19", "mpp20", "mpp21", "mpp22",
+				       "mpp23", "mpp24", "mpp25", "mpp26",
+				       "mpp27";
+			marvell,function = "dev";
+		};
+		nand_rb: nand-rb {
+			marvell,pins = "mpp13";
+			marvell,function = "nf";
+		};
+	};
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy0>;
+	phy-names = "usb";
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy1>;
+	phy-names = "usb";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db-B.dts b/arch/arm64/boot/dts/marvell/cn9131-db-B.dts
new file mode 100644
index 000000000000..183b1ec8b1f0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-db-B.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ *
+ * Device tree for the CN9131-DB board (setup "B").
+ */
+
+#include "cn9131-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9131-DB setup B";
+};
+
+/* Setup B has NAND flash as a boot device, while regular setup uses SPI flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When NAND controller is enabled, SPI1 should be disabled.
+ */
+
+&cp0_nand_controller {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dts b/arch/arm64/boot/dts/marvell/cn9131-db.dts
index 3c975f98b2a3..a60fdee79bf8 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dts
@@ -5,198 +5,18 @@
  * Device tree for the CN9131-DB board.
  */
 
-#include "cn9130-db.dts"
+#include "cn9131-db.dtsi"
 
 / {
-	model = "Marvell Armada CN9131-DB";
-	compatible = "marvell,cn9131", "marvell,cn9130",
-		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
-
-	aliases {
-		gpio3 = &cp1_gpio1;
-		gpio4 = &cp1_gpio2;
-		ethernet3 = &cp1_eth0;
-		ethernet4 = &cp1_eth1;
-	};
-
-	cp1_reg_usb3_vbus0: cp1_usb3_vbus@0 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp1_xhci0_vbus_pins>;
-		regulator-name = "cp1-xhci0-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&cp1_gpio1 3 GPIO_ACTIVE_HIGH>;
-	};
-
-	cp1_usb3_0_phy0: cp1_usb3_phy0 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cp1_reg_usb3_vbus0>;
-	};
-
-	cp1_sfp_eth1: sfp-eth1 {
-		compatible = "sff,sfp";
-		i2c-bus = <&cp1_i2c0>;
-		los-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp1_gpio1 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cp1_sfp_pins>;
-		/*
-		 * SFP cages are unconnected on early PCBs because of an the I2C
-		 * lanes not being connected. Prevent the port for being
-		 * unusable by disabling the SFP node.
-		 */
-		status = "disabled";
-	};
+	model = "Marvell Armada CN9131-DB setup A";
 };
 
-/*
- * Instantiate the first slave CP115
+/* Setup A has SPI1 flash as a boot device, while setup B uses NAND flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When SPI controller is enabled, NAND should be disabled.
  */
 
-#define CP11X_NAME		cp1
-#define CP11X_BASE		f4000000
-#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
-#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
-#define CP11X_PCIE0_BASE	f4600000
-#define CP11X_PCIE1_BASE	f4620000
-#define CP11X_PCIE2_BASE	f4640000
-
-#include "armada-cp115.dtsi"
-
-#undef CP11X_NAME
-#undef CP11X_BASE
-#undef CP11X_PCIEx_MEM_BASE
-#undef CP11X_PCIEx_MEM_SIZE
-#undef CP11X_PCIE0_BASE
-#undef CP11X_PCIE1_BASE
-#undef CP11X_PCIE2_BASE
-
-&cp1_crypto {
-	status = "disabled";
-};
-
-&cp1_ethernet {
-	status = "okay";
-};
-
-/* CON50 */
-&cp1_eth0 {
-	status = "disabled";
-	phy-mode = "10gbase-kr";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy4 0>;
-	managed = "in-band-status";
-	sfp = <&cp1_sfp_eth1>;
-};
-
-&cp1_gpio1 {
-	status = "okay";
-};
-
-&cp1_gpio2 {
-	status = "okay";
-};
-
-&cp1_i2c0 {
+&cp0_spi1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp1_i2c0_pins>;
-	clock-frequency = <100000>;
 };
 
-/* CON40 */
-&cp1_pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp1_pcie_reset_pins>;
-	num-lanes = <2>;
-	num-viewport = <8>;
-	marvell,reset-gpio = <&cp1_gpio1 0 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy0 0
-		&cp1_comphy1 0>;
-};
-
-&cp1_sata0 {
-	status = "okay";
-
-	/* CON32 */
-	sata-port@1 {
-		/* Generic PHY, providing serdes lanes */
-		phys = <&cp1_comphy5 1>;
-	};
-};
-
-/* U24 */
-&cp1_spi1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp1_spi0_pins>;
-	reg = <0x700680 0x50>;
-
-	spi-flash@0 {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		/* On-board MUX does not allow higher frequencies */
-		spi-max-frequency = <40000000>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "U-Boot-1";
-				reg = <0x0 0x200000>;
-			};
-
-			partition@400000 {
-				label = "Filesystem-1";
-				reg = <0x200000 0xe00000>;
-			};
-		};
-	};
-
-};
-
-&cp1_syscon0 {
-	cp1_pinctrl: pinctrl {
-		compatible = "marvell,cp115-standalone-pinctrl";
-
-		cp1_i2c0_pins: cp1-i2c-pins-0 {
-			marvell,pins = "mpp37", "mpp38";
-			marvell,function = "i2c0";
-		};
-		cp1_spi0_pins: cp1-spi-pins-0 {
-			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
-			marvell,function = "spi1";
-		};
-		cp1_xhci0_vbus_pins: cp1-xhci0-vbus-pins {
-			marvell,pins = "mpp3";
-			marvell,function = "gpio";
-		};
-		cp1_sfp_pins: sfp-pins {
-			marvell,pins = "mpp8", "mpp9", "mpp10", "mpp11";
-			marvell,function = "gpio";
-		};
-		cp1_pcie_reset_pins: cp1-pcie-reset-pins {
-			marvell,pins = "mpp0";
-			marvell,function = "gpio";
-		};
-	};
-};
-
-/* CON58 */
-&cp1_usb3_1 {
-	status = "okay";
-	usb-phy = <&cp1_usb3_0_phy0>;
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy3 1>;
-	phy-names = "usb";
-};
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
new file mode 100644
index 000000000000..82471a83ad6d
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ *
+ * Device tree for the CN9131-DB board.
+ */
+
+#include "cn9130-db.dtsi"
+
+/ {
+	compatible = "marvell,cn9131", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	aliases {
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		ethernet3 = &cp1_eth0;
+		ethernet4 = &cp1_eth1;
+	};
+
+	cp1_reg_usb3_vbus0: cp1_usb3_vbus@0 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_xhci0_vbus_pins>;
+		regulator-name = "cp1-xhci0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&cp1_gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp1_usb3_0_phy0: cp1_usb3_phy0 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp1_reg_usb3_vbus0>;
+	};
+
+	cp1_sfp_eth1: sfp-eth1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp1_i2c0>;
+		los-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_sfp_pins>;
+		/*
+		 * SFP cages are unconnected on early PCBs because of an the I2C
+		 * lanes not being connected. Prevent the port for being
+		 * unusable by disabling the SFP node.
+		 */
+		status = "disabled";
+	};
+};
+
+/*
+ * Instantiate the first slave CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+&cp1_crypto {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* CON50 */
+&cp1_eth0 {
+	status = "disabled";
+	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy4 0>;
+	managed = "in-band-status";
+	sfp = <&cp1_sfp_eth1>;
+};
+
+&cp1_gpio1 {
+	status = "okay";
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_i2c0_pins>;
+	clock-frequency = <100000>;
+};
+
+/* CON40 */
+&cp1_pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_pcie_reset_pins>;
+	num-lanes = <2>;
+	num-viewport = <8>;
+	marvell,reset-gpio = <&cp1_gpio1 0 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy0 0
+		&cp1_comphy1 0>;
+};
+
+&cp1_sata0 {
+	status = "okay";
+
+	/* CON32 */
+	sata-port@1 {
+		/* Generic PHY, providing serdes lanes */
+		phys = <&cp1_comphy5 1>;
+	};
+};
+
+/* U24 */
+&cp1_spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_spi0_pins>;
+	reg = <0x700680 0x50>;
+
+	spi-flash@0 {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		/* On-board MUX does not allow higher frequencies */
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-Boot-1";
+				reg = <0x0 0x200000>;
+			};
+
+			partition@400000 {
+				label = "Filesystem-1";
+				reg = <0x200000 0xe00000>;
+			};
+		};
+	};
+
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp1_i2c0_pins: cp1-i2c-pins-0 {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+		cp1_spi0_pins: cp1-spi-pins-0 {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+		cp1_xhci0_vbus_pins: cp1-xhci0-vbus-pins {
+			marvell,pins = "mpp3";
+			marvell,function = "gpio";
+		};
+		cp1_sfp_pins: sfp-pins {
+			marvell,pins = "mpp8", "mpp9", "mpp10", "mpp11";
+			marvell,function = "gpio";
+		};
+		cp1_pcie_reset_pins: cp1-pcie-reset-pins {
+			marvell,pins = "mpp0";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/* CON58 */
+&cp1_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp1_usb3_0_phy0>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy3 1>;
+	phy-names = "usb";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db-B.dts b/arch/arm64/boot/dts/marvell/cn9132-db-B.dts
new file mode 100644
index 000000000000..7137a6f22d0f
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-db-B.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * Device tree for the CN9132-DB board.
+ */
+
+#include "cn9132-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9132-DB setup B";
+};
+
+/* Setup B has NAND flash as a boot device, while regular setup uses SPI flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When NAND controller is enabled, SPI1 should be disabled.
+ */
+
+&cp0_nand_controller {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dts b/arch/arm64/boot/dts/marvell/cn9132-db.dts
index 4ef0df3097ca..1f2e6377afc3 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dts
@@ -5,217 +5,18 @@
  * Device tree for the CN9132-DB board.
  */
 
-#include "cn9131-db.dts"
+#include "cn9132-db.dtsi"
 
 / {
-	model = "Marvell Armada CN9132-DB";
-	compatible = "marvell,cn9132", "marvell,cn9131", "marvell,cn9130",
-		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
-
-	aliases {
-		gpio5 = &cp2_gpio1;
-		gpio6 = &cp2_gpio2;
-		ethernet5 = &cp2_eth0;
-	};
-
-	cp2_reg_usb3_vbus0: cp2_usb3_vbus@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "cp2-xhci0-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&cp2_gpio1 2 GPIO_ACTIVE_HIGH>;
-	};
-
-	cp2_usb3_0_phy0: cp2_usb3_phy0 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cp2_reg_usb3_vbus0>;
-	};
-
-	cp2_reg_usb3_vbus1: cp2_usb3_vbus@1 {
-		compatible = "regulator-fixed";
-		regulator-name = "cp2-xhci1-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&cp2_gpio1 3 GPIO_ACTIVE_HIGH>;
-	};
-
-	cp2_usb3_0_phy1: cp2_usb3_phy1 {
-		compatible = "usb-nop-xceiv";
-		vcc-supply = <&cp2_reg_usb3_vbus1>;
-	};
-
-	cp2_reg_sd_vccq: cp2_sd_vccq@0 {
-		compatible = "regulator-gpio";
-		regulator-name = "cp2_sd_vcc";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&cp2_gpio2 17 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x1 3300000 0x0>;
-	};
-
-	cp2_sfp_eth0: sfp-eth0 {
-		compatible = "sff,sfp";
-		i2c-bus = <&cp2_sfpp0_i2c>;
-		los-gpio = <&cp2_module_expander1 11 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&cp2_module_expander1 10 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&cp2_module_expander1 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&cp2_module_expander1 8 GPIO_ACTIVE_HIGH>;
-		/*
-		 * SFP cages are unconnected on early PCBs because of an the I2C
-		 * lanes not being connected. Prevent the port for being
-		 * unusable by disabling the SFP node.
-		 */
-		status = "disabled";
-	};
+	model = "Marvell Armada CN9132-DB setup A";
 };
 
-/*
- * Instantiate the second slave CP115
+/* Setup A has SPI1 flash as a boot device, while setup B uses NAND flash.
+ * Since CP0 SPI1 and CP0 NAND are sharing some pins, they cannot be activated
+ * simultaneously. When SPI controller is enabled, NAND should be disabled.
  */
 
-#define CP11X_NAME		cp2
-#define CP11X_BASE		f6000000
-#define CP11X_PCIEx_MEM_BASE(iface) (0xe5000000 + (iface * 0x1000000))
-#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
-#define CP11X_PCIE0_BASE	f6600000
-#define CP11X_PCIE1_BASE	f6620000
-#define CP11X_PCIE2_BASE	f6640000
-
-#include "armada-cp115.dtsi"
-
-#undef CP11X_NAME
-#undef CP11X_BASE
-#undef CP11X_PCIEx_MEM_BASE
-#undef CP11X_PCIEx_MEM_SIZE
-#undef CP11X_PCIE0_BASE
-#undef CP11X_PCIE1_BASE
-#undef CP11X_PCIE2_BASE
-
-&cp2_crypto {
-	status = "disabled";
-};
-
-&cp2_ethernet {
-	status = "okay";
-};
-
-/* SLM-1521-V2, CON9 */
-&cp2_eth0 {
-	status = "disabled";
-	phy-mode = "10gbase-kr";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy4 0>;
-	managed = "in-band-status";
-	sfp = <&cp2_sfp_eth0>;
-};
-
-&cp2_gpio1 {
-	status = "okay";
-};
-
-&cp2_gpio2 {
-	status = "okay";
-};
-
-&cp2_i2c0 {
-	clock-frequency = <100000>;
-
-	/* SLM-1521-V2 - U3 */
-	i2c-mux@72 {
-		compatible = "nxp,pca9544";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x72>;
-		cp2_sfpp0_i2c: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			/* U12 */
-			cp2_module_expander1: pca9555@21 {
-				compatible = "nxp,pca9555";
-				pinctrl-names = "default";
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x21>;
-			};
-		};
-	};
-};
-
-/* SLM-1521-V2, CON6 */
-&cp2_pcie0 {
-	status = "okay";
-	num-lanes = <2>;
-	num-viewport = <8>;
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy0 0
-		&cp2_comphy1 0>;
-};
-
-/* SLM-1521-V2, CON8 */
-&cp2_pcie2 {
-	status = "okay";
-	num-lanes = <1>;
-	num-viewport = <8>;
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy5 2>;
-};
-
-&cp2_sata0 {
+&cp0_spi1 {
 	status = "okay";
-
-	/* SLM-1521-V2, CON4 */
-	sata-port@0 {
-		/* Generic PHY, providing serdes lanes */
-		phys = <&cp2_comphy2 0>;
-	};
 };
 
-/* CON 2 on SLM-1683 - microSD */
-&cp2_sdhci0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp2_sdhci_pins>;
-	bus-width = <4>;
-	cd-gpios = <&cp2_gpio2 23 GPIO_ACTIVE_LOW>;
-	vqmmc-supply = <&cp2_reg_sd_vccq>;
-};
-
-&cp2_syscon0 {
-	cp2_pinctrl: pinctrl {
-		compatible = "marvell,cp115-standalone-pinctrl";
-
-		cp2_i2c0_pins: cp2-i2c-pins-0 {
-			marvell,pins = "mpp37", "mpp38";
-			marvell,function = "i2c0";
-		};
-		cp2_sdhci_pins: cp2-sdhi-pins-0 {
-			marvell,pins = "mpp56", "mpp57", "mpp58",
-				       "mpp59", "mpp60", "mpp61";
-			marvell,function = "sdio";
-		};
-	};
-};
-
-&cp2_usb3_0 {
-	status = "okay";
-	usb-phy = <&cp2_usb3_0_phy0>;
-	phy-names = "usb";
-};
-
-/* SLM-1521-V2, CON11 */
-&cp2_usb3_1 {
-	status = "okay";
-	usb-phy = <&cp2_usb3_0_phy1>;
-	phy-names = "usb";
-	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy3 1>;
-};
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
new file mode 100644
index 000000000000..0c2d9f57318b
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ *
+ * Device tree for the CN9132-DB board.
+ */
+
+#include "cn9131-db.dtsi"
+
+/ {
+	compatible = "marvell,cn9132", "marvell,cn9131", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	aliases {
+		gpio5 = &cp2_gpio1;
+		gpio6 = &cp2_gpio2;
+		ethernet5 = &cp2_eth0;
+	};
+
+	cp2_reg_usb3_vbus0: cp2_usb3_vbus@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp2-xhci0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&cp2_gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp2_usb3_0_phy0: cp2_usb3_phy0 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp2_reg_usb3_vbus0>;
+	};
+
+	cp2_reg_usb3_vbus1: cp2_usb3_vbus@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp2-xhci1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&cp2_gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp2_usb3_0_phy1: cp2_usb3_phy1 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp2_reg_usb3_vbus1>;
+	};
+
+	cp2_reg_sd_vccq: cp2_sd_vccq@0 {
+		compatible = "regulator-gpio";
+		regulator-name = "cp2_sd_vcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&cp2_gpio2 17 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1 3300000 0x0>;
+	};
+
+	cp2_sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp2_sfpp0_i2c>;
+		los-gpio = <&cp2_module_expander1 11 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp2_module_expander1 10 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp2_module_expander1 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp2_module_expander1 8 GPIO_ACTIVE_HIGH>;
+		/*
+		 * SFP cages are unconnected on early PCBs because of an the I2C
+		 * lanes not being connected. Prevent the port for being
+		 * unusable by disabling the SFP node.
+		 */
+		status = "disabled";
+	};
+};
+
+/*
+ * Instantiate the second slave CP115
+ */
+
+#define CP11X_NAME		cp2
+#define CP11X_BASE		f6000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe5000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f6600000
+#define CP11X_PCIE1_BASE	f6620000
+#define CP11X_PCIE2_BASE	f6640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+&cp2_crypto {
+	status = "disabled";
+};
+
+&cp2_ethernet {
+	status = "okay";
+};
+
+/* SLM-1521-V2, CON9 */
+&cp2_eth0 {
+	status = "disabled";
+	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp2_comphy4 0>;
+	managed = "in-band-status";
+	sfp = <&cp2_sfp_eth0>;
+};
+
+&cp2_gpio1 {
+	status = "okay";
+};
+
+&cp2_gpio2 {
+	status = "okay";
+};
+
+&cp2_i2c0 {
+	clock-frequency = <100000>;
+
+	/* SLM-1521-V2 - U3 */
+	i2c-mux@72 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x72>;
+		cp2_sfpp0_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* U12 */
+			cp2_module_expander1: pca9555@21 {
+				compatible = "nxp,pca9555";
+				pinctrl-names = "default";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x21>;
+			};
+		};
+	};
+};
+
+/* SLM-1521-V2, CON6 */
+&cp2_pcie0 {
+	status = "okay";
+	num-lanes = <2>;
+	num-viewport = <8>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp2_comphy0 0
+		&cp2_comphy1 0>;
+};
+
+/* SLM-1521-V2, CON8 */
+&cp2_pcie2 {
+	status = "okay";
+	num-lanes = <1>;
+	num-viewport = <8>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp2_comphy5 2>;
+};
+
+&cp2_sata0 {
+	status = "okay";
+
+	/* SLM-1521-V2, CON4 */
+	sata-port@0 {
+		/* Generic PHY, providing serdes lanes */
+		phys = <&cp2_comphy2 0>;
+	};
+};
+
+/* CON 2 on SLM-1683 - microSD */
+&cp2_sdhci0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2_sdhci_pins>;
+	bus-width = <4>;
+	cd-gpios = <&cp2_gpio2 23 GPIO_ACTIVE_LOW>;
+	vqmmc-supply = <&cp2_reg_sd_vccq>;
+};
+
+&cp2_syscon0 {
+	cp2_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp2_i2c0_pins: cp2-i2c-pins-0 {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+		cp2_sdhci_pins: cp2-sdhi-pins-0 {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61";
+			marvell,function = "sdio";
+		};
+	};
+};
+
+&cp2_usb3_0 {
+	status = "okay";
+	usb-phy = <&cp2_usb3_0_phy0>;
+	phy-names = "usb";
+};
+
+/* SLM-1521-V2, CON11 */
+&cp2_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp2_usb3_0_phy1>;
+	phy-names = "usb";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp2_comphy3 1>;
+};
-- 
2.17.1

