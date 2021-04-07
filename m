Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD29357638
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhDGUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:41:04 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51403 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDGUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:41:01 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 11AF160003;
        Wed,  7 Apr 2021 20:40:47 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
        robh+dt@kernel.org, andrew@lunn.ch, sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chris.packham@alliedtelesis.co.nz,
        Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] ARM: dts: mvebu: Add device tree for ATL-x530 Board
In-Reply-To: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
Date:   Wed, 07 Apr 2021 22:40:47 +0200
Message-ID: <87sg41bzg0.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aryan,

> Add device tree file for x530 board. This has an Armada 385 SoC. Has
> NAND-flash for user storage and SPI for booting. Covers majority of x530
> and GS980MX variants.
>
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I don't know why I missed this one but I've finally applied it on
mvebu/dt and sent a pull request for 5.13.

Sorry for this delay.

Thanks,

Gregory


> ---
> Notes:
> 	Changes in v2:
> 	-Adding to Makefile
>
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/armada-385-atl-x530.dts | 235 ++++++++++++++++++++++
>  2 files changed, 236 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-atl-x530.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a60407ad7347..d65d84e9bf9c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1320,6 +1320,7 @@ dtb-$(CONFIG_MACH_ARMADA_375) += \
>  	armada-375-db.dtb
>  dtb-$(CONFIG_MACH_ARMADA_38X) += \
>  	armada-382-rd-ac3x-48g4x2xl.dtb \
> +	armada-385-atl-x530.dtb\
>  	armada-385-clearfog-gtr-s4.dtb \
>  	armada-385-clearfog-gtr-l8.dtb \
>  	armada-385-db-88f6820-amc.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dts/armada-385-atl-x530.dts
> new file mode 100644
> index 000000000000..2041bf09c578
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Device Tree file for Armada 385 Allied Telesis x530/GS980MX Board.
> + (x530/AT-GS980MX)
> + *
> + Copyright (C) 2020 Allied Telesis Labs
> + */
> +
> +/dts-v1/;
> +#include "armada-385.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "x530/AT-GS980MX";
> +	compatible = "alliedtelesis,gs980mx", "alliedtelesis,x530", "marvell,armada385", "marvell,armada380";
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>; /* 1GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x3d) 0 0xf4800000 0x80000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
> +
> +		internal-regs {
> +			i2c0: i2c@11000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c0_pins>;
> +				status = "okay";
> +			};
> +
> +			uart0: serial@12000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart0_pins>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> +
> +&pciec {
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	status = "okay";
> +	reset-gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
> +	reset-delay-us = <400000>;
> +};
> +
> +&pcie2 {
> +	status = "okay";
> +};
> +
> +&devbus_cs1 {
> +	compatible = "marvell,mvebu-devbus";
> +	status = "okay";
> +
> +	devbus,bus-width    = <8>;
> +	devbus,turn-off-ps  = <60000>;
> +	devbus,badr-skew-ps = <0>;
> +	devbus,acc-first-ps = <124000>;
> +	devbus,acc-next-ps  = <248000>;
> +	devbus,rd-setup-ps  = <0>;
> +	devbus,rd-hold-ps   = <0>;
> +
> +	/* Write parameters */
> +	devbus,sync-enable = <0>;
> +	devbus,wr-high-ps  = <60000>;
> +	devbus,wr-low-ps   = <60000>;
> +	devbus,ale-wr-ps   = <60000>;
> +
> +	nvs@0 {
> +		status = "okay";
> +
> +		compatible = "mtd-ram";
> +		reg = <0 0x00080000>;
> +		bank-width = <1>;
> +		label = "nvs";
> +	};
> +};
> +
> +&pinctrl {
> +	i2c0_gpio_pins: i2c-gpio-pins-0 {
> +		marvell,pins = "mpp2", "mpp3";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-1 = <&i2c0_gpio_pins>;
> +	scl-gpio = <&gpio0 2 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +	sda-gpio = <&gpio0 3 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +
> +	i2c0mux: mux@71 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "nxp,pca9544";
> +		reg = <0x71>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c@0 { /* POE devices MUX */
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			adt7476_2e: hwmon@2e {
> +				compatible = "adi,adt7476";
> +				reg = <0x2e>;
> +			};
> +
> +			adt7476_2d: hwmon@2d {
> +				compatible = "adi,adt7476";
> +				reg = <0x2d>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +
> +			rtc@68 {
> +				compatible = "dallas,ds1340";
> +				reg = <0x68>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +
> +			gpio@20 {
> +				compatible = "nxp,pca9554";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x20>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins>;
> +	status = "okay";
> +
> +	spi-flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <1>; /* Chip select 1 */
> +		spi-max-frequency = <54000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@u-boot {
> +				reg = <0x00000000 0x00100000>;
> +				label = "u-boot";
> +			};
> +			partition@u-boot-env {
> +				reg = <0x00100000 0x00040000>;
> +				label = "u-boot-env";
> +			};
> +			partition@unused {
> +				reg = <0x00140000 0x00e80000>;
> +				label = "unused";
> +			};
> +			partition@idprom {
> +				reg = <0x00fc0000 0x00040000>;
> +				label = "idprom";
> +			};
> +		};
> +	};
> +};
> +
> +&nand_controller {
> +	status = "okay";
> +
> +	nand@0 {
> +		reg = <0>;
> +		label = "pxa3xx_nand-0";
> +		nand-rb = <0>;
> +		nand-on-flash-bbt;
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +
> +		marvell,nand-enable-arbiter;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@user {
> +				reg = <0x00000000 0x0f000000>;
> +				label = "user";
> +			};
> +			partition@errlog {
> +				/* Maximum mtdoops size is 8MB, so set to that. */
> +				reg = <0x0f000000 0x00800000>;
> +				label = "errlog";
> +			};
> +			partition@nand-bbt {
> +				reg = <0x0f800000 0x00800000>;
> +				label = "nand-bbt";
> +			};
> +		};
> +	};
> +};
> +
> -- 
> 2.29.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
