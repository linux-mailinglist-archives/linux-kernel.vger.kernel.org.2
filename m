Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFFE420535
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhJDEYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 00:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhJDEX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 00:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E7661184;
        Mon,  4 Oct 2021 04:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633321318;
        bh=G7fb4j3gWYvjfKOSrDGGcUiEB+p07o19rlI8qBQS+DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxXLlYX2pr8oMlSblZi7wNjS4ooI5RTBQSH2kDDISqaJNzO4M6LvGoNF3rdK41jar
         BLAw1pq52BHoixQt7aN3QhE4rHl1j1RSgcCGlcwz3pZ0ZrIzjB3TU4LKRjP6YWnMbd
         NIPiiYBA3Po070CEiVkqO0JO68vQ5Xm/C+sUwmGJupUFdmfLbtYgvVaMXzFFIe75zh
         5CT9cmz+GR5ZpSNnI1v28cLXD9K1eJf+khY6FTelxLG0CUVrENhvk/RMmD3eeSbVjp
         erwcT5qEdBkSRs3aW31MFHMx4wCMd0MXaTUZy7QnN9W//mbcVrOyG0n7/U1bkgsEXR
         1AQOuk1rFlgvw==
Date:   Mon, 4 Oct 2021 12:21:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     thanushree.sreerama@emtrion.com
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Add support for emtrion emCON-MX8M
 Mini
Message-ID: <20211004042151.GD15650@dragon>
References: <20210901122826.75209-1-thanushree.sreerama@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901122826.75209-1-thanushree.sreerama@emtrion.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:28:26PM +0200, thanushree.sreerama@emtrion.com wrote:
> This patch adds support for the emtrion GmbH emCON-MX8M Mini modules.
> They are available with NXP i.MX 8M Mini equipped with 2 or 4 GB Memory.
> 
> The devicetree imx8mm-emcon.dtsi is the common part providing all
> module components and the basic support for the SoC. The support for the
> avari baseboard in the developer-kit configuration is provided by the
> emcon-avari dts files.
> 
> Signed-off-by: Thanushree Sreerama <thanushree.sreerama@emtrion.com>
> Reviewed by: Frank Erdrich <frank.erdrich@emtrion.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mm-emcon-avari.dts |  23 +
>  .../dts/freescale/imx8mm-emcon-avari.dtsi     | 141 ++++
>  .../boot/dts/freescale/imx8mm-emcon.dtsi      | 687 ++++++++++++++++++
>  4 files changed, 852 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 44890d56c194..ac67956e0bdc 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -64,5 +64,6 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb

Try to keep the list sort alphabetically, it will find its place.

>  
>  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
> new file mode 100644
> index 000000000000..b2e8967e9687
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +//
> +// Copyright (c) 2021 emtrion GmbH
> +// Author: Frank Erdrich <frank.erdrich@emtrion.com>
> +//
> +
> +/dts-v1/;
> +
> +#include "imx8mm-emcon.dtsi"
> +#include "imx8mm-emcon-avari.dtsi"
> +
> +/ {
> +	model = "emtrion SoM emCON-MX8M mini on Avari";
> +	compatible = "emtrion,emcon-mx8mm-avari", "fsl,imx8mm";

The compatible needs to be documented in binding doc.

> +};
> +
> +&lvds_backlight {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
> new file mode 100644
> index 000000000000..127385ad36aa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +//
> +// Copyright (C) 2021 emtrion GmbH
> +// Author: Frank Erdrich <frank.erdrich@emtrion.com>
> +//
> +
> +/ {
> +	aliases {
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		boardid = &boardID;

Sort the list alphabetically.

> +	};
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	reg_wall_5p0: reg-wall5p0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "Main-Supply";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_base3p3: reg-base3p3 {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_wall_5p0>;
> +		regulator-name = "3V3-avari";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_base1p5: reg-base1p5 {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_base3p3>;
> +		regulator-name = "1V5-avari";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_usb_otg: reg-otgvbus {
> +		compatible = "regulator-fixed";
> +		vin-supply = <&reg_wall_5p0>;
> +		regulator-name = "OTG_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +		regulator-always-on;
> +	};
> +
> +	clk_codec: clock-codec {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12000000>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "SGTL5000-Card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&codec_dai>;
> +		simple-audio-card,frame-master = <&codec_dai>;
> +		simple-audio-card,widgets = "Headphone", "Headphone Jack";
> +		simple-audio-card,routing = "Headphone Jack", "HP_OUT";
> +
> +		cpu_dai: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		codec_dai: simple-audio-card,codec {
> +			sound-dai = <&sgtl5000>;
> +		};
> +	};
> +};
> +
> +&ecspi1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	sgtl5000: audio-codec@a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clk_codec>;
> +		VDDA-supply = <&reg_base3p3>;
> +		VDDIO-supply = <&reg_base3p3>;
> +	};
> +
> +	boardID: gpio@3a {
> +		compatible = "nxp,pca8574";
> +		reg = <0x3a>;
> +		gpio-controller;
> +		#gpio-cells = <1>;
> +	};
> +};
> +
> +&sai2 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	fsl,uart-has-rtscts;

uart-has-rtscts

> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	status = "disabled";
> +};
> +
> +&usdhc2 {
> +	status = "okay";
> +};
> +
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
> new file mode 100644
> index 000000000000..9a0cae089568
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
> @@ -0,0 +1,687 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +//
> +// Copyright 2018 NXP
> +// Copyright (C) 2021 emtrion GmbH
> +//
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "emtrion SoM emCON-MX8MM";
> +	compatible = "emtrion,emcon-mx8", "fsl,imx8mm";

This compatible will be overwritten by imx8mm-emcon-avari.dts anyway, right?

> +
> +	chosen {
> +		bootargs = "console=ttymxc0,115200 earlycon=ec_imx6q,0x30860000,115200";

Do you really want to have this bootargs in DTB?

> +		stdout-path = &uart1;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		rpmsg_reserved: rpmsg@0xb8000000 {

No `0x` in unit-address.

> +			no-map;
> +			reg = <0 0xb8000000 0 0x400000>;
> +		};
> +
> +		ivshmem_reserved: ivshmem@bbb00000 {
> +			no-map;
> +			reg = <0 0xbbb00000 0x0 0x00100000>;
> +		};
> +
> +		ivshmem2_reserved: ivshmem2@bba00000 {
> +			no-map;
> +			reg = <0 0xbba00000 0x0 0x00100000>;
> +		};
> +
> +		pci_reserved: pci@bb800000 {
> +			no-map;
> +			reg = <0 0xbb800000 0x0 0x00200000>;
> +		};
> +
> +		loader_reserved: loader@bb700000 {
> +			no-map;
> +			reg = <0 0xbb700000 0x0 0x00100000>;
> +		};

Sort the nodes in unit-address.

> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		/* dummy entry, required for pcie */

You do not have a real clock for PCIe?

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	som_leds: leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		green {
> +			label = "som:green";
> +			gpios = <&gpio3 4 0>;

Use define for GPIO polarity.

> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		red {
> +			label = "som:red";
> +			gpios = <&gpio5 10 0>;

Ditto

> +			default-state = "off";
> +		};
> +	};
> +
> +	lvds_backlight: lvds-backlight {
> +		compatible = "pwm-backlight";
> +		enable-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm1 0 50000 0>;
> +		brightness-levels = <
> +			0 4 8 16 32 64 80 96 112
> +			128 144 160 176 250
> +		>;
> +		default-brightness-level = <9>;
> +		status = "disabled";
> +	};
> +
> +	reg_usdhc1_vmmc: regulator-emmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "eMMC";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;

...

> +		off-on-delay = <20000>;
> +		startup-delay-us = <100>;
> +		enable-active-high;

These properties are meaningless if you do not have an on/off control
for this regulator.

> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "sdcard_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		off-on-delay = <20000>;
> +		enable-active-high;
> +	};
> +
> +	busfreq {
> +		/* Disable busfreq, to avoid 1st Linux busfreq crash other inmates */
> +		status = "disabled";
> +	};

Where is this busfreq node defined?  There is no point to disable
a non-existing node.

> +};
> +
> +

One newline is enough.

> +&cpu_pd_wait {
> +	/delete-property/ compatible;
> +	/* arm,psci-suspend-param = <0x0>; */

What are you trying to do here?

> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +
> +	emcon-mx8 {

No need to have a container node.

> +		pinctrl_csi_pwn: csi_pwn_grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
> +			>;
> +		};
> +
> +		pinctrl_fec1: fec1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +				MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
> +				MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +				MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +				MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +				MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +				MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +				MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +				MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +				MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +				MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +				MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +				MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +				MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +				MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +			>;
> +		};
> +
> +		pinctrl_flexspi0: flexspi0grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x1c2
> +				MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82
> +				MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82
> +				MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82
> +				MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82
> +				MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82
> +				MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x82
> +			>;
> +		};
> +
> +		pinctrl_flexspi1: flexspi1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_NAND_CLE_QSPI_B_SCLK		0x1c2
> +				MX8MM_IOMUXC_NAND_CE2_B_QSPI_B_SS0_B		0x82
> +				MX8MM_IOMUXC_NAND_DATA04_QSPI_B_DATA0		0x82
> +				MX8MM_IOMUXC_NAND_DATA05_QSPI_B_DATA1		0x82
> +				MX8MM_IOMUXC_NAND_DATA06_QSPI_B_DATA2		0x82
> +				MX8MM_IOMUXC_NAND_DATA07_QSPI_B_DATA3		0x82
> +			>;
> +		};
> +
> +		pinctrl_ecspi1: ecspi1grp {

Sort the pinctrl nodes alphabetically.

> +			fsl,pins = <
> +				MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
> +				MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
> +				MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
> +			>;
> +		};
> +
> +		pinctrl_ecspi1_cs: ecspi1cs {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x40000
> +				MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x40000
> +			>;
> +		};
> +
> +		pinctrl_gpio_led: gpioledgrp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_ECSPI2_SCLK_GPIO5_IO10		0x19
> +				MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x19
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
> +				MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x400001c3
> +				MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x400001c3
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c3
> +				MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c3
> +			>;
> +		};
> +
> +		pinctrl_pcie0: pcie0grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x41
> +				MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x41
> +			>;
> +		};
> +
> +		pinctrl_pmic: pmicirq {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x41
> +			>;
> +		};
> +
> +		pinctrl_sai2: sai2grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6
> +				MX8MM_IOMUXC_SAI2_RXC_SAI2_RX_BCLK		0xd6
> +				MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6
> +				MX8MM_IOMUXC_SAI2_RXFS_SAI2_RX_SYNC		0xd6
> +				MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6
> +				MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6
> +				MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6
> +			>;
> +		};
> +
> +		pinctrl_spdif1: spdif1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT		0xd6
> +				MX8MM_IOMUXC_SPDIF_RX_SPDIF1_IN			0xd6
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX		0x140
> +				MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX		0x140
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX		0x140
> +				MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX		0x140
> +
> +				/* rts and cts */
> +				MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
> +				MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
> +				MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
> +			>;
> +		};
> +
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x140
> +				MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x140
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_gpio: usdhc1grpgpio {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x41
> +				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x1c4
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
> +				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
> +				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
> +				MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
> +				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
> +				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
> +				MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x196
> +				MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d6
> +				MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6
> +				MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6
> +			>;
> +		};
> +
> +		/* no reset for sdhc2 interface */
> +		pinctrl_usdhc2_gpio: usdhc2grpgpio {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x1c4
> +				MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x1c4
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
> +				MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
> +				MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
> +				MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
> +				MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
> +				MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
> +				MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
> +				MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
> +				MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
> +				MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
> +				MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
> +				MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
> +				MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
> +				MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
> +				MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
> +				MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
> +				MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
> +				MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
> +				MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			>;
> +		};
> +
> +		pinctrl_wdog: wdoggrp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
> +			>;
> +		};
> +
> +		pinctrl_pwm1: pwm1grp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT		0x06
> +			>;
> +		};
> +
> +		pinctrl_lvds: lvdsgrp {
> +			fsl,pins = <
> +				MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x06
> +			>;
> +		};
> +	};
> +};
> +
> +&clk {
> +	init-on-array = <
> +		IMX8MM_CLK_USDHC3_ROOT
> +		IMX8MM_CLK_NAND_USDHC_BUS
> +		IMX8MM_CLK_UART4_ROOT
> +	>;

Unsupported binding.

> +};
> +
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	pinctrl-1 = <&pinctrl_flexspi1>;
> +	status = "okay";
> +
> +	flash0: spi-flash@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spi-flash";
> +		spi-max-frequency = <40000000>;
> +	};
> +};
> +
> +&ecspi1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	fsl,spi-num-chipselects = <1>;

Unsupported property.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	pmic: bd71837@4b {

bd71837: pmic@4b

> +		compatible = "rohm,bd71847";

So `bd71847: pmic@4b` maybe?

> +		reg = <0x4b>;
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <2 GPIO_ACTIVE_LOW>;
> +		rohm,reset-snvs-powered;
> +
> +		regulators {
> +			buck1_reg: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +				rohm,dvs-run-voltage = <1000000>;
> +				rohm,dvs-idle-voltage = <900000>;
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				// BUCK5 in datasheet
> +				regulator-name = "BUCK3";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				// BUCK6 in datasheet
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				// BUCK7 in datasheet
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1605000>;
> +				regulator-max-microvolt = <1995000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				// BUCK8 in datasheet
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <1900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo6_reg: LDO6 {
> +				regulator-name = "LDO6";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;

You really want to have all these regulators boot-on and always-on?

> +			};
> +		};
> +	};
> +
> +	rtc: rv1805@69 {

rv1805: rtc@69

> +		reg = <0x69>;
> +		compatible = "abracon,ab1805";
> +		status = "okay";

We usually use `okay` status to flip `disabled` nodes.  It's not really
needed in the case here.

> +	};
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +};
> +
> +&mu {
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <12000000>;
> +	status = "disabled";
> +};
> +
> +&spdif1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spdif1>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
> +		<&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
> +	clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
> +		"rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
> +	status = "disabled";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-reset-gpios = <&gpio1 9 0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +};
> +
> +&uart1 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART4>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	over-current-active-low;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "disabled";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +	bus-width = <8>;
> +	vmmc-supply = <&reg_usdhc1_vmmc>;
> +	pm-ignore-notify;

Unsupported property.

> +	keep-power-in-suspend;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2_reg>;
> +};

Sort labeled nodes alphabetically.

Shawn

> -- 
> 2.20.1
> 
