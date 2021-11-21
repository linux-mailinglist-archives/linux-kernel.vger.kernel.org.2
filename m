Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2044C4585AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhKURxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:53:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37578 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238796AbhKURxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:53:44 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1moqz1-0007ug-8K; Sun, 21 Nov 2021 18:50:31 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Dennis Gilmore <dgilmore@redhat.com>
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>,
        Florian Klink <flokli@flokli.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: helios64: define usb hub and 2.5GbE nic
Date:   Sun, 21 Nov 2021 18:50:30 +0100
Message-ID: <2865185.A8ACM6KOrL@diego>
In-Reply-To: <20211026150751.70115-1-dgilmore@redhat.com>
References: <20211026150751.70115-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

Am Dienstag, 26. Oktober 2021, 17:07:47 CET schrieb Dennis Gilmore:
> Add the 4 ports on the internal hub and define and turn on the 2.5GbE
> nic.
> 
> Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
> ---
>  .../dts/rockchip/rk3399-kobol-helios64.dts    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> index 26d45cf7ce00..1ffddf860375 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> @@ -125,6 +125,18 @@ pcie_power: pcie-power {
>  		vin-supply = <&vcc5v0_perdev>;
>  	};
>  
> +	usblan_power: usblan-power {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_lan_en>;
> +		regulator-name = "usblan_power";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
>  	vcc1v8_sys_s0: vcc1v8-sys-s0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc1v8_sys_s0";
> @@ -465,6 +477,11 @@ hdd_b_power_en: hdd-b-power-en {
>  		vcc5v0_usb_en: vcc5v0-usb-en {
>  			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> +
> +		usb_lan_en: usb-lan-en {
> +			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
>  	};
>  
>  	vcc3v0-sd {
> @@ -563,5 +580,43 @@ &usbdrd3_1 {
>  	usb@fe900000 {
>  		dr_mode = "host";
>  		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hub@1 {
> +			compatible = "usb2109,0815";
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@1 {

port@ nodes are not defined in the dt-bindings.

Are you really sure these are needed, as I guess only defining the
device@4 should be enough and leaving the rest to be allocated
dynamically?

The binding at least contains the line
	Usually, we only use device tree for hard wired USB device.


Heiko

> +				reg = <1>;
> +				#trigger-source-cells = <0>;
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				#trigger-source-cells = <0>;
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				#trigger-source-cells = <0>;
> +			};
> +
> +			device@4 {
> +				compatible = "usbbda,8156";
> +				reg = <4>;
> +
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +
> +				interface@0 {	/* interface 0 of configuration 1 */
> +					compatible = "usbbda,8156.config1.0";
> +					reg = <0 1>;
> +				};
> +			};
> +		};
>  	};
>  };
> 




