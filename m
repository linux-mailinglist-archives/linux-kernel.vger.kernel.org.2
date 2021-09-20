Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8441299F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbhITX6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:58:51 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:35599 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhITX4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:56:51 -0400
Received: by mail-ot1-f43.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so14828704otj.2;
        Mon, 20 Sep 2021 16:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6uM+gxeDXYFxRPr62zc48/76K2FtsgJgxYSNWV7dW8=;
        b=f2nvlfJF8EZNzrnZQRQoq51Uir23PMmqzN0AqhYbsA70EdwTxvzrdtr8ItSl+OP+S7
         7h3OBpD0nFPDvpSj3F84YOVKOzbVYJzWj5Wt0RZ6pd6EH4IZqGbzapytBHSRcWnqGPdv
         29LLkjxnsNZfvs2A1uq9Ljz2Q0LcSa5D3esHWSRWwIGcVo3BHwCO0Ef1U2OMUoBooxAa
         yRyWMOs5v3OQcRaP7QCtN1K46JioUsYARFR1iyy0WOf9FGkYgWxmElXcUCSMOzoy4Kyh
         nxGpwHih1gqsZcTGmAQzC6xaKhYfCNvOq7SHSCohDnjkWnYbUIM4Vied8TLZDI9vBRVa
         Jj5g==
X-Gm-Message-State: AOAM532xN4yZ+YmjLWA8zqeFsZLcYDNMGO0IIkniq6y1vSt+SX3wIrFp
        NZOAB4YadKzRiuRkx3nN3A==
X-Google-Smtp-Source: ABdhPJyUhWUd+xCwTJoSuwz2i9StrPc4K2w0twFg60PYG2Ab8eaudGAYx7HONFue2YSjr+mCuCmrjA==
X-Received: by 2002:a9d:4c06:: with SMTP id l6mr7621793otf.185.1632182123118;
        Mon, 20 Sep 2021 16:55:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm3809482ooa.1.2021.09.20.16.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:55:21 -0700 (PDT)
Received: (nullmailer pid 1066793 invoked by uid 1000);
        Mon, 20 Sep 2021 23:55:21 -0000
Date:   Mon, 20 Sep 2021 18:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     andrej.rosano@f-secure.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ulz: add support for USB armory Mk II
Message-ID: <YUkfaaYb/NTL19gE@robh.at.kernel.org>
References: <20210908103232.204763-1-andrej.rosano@f-secure.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908103232.204763-1-andrej.rosano@f-secure.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 12:32:32PM +0200, andrej.rosano@f-secure.com wrote:
> From: Andrej Rosano <andrej.rosano@f-secure.com>
> 
> Add support for F-Secure USB armory Mk II board, an open source
> flash-drive sized computer based on NXP i.MX6ULZ SoC.
> 
> https://github.com/f-secure-foundry/usbarmory
> 
> Signed-off-by: Andrej Rosano <andrej.rosano@f-secure.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   3 +-
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  arch/arm/boot/dts/imx6ulz-usbarmory.dts       | 238 ++++++++++++++++++
>  3 files changed, 242 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ulz-usbarmory.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 1c827c1954dc..a11d10a22b64 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -595,7 +595,8 @@ properties:
>        - description: i.MX6ULZ based Boards
>          items:
>            - enum:
> -              - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
> +              - fsl,imx6ulz-14x14-evk         # i.MX6 ULZ 14x14 EVK Board
> +              - inversepath,imx6ulz-usbarmory # F-Secure USB armory Mk II
>            - const: fsl,imx6ull # This seems odd. Should be last?
>            - const: fsl,imx6ulz
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 863347b6b65e..6fd2b8f55255 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -655,7 +655,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
>  	imx6ull-phytec-segin-lc-rdk-nand.dtb \
> -	imx6ulz-14x14-evk.dtb
> +	imx6ulz-14x14-evk.dtb \
> +	imx6ulz-usbarmory.dtb
>  dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-cl-som-imx7.dtb \
>  	imx7d-colibri-aster.dtb \
> diff --git a/arch/arm/boot/dts/imx6ulz-usbarmory.dts b/arch/arm/boot/dts/imx6ulz-usbarmory.dts
> new file mode 100644
> index 000000000000..6262d30bcb9c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ulz-usbarmory.dts
> @@ -0,0 +1,238 @@
> +/*
> + * USB armory Mk II device tree file
> + * https://github.com/f-secure-foundry/usbarmory
> + *
> + * Copyright (C) 2020, F-Secure Corporation
> + * Andrej Rosano <andrej.rosano@f-secure.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Replace all this with SPDX tag.

> + */
> +
> +/dts-v1/;
> +
> +#include "imx6ulz.dtsi"

Which should match the license here (it's not GPL2 OR LATER).

> +
> +/ {
> +	model = "F-Secure USB armory Mk II";
> +	compatible = "inversepath,imx6ulz-usbarmory-mkII", "fsl,imx6ull", "fsl,imx6ulz";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	memory {

memory@80000000

> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led>;
> +
> +		led-white {
> +			label = "LED_WHITE";
> +			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-blue {
> +			label = "LED_BLUE";
> +			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";

This is not a bus... Drop.

> +		#address-cells = <1>;
> +		#size-cells = <0>;

And these too.

> +
> +		reg_sd1_vmmc: sd1_regulator {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VSD_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_bluetooth>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_bluetooth: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b0 /* BT_UART_TX  */
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b0 /* BT_UART_RX  */
> +			MX6UL_PAD_UART1_CTS_B__UART1_DCE_CTS	0x1b0b0 /* BT_UART_CTS */
> +			MX6UL_PAD_GPIO1_IO07__UART1_DCE_RTS	0x130b0 /* BT_UART_RTS */
> +			MX6UL_PAD_UART3_TX_DATA__GPIO1_IO24	0x1f020 /* BT_UART_DSR */
> +			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x10020 /* BT_UART_DTR */
> +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1f020 /* BT_SWDCLK   */
> +			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x1f020 /* BT_SWDIO    */
> +			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x1f020 /* BT_RESET    */
> +			MX6UL_PAD_UART3_RTS_B__GPIO1_IO27	0x1f020 /* BT_SWITCH_1 */
> +			MX6UL_PAD_UART3_CTS_B__GPIO1_IO26	0x1f020 /* BT_SWITCH_2 */
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO02__I2C1_SCL	0x4001b8b0
> +			MX6UL_PAD_GPIO1_IO03__I2C1_SDA	0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x1f020
> +			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x1f020
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x1f019
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x1f019
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x1f019
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x1f019
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x1f019
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x1f019
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
> +		>;
> +	};
> +};
> +
> +&usbotg1 {
> +	dr_mode = "peripheral";
> +	disable-over-current;
> +	tpl-support;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	tpl-support;
> +	status = "okay";
> +};
> -- 
> 2.33.0
> 
> 
