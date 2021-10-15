Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D489F42E699
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhJOCgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbhJOCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:36:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DBA360E09;
        Fri, 15 Oct 2021 02:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634265276;
        bh=fFWd7W0A8avMsreQIaRnsEHnC9nePwnvE5BXsGQ4qw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGUWdZPUp+YZvCIKgSsxG63dyhkM5UGvjU/4L/CL/7Jqw+QDTLUWEb5nnghTp9vvM
         2aLvxEr4BdJTVxKEj/8VmWIa2/Jl893NKj+6Lyvua+IW4b0xpDyZ7fUebjQ7vzNycM
         +jwjYG2HtFFxzIwCqRifzZUjZi1zIHEfMPGyFwUAXtv2K8DvHlDI2LMVCzwo1M2xPy
         3Tdx0dW8CPOtMTnHHNIBS7SNKsYKwpNJKXhEiPJiA3Vyaj8pZmgF4NPtWOzNqEy1mf
         li03c1J0o0Hy/Mewc4OOilEQBZWU3UNi9jdxFN6Td9iUodjhGCDoLara7JYY1Xqg3n
         98mPjbot+hFhQ==
Date:   Fri, 15 Oct 2021 10:34:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] arm64: dts: freescale: add initial tree for
 TQMa8MQML with i.MX8MM
Message-ID: <20211015023427.GD10197@dragon>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
 <20211006132309.1239708-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006132309.1239708-3-alexander.stein@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:23:04PM +0200, Alexander Stein wrote:
> This adds support for TQMa8MQML module on MBa8Mx board.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 259 +++++++++++++
>  .../boot/dts/freescale/imx8mm-tqma8mqml.dtsi  | 350 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/mba8mx.dtsi     | 285 ++++++++++++++
>  4 files changed, 895 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/mba8mx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index db9e36ebe932..032588e83f12 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb

Keep the list sort alphabetically.

>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> new file mode 100644
> index 000000000000..a0e22bef188e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright 2020-2021 TQ-Systems GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm-tqma8mqml.dtsi"
> +#include "mba8mx.dtsi"
> +
> +/ {
> +	model = "TQ-Systems GmbH i.MX8MM TQMa8MxML on MBa8Mx";
> +	compatible = "tq,imx8mm-tqma8mqml-mba8mx", "tq,imx8mm-tqma8mqml", "fsl,imx8mm";
> +
> +	aliases {
> +		eeprom0 = &eeprom3;
> +		mmc0 = &usdhc3;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc1;
> +		rtc0 = &pcf85063;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-vmmc {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		off-on-delay-us = <12000>;
> +	};
> +};
> +
> +&codec {
> +	clock-names = "mclk";
> +	clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> +};
> +
> +&i2c1 {
> +	expander2: gpio@27 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x27>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		vcc-supply = <&reg_vcc_3v3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_expander>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&sai3 {
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
> +	clocks = <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
> +		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
> +		<&clk IMX8MM_AUDIO_PLL2_OUT>;
> +};
> +
> +&uart1 {
> +	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +};
> +
> +&uart2 {
> +	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> +};
> +
> +&iomuxc {
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x00000006
> +			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x00000006
> +			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x00000006
> +			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x00000006
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x00000006
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x00000006
> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x00000006
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x00000006
> +		>;
> +	};
> +
> +	pinctrl_expander: expandergrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x94
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x40000002
> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO	0x40000002
> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x14
> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x14
> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x14
> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x14
> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x90
> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x90
> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x90
> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x90
> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x14
> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x90
> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x90
> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x14
> +		>;
> +	};
> +
> +	pinctrl_gpiobutton: gpiobuttongrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x84
> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x84
> +			MX8MM_IOMUXC_SD1_CLK_GPIO2_IO0		0x84
> +		>;
> +	};
> +
> +	pinctrl_gpioled: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x84
> +			MX8MM_IOMUXC_NAND_DQS_GPIO3_IO14	0x84
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x40000004
> +			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x40000004
> +		>;
> +	};
> +
> +	pinctrl_i2c2_gpio: i2c2gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x40000004
> +			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x40000004
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x40000004
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x40000004
> +		>;
> +	};
> +
> +	pinctrl_i2c3_gpio: i2c3gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18	0x40000004
> +			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19	0x40000004
> +		>;
> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO14_PWM3_OUT	0x14
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO15_PWM4_OUT	0x14
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK	0x94
> +			MX8MM_IOMUXC_SAI3_RXC_SAI3_RX_BCLK	0x94
> +			MX8MM_IOMUXC_SAI3_RXFS_SAI3_RX_SYNC	0x94
> +			MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0x94
> +			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC	0x94
> +			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0	0x94
> +			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK	0x94
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x16
> +			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x16
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x16
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x16
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x16
> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x16
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX	0x16
> +			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX	0x16
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2grpgpio {

Does it pass the 'grp$' pattern check in fsl,imx8mn-pinctrl.yaml?

> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
> new file mode 100644
> index 000000000000..5d947ca7b1bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright 2020-2021 TQ-Systems GmbH
> + */
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "TQ-Systems GmbH i.MX8MM TQMa8MxML";
> +	compatible = "tq,imx8mm-tqma8mqml", "fsl,imx8mm";
> +
> +	chosen {
> +	};

Is it useful?

> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/*  our minimum RAM config will be 1024 MiB */
> +		reg = <0x00000000 0x40000000 0 0x40000000>;
> +	};
> +
> +	/* e-MMC IO, needed for HS modes */
> +	reg_vcc1v8: regulator-vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "TQMA8MXML_VCC1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	/* identical to buck4_reg, but should never change */
> +	reg_vcc3v3: regulator-vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "TQMA8MXML_VCC3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* global autoconfigured region for contiguous allocations */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			/* 640 MiB */
> +			size = <0 0x28000000>;
> +			/*  1024 - 128 MiB, our minimum RAM config will be 1024 MiB */
> +			alloc-ranges = <0 0x40000000 0 0x78000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi>;
> +	status = "okay";
> +
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <84000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	sensor0: temperature-sensor-eeprom@1b {
> +		compatible = "nxp,se97", "jedec,jc-42.4-temp";
> +		reg = <0x1b>;
> +	};
> +
> +	pca9450: pmic@25 {
> +		compatible = "nxp,pca9450a";
> +		reg = <0x25>;
> +
> +		/* PMIC PCA9450 PMIC_nINT GPIO1_IO08 */
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		pinctrl-names = "default";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			/* V_0V85_SOC: 0.85 */
> +			buck1_reg: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			/* VDD_ARM */
> +			buck2_reg: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			/* V_0V85_GPU / DRAM / VPU */
> +			buck3_reg: BUCK3 {
> +				regulator-name = "BUCK3";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			/* VCC3V3 -> VMMC, ... must not be changed */
> +			buck4_reg: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_1V8 -> VQMMC, SPI-NOR, ... must not be changed */
> +			buck5_reg: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_1V1 -> RAM, ... must not be changed */
> +			buck6_reg: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_1V8_SNVS */
> +			ldo1_reg: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_0V8_SNVS */
> +			ldo2_reg: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_1V8_ANA */
> +			ldo3_reg: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* V_0V9_MIPI */
> +			ldo4_reg: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			/* VCC SD IO - switched using SD2 VSELECT */
> +			ldo5_reg: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +
> +
> +	pcf85063: rtc@51 {
> +		compatible = "nxp,pcf85063a";
> +		reg = <0x51>;
> +		quartz-load-femtofarads = <7000>;
> +	};
> +
> +	eeprom1: eeprom@53 {
> +		compatible = "nxp,se97b", "atmel,24c02";
> +		read-only;
> +		reg = <0x53>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom0: eeprom@57 {
> +		compatible = "atmel,24c64";
> +		reg = <0x57>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc1v8>;
> +	status = "okay";
> +};
> +
> +/*
> + * Attention:
> + * wdog reset is routed to PMIC, PMIC must be preconfigured to force POR
> + * without LDO for SNVS. GPIO1_IO02 must not be used as GPIO.
> + */
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_flexspi: flexspigrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x82
> +			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82
> +			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82
> +			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
> +			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
> +			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000004
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000004
> +		>;
> +	};
> +
> +	pinctrl_i2c1_gpio: i2c1gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x40000004
> +			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x40000004
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x94
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d4
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x84
> +			/* option USDHC3_RESET_B not defined, only in RM */
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d2
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x84
> +			/* option USDHC3_RESET_B not defined, only in RM */
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x84
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d6
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x84
> +			/* option USDHC3_RESET_B not defined, only in RM */
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x84
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x84
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> new file mode 100644
> index 000000000000..5b46ab79f05d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright 2020-2021 TQ-Systems GmbH
> + */
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/* TQ-Systems GmbH MBa8Mx baseboard */
> +
> +/ {
> +	beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm4 0 250000 0>;
> +		beeper-hz = <4000>;
> +		amp-supply = <&reg_vcc_3v3>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttymxc2,115200 earlycon=ec_imx6q,0x30880000,115200";
> +		stdout-path = &uart3;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiobutton>;
> +		autorepeat;
> +
> +		switch1 {
> +			label = "switch1";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +		};
> +
> +		btn2: switch2 {
> +			label = "switch2";
> +			linux,code = <BTN_1>;
> +			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +		};
> +
> +		switch3 {
> +			label = "switch3";
> +			linux,code = <BTN_2>;
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio_leds: gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpioled>;
> +
> +		led1 {
> +			label = "led1";
> +			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		led2: led2 {
> +			label = "led2";
> +			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	reg_hub_vbus: regulator-hub-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "MBA8MX_HUB_VBUS";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_sn65dsi83_1v8: regulator-sn65dsi83-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SN65DSI83_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&expander0 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vcc_3v3: regulator-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "MBA8MX_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-tlv320aic32x4";
> +		model = "tqm-tlv320aic32";
> +		ssi-controller = <&sai3>;
> +		audio-codec = <&codec>;
> +	};
> +};
> +
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	phy-supply = <&reg_vcc_3v3>;
> +	fsl,magic-packet;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@e {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0xe>;
> +			interrupt-parent = <&expander2>;
> +			interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +			enet-phy-lane-no-swap;
> +			reset-gpios = <&expander2 7 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <500000>;
> +			reset-deassert-us = <500>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	expander0: gpio@23 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x23>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		vcc-supply = <&reg_vcc_3v3>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		sd-mux-oe-hog {
> +			gpio-hog;
> +			gpios = <8 0>;
> +			output-low;
> +			line-name = "SD_MUX_EN#";
> +		};
> +
> +		boot-cfg-oe-hog {
> +			gpio-hog;
> +			gpios = <12 0>;
> +			output-high;
> +			line-name = "BOOT_CFG_OE#";
> +		};
> +
> +		rst-usb-hub-hog {
> +			gpio-hog;
> +			gpios = <13 0>;
> +			output-high;
> +			line-name = "RST_USB_HUB#";
> +		};
> +	};
> +
> +	expander1: gpio@24 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x24>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		vcc-supply = <&reg_vcc_3v3>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	codec: tlv320aic3x04@18 {

Node name should be generic, i.e. 'audio-codec'.

Shawn

> +		compatible = "ti,tlv320aic32x4";
> +		reg = <0x18>;
> +		reset-gpios = <&expander2 0 GPIO_ACTIVE_LOW>;
> +		iov-supply = <&reg_vcc_3v3>;
> +		ldoin-supply = <&reg_vcc_3v3>;
> +	};
> +
> +	sensor1: sensor@1f {
> +		compatible = "nxp,se97", "jedec,jc-42.4-temp";
> +		reg = <0x1f>;
> +	};
> +
> +	eeprom3: eeprom@57 {
> +		compatible = "nxp,se97b", "atmel,24c02";
> +		reg = <0x57>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
> +	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	#sound-dai-cells = <0>;
> +	assigned-clock-rates = <49152000>;
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* console */
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +/* UART4 is assigned to Cortex-M4 */
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	no-mmc;
> +	no-sdio;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> -- 
> 2.25.1
> 
