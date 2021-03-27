Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE43534B874
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhC0RWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:22:36 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36423 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhC0RWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:22:24 -0400
X-Originating-IP: 90.112.180.199
Received: from [192.168.1.36] (lfbn-gre-1-220-199.w90-112.abo.wanadoo.fr [90.112.180.199])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AE15FE0003;
        Sat, 27 Mar 2021 17:22:14 +0000 (UTC)
Subject: Re: [PATCH v4 3/5] RISC-V: Initial DTS for Microchip ICICLE board
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
References: <20210303200253.1827553-1-atish.patra@wdc.com>
 <20210303200253.1827553-4-atish.patra@wdc.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <7eb2b954-6b0a-b143-9107-57f4dd90d0cf@ghiti.fr>
Date:   Sat, 27 Mar 2021 13:22:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210303200253.1827553-4-atish.patra@wdc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Le 3/3/21 à 3:02 PM, Atish Patra a écrit :
> Add initial DTS for Microchip ICICLE board having only
> essential devices (clocks, sdhci, ethernet, serial, etc).
> The device tree is based on the U-Boot patch.
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>   arch/riscv/boot/dts/Makefile                  |   1 +
>   arch/riscv/boot/dts/microchip/Makefile        |   2 +
>   .../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
>   .../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
>   4 files changed, 404 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>   create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 7ffd502e3e7b..fe996b88319e 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   subdir-y += sifive
>   subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> +subdir-y += microchip
>   
>   obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> new file mode 100644
> index 000000000000..622b12771fd3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb

I'm playing (or trying to...) with XIP_KERNEL and I had to add the 
following to have the device tree actually builtin the kernel:

diff --git a/arch/riscv/boot/dts/microchip/Makefile 
b/arch/riscv/boot/dts/microchip/Makefile
index 622b12771fd3..855c1502d912 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,2 +1,3 @@
  # SPDX-License-Identifier: GPL-2.0
  dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))

Alex

> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> new file mode 100644
> index 000000000000..ec79944065c9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "microchip-mpfs.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ		1000000
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip PolarFire-SoC Icicle Kit";
> +	compatible = "microchip,mpfs-icicle-kit";
> +
> +	chosen {
> +		stdout-path = &serial0;
> +	};
> +
> +	cpus {
> +		timebase-frequency = <RTCCLK_FREQ>;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +		clocks = <&clkcfg 26>;
> +	};
> +
> +	soc {
> +	};
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +&serial1 {
> +	status = "okay";
> +};
> +
> +&serial2 {
> +	status = "okay";
> +};
> +
> +&serial3 {
> +	status = "okay";
> +};
> +
> +&sdcard {
> +	status = "okay";
> +};
> +
> +&emac0 {
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy0>;
> +	phy0: ethernet-phy@8 {
> +		reg = <8>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +};
> +
> +&emac1 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy1>;
> +	phy1: ethernet-phy@9 {
> +		reg = <9>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> new file mode 100644
> index 000000000000..b9819570a7d1
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip MPFS Icicle Kit";
> +	compatible = "microchip,mpfs-icicle-kit";
> +
> +	chosen {
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,e51", "sifive,rocket0", "riscv";
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <16384>;
> +			reg = <0>;
> +			riscv,isa = "rv64imac";
> +			status = "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@1 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu1_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@2 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <2>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu2_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@3 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <3>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +
> +			cpu3_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu@4 {
> +			clock-frequency = <0>;
> +			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <4>;
> +			riscv,isa = "rv64imafdc";
> +			tlb-split;
> +			status = "okay";
> +			cpu4_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		cache-controller@2010000 {
> +			compatible = "sifive,fu540-c000-ccache", "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <1024>;
> +			cache-size = <2097152>;
> +			cache-unified;
> +			interrupt-parent = <&plic>;
> +			interrupts = <1 2 3>;
> +			reg = <0x0 0x2010000 0x0 0x1000>;
> +		};
> +
> +		clint@2000000 {
> +			compatible = "sifive,clint0";
> +			reg = <0x0 0x2000000 0x0 0xC000>;
> +			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
> +						&cpu1_intc 3 &cpu1_intc 7
> +						&cpu2_intc 3 &cpu2_intc 7
> +						&cpu3_intc 3 &cpu3_intc 7
> +						&cpu4_intc 3 &cpu4_intc 7>;
> +		};
> +
> +		plic: interrupt-controller@c000000 {
> +			#interrupt-cells = <1>;
> +			compatible = "sifive,plic-1.0.0";
> +			reg = <0x0 0xc000000 0x0 0x4000000>;
> +			riscv,ndev = <186>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11
> +					&cpu1_intc 11 &cpu1_intc 9
> +					&cpu2_intc 11 &cpu2_intc 9
> +					&cpu3_intc 11 &cpu3_intc 9
> +					&cpu4_intc 11 &cpu4_intc 9>;
> +		};
> +
> +		dma@3000000 {
> +			compatible = "sifive,fu540-c000-pdma";
> +			reg = <0x0 0x3000000 0x0 0x8000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <23 24 25 26 27 28 29 30>;
> +			#dma-cells = <1>;
> +		};
> +
> +		refclk: refclk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <600000000>;
> +			clock-output-names = "msspllclk";
> +		};
> +
> +		clkcfg: clkcfg@20002000 {
> +			compatible = "microchip,mpfs-clkcfg";
> +			reg = <0x0 0x20002000 0x0 0x1000>;
> +			reg-names = "mss_sysreg";
> +			clocks = <&refclk>;
> +			#clock-cells = <1>;
> +			clock-output-names = "cpu", "axi", "ahb", "envm",	/* 0-3   */
> +				 "mac0", "mac1", "mmc", "timer",		/* 4-7   */
> +				"mmuart0", "mmuart1", "mmuart2", "mmuart3",	/* 8-11  */
> +				"mmuart4", "spi0", "spi1", "i2c0",		/* 12-15 */
> +				"i2c1", "can0", "can1", "usb",			/* 16-19 */
> +				"rsvd", "rtc", "qspi", "gpio0",			/* 20-23 */
> +				"gpio1", "gpio2", "ddrc", "fic0",		/* 24-27 */
> +				"fic1", "fic2", "fic3", "athena", "cfm";	/* 28-32 */
> +		};
> +
> +		serial0: serial@20000000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20000000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <90>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 8>;
> +			status = "disabled";
> +		};
> +
> +		serial1: serial@20100000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20100000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <91>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 9>;
> +			status = "disabled";
> +		};
> +
> +		serial2: serial@20102000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20102000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <92>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 10>;
> +			status = "disabled";
> +		};
> +
> +		serial3: serial@20104000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20104000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <93>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg 11>;
> +			status = "disabled";
> +		};
> +
> +		emmc: mmc@20008000 {
> +			compatible = "cdns,sd4hc";
> +			reg = <0x0 0x20008000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <88 89>;
> +			pinctrl-names = "default";
> +			clocks = <&clkcfg 6>;
> +			bus-width = <4>;
> +			cap-mmc-highspeed;
> +			mmc-ddr-3_3v;
> +			max-frequency = <200000000>;
> +			non-removable;
> +			no-sd;
> +			no-sdio;
> +			voltage-ranges = <3300 3300>;
> +			status = "disabled";
> +		};
> +
> +		sdcard: sdhc@20008000 {
> +			compatible = "cdns,sd4hc";
> +			reg = <0x0 0x20008000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <88>;
> +			pinctrl-names = "default";
> +			clocks = <&clkcfg 6>;
> +			bus-width = <4>;
> +			disable-wp;
> +			cap-sd-highspeed;
> +			card-detect-delay = <200>;
> +			sd-uhs-sdr12;
> +			sd-uhs-sdr25;
> +			sd-uhs-sdr50;
> +			sd-uhs-sdr104;
> +			max-frequency = <200000000>;
> +			status = "disabled";
> +		};
> +
> +		emac0: ethernet@20110000 {
> +			compatible = "cdns,macb";
> +			reg = <0x0 0x20110000 0x0 0x2000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <64 65 66 67>;
> +			local-mac-address = [00 00 00 00 00 00];
> +			clocks = <&clkcfg 4>, <&clkcfg 2>;
> +			clock-names = "pclk", "hclk";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		emac1: ethernet@20112000 {
> +			compatible = "cdns,macb";
> +			reg = <0x0 0x20112000 0x0 0x2000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <70 71 72 73>;
> +			mac-address = [00 00 00 00 00 00];
> +			clocks = <&clkcfg 5>, <&clkcfg 2>;
> +			status = "disabled";
> +			clock-names = "pclk", "hclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +	};
> +};
> 
