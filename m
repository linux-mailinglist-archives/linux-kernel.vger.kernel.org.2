Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A8379CED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEKC2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKC2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:28:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FEF561466;
        Tue, 11 May 2021 02:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620700051;
        bh=0s5VHawRtxwlwlHKrz6cNOOfyLZenbHb07VdzgiSQao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoN7wK3NJoPA93GxMC4NV895JVH4+hH+bPAzIWmqlZjA9NtTihRw1kgg1VMNvhsoq
         /HaRWgsJMEn2xRmw5Hp5dSPaHRu59ow5OjN8+1eX4GobVH4jPZ/PPcrJSh7yYtqb06
         sYKp8XuIkzrAL6vrerPOorZLDoHRWWyBlc9JHUUlAiwdi9no9ksjGIipY4BC2vvbHK
         eOMPyzOrkFzhwJB2j10fav3AgO1lofoZ1NLlF7C/D/jmlofYtiq5vze5//QvTkCSgo
         DQrt1XHEcqitSYbPQZ+ptkJw0XcVBuwl2QWzbxI/HJvFWHlqmlNPwOCRq+igLcFgbG
         1ApfrHfcYgXmA==
Date:   Tue, 11 May 2021 10:27:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI
 to HDMI
Message-ID: <20210511022725.GC3425@dragon>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
 <20210331232356.2204476-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331232356.2204476-4-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:23:55AM +0200, Adrien Grassein wrote:
> Add support of the lt8912b in the DTB.
> This adds the support of the DB_DSIHD daugther board from
> Boundary Devices.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> index 04992cbba56e..4ffd23ea705f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> @@ -34,6 +34,19 @@ power {
>  		};
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		ddc-i2c-bus = <&ddc_i2c_bus>;
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&lt8912_out>;
> +			};
> +		};
> +	};
> +
>  	reg_usb_otg_vbus: regulator-usb-otg-vbus {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -81,6 +94,9 @@ reg_vref_5v: regulator-vref-5v {
>  	};
>  };
>  
> +&dphy {
> +	status = "okay";
> +};
>  
>  &fec1 {
>  	pinctrl-names = "default";
> @@ -193,6 +209,97 @@ rtc@68 {
>  	};
>  };
>  
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pca9546: i2cmux9546@70 {

Node name should be generic, so 9546 should be dropped from there?

> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c4@0 {

Is number 4 really needed in node name?

> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <100000>;
> +
> +			hdmi-bridge@48 {
> +				compatible = "lontium,lt8912b";
> +				reg = <0x48> ;
> +				reset-gpios = <&max7323 0 GPIO_ACTIVE_LOW>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						hdmi_out_in: endpoint {
> +							data-lanes = <1 2 3 4>;
> +							remote-endpoint = <&mipi_dsi_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						lt8912_out: endpoint {
> +							remote-endpoint = <&hdmi_connector_in>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		ddc_i2c_bus: i2c4@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <100000>;
> +		};
> +
> +		i2c4@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <100000>;
> +
> +			max7323: max7323@68 {

Can we have a generic node name for this device?

> +				compatible = "maxim,max7323";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_max7323>;
> +				gpio-controller;
> +				reg = <0x68>;
> +				#gpio-cells = <2>;
> +			};
> +		};
> +	};
> +};
> +
> +&lcdif {
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	status = "okay";

Move it to end of property list.

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;

Newline between property and child node.

Shawn

> +			mipi_dsi_out: endpoint {
> +				remote-endpoint = <&hdmi_out_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &uart1 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -368,6 +475,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x49
>  		>;
>  	};
>  
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_max7323: max7323grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15 0x19
> +		>;
> +	};
> +
>  	pinctrl_reg_arm_dram: reg-arm-dramgrp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_SAI5_RXD3_GPIO3_IO24	0x16
> -- 
> 2.25.1
> 
