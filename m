Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B33F31EB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBROtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhBRMvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:51:09 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB5C06178A;
        Thu, 18 Feb 2021 04:50:28 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4B11D2223A;
        Thu, 18 Feb 2021 13:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613652625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOQYXAKpLBWVQTpG/xcw9wM2L/SyBGSLEb6eiPv+cTA=;
        b=KccNURHpqZvHvzp7PrLg4mKlnKUkRjaewYDGcQ4SN4bln2NIODz6Z0bbO7vMR4IRLxtsw5
        YFih2yHLrfMsCbcLH6XPZiRX5wUaR1U/RVWzP2SYSsuCmt+J26SdEtO52Fy1U6J8z80b1F
        xbsj4B9vZ0oQXv8g4pzuBn/h0u+ZSgA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Feb 2021 13:50:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: add support for Kontron pitx-imx8m
 board
In-Reply-To: <20210218123327.25486-3-heiko.thiery@gmail.com>
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
 <20210218123327.25486-3-heiko.thiery@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <f797ddd4cb16ccbf0c0deb42682bb8ae@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-18 13:33, schrieb Heiko Thiery:
> The Kontron pitx-imx8m board is based on an i.MX8MQ soc.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 675 ++++++++++++++++++
>  2 files changed, 676 insertions(+)
>  create mode 100644 
> arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 6438db3822f8..9fc2c6f64407 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-kontron-pitx-imx8m.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
> diff --git
> a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> new file mode 100644
> index 000000000000..79805928204e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> @@ -0,0 +1,675 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree File for the Kontron pitx-imx8m board.
> + *
> + * Copyright (C) 2021 Heiko Thiery <heiko.thiery@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mq.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "Kontron pITX-imx8m";
> +	compatible = "kontron,pitx-imx8m", "fsl,imx8mq";
> +
> +	aliases {
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		spi0 = &qspi0;
> +		spi1 = &ecspi2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_usdhc2_vmmc: regulator-v-3v3-sd {
> +			compatible = "regulator-fixed";
> +			regulator-name = "V_3V3_SD";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +			off-on-delay-us = <20000>;
> +			enable-active-high;
> +		};
> +	};
> +
> +	usb_hub_reset: usb-hub-reset {
> +		compatible = "gpio-reset";
> +		reset-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <3000>;
> +		reset-post-delay-ms = <50>;
> +		#reset-cells = <0>;
> +	};
> +
> +	tpm_reset: tpm-reset {
> +		compatible = "gpio-reset";
> +		reset-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <2>;
> +		reset-post-delay-ms = <60>;
> +		#reset-cells = <0>;
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	pcie1_refclk: pcie1-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		pciewake {
> +			label = "PCIE_Wake";

This looks odd, is this the PCIE_WAKE# signal? Is this the way
it is usually handled in linux?

> +			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <4>; /* EV_MSC */
> +			linux,code = <3>; /* MSC_RAW */
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> +
> +&ecspi2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	slb9670@0 {
> +		compatible = "infineon,slb9670";
> +		reg = <0>;
> +		resets = <&tpm_reset>;
> +		spi-max-frequency = <43000000>;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	phy-reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		compatible = "fsl,pfuze100";
> +		fsl,pfuze-support-disable-sw;
> +		reg = <0x8>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-name = "V_0V9_GPU";
> +				regulator-min-microvolt = <825000>;
> +				regulator-max-microvolt = <1100000>;
> +			};
> +
> +			sw1c_reg: sw1c {
> +				regulator-name = "V_0V9_VPU";
> +				regulator-min-microvolt = <825000>;
> +				regulator-max-microvolt = <1100000>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-name = "V_1V1_NVCC_DRAM";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3ab {
> +				regulator-name = "V_1V0_DRAM";
> +				regulator-min-microvolt = <825000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-name = "V_1V8_S0";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			swbst_reg: swbst {
No name?

> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-name = "V_0V9_SNVS";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-name = "V_0V55_VREF_DDR";
> +				regulator-always-on;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-name = "V_1V5_CSI";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-name = "V_0V9_PHY";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <975000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-name = "V_1V8_PHY";
> +				regulator-min-microvolt = <1675000>;
> +				regulator-max-microvolt = <1975000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-name = "V_1V8_VDDA";
> +				regulator-min-microvolt = <1625000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-name = "V_3V3_PHY";
> +				regulator-min-microvolt = <3075000>;
> +				regulator-max-microvolt = <3625000>;
> +				regulator-always-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-name = "V_2V8_CAM";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	max6650@1b {
> +		compatible = "maxim,max6650";
> +		reg = <0x1b>;
> +		maxim,fan-microvolt = <5000000>;
> +	};
> +
> +	rtc@32 {
> +		compatible = "microcrystal,rv8803";
> +		reg = <0x32>;
> +	};
> +
> +	lm75@4b {
> +		compatible = "national,lm75b";
> +		reg = <0x4b>;
> +	};
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c32";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	wm8904: audio-codec@1a {
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +		clock-names = "mclk";
> +		clock-frequency = <24000000>;
> +	};

Looks like this audio codec is not used at all.

> +};
> +
> +/* M.2 B-key slot */
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	disable-gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;
> +	reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> +		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
> +		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
> +		 <&pcie0_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	ext_osc = <1>;
> +	status = "okay";
> +};
> +
> +/* Intel Ethernet Controller I210/I211 */
> +&pcie1 {
> +	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
> +		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
> +		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
> +		 <&pcie1_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	ext_osc = <1>;
> +	fsl,max-link-speed = <1>;
> +	status = "okay";
> +};
> +
> +&pgc_gpu {
> +	power-supply = <&sw1a_reg>;
> +};
> +
> +&pgc_vpu {
> +	power-supply = <&sw1c_reg>;
> +};
> +
> +&qspi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MQ_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	assigned-clocks = <&clk IMX8MQ_CLK_UART2>;
> +	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	fsl,uart-has-rtscts;
> +	assigned-clocks = <&clk IMX8MQ_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb0>;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {

for arm64 boards the references are normally sorted
alphabetically. Anyway, since this is only usb2.0 do you need
this at all?

> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	resets = <&usb_hub_reset>;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
> +	assigned-clock-rates = <400000000>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	vqmmc-supply = <&sw4_reg>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
> +	assigned-clock-rates = <200000000>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
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
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19 /* TPM Reset */
> +			MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x19 /* USB2 Hub Reset */
> +		>;
> +	};
> +
> +	pinctrl_gpio: gpiogrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5			0x19 /* GPIO0 */
> +			MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15		0x19 /* GPIO1 */
> +			MX8MQ_IOMUXC_NAND_WE_B_GPIO3_IO17		0x19 /* GPIO2 */
> +			MX8MQ_IOMUXC_NAND_WP_B_GPIO3_IO18		0x19 /* GPIO3 */
> +			MX8MQ_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* GPIO4 */
> +			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10		0x19 /* GPIO5 */
> +			MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11		0x19 /* GPIO6 */
> +			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x19 /* GPIO7 */
> +		>;
> +	};
> +
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x16 /* PCIE_PERST */
> +			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16 /* W_DISABLE */
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpio-keysgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x16 /* PCIE_WAKE */
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
> +			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x16
> +			MX8MQ_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x16
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_qspi: qspigrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x82
> +			MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82
> +			MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82
> +			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82
> +			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82
> +			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82
> +
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x19
> +			MX8MQ_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x19
> +			MX8MQ_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x19
> +		>;
> +	};
> +
> +	pinctrl_ecspi2_cs: ecspi2cs {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
> +			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
> +			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x49
> +			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x49
> +			MX8MQ_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B		0x49
> +			MX8MQ_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x49
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
> +			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
> +			MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20			0x19
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8d
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcd
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcd
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcd
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcd
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9f
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xdf
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xdf
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xdf
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xdf
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xdf
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usb0: usb0grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO12_USB1_OTG_PWR		0x19
> +			MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x19
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6
> +			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6
> +			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6
> +			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6
> +			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6
> +		>;
> +	};
> +
> +	pinctrl_spdif1: spdif1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT		0xd6
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
> +		>;
> +	};
> +};

-- 
-michael
