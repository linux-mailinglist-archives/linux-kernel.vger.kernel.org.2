Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAF3E8E51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhHKKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhHKKOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:14:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A5C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:12:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mDlE9-0004NE-Ds; Wed, 11 Aug 2021 12:12:49 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mDlE7-0005go-5G; Wed, 11 Aug 2021 12:12:47 +0200
Date:   Wed, 11 Aug 2021 12:12:47 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] arm64: zynqmp: Enable xlnx, zynqmp-dwc3 driver
 for xilinx boards
Message-ID: <20210811101247.GC27204@pengutronix.de>
References: <cover.1628244703.git.michal.simek@xilinx.com>
 <640a3bc0dc3e32560d3e84c2f78b5ae561396eb0.1628244703.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <640a3bc0dc3e32560d3e84c2f78b5ae561396eb0.1628244703.git.michal.simek@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:10:57 up 174 days, 13:34, 92 users,  load average: 0.38, 0.26,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2021 12:12:07 +0200, Michal Simek wrote:
> The commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
> finally add proper support for Xilinx dwc3 driver. This patch is adding DT
> description for it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
> 
> Changes in v3:
> - usb node name fix, remove undocumented properties reported by Michael Tretter
> - Also remove status property from dwc3_0/1 nodes reported by Michael
>   Tretter
> - Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
>   Narani
> 
> Changes in v2:
> - New patch in the series
> 
>  .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  8 ++-
>  .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  7 +++
>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 14 +++++
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 14 ++++-
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  8 ++-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++----
>  10 files changed, 122 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index d93fe2efa39d..b05be2552826 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -27,6 +27,7 @@ aliases {
>  		rtc0 = &rtc;
>  		serial0 = &uart0;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -404,9 +405,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index cd61550c52e5..938b76bd0527 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -26,6 +26,7 @@ aliases {
>  		serial1 = &uart1;
>  		spi0 = &spi0;
>  		spi1 = &spi1;
> +		usb0 = &usb1;
>  	};
>  
>  	chosen {
> @@ -479,7 +480,13 @@ &usb1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb1_default>;
> +};
> +
> +&dwc3_1 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
> +	maximum-speed = "super-speed";
>  };
>  
>  &uart0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> index ba7f1f21c579..4394ec3b6a23 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> @@ -24,6 +24,8 @@ aliases {
>  		rtc0 = &rtc;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
>  	};
>  
>  	chosen {
> @@ -147,11 +149,23 @@ &uart1 {
>  
>  &usb0 {
>  	status = "okay";
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
> +	maximum-speed = "super-speed";
>  };
>  
>  /* ULPI SMSC USB3320 */
>  &usb1 {
>  	status = "okay";
> +};
> +
> +&dwc3_1 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
> +	maximum-speed = "super-speed";
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 80415e202814..f6aad4159ccd 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -30,6 +30,8 @@ aliases {
>  		serial2 = &dcc;
>  		spi0 = &spi0;
>  		spi1 = &spi1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
>  	};
> @@ -537,9 +539,13 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "peripheral";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "peripheral";
>  	maximum-speed = "super-speed";
>  };
>  
> @@ -548,9 +554,13 @@ &usb1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb1_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
> +};
> +
> +&dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 3d8d14ef1ede..7b9a88b125d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -31,6 +31,7 @@ aliases {
>  		serial1 = &uart1;
>  		serial2 = &dcc;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -997,9 +998,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 86fff3632c7d..bd8f20f3223d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -29,6 +29,7 @@ aliases {
>  		serial1 = &uart1;
>  		serial2 = &dcc;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -481,9 +482,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 2a872d439804..96feaad30166 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -29,6 +29,7 @@ aliases {
>  		serial1 = &uart1;
>  		serial2 = &dcc;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -493,9 +494,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 057c04352591..20b7c75bb1d3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -31,6 +31,7 @@ aliases {
>  		serial1 = &uart1;
>  		serial2 = &dcc;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -990,9 +991,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index e1fff62a4cd5..e36df6adbeee 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -30,6 +30,7 @@ aliases {
>  		serial0 = &uart0;
>  		serial1 = &dcc;
>  		spi0 = &qspi;
> +		usb0 = &usb0;
>  	};
>  
>  	chosen {
> @@ -827,9 +828,14 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> -	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	maximum-speed = "super-speed";
>  };
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index b5fde9dddca5..74e66443e4ce 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP
>   *
> - * (C) Copyright 2014 - 2019, Xilinx, Inc.
> + * (C) Copyright 2014 - 2021, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   *
> @@ -805,24 +805,58 @@ uart1: serial@ff010000 {
>  			power-domains = <&zynqmp_firmware PD_UART_1>;
>  		};
>  
> -		usb0: usb@fe200000 {
> -			compatible = "snps,dwc3";
> +		usb0: usb@ff9d0000 {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
>  			status = "disabled";
> -			interrupt-parent = <&gic>;
> -			interrupts = <0 65 4>;
> -			reg = <0x0 0xfe200000 0x0 0x40000>;
> -			clock-names = "clk_xin", "clk_ahb";
> +			compatible = "xlnx,zynqmp-dwc3";
> +			reg = <0x0 0xff9d0000 0x0 0x100>;
> +			clock-names = "bus_clk", "ref_clk";
>  			power-domains = <&zynqmp_firmware PD_USB_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
> +			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
> +			ranges;
> +
> +			dwc3_0: usb@fe200000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xfe200000 0x0 0x40000>;
> +				interrupt-parent = <&gic>;
> +				interrupt-names = "dwc_usb3", "otg";
> +				interrupts = <0 65 4>, <0 69 4>;
> +				#stream-id-cells = <1>;
> +				iommus = <&smmu 0x860>;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				/* dma-coherent; */
> +			};
>  		};
>  
> -		usb1: usb@fe300000 {
> -			compatible = "snps,dwc3";
> +		usb1: usb@ff9e0000 {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
>  			status = "disabled";
> -			interrupt-parent = <&gic>;
> -			interrupts = <0 70 4>;
> -			reg = <0x0 0xfe300000 0x0 0x40000>;
> -			clock-names = "clk_xin", "clk_ahb";
> +			compatible = "xlnx,zynqmp-dwc3";
> +			reg = <0x0 0xff9e0000 0x0 0x100>;
> +			clock-names = "bus_clk", "ref_clk";
>  			power-domains = <&zynqmp_firmware PD_USB_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
> +			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
> +			ranges;
> +
> +			dwc3_1: usb@fe300000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xfe300000 0x0 0x40000>;
> +				interrupt-parent = <&gic>;
> +				interrupt-names = "dwc_usb3", "otg";
> +				interrupts = <0 70 4>, <0 74 4>;
> +				#stream-id-cells = <1>;
> +				iommus = <&smmu 0x861>;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				/* dma-coherent; */
> +			};
>  		};
>  
>  		watchdog0: watchdog@fd4d0000 {
> -- 
> 2.32.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Michael Tretter             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
