Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F503FEE75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbhIBNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:13:46 -0400
Received: from mx.msync.work ([95.217.65.204]:51312 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344998AbhIBNNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:14 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 09:13:13 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3CC0D3645;
        Thu,  2 Sep 2021 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630587942; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=RWAoVYwEp4IMd+8dPIbqauHhMLVqn1vvfdHSoCyC0tY=;
        b=xs7y4AIpBCfSskPAWnTCHelPnAGGgBx3/abslaDOzfw9AeuBWOZJcXjGorPK0Xb5eWvdyj
        DVxJZjhSmOG+uXFO+v9LHmfnTd7npWzGi1BAG2WiFP8VbUHuFZdpBrTPZBPbaYv6FB4uxk
        +QrbEPDF+VltuTStyHl9ut6Abq72pggHVciz0U/dPkvVmh7Dhhq4gSNKDZi1tCWOLCz3vy
        OrgtiB89h6t5F6WsJgSTdfWKlUFOuLtv2oVG3C9ZbTzZ/VHq+ZlzdR1wMEG7czIEmPE4JX
        Sw17DhK/77R8SBJmuqc9iyPmKG37ZBelD7PmxvBrYJS4PeyigUxxEhIRT37Vdg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-axg: add support for JetHub D1
Date:   Thu,  2 Sep 2021 16:05:15 +0300
Message-Id: <20210902130516.3892452-3-adeep@lexina.in>
In-Reply-To: <20210902130516.3892452-1-adeep@lexina.in>
References: <20210902130516.3892452-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller with the following features:
- DIN Rail Mounting
- Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 512Mb/1GB LPDDR4
- 8/16GB eMMC flash
- 1 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
- 2 x gpio LEDS
- GPIO user Button
- 1 x 1-Wire
- 2 x RS-485
- 4 x dry contact digital GPIO inputs
- 3 x relay GPIO outputs
- DC source with a voltage of 9 to 56 V / Passive POE

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-axg-jethome-jethub-j100.dts | 439 ++++++++++++++++++
 2 files changed, 440 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 2c3ce7c401a5..3ba6f58b9833 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
new file mode 100644
index 000000000000..68d688528c86
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -0,0 +1,439 @@
+
+/dts-v1/;
+
+#include "meson-axg.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "jethome,j100", "amlogic,a113d", "amlogic,meson-axg";
+	model = "JetHome JetHub J100";
+	amlogic-dt-id = "axg_jethubj100_v1";
+
+	aliases {
+		serial0 = &uart_AO;   /* Console */
+		serial1 = &uart_B;    /* Bluetooth */
+		serial2 = &uart_AO_B; /* External UART (Wireless Module) */
+		ethernet0 = &ethmac;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* 1024MB RAM */
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable; size = <0x0 0x400000>;
+			alignment = <0x0 0x400000>;
+			linux,cma-default;
+		};
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vcc_5v: regulator-vcc_5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v>;
+		regulator-always-on;
+	};
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	usb_pwr: regulator-usb_pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_PWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v>;
+		regulator-always-on;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
+	};
+
+	partitions: partitions {
+		parts = <1>;
+		part-0 = <&rootfs>;
+		rootfs: rootfs {
+			pname = "rootfs";
+			size = <0xffffffff 0xffffffff>;
+			mask = <4>;
+		};
+	};
+
+	efusekey: efusekey {
+		keynum = <5>;
+		key0 = <&key_0>;
+		key1 = <&key_1>;
+		key2 = <&key_2>;
+		key3 = <&key_3>;
+		key4 = <&key_4>;
+
+		key_0: key_0 {
+			keyname = "mac";
+			offset = <0>;
+			size = <6>;
+		};
+		key_1: key_1 {
+			keyname = "mac_bt";
+			offset = <6>;
+			size = <6>;
+		};
+		key_2: key_2 {
+			keyname = "mac_wifi";
+			offset = <12>;
+			size = <6>;
+		};
+		key_3: key_3 {
+			keyname = "usid";
+			offset = <18>;
+			size = <32>;
+		};
+		key_4: key_4 {
+			keyname = "serial";
+			offset = <50>;
+			size = <32>;
+		};
+	}; //End efusekey
+
+	unifykey {
+		compatible = "amlogic, unifykey";
+		status = "ok";
+		unifykey-num = <6>;
+		unifykey-index-0 = <&keysn_0>;
+		unifykey-index-1 = <&keysn_1>;
+		unifykey-index-2 = <&keysn_2>;
+		unifykey-index-3 = <&keysn_3>;
+		unifykey-index-4 = <&keysn_4>;
+		unifykey-index-5 = <&keysn_5>;
+
+		keysn_0: key_0 {
+			key-name = "usid";
+			key-device = "normal";
+			key-permit = "read";
+		};
+		keysn_1: key_1 {
+			key-name = "mac";
+			key-device = "normal";
+			key-permit = "read";
+		};
+		keysn_2: key_2 {
+			key-name = "mac_bt";
+			key-device = "normal";
+			key-permit = "read","write","del";
+			key-type  = "mac";
+		};
+		keysn_3: key_3 {
+			key-name = "mac_wifi";
+			key-device = "normal";
+			key-permit = "read","write","del";
+			key-type = "mac";
+		};
+		keysn_4: key_4 {
+			key-name = "serial";
+			key-device = "normal";
+			key-permit = "read";
+		};
+		keysn_5:key_5 {
+			key-name = "deviceid";
+			key-device = "normal";
+			key-permit = "read","write","del";
+		};
+	}; //End unifykey
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&scpi_sensors 0>;
+			trips {
+				cpu_passive: cpu-passive {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_hot: cpu-hot {
+					temperature = <80000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "hot";
+				};
+				cpu_critical: cpu-critical {
+					temperature = <100000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+		};
+		cpu_cooling_maps: cooling-maps {
+			map0 {
+				trip = <&cpu_passive>;
+				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+			map1 {
+				trip = <&cpu_hot>;
+				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rmii_x_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rmii";
+	internal_phy=<0>;
+	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ICPlus IP101A/G Ethernet PHY (vendor_id=0x0243, model_id=0x0c54) */
+		eth_phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0243.0c54";
+			max-speed = <100>;
+			reg = <0>;
+
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+			reset-gpios = <&gpio GPIOZ_5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* Internal I2C bus (on CPU module) */
+&i2c1 {
+	status = "okay";
+	pinctrl-0 = <&i2c1_z_pins>;
+	pinctrl-names = "default";
+
+	/* RTC */
+	pcf8563: pcf8563@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		status = "okay";
+	};
+};
+
+/* Peripheral I2C bus (on motherboard) */
+&i2c_AO {
+	status = "okay";
+	pinctrl-0 = <&i2c_ao_sck_10_pins>, <&i2c_ao_sda_11_pins>;
+	pinctrl-names = "default";
+};
+
+&pwm_ab {
+	status = "okay";
+	pinctrl-0 = <&pwm_a_x20_pins>;
+	pinctrl-names = "default";
+};
+
+/* wifi module */
+&sd_emmc_b {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr104;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* emmc storage */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
+
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+/* UART Bluetooth */
+&uart_B {
+	status = "okay";
+	pinctrl-0 = <&uart_b_z_pins>, <&uart_b_z_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* UART Console */
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+/* UART Wireless module */
+&uart_AO_B {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_b_pins>;
+	pinctrl-names = "default";
+};
+
+&usb {
+	status = "okay";
+	phy-supply = <&usb_pwr>;
+};
+
+&spicc1 {
+	status = "okay";
+};
+
+&audio {
+	status = "disabled";
+};
+
+&efuse {
+	status = "okay";
+	compatible = "amlogic,meson-gxbb-efuse", "amlogic, efuse";
+	read_cmd = <0x82000030>;
+	write_cmd = <0x82000031>;
+	get_max_cmd = <0x82000033>;
+	key = <&efusekey>;
+	clock-names = "efuse_clk";
+};
+
+&gpio {
+	interrupt-parent = <&gpio_intc>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	gpio-line-names = 
+		"", "", "", "", "", // 0 - 4
+		"", "", "", "", "", // 5 - 9
+		"UserButton", "", "", "", "", // 10 - 14
+		"", "", "", "", "", // 15 - 19
+		"", "", "", "", "", // 20 - 24
+		"", "LEDRED", "LEDGREEN", "Output3", "Output2", // 25 - 29
+		"Output1", "", "", "", "", // 30 - 34
+		"", "ZigBeeBOOT", "", "", "", // 35 - 39
+		"", "ZigBeeRESET", "", "Input4", "Input3", // 40 - 44
+		"Input2", "Input1", "", "", "", // 45 - 49
+		"", "", "", "", "", // 50 - 54
+		"", "", "", "", "", // 55 - 59
+		"", "", "", "", "", // 60 - 64
+		"", "", "", "", "", // 65 - 69
+		"", "", "", "", "", // 70 - 74
+		"", "", "", "", "", // 75 - 79
+		"", "", "", "", "", // 80 - 84
+		"", ""; // 85-86
+};
+
+&cpu0 {
+	#cooling-cells = <2>;
+};
+
+&cpu1 {
+	#cooling-cells = <2>;
+};
+
+&cpu2 {
+	#cooling-cells = <2>;
+};
+
+&cpu3 {
+	#cooling-cells = <2>;
+};
+
-- 
2.30.2

