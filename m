Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727A40004D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbhICNOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 09:14:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43532 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235336AbhICNOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 09:14:46 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mM90r-0005M9-6l; Fri, 03 Sep 2021 15:13:45 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jacopo@jmondi.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: hook up camera on px30-evb
Date:   Fri, 03 Sep 2021 15:13:44 +0200
Message-ID: <2431927.xZuKtqe2JJ@diego>
In-Reply-To: <20210830141318.66744-2-heiko@sntech.de>
References: <20210830141318.66744-1-heiko@sntech.de> <20210830141318.66744-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. August 2021, 16:13:18 CEST schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Note to self: missing patch description, make it something like:

Enable the isp and csi phy on px30-evb and connect it to the board's
ov5695 camera.


> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30-evb.dts | 52 +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> index c1ce9c295e5b..848bc39cf86a 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> @@ -114,6 +114,10 @@ &cpu3 {
>  	cpu-supply = <&vdd_arm>;
>  };
>  
> +&csi_dphy {
> +	status = "okay";
> +};
> +
>  &display_subsystem {
>  	status = "okay";
>  };
> @@ -428,6 +432,36 @@ sensor@4c {
>  	};
>  };
>  
> +&i2c2 {
> +	status = "okay";
> +
> +	clock-frequency = <100000>;
> +
> +	/* These are relatively safe rise/fall times; TODO: measure */
> +	i2c-scl-falling-time-ns = <50>;
> +	i2c-scl-rising-time-ns = <300>;
> +
> +	ov5695: ov5695@36 {
> +		compatible = "ovti,ov5695";
> +		reg = <0x36>;
> +		avdd-supply = <&vcc2v8_dvp>;
> +		clocks = <&cru SCLK_CIF_OUT>;
> +		clock-names = "xvclk";
> +		dvdd-supply = <&vcc1v5_dvp>;
> +		dovdd-supply = <&vcc1v8_dvp>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cif_clkout_m0>;
> +		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			ucam_out: endpoint {
> +				remote-endpoint = <&mipi_in_ucam>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +	};
> +};
> +
>  &i2s1_2ch {
>  	status = "okay";
>  };
> @@ -443,6 +477,24 @@ &io_domains {
>  	vccio6-supply = <&vccio_flash>;
>  };
>  
> +&isp {
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			mipi_in_ucam: endpoint@0 {
> +				reg = <0>;
> +				data-lanes = <1 2>;
> +				remote-endpoint = <&ucam_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&isp_mmu {
> +	status = "okay";
> +};
> +
>  &pinctrl {
>  	headphone {
>  		hp_det: hp-det {
> 




