Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D932C29A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbhCDABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:01:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51828 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387980AbhCCUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802168; x=1646338168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1gWBmlFWCSrPX0EbyuLB9CVl6BjYMXJwMSjxYidaAk=;
  b=eTv7dBZMqMTAB+o7CFjxn/Uy9J4AGnl393ulr129OgIe60qhLUsoWj8e
   aQpGSXxb7hjVoEmA7LjZSeTH6KHYHR1B3SQ7qpyQgxCJv0hAw3mlowqaz
   j2D8D9+vkCAT8xUG7EZVoDtfsu1lRP1yEZzfZUXAB3nRIByDq6GC26hDJ
   ey5JudUdwQoTLiA/prhlwtpuXMG+fsCL+xKxp9va4BX0Bxnl5rMWKaXms
   moByLYkPSBEsp33ojiudCIMYKxql0STjAbgNqbuksIDNCPQeNtBXL5Z5K
   uYhYjN98HFIK56mhmGWYWYGpYb9ozuvuqmILubN2qSrUBx5uc76TawmsQ
   w==;
IronPort-SDR: Y9O7eIWwn3akI2eO3kqv9bAyejO6fHwZBNEByPxDHCS8BHEsWPQs/rZZSEV/V6yR92yHIDdb0p
 TlvF9IfBZI0pjW5fAwCNYpif0+W4PhSh3HXWLxTy91nejNvovv8QbOJQLTeSnrPVQMXmg8YdOT
 bRMcbTJugVpczxOUlPKRM4k13N5yhPazxO5fcwrNY8TuCKRpBA+us9wr1Oz5iEmtjr8rFJa9MP
 4Gjp0U1P1zgMmYIg0WRIq+OYEIQbjMRWIbpbEJaR7wvhL+CbigP1j+h0bgYJsuB9eisyH//QdH
 YZ0=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271862"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:06:59 +0800
IronPort-SDR: ggA12S9CVOW/kRY9O0LPpfjg0AAGNp84z1zVc/pLpAUPCJwIcm3VUo1Ex1WiKi99SKXEpd90BS
 ypXk5z3cRArPKuIY9430N/NkZmmKq+Qk2IjLTx0s7mKwAK96I44LcMptEYHWNDBVqhueEJyVax
 VSz6rAFxOZC1FeGDIQzr8E7o5s9EdhzER4fef6pVZDwb/hDayocQvddve+NIJKemFO7tnIGQXg
 724/hQt2RCRaaSit67jKXFIf/lXo92ePoAT7NXLfecVjC9tPK9S0v7GqQElkyJ/q+zHpzhAKPP
 KgdoYfvmRYzoqqOsU84VAn9q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:03 -0800
IronPort-SDR: nK34yjfuUZmSoHl02fsbBygD8ZPrGnmTDCLLeu3mva0TNwhoWxE1fLc5/ZWQ4rz55MTMmODTlx
 VyGrtKZlURnBEnsgzS9QTA/59EMRFrCj9k8FfBL4tst+iBL7Bps/PTEqse2QwHCIFrcNzFzOLQ
 hcMbC5wKLQWcMbXkK/rCHRFFRBJKiGrXvITunmwXihoc2K9tayXkl633AL1PdP5WgLNoXKKQeq
 1lqLvac77LnFBFLNz8mlv4KLrmBSixcx5e0G9lveN6ozjT+gLhpvNRxSRLCh3UK1XN86jkr02M
 IX4=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:06:59 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Subject: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
Date:   Wed,  3 Mar 2021 12:02:51 -0800
Message-Id: <20210303200253.1827553-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303200253.1827553-1-atish.patra@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial DTS for Microchip ICICLE board having only
essential devices (clocks, sdhci, ethernet, serial, etc).
The device tree is based on the U-Boot patch.

https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/microchip/Makefile        |   2 +
 .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
 4 files changed, 404 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 7ffd502e3e7b..fe996b88319e 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += sifive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
+subdir-y += microchip
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
new file mode 100644
index 000000000000..622b12771fd3
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
new file mode 100644
index 000000000000..ec79944065c9
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "microchip-mpfs.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define RTCCLK_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PolarFire-SoC Icicle Kit";
+	compatible = "microchip,mpfs-icicle-kit";
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+		clocks = <&clkcfg 26>;
+	};
+
+	soc {
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
+
+&sdcard {
+	status = "okay";
+};
+
+&emac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+		ti,fifo-depth = <0x01>;
+	};
+};
+
+&emac1 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+		ti,fifo-depth = <0x01>;
+	};
+};
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
new file mode 100644
index 000000000000..b9819570a7d1
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020 Microchip Technology Inc */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip MPFS Icicle Kit";
+	compatible = "microchip,mpfs-icicle-kit";
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			clock-frequency = <0>;
+			compatible = "sifive,e51", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			status = "disabled";
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@1 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@2 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@3 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@4 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		cache-controller@2010000 {
+			compatible = "sifive,fu540-c000-ccache", "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <2097152>;
+			cache-unified;
+			interrupt-parent = <&plic>;
+			interrupts = <1 2 3>;
+			reg = <0x0 0x2010000 0x0 0x1000>;
+		};
+
+		clint@2000000 {
+			compatible = "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0xC000>;
+			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
+						&cpu1_intc 3 &cpu1_intc 7
+						&cpu2_intc 3 &cpu2_intc 7
+						&cpu3_intc 3 &cpu3_intc 7
+						&cpu4_intc 3 &cpu4_intc 7>;
+		};
+
+		plic: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			compatible = "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			riscv,ndev = <186>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11
+					&cpu1_intc 11 &cpu1_intc 9
+					&cpu2_intc 11 &cpu2_intc 9
+					&cpu3_intc 11 &cpu3_intc 9
+					&cpu4_intc 11 &cpu4_intc 9>;
+		};
+
+		dma@3000000 {
+			compatible = "sifive,fu540-c000-pdma";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic>;
+			interrupts = <23 24 25 26 27 28 29 30>;
+			#dma-cells = <1>;
+		};
+
+		refclk: refclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+			clock-output-names = "msspllclk";
+		};
+
+		clkcfg: clkcfg@20002000 {
+			compatible = "microchip,mpfs-clkcfg";
+			reg = <0x0 0x20002000 0x0 0x1000>;
+			reg-names = "mss_sysreg";
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+			clock-output-names = "cpu", "axi", "ahb", "envm",	/* 0-3   */
+				 "mac0", "mac1", "mmc", "timer",		/* 4-7   */
+				"mmuart0", "mmuart1", "mmuart2", "mmuart3",	/* 8-11  */
+				"mmuart4", "spi0", "spi1", "i2c0",		/* 12-15 */
+				"i2c1", "can0", "can1", "usb",			/* 16-19 */
+				"rsvd", "rtc", "qspi", "gpio0",			/* 20-23 */
+				"gpio1", "gpio2", "ddrc", "fic0",		/* 24-27 */
+				"fic1", "fic2", "fic3", "athena", "cfm";	/* 28-32 */
+		};
+
+		serial0: serial@20000000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20000000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <90>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 8>;
+			status = "disabled";
+		};
+
+		serial1: serial@20100000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20100000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <91>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 9>;
+			status = "disabled";
+		};
+
+		serial2: serial@20102000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20102000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <92>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 10>;
+			status = "disabled";
+		};
+
+		serial3: serial@20104000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20104000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <93>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 11>;
+			status = "disabled";
+		};
+
+		emmc: mmc@20008000 {
+			compatible = "cdns,sd4hc";
+			reg = <0x0 0x20008000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <88 89>;
+			pinctrl-names = "default";
+			clocks = <&clkcfg 6>;
+			bus-width = <4>;
+			cap-mmc-highspeed;
+			mmc-ddr-3_3v;
+			max-frequency = <200000000>;
+			non-removable;
+			no-sd;
+			no-sdio;
+			voltage-ranges = <3300 3300>;
+			status = "disabled";
+		};
+
+		sdcard: sdhc@20008000 {
+			compatible = "cdns,sd4hc";
+			reg = <0x0 0x20008000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <88>;
+			pinctrl-names = "default";
+			clocks = <&clkcfg 6>;
+			bus-width = <4>;
+			disable-wp;
+			cap-sd-highspeed;
+			card-detect-delay = <200>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		emac0: ethernet@20110000 {
+			compatible = "cdns,macb";
+			reg = <0x0 0x20110000 0x0 0x2000>;
+			interrupt-parent = <&plic>;
+			interrupts = <64 65 66 67>;
+			local-mac-address = [00 00 00 00 00 00];
+			clocks = <&clkcfg 4>, <&clkcfg 2>;
+			clock-names = "pclk", "hclk";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		emac1: ethernet@20112000 {
+			compatible = "cdns,macb";
+			reg = <0x0 0x20112000 0x0 0x2000>;
+			interrupt-parent = <&plic>;
+			interrupts = <70 71 72 73>;
+			mac-address = [00 00 00 00 00 00];
+			clocks = <&clkcfg 5>, <&clkcfg 2>;
+			status = "disabled";
+			clock-names = "pclk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+	};
+};
-- 
2.25.1

