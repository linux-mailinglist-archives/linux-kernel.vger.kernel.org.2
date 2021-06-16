Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FC3A9605
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPJ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:26:09 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43679 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhFPJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:26:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 338BC5804B5;
        Wed, 16 Jun 2021 05:23:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Jun 2021 05:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=B
        L3i8Z+WKykX1QBVl6igxuggzr1PYt1XLzk2OEgkLC8=; b=GMMIdoarskwh43D0t
        D63ScLlvamGBkh6TYsB9hs7bbyXBy1W+vpG/OwLD3logCjTWyjfXn0ia2lRLB7c3
        Q+uC7yVJVzbrBD9qy5zD41LEHQqY2ohgSLFe11hRIx427/AM140ls8RPya+hjENS
        MSKhvAdB9PP2rgwaunlcPdDuhPjs2fMd3ktBiV12Kjqoqsp7CVwXdbhrvNp5pj0e
        ZE/zDkaJIAfDaRMYZINKG/AADXEqGA7Kzx0JTnr1M8sxxigixjy+rZ7i6kPWk5sn
        5c5ahyp0u45X7J6Azvm1k38yyjuL+HiIQ7zIFqsMNJCsg1T0NfWphuTjvXwvYOvb
        36KNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=BL3i8Z+WKykX1QBVl6igxuggzr1PYt1XLzk2OEgkL
        C8=; b=DsFPoGMPhkTYLAG0lO3L2A/t7M3aPuIzbkeignt6MpWiYr0Nc4e/0L9S4
        /tIcRnxJe1cFiIsI9B0ahHjouWuV+Okt/75QcuCKFI30mTDAJTvjJpFru7Z5w+Cj
        EYk1XXZhz5X8wTK9j9F81yBcjh67fW5Sx3YyOhQ+zGHXYVycSQ1p9O/9vwlCpx+5
        8JDbS2GVwfcDhU1PlceEkrrETI94EvtS+f1LEOqcBOJIaxHrAHFsGaeSrZ1+IdY+
        /G/RWWFbUKTY10Y8gpvC83vXOGfOPYDBJd2fOR6I/7nEro6x/lAUAeVcKhAjEWg2
        OPWsHq3aChSYtm6xmDxCypi2fAA3A==
X-ME-Sender: <xms:LMPJYKEuKNu6mYGyjqFW2HKuyhwmRR2_nbWr0EwFHcVosvsOS0MhFw>
    <xme:LMPJYLWcYkzNvtWjylwsWBVexFvco5v_fcDaKWqgQTlWC0-JS31VTtYZySiJGl2La
    _RZBJtfTpw_cuQ2yn8>
X-ME-Received: <xmr:LMPJYEKvA4PLX4vOY4k1YhoX98TMYTiZ1K0kwpAtNk_rU8a1Qtv4palZADeaJ9yzcInCu6GvoktFXZM09okv3xW57hKsO-n-s6VM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LcPJYEFXwim8f8JHTcRd8WKHw3WyZwK7XBBn5Zs8Ql4n4gI0-ca4FQ>
    <xmx:LcPJYAVRU2x00YGRa4_xnSosyD2WLQt7UsvHufsCPY3kUzrzSRp8NQ>
    <xmx:LcPJYHOZxoFfzpgoGsWHMBCfpGnziP9HLDrJJuBWrEMgpIue7zG1Dg>
    <xmx:LsPJYJMudE5GtH4ZOvMYNOl0kZOqMUzt2D184MZX9j7DVw442OkZGg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 05:23:56 -0400 (EDT)
Date:   Wed, 16 Jun 2021 11:23:55 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 16/19] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20210616092355.ndhjelwcch6umdxg@gilmour>
References: <20210615110636.23403-1-andre.przywara@arm.com>
 <20210615110636.23403-17-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210615110636.23403-17-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 15, 2021 at 12:06:33PM +0100, Andre Przywara wrote:
> This (relatively) new SoC is similar to the H6, but drops the (broken)
> PCIe support and the USB 3.0 controller. It also gets the management
> controller removed, which in turn removes *some*, but not all of the
> devices formerly dedicated to the ARISC (CPUS).
> And while there is still the extra sunxi interrupt controller, the
> package lacks the corresponding NMI pin, so no interrupts for the PMIC.
>=20
> The reserved memory node is actually handled by Trusted Firmware now,
> but U-Boot fails to propagate this to a separately loaded DTB, so we
> keep it in here for now, until U-Boot learns to do this properly.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 735 ++++++++++++++++++
>  1 file changed, 735 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> new file mode 100644
> index 000000000000..021b8597cfb8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -0,0 +1,735 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Arm Ltd.
> +// based on the H6 dtsi, which is:
> +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@40000000 {
> +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> +			no-map;
> +		};
> +	};

Can't this be added by ATF directly?

> +	osc24M: osc24M_clk {

underscores are not valid in the node names and trigger a DTC warning.

> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "osc24M";
> +	};
> +
> +	pmu {
> +		compatible =3D "arm,cortex-a53-pmu";
> +		interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		arm,no-tick-in-suspend;
> +		interrupts =3D <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x0 0x0 0x0 0x40000000>;
> +
> +		syscon: syscon@3000000 {
> +			compatible =3D "allwinner,sun50i-h616-system-control";
> +			reg =3D <0x03000000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			sram_c: sram@28000 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x00028000 0x30000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x00028000 0x30000>;
> +			};
> +		};
> +
> +		ccu: clock@3001000 {
> +			compatible =3D "allwinner,sun50i-h616-ccu";
> +			reg =3D <0x03001000 0x1000>;
> +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> +			clock-names =3D "hosc", "losc", "iosc";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
> +
> +		watchdog: watchdog@30090a0 {
> +			compatible =3D "allwinner,sun50i-h616-wdt",
> +				     "allwinner,sun6i-a31-wdt";
> +			reg =3D <0x030090a0 0x20>;
> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc24M>;
> +			status =3D "okay";
> +		};
> +
> +		pio: pinctrl@300b000 {
> +			compatible =3D "allwinner,sun50i-h616-pinctrl";
> +			reg =3D <0x0300b000 0x400>;
> +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
> +			clock-names =3D "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells =3D <3>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +
> +			ext_rgmii_pins: rgmii-pins {
> +				pins =3D "PI0", "PI1", "PI2", "PI3", "PI4",
> +				       "PI5", "PI7", "PI8", "PI9", "PI10",
> +				       "PI11", "PI12", "PI13", "PI14", "PI15",
> +				       "PI16";
> +				function =3D "emac0";
> +				drive-strength =3D <40>;
> +			};
> +
> +			i2c0_pins: i2c0-pins {
> +				pins =3D "PI6", "PI7";
> +				function =3D "i2c0";
> +			};
> +
> +			i2c3_ph_pins: i2c3-ph-pins {
> +				pins =3D "PH4", "PH5";
> +				function =3D "i2c3";
> +			};
> +
> +			ir_rx_pin: ir-rx-pin {
> +				pins =3D "PH10";
> +				function =3D "ir_rx";
> +			};
> +
> +			mmc0_pins: mmc0-pins {
> +				pins =3D "PF0", "PF1", "PF2", "PF3",
> +				       "PF4", "PF5";
> +				function =3D "mmc0";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc1_pins: mmc1-pins {
> +				pins =3D "PG0", "PG1", "PG2", "PG3",
> +				       "PG4", "PG5";
> +				function =3D "mmc1";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc2_pins: mmc2-pins {
> +				pins =3D "PC0", "PC1", "PC5", "PC6",
> +				       "PC8", "PC9", "PC10", "PC11",
> +				       "PC13", "PC14", "PC15", "PC16";
> +				function =3D "mmc2";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			spi0_pins: spi0-pins {
> +				pins =3D "PC0", "PC2", "PC3", "PC4";
> +				function =3D "spi0";
> +			};
> +
> +			spi1_pins: spi1-pins {
> +				pins =3D "PH6", "PH7", "PH8";
> +				function =3D "spi1";
> +			};
> +
> +			spi1_cs_pin: spi1-cs-pin {
> +				pins =3D "PH5";
> +				function =3D "spi1";
> +			};
> +
> +			uart0_ph_pins: uart0-ph-pins {
> +				pins =3D "PH0", "PH1";
> +				function =3D "uart0";
> +			};
> +
> +			uart1_pins: uart1-pins {
> +				pins =3D "PG6", "PG7";
> +				function =3D "uart1";
> +			};
> +
> +			uart1_rts_cts_pins: uart1-rts-cts-pins {
> +				pins =3D "PG8", "PG9";
> +				function =3D "uart1";
> +			};
> +		};
> +
> +		gic: interrupt-controller@3021000 {
> +			compatible =3D "arm,gic-400";
> +			reg =3D <0x03021000 0x1000>,
> +			      <0x03022000 0x2000>,
> +			      <0x03024000 0x2000>,
> +			      <0x03026000 0x2000>;
> +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HI=
GH)>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +		};
> +
> +		mmc0: mmc@4020000 {
> +			compatible =3D "allwinner,sun50i-h616-mmc",
> +				     "allwinner,sun50i-a100-mmc";
> +			reg =3D <0x04020000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names =3D "ahb", "mmc";
> +			resets =3D <&ccu RST_BUS_MMC0>;
> +			reset-names =3D "ahb";
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&mmc0_pins>;
> +			status =3D "disabled";
> +			max-frequency =3D <150000000>;
> +			cap-sd-highspeed;
> +			cap-mmc-highspeed;
> +			mmc-ddr-3_3v;
> +			mmc-ddr-1_8v;

This is not something you know in the DTSI? It entirely depends on how
the board has been designed.

Maxime
