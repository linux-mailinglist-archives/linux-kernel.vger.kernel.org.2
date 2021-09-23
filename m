Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20141651E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhIWSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhIWSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:20:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:18:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so19779283wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnjMNCMHJD801NqNWX0wNVVKm8RKZ3cZooPrp+qOtYA=;
        b=gptPla15EWLMjESwGIE5ohpg6Es/2KU12T8KfZF9domlXR+jCtQDUDp/gwOkI9C8x8
         Cj8A0YEQv7/OIwbjD8cp/NW7N1INWP3/tZFi5Jor86dfH0YJAY2wCro9ZmLap7uONB8H
         U/EpGsLq+vr1xUuzpQnA868pxo4TtSu/DWheQ1HqWIjBhBKUHVQn258AMASNB2TfkpOL
         IdvZwuXcZ9kTC+QiA2iqaio/iR+12UyZKSnyDaSlcFcixH4YIDZAxI3NtzzrFv/j53hm
         OEYpeLa14KFMm4haBrnbjG8eWU/PO7ORwaeR4qLjJW046kN+SCxFyLCtaFJTv2sCo41o
         8AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnjMNCMHJD801NqNWX0wNVVKm8RKZ3cZooPrp+qOtYA=;
        b=yoUqm1sY5jjhXQb06GFQ38azrw52qlcG9iCgNsRegZvz5Iecerz0eNqgIG+lHADmHT
         0nh9xdm9DRRf9J19Z8FVO8AN/vKtk5EJQWrm/+8VD+4HSpbKfA1QjpHjmrXoyNr227xg
         xloFIh2ouW5nIY5QEvOlIPFvihonbDFz50Ez1gz2oG9erAoUeOde+h7ieRFob8624vbU
         qPE8O2wTXj1H5TzUZchPP5ygaWfC2BxbisL02F4m4YRkKFAd6SW/v+TaDkOKPI/Xpo79
         2ghzzrJzG+EemsXMMi9wbeaDYBwZCrr4WsJ6DfEmqrWiV8pMgVS7G5EGjDYTfsXepOwU
         iN9A==
X-Gm-Message-State: AOAM533SuvaWty0Z6CXejWZnxAAPvBlQ1IRV1eTeJ2W4m9V0Xm0FWqnB
        Bc9QOmZ0JBTgGhvZk+zHGkGYZhRp0cqICw==
X-Google-Smtp-Source: ABdhPJyq8lHed+Gq+6LJQeXLoVlv5YHdm653UZ+glzuvj0eLfeYCry5qENzdJIjXkmj1CAPI/ghkSw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr6683766wrt.209.1632421116621;
        Thu, 23 Sep 2021 11:18:36 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-162-cbl.xnet.hr. [94.253.144.162])
        by smtp.googlemail.com with ESMTPSA id 61sm6251062wrl.94.2021.09.23.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:18:36 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3] arm64: dts: marvell: add Globalscale MOCHAbin
Date:   Thu, 23 Sep 2021 20:18:30 +0200
Message-Id: <20210923181830.3449602-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Globalscale MOCHAbin is a Armada 7040 based development board.

Specifications:
* Armada 7040 Quad core ARMv8 Cortex A-72 @ 1.4GHz
* 2 / 4 / 8 GB of DDR4 DRAM
* 16 GB eMMC
* 4MB SPI-NOR (Bootloader)
* 1x M.2-2280 B-key socket (for SSD expansion, SATA3 only)
* 1x M.2-2250 B-key socket (for modems, USB2.0 and I2C only)
* 1x Mini-PCIe 3.0 (x1, USB2.0 and I2C)
* 1x SATA 7+15 socket (SATA3)
* 1x 16-pin (2×8) MikroBus Connector
* 1x SIM card slot (Connected to the mini-PCIe and both M.2 slots)
* 2x USB3.0 Type-A ports via SMSC USB5434B hub
* Cortex 2x5 JTAG
* microUSB port for UART (PL2303GL/PL2303SA onboard)
* 1x 10G SFP+
* 1x 1G SFP (Connected to 88E1512 PHY)
* 1x 1G RJ45 with PoE PD (Connected to 88E1512 PHY)
* 4x 1G RJ45 ports via Topaz 88E6141 switch
* RTC with battery holder (SoC provided, requires CR2032 battery)
* 1x 12V DC IN
* 1x Power switch
* 1x 12V fan header (3-pin, power only)
* 1x mini-PCIe LED header (2x0.1" pins)
* 1x M.2-2280 LED header (2x0.1" pins)
* 6x Bootstrap jumpers
* 1x Power LED (Green)
* 3x Tri-color RGB LEDs (Controllable)
* 1x Microchip ATECC608B secure element

Note that 1G SFP and 1G WAN cannot be used at the same time as they are in
parallel connected to the same PHY.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Use IRQ_TYPE_LEVEL_LOW instead of IRQ_TYPE_EDGE_FALLING as both the
PCA9554 and Topaz switch have an active LOW IRQ signal.

Changes in v2:
* Use "10gbase-r" instead of "10gbase-kr"
---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-7040-mochabin.dts | 452 ++++++++++++++++++
 2 files changed, 453 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 34efe0fb6f37..4d3a2ae9adbd 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-mochabin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
new file mode 100644
index 000000000000..f7b8ef5eeaf0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree file for Globalscale MOCHAbin
+ * Copyright (C) 2019 Globalscale technologies, Inc.
+ * Copyright (C) 2021 Sartura Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-7040.dtsi"
+
+/ {
+	model = "Globalscale MOCHAbin";
+	compatible = "globalscale,mochabin", "marvell,armada7040",
+		     "marvell,armada-ap806-quad", "marvell,armada-ap806";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+		ethernet3 = &swport1;
+		ethernet4 = &swport2;
+		ethernet5 = &swport3;
+		ethernet6 = &swport4;
+	};
+
+	/* SFP+ 10G */
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpio = <&sfp_gpio 3 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&sfp_gpio 2 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&sfp_gpio 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio  = <&sfp_gpio 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* SFP 1G */
+	sfp_eth2: sfp-eth2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c0>;
+		los-gpio = <&sfp_gpio 7 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&sfp_gpio 6 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&sfp_gpio 5 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio  = <&sfp_gpio 4 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* microUSB UART console */
+&uart0 {
+	status = "okay";
+
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+};
+
+/* eMMC */
+&ap_sdhci0 {
+	status = "okay";
+
+	bus-width = <4>;
+	non-removable;
+	/delete-property/ marvell,xenon-phy-slow-mode;
+	no-1-8-v;
+};
+
+&cp0_pinctrl {
+	cp0_uart0_pins: cp0-uart0-pins {
+		marvell,pins = "mpp6", "mpp7";
+		marvell,function = "uart0";
+	};
+
+	cp0_spi0_pins: cp0-spi0-pins {
+		marvell,pins = "mpp56", "mpp57", "mpp58", "mpp59";
+		marvell,function = "spi0";
+	};
+
+	cp0_spi1_pins: cp0-spi1-pins {
+		marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+		marvell,function = "spi1";
+	};
+
+	cp0_i2c0_pins: cp0-i2c0-pins {
+		marvell,pins = "mpp37", "mpp38";
+		marvell,function = "i2c0";
+	};
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "i2c1";
+	};
+
+	pca9554_int_pins: pca9554-int-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_rgmii1_pins: cp0-rgmii1-pins {
+		marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47", "mpp48", "mpp49",
+			       "mpp50", "mpp51", "mpp52", "mpp53", "mpp54", "mpp55";
+		marvell,function = "ge1";
+	};
+
+	is31_sdb_pins: is31-sdb-pins {
+		marvell,pins = "mpp30";
+		marvell,function = "gpio";
+	};
+
+	cp0_pcie_reset_pins: cp0-pcie-reset-pins {
+		marvell,pins = "mpp9";
+		marvell,function = "gpio";
+	};
+
+	cp0_switch_pins: cp0-switch-pins {
+		marvell,pins = "mpp0", "mpp1";
+		marvell,function = "gpio";
+	};
+
+	cp0_phy_pins: cp0-phy-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "gpio";
+	};
+};
+
+/* mikroBUS UART */
+&cp0_uart0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart0_pins>;
+};
+
+/* mikroBUS SPI */
+&cp0_spi0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi0_pins>;
+};
+
+/* SPI-NOR */
+&cp0_spi1{
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x3e0000>;
+				read-only;
+			};
+
+			partition@3e0000 {
+				label = "hw-info";
+				reg = <0x3e0000 0x10000>;
+				read-only;
+			};
+
+			partition@3f0000 {
+				label = "u-boot-env";
+				reg = <0x3f0000 0x10000>;
+			};
+		};
+	};
+};
+
+/* mikroBUS, 1G SFP and GPIO expander */
+&cp0_i2c0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+
+	sfp_gpio: pca9554@39 {
+		compatible = "nxp,pca9554";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pca9554_int_pins>;
+		reg = <0x39>;
+
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/*
+		 * IO0_0: SFP+_TX_FAULT
+		 * IO0_1: SFP+_TX_DISABLE
+		 * IO0_2: SFP+_PRSNT
+		 * IO0_3: SFP+_LOSS
+		 * IO0_4: SFP_TX_FAULT
+		 * IO0_5: SFP_TX_DISABLE
+		 * IO0_6: SFP_PRSNT
+		 * IO0_7: SFP_LOSS
+		 */
+	};
+};
+
+/* IS31FL3199, mini-PCIe and 10G SFP+ */
+&cp0_i2c1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	clock-frequency = <100000>;
+
+	leds@64 {
+		compatible = "issi,is31fl3199";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&is31_sdb_pins>;
+		shutdown-gpios = <&cp0_gpio1 30 GPIO_ACTIVE_HIGH>;
+		reg = <0x64>;
+
+		led1_red: led@1 {
+			label = "led1:red";
+			reg = <1>;
+			led-max-microamp = <20000>;
+		};
+
+		led1_green: led@2 {
+			label = "led1:green";
+			reg = <2>;
+		};
+
+		led1_blue: led@3 {
+			label = "led1:blue";
+			reg = <3>;
+		};
+
+		led2_red: led@4 {
+			label = "led2:red";
+			reg = <4>;
+		};
+
+		led2_green: led@5 {
+			label = "led2:green";
+			reg = <5>;
+		};
+
+		led2_blue: led@6 {
+			label = "led2:blue";
+			reg = <6>;
+		};
+
+		led3_red: led@7 {
+			label = "led3:red";
+			reg = <7>;
+		};
+
+		led3_green: led@8 {
+			label = "led3:green";
+			reg = <8>;
+		};
+
+		led3_blue: led@9 {
+			label = "led3:blue";
+			reg = <9>;
+		};
+	};
+};
+
+&cp0_mdio {
+	status = "okay";
+
+	/* 88E1512 PHY */
+	eth2phy: ethernet-phy@1 {
+		reg = <1>;
+		sfp = <&sfp_eth2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_phy_pins>;
+		reset-gpios = <&cp0_gpio1 12 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 88E6141 Topaz switch */
+	switch: switch@3 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_switch_pins>;
+		reset-gpios = <&cp0_gpio1 0 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			swport1: port@1 {
+				reg = <1>;
+				label = "lan0";
+				phy-handle = <&swphy1>;
+			};
+
+			swport2: port@2 {
+				reg = <2>;
+				label = "lan1";
+				phy-handle = <&swphy2>;
+			};
+
+			swport3: port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy-handle = <&swphy3>;
+			};
+
+			swport4: port@4 {
+				reg = <4>;
+				label = "lan3";
+				phy-handle = <&swphy4>;
+			};
+
+			port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth1>;
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			swphy1: swphy1@17 {
+				reg = <17>;
+			};
+
+			swphy2: swphy2@18 {
+				reg = <18>;
+			};
+
+			swphy3: swphy3@19 {
+				reg = <19>;
+			};
+
+			swphy4: swphy4@20 {
+				reg = <20>;
+			};
+		};
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* 10G SFP+ */
+&cp0_eth0 {
+	status = "okay";
+
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy4 0>;
+	managed = "in-band-status";
+	sfp = <&sfp_eth0>;
+};
+
+/* Topaz switch uplink */
+&cp0_eth1 {
+	status = "okay";
+
+	phy-mode = "2500base-x";
+	phys = <&cp0_comphy0 1>;
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+	};
+};
+
+/* 1G SFP or 1G RJ45 */
+&cp0_eth2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_rgmii1_pins>;
+
+	phy = <&eth2phy>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+/* SMSC USB5434B hub */
+&cp0_usb3_0 {
+	status = "okay";
+
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "cp0-usb3h0-comphy", "utmi";
+};
+
+/* miniPCI-E USB */
+&cp0_usb3_1 {
+	status = "okay";
+};
+
+&cp0_sata0 {
+	status = "okay";
+
+	/* 7 + 12 SATA connector (J24) */
+	sata-port@0 {
+		phys = <&cp0_comphy2 0>;
+		phy-names = "cp0-sata0-0-phy";
+	};
+
+	/* M.2-2250 B-key (J39) */
+	sata-port@1 {
+		phys = <&cp0_comphy3 1>;
+		phy-names = "cp0-sata0-1-phy";
+	};
+};
+
+/* miniPCI-E (J5) */
+&cp0_pcie2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_pcie_reset_pins>;
+	phys = <&cp0_comphy5 2>;
+	phy-names = "cp0-pcie2-x1-phy";
+	reset-gpio = <&cp0_gpio1 9 GPIO_ACTIVE_LOW>;
+};
-- 
2.31.1

