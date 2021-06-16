Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07E3A96E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFPKI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:60928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFPKI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:08:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C89291042;
        Wed, 16 Jun 2021 03:06:49 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120A53F70D;
        Wed, 16 Jun 2021 03:06:47 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:06:30 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 16/19] arm64: dts: allwinner: Add Allwinner H616
 .dtsi file
Message-ID: <20210616110630.54061205@slackpad.fritz.box>
In-Reply-To: <20210616092355.ndhjelwcch6umdxg@gilmour>
References: <20210615110636.23403-1-andre.przywara@arm.com>
        <20210615110636.23403-17-andre.przywara@arm.com>
        <20210616092355.ndhjelwcch6umdxg@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:23:55 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

Hi Maxime,

> On Tue, Jun 15, 2021 at 12:06:33PM +0100, Andre Przywara wrote:
> > This (relatively) new SoC is similar to the H6, but drops the (broken)
> > PCIe support and the USB 3.0 controller. It also gets the management
> > controller removed, which in turn removes *some*, but not all of the
> > devices formerly dedicated to the ARISC (CPUS).
> > And while there is still the extra sunxi interrupt controller, the
> > package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> > 
> > The reserved memory node is actually handled by Trusted Firmware now,
> > but U-Boot fails to propagate this to a separately loaded DTB, so we
> > keep it in here for now, until U-Boot learns to do this properly.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 735 ++++++++++++++++++
> >  1 file changed, 735 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > new file mode 100644
> > index 000000000000..021b8597cfb8
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > @@ -0,0 +1,735 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2020 Arm Ltd.
> > +// based on the H6 dtsi, which is:
> > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > +
> > +/ {
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <1>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <2>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <3>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > +		secmon_reserved: secmon@40000000 {
> > +			reg = <0x0 0x40000000 0x0 0x80000>;
> > +			no-map;
> > +		};
> > +	};  
> 
> Can't this be added by ATF directly?

It actually is, and if you use U-Boot's DT ($fdtcontroladdr), that
actually works. But as it stands right now, U-Boot fails to propagate
this to any DTB that gets *loaded*. Fixing this requires generic code
fixes, so I can't just hack this in for sunxi quickly.
So I wanted to keep this around for a while, as missing this is a
showstopper for booting Linux.

> > +	osc24M: osc24M_clk {  
> 
> underscores are not valid in the node names and trigger a DTC warning.

Oops, sorry for that.

> 
> > +		#clock-cells = <0>;
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "osc24M";
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		arm,no-tick-in-suspend;
> > +		interrupts = <GIC_PPI 13
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 14
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 11
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 10
> > +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +	};
> > +
> > +	soc {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x0 0x0 0x0 0x40000000>;
> > +
> > +		syscon: syscon@3000000 {
> > +			compatible = "allwinner,sun50i-h616-system-control";
> > +			reg = <0x03000000 0x1000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			sram_c: sram@28000 {
> > +				compatible = "mmio-sram";
> > +				reg = <0x00028000 0x30000>;
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				ranges = <0 0x00028000 0x30000>;
> > +			};
> > +		};
> > +
> > +		ccu: clock@3001000 {
> > +			compatible = "allwinner,sun50i-h616-ccu";
> > +			reg = <0x03001000 0x1000>;
> > +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
> > +			clock-names = "hosc", "losc", "iosc";
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> > +		watchdog: watchdog@30090a0 {
> > +			compatible = "allwinner,sun50i-h616-wdt",
> > +				     "allwinner,sun6i-a31-wdt";
> > +			reg = <0x030090a0 0x20>;
> > +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&osc24M>;
> > +			status = "okay";
> > +		};
> > +
> > +		pio: pinctrl@300b000 {
> > +			compatible = "allwinner,sun50i-h616-pinctrl";
> > +			reg = <0x0300b000 0x400>;
> > +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
> > +			clock-names = "apb", "hosc", "losc";
> > +			gpio-controller;
> > +			#gpio-cells = <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +
> > +			ext_rgmii_pins: rgmii-pins {
> > +				pins = "PI0", "PI1", "PI2", "PI3", "PI4",
> > +				       "PI5", "PI7", "PI8", "PI9", "PI10",
> > +				       "PI11", "PI12", "PI13", "PI14", "PI15",
> > +				       "PI16";
> > +				function = "emac0";
> > +				drive-strength = <40>;
> > +			};
> > +
> > +			i2c0_pins: i2c0-pins {
> > +				pins = "PI6", "PI7";
> > +				function = "i2c0";
> > +			};
> > +
> > +			i2c3_ph_pins: i2c3-ph-pins {
> > +				pins = "PH4", "PH5";
> > +				function = "i2c3";
> > +			};
> > +
> > +			ir_rx_pin: ir-rx-pin {
> > +				pins = "PH10";
> > +				function = "ir_rx";
> > +			};
> > +
> > +			mmc0_pins: mmc0-pins {
> > +				pins = "PF0", "PF1", "PF2", "PF3",
> > +				       "PF4", "PF5";
> > +				function = "mmc0";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc1_pins: mmc1-pins {
> > +				pins = "PG0", "PG1", "PG2", "PG3",
> > +				       "PG4", "PG5";
> > +				function = "mmc1";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc2_pins: mmc2-pins {
> > +				pins = "PC0", "PC1", "PC5", "PC6",
> > +				       "PC8", "PC9", "PC10", "PC11",
> > +				       "PC13", "PC14", "PC15", "PC16";
> > +				function = "mmc2";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			spi0_pins: spi0-pins {
> > +				pins = "PC0", "PC2", "PC3", "PC4";
> > +				function = "spi0";
> > +			};
> > +
> > +			spi1_pins: spi1-pins {
> > +				pins = "PH6", "PH7", "PH8";
> > +				function = "spi1";
> > +			};
> > +
> > +			spi1_cs_pin: spi1-cs-pin {
> > +				pins = "PH5";
> > +				function = "spi1";
> > +			};
> > +
> > +			uart0_ph_pins: uart0-ph-pins {
> > +				pins = "PH0", "PH1";
> > +				function = "uart0";
> > +			};
> > +
> > +			uart1_pins: uart1-pins {
> > +				pins = "PG6", "PG7";
> > +				function = "uart1";
> > +			};
> > +
> > +			uart1_rts_cts_pins: uart1-rts-cts-pins {
> > +				pins = "PG8", "PG9";
> > +				function = "uart1";
> > +			};
> > +		};
> > +
> > +		gic: interrupt-controller@3021000 {
> > +			compatible = "arm,gic-400";
> > +			reg = <0x03021000 0x1000>,
> > +			      <0x03022000 0x2000>,
> > +			      <0x03024000 0x2000>,
> > +			      <0x03026000 0x2000>;
> > +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +		};
> > +
> > +		mmc0: mmc@4020000 {
> > +			compatible = "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg = <0x04020000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC0>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc0_pins>;
> > +			status = "disabled";
> > +			max-frequency = <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			mmc-ddr-1_8v;  
> 
> This is not something you know in the DTSI? It entirely depends on how
> the board has been designed.

Are you referring just to the last property?
This is copying what the driver unconditionally sets for the other
SoCs at the moment (minus the H5 screwup):
	mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
IIUC 1.8V operation requires a 1.8V regulator for vqmmc to actually
work, so this property alone won't enable anything.
But if it's just about the 1.8V property, I can of course move this to
the board dts files.

Cheers,
Andre
