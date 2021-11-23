Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC945A479
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhKWOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:11:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhKWOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:11:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id E53F61F455E5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637676489; bh=jLDZl2B9THNhyQZHu5YQuGUEQDeAAQ9yfVt7IJ5H1RU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MnFZ0SYkYqOFB5Zn1/omkOfZmO18JYdWmOIdLC4spO8jrsUN63DYy/B8PgufuwdCd
         lWyw0cSULOgpQyV1P340Yr8VVPYE7U1CT/63GJd1CDvlWQ7+P+WUO6qGln6pWOO1mO
         xZsWsQ/Gd9t3IhHRitYRzW8FsxKVfHI/SO/cVGzp9GnDebSVouUcwkNmw++9XzxDYW
         QqYAdLCqKOqiX0KxWtjz9cNdGEfi0TMsOayxQmy618Bp5vvxCsTKDYnbWdP2uGa9uQ
         eqqg8hZ8bdDF8LvLvDezXH+ZXwx9WtrcN0wzV8zzexEAq0DZg1jT3uDSQUATMQpwnq
         zdI2sdy/hQDNA==
Subject: Re: [PATCH] arm64: dts: imx8mn-bsh-smm-s2/pro: Add iMX8MN BSH SMM S2
 boards
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        tharvey@gateworks.com
References: <20211103202819.326661-1-ariel.dalessandro@collabora.com>
 <20211122005528.GR31998@dragon>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <00a5dc00-8a4b-0984-4b20-407cd469b627@collabora.com>
Date:   Tue, 23 Nov 2021 11:07:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211122005528.GR31998@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/21 9:55 PM, Shawn Guo wrote:
> On Wed, Nov 03, 2021 at 05:28:19PM -0300, Ariel D'Alessandro wrote:
>> Introduce BSH SystemMaster (SMM) S2 board family, which consists of:
>> iMX8MN SMM S2 and iMX8MN SMM S2 PRO boards.
>>
>> Add support for iMX8MN BSH SMM S2 board:
>>
>> - 256 MiB DDR3 RAM
>> - 512 MiB NAND
>> - Megabit Ethernet PHY
>> - Wi-Fi 802.11 a/b/g/n/ac with Bluetooth 5.0
>> - USB-OTG (peripheral mode)
>>
>> Add support for iMX8MN BSH SMM S2 PRO board:
>>
>> - 512 MiB DDR3 RAM
>> - 8 GiB eMMC
>> - Megabit Ethernet PHY
>> - Wi-Fi 802.11 a/b/g/n/ac with Bluetooth 5.0
>> - USB-OTG (peripheral mode)
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>>  .../freescale/imx8mn-bsh-smm-s2-common.dtsi   | 426 ++++++++++++++++++
>>  .../boot/dts/freescale/imx8mn-bsh-smm-s2.dts  |  48 ++
>>  .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    |  80 ++++
>>  4 files changed, 556 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts

[snip]

>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	pmic: bd71847@4b {
> 
> 	bd71847: pmic@4b

Thanks.

> 
>> +		compatible = "rohm,bd71847";
>> +		reg = <0x4b>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +		rohm,reset-snvs-powered;
>> +
>> +		#clock-cells = <0>;
>> +		clocks = <&osc_32k 0>;
>> +		clock-output-names = "clk-32k-out";
>> +
>> +		regulators {
>> +			buck1_reg: BUCK1 {
>> +				/* PMIC_BUCK1 - VDD_SOC */
>> +				regulator-name = "buck1";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <1250>;
>> +			};
>> +
>> +			buck2_reg: BUCK2 {
>> +				/* PMIC_BUCK2 - VDD_ARM */
>> +				regulator-name = "buck2";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <1250>;
>> +			};
>> +
>> +			buck3_reg: BUCK3 {
>> +				/* PMIC_BUCK5 - VDD_DRAM_VPU_GPU */
>> +				regulator-name = "buck3";
>> +				regulator-min-microvolt = <700000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck4_reg: BUCK4 {
>> +				/* PMIC_BUCK6 - VDD_3V3 */
>> +				regulator-name = "buck4";
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck5_reg: BUCK5 {
>> +				/* PMIC_BUCK7 - VDD_1V8 */
>> +				regulator-name = "buck5";
>> +				regulator-min-microvolt = <1605000>;
>> +				regulator-max-microvolt = <1995000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			buck6_reg: BUCK6 {
>> +				/* PMIC_BUCK8 - NVCC_DRAM */
>> +				regulator-name = "buck6";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1400000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo1_reg: LDO1 {
>> +				/* PMIC_LDO1 - NVCC_SNVS_1V8 */
>> +				regulator-name = "ldo1";
>> +				regulator-min-microvolt = <1600000>;
>> +				regulator-max-microvolt = <1900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo2_reg: LDO2 {
>> +				/* PMIC_LDO2 - VDD_SNVS_0V8 */
>> +				regulator-name = "ldo2";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo3_reg: LDO3 {
>> +				/* PMIC_LDO3 - VDDA_1V8 */
>> +				regulator-name = "ldo3";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4_reg: LDO4 {
>> +				/* PMIC_LDO4 - VDD_MIPI_0V9 */
>> +				regulator-name = "ldo4";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo6_reg: LDO6 {
>> +				/* PMIC_LDO6 - VDD_MIPI_1V2 */
>> +				regulator-name = "ldo6";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c3>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c4>;
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart3>;
>> +	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
>> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +
>> +	bluetooth {
>> +		compatible = "brcm,bcm43438-bt";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_bluetooth>;
>> +		shutdown-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
>> +		device-wakeup-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>> +		host-wakeup-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +		max-speed = <3000000>;
>> +	};
>> +};
>> +
>> +/* Console */
>> +&uart4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart4>;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	dr_mode = "peripheral";
>> +	disable-over-current;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc2 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>> +	mmc-pwrseq = <&usdhc2_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	status = "okay";
>> +
>> +	brcmf: bcrmf@1 {
>> +		compatible = "brcm,bcm4329-fmac";
>> +		reg = <1>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_wlan>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "host-wake";
>> +	};
>> +};
>> +
>> +&wdog1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_wdog>;
>> +	fsl,ext-reset-output;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_espi2: espi2grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK            0x082
>> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI            0x082
>> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO            0x082
>> +			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1: i2c1grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL			0x400000c2
>> +			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA			0x400000c2
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c3: i2c3grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL			0x400000c2
>> +			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA			0x400000c2
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c4: i2c4grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL			0x400000c2
>> +			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA			0x400000c2
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic: pmicirq {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart4: uart4grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_UART4_RXD_UART4_DCE_RX		0x040
>> +			MX8MN_IOMUXC_UART4_TXD_UART4_DCE_TX		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_pwrseq: usdhc2pwrseqgrp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x040	/* WL_REG_ON */
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x090
>> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d0
>> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d0
>> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d0
>> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d0
>> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d0
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x094
>> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d4
>> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d4
>> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d4
>> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d4
>> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d4
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x096
>> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d6
>> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0d6
>> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x0d6
>> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x0d6
>> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d6
>> +		>;
>> +	};
>> +
>> +	pinctrl_wlan: wlangrp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x0d6	/* GPIO_0 - WIFI_GPIO_0 */
>> +			MX8MN_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x0d6	/* GPIO_1 - WIFI_GPIO_1 */
>> +			MX8MN_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x0d6	/* BT_GPIO_5 - WIFI_GPIO_5 */
>> +			MX8MN_IOMUXC_SPDIF_RX_GPIO5_IO4			0x0d6	/* I2S_CLK - WIFI_GPIO_6 */
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart2: uart2grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX		0x040
>> +			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart3: uart3grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX		0x040
>> +			MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX		0x040
>> +			MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x040
>> +			MX8MN_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_bluetooth: bluetoothgrp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x044	/* BT_REG_ON */
>> +			MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x046	/* BT_DEV_WAKE */
>> +			MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x090	/* BT_HOST_WAKE */
>> +		>;
>> +	};
>> +
>> +	pinctrl_wdog: wdoggrp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x046
>> +		>;
>> +	};
>> +
>> +	pinctrl_fec1: fec1grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x002
>> +			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x002
>> +			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x090
>> +			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x090
>> +			MX8MN_IOMUXC_ENET_RXC_ENET1_RX_ER		0x090
>> +			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x016
>> +			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x016
>> +			MX8MN_IOMUXC_ENET_TD2_ENET1_TX_CLK		0x016
>> +			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x016
>> +			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x090
>> +			MX8MN_IOMUXC_ENET_TXC_ENET1_TX_ER		0x016
>> +			MX8MN_IOMUXC_SD2_CD_B_GPIO2_IO12		0x150	/* RMII_INT - ENET_INT */
>> +			MX8MN_IOMUXC_SD2_WP_GPIO2_IO20			0x150	/* RMII_EN - ENET_EN */
>> +			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x016	/* RMII_WAKE - GPIO_ENET_WAKE */
>> +			MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x016	/* RMII_RESET - GPIO_ENET_RST */
>> +		>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
>> new file mode 100644
>> index 000000000000..33f98582eace
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright 2021 Collabora Ltd.
>> + * Copyright 2021 BSH Hausgeraete GmbH
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mn-bsh-smm-s2-common.dtsi"
>> +
>> +/ {
>> +	model = "BSH SMM S2";
>> +	compatible = "bsh,imx8mn-bsh-smm-s2", "fsl,imx8mn";
> 
> New compatible needs to be documented.

Will fix.

Regards,
Ariel
