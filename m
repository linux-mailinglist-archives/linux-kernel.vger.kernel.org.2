Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB83167D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBJNTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:19:42 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24626 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhBJNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:17:42 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ADGOir023222;
        Wed, 10 Feb 2021 05:16:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=q0uHQSnmIUwPJEruthAl8tsRDnpmyDAxgo+KyTJEQQQ=;
 b=ewqEa426tQR2S0KDB9xfzsRr+w1fW81xLMsexwcw0ANz7xpT1sm5qLquCCPJ0HgiPobc
 O7Dfjd2mca0oqj4HBACUmD/HUgBg2CxupJChANeYFUlXxko47G1C/Z5GG5KZD/W4YA3M
 kblWNPoABsoUMtQQiCdZN2B423CHdnkLj4g6lJ0gBfAZrQjoqE50hdfecFIlchuocwcf
 Z7IqCRAIjTP+muQTVA/nrHb7wwynYluU5ykcQWC4VSJmaJM8t713BbNj4FSr5tcu6Ukh
 itvr9QR7njs1AKpqzOqxVdXAgSjqqvi4khkoZDgHJoVbWnCDHlA44Fxnc7Rf6N3/oPSp 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbn6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:16:37 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:16:35 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 37B833F7041;
        Wed, 10 Feb 2021 05:16:31 -0800 (PST)
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
Subject: [PATCH v5 5/5] arm64: dts: add support for Marvell cn9130-crb platform
Date:   Wed, 10 Feb 2021 15:16:04 +0200
Message-ID: <20210210131604.28806-6-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210131604.28806-1-kostap@marvell.com>
References: <20210210131604.28806-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

The Marvell reference platform CN9130-CRB is a small form factor
board in a metal case. The platform is based on CN9130 SoC with
addition of 8 Gigabit ports SOHO Ethernet switch.
The reference platform features the following:
* Up to 4 CPU cores ARMv8 Cortex-A72 CPU
* CPU core operating speed of up to 2.2GHz
* DDR4 DIMM – 8GB 64bit+ECC @ 2400Mhz.
* 1x eMMC 8GB device
* 1x uSD card 4 bits port on CP
* 1x 128MB SPI NOR flash memory
* 1x USB 3.0 Host port (Type A)
* 1x SATA Gen3 via M.2
* 1x USB 3.0 via M.2
* 1x SIM card slot
* 1x 1G Ethernet port via RGMII
* 1x 10G switch port over SFP+ connector
* 8x 1G ports through 88E6393X switch via XFI
* 1x 2.5G/1G/100M/10M port via HS_SGMII
* 1x PCI Express (PCIe)x1 Gen 3.0
* 1x PCI Express (PCIe)x4 Gen 3.0 via NVMe M.2
* JTAG port

The CRB board uses MCP23017 i2c pin controller that drives the
onboard eMMC abd USB 3,0 port power lines.
The following configuration should be enabled for this controller
support:
CONFIG_PINCTRL_MCP23S08=y

The plaform supports two HW configurations - "A" and "B"
CN9130-CRB-A
* AP-MPP configuration: SDIO, UART
* CP0 Serdes configuration:
	* Lane0-3: NVMe (PCIe x4)
	* Lane4: XFI
	* Lane5: HS_SGMII

2. CN9130-CRB-B
* AP-MPP configuration: SDIO, UART
* CP0-MPP configuration: RGMII, SDIO, I2C0, I2C1, SMI, XSMI
* CP0 Serdes configuration:
	* Lane0: PCIe x1
	* Lane1: USB3_0 x1
	* Lane2: SATA x1
	* Lane3: USB3_1 x1
	* Lane4: XFI
	* Lane5: HS_SGMII

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/Makefile         |   2 +
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts |  38 ++++
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts |  46 ++++
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi  | 222 ++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 5e39f9774e68..c686a8dd3ca5 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -21,3 +21,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9131-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9131-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
new file mode 100644
index 000000000000..a7b6dfba8af5
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ */
+
+#include "cn9130-crb.dtsi"
+
+/ {
+	model = "Marvell Armada CN9130-CRB-A";
+};
+
+&cp0_pcie0 {
+	status = "okay";
+	num-lanes = <4>;
+	num-viewport = <8>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy0 0
+		&cp0_comphy1 0
+		&cp0_comphy2 0
+		&cp0_comphy3 0>;
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
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
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
new file mode 100644
index 000000000000..0904cb0309ae
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ */
+
+#include "cn9130-crb.dtsi"
+
+/ {
+	model = "Marvell Armada CN9130-CRB-B";
+};
+
+&cp0_pcie0 {
+	status = "okay";
+	num-lanes = <1>;
+	num-viewport = <8>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy0 0>;
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
+};
+
+&cp0_sata0 {
+	status = "okay";
+	sata-port@0 {
+		status = "okay";
+		/* Generic PHY, providing serdes lanes */
+		phys = <&cp0_comphy2 0>;
+	};
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy0>;
+	phy-names = "usb";
+	phys = <&cp0_comphy1 0>;
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy1>;
+	phy-names = "usb";
+	phys = <&cp0_comphy3 1>;
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
new file mode 100644
index 000000000000..75933477324a
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Marvell International Ltd.
+ */
+
+#include "cn9130.dtsi" /* include SoC device tree */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		i2c0 = &cp0_i2c0;
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+	};
+
+	memory@00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	ap0_reg_mmc_vccq: ap0_mmc_vccq@0 {
+		compatible = "regulator-gpio";
+		regulator-name = "ap0_mmc_vccq";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&expander0 5 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
+
+	cp0_reg_usb3_vbus1: cp0_usb3_vbus@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp0-xhci1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander0 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	cp0_usb3_0_phy0: cp0_usb3_phy0 {
+		compatible = "usb-nop-xceiv";
+	};
+
+	cp0_usb3_0_phy1: cp0_usb3_phy1 {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cp0_reg_usb3_vbus1>;
+	};
+
+	cp0_reg_sd_vccq: cp0_sd_vccq@0 {
+		compatible = "regulator-gpio";
+		regulator-name = "cp0_sd_vccq";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&cp0_gpio2 18 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
+
+	cp0_reg_sd_vcc: cp0_sd_vcc@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp0_sd_vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* on-board eMMC U6 */
+&ap_sdhci0 {
+	pinctrl-names = "default";
+	bus-width = <8>;
+	status = "okay";
+	mmc-ddr-1_8v;
+	vqmmc-supply = <&ap0_reg_mmc_vccq>;
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
+		cp0_sdhci_cd_pins_crb: cp0-sdhci-cd-pins-crb {
+			marvell,pins = "mpp55";
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
+	};
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	status = "okay";
+	clock-frequency = <100000>;
+	expander0: mcp23x17@20 {
+		compatible = "microchip,mcp23017";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x20>;
+		status = "okay";
+	};
+};
+
+&cp0_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+
+&cp0_sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_sdhci_pins
+		     &cp0_sdhci_cd_pins_crb>;
+	bus-width = <4>;
+	cd-gpios = <&cp0_gpio2 23 GPIO_ACTIVE_HIGH>;
+	vqmmc-supply = <&cp0_reg_sd_vccq>;
+	vmmc-supply = <&cp0_reg_sd_vcc>;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi0_pins>;
+	reg = <0x700680 0x50>,		/* control */
+	      <0x2000000 0x1000000>;	/* CS0 */
+	status = "okay";
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
+				label = "U-Boot";
+				reg = <0x0 0x200000>;
+			};
+
+			partition@400000 {
+				label = "Filesystem";
+				reg = <0x200000 0xe00000>;
+			};
+		};
+	};
+};
+
+&cp0_mdio {
+	status = "okay";
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_xmdio {
+	status = "okay";
+	nbaset_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth0 {
+	/* This port is connected to 88E6393X switch */
+	status = "okay";
+	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	phys = <&cp0_comphy4 0>;
+};
+
+&cp0_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_eth2 {
+	/* This port uses "2500base-t" phy-mode */
+	status = "disabled";
+	phy = <&nbaset_phy0>;
+	phys = <&cp0_comphy5 2>;
+};
+
-- 
2.17.1

