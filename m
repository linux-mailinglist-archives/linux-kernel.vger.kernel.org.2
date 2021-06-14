Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEB3A659A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhFNLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236127AbhFNL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:29:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64100610A1;
        Mon, 14 Jun 2021 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670064;
        bh=2rY2tAo241vX6ekFHgV1yvqOPbGBmy18m5WLXiLqfeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOuiFxjSh80/mdRceoX2xOb5QbpLlHTQbi+rVVDf2f2VlXYzWQ8Ize0UMp/alOLaF
         AoOxZuDyYT4+GWocZ49wSxFKUrPDfxEWAGyYKlnU/Jgqo+mIVbBVuMaLmnni/mMiBv
         L9Ulk/ntWSNtHpUtjH4WFaAZ4sc21qCsB6BhM7grhPC7ZN1nH4n1xJCejKkuGuyApt
         ao1/BEpgn+k8QggMfxP6JXc4dWOEtSLugtluKJUxMvIVPYovSvlWSTX4R+xcPuS3zQ
         bihwlM5ANdd+WJQExzG902nQ9A3cQ3HzU0lTSxAdLry3+BJ5rlYCuumxkD2n6F8+G+
         S+VRXos4WvSaA==
Date:   Mon, 14 Jun 2021 16:57:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet
 support
Message-ID: <20210614112733.GA38584@thinkpad>
References: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
 <d0e1fbf81984127f0352eb740c7129424b5e40f9.1623401998.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e1fbf81984127f0352eb740c7129424b5e40f9.1623401998.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:11:33PM +0300, Cristian Ciocaltea wrote:
> Add pinctrl configuration for enabling the Ethernet MAC on RoseapplePi
> SBC. Additionally, provide the necessary properties for the generic S500
> ethernet node in order to setup PHY and MDIO.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani 

> ---
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> index b8c5db2344aa..eb555f385283 100644
> --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -225,6 +225,27 @@ bias1-pinconf {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	ethernet_pins: ethernet-pins {
> +		eth_rmii-pinmux {
> +			groups = "rmii_txd0_mfp", "rmii_txd1_mfp",
> +				 "rmii_rxd0_mfp", "rmii_rxd1_mfp",
> +				 "rmii_txen_mfp", "rmii_rxen_mfp",
> +				 "rmii_crs_dv_mfp", "rmii_ref_clk_mfp";
> +			function = "eth_rmii";
> +		};
> +
> +		phy_clk-pinmux {
> +			groups = "clko_25m_mfp";
> +			function = "clko_25m";
> +		};
> +
> +		ref_clk-pinconf {
> +			groups = "rmii_ref_clk_drv";
> +			drive-strength = <2>;
> +		};
> +
> +	};
>  };
>  
>  /* uSD */
> @@ -241,6 +262,30 @@ &mmc0 {
>  	vqmmc-supply = <&sd_vcc>;
>  };
>  
> +&ethernet {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ethernet_pins>;
> +	phy-mode = "rmii";
> +	phy-handle = <&eth_phy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reset-gpios = <&pinctrl 88 GPIO_ACTIVE_LOW>; /* GPIOC24 */
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <150000>;
> +
> +		eth_phy: ethernet-phy@3 {
> +			reg = <0x3>;
> +			max-speed = <100>;
> +			interrupt-parent = <&sirq>;
> +			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
> +};
> +
>  &twd_timer {
>  	status = "okay";
>  };
> -- 
> 2.32.0
> 
