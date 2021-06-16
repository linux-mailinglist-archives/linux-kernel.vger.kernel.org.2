Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068933A96E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFPKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhFPKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:09:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C08C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:07:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1ltSRu-00015P-2M; Wed, 16 Jun 2021 12:07:06 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1ltSRs-0002H5-DS; Wed, 16 Jun 2021 12:07:04 +0200
Date:   Wed, 16 Jun 2021 12:07:04 +0200
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
Subject: Re: [PATCH v2 31/33] arm64: zynqmp: Enable xlnx, zynqmp-dwc3 driver
 for xilinx boards
Message-ID: <20210616100704.GH22530@pengutronix.de>
References: <cover.1623684253.git.michal.simek@xilinx.com>
 <3a68b328a69a0db51948798216cf914c9073baf2.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a68b328a69a0db51948798216cf914c9073baf2.1623684253.git.michal.simek@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:31:28 up 118 days, 12:55, 123 users,  load average: 0.16, 0.14,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 17:25:39 +0200, Michal Simek wrote:
> The commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
> finally add proper support for Xilinx dwc3 driver. This patch is adding DT
> description for it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - New patch in the series
> 
>  .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  6 ++
>  .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  7 ++
>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 14 ++++
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 10 +++
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  6 ++
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 ++
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  6 ++
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  6 ++
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  6 ++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 70 +++++++++++++++----
>  10 files changed, 124 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index d78439e891b9..c1cedc92e017 100644
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
> @@ -404,7 +405,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
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
> index 80415e202814..6d32bfac48b5 100644
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
> @@ -537,6 +539,10 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "peripheral";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
> @@ -548,6 +554,10 @@ &usb1 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb1_default>;
> +};
> +
> +&dwc3_1 {
> +	status = "okay";
>  	dr_mode = "host";
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index becfc23a5610..b17677378ab5 100644
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
> @@ -998,7 +999,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 86fff3632c7d..fb7a9f7907d9 100644
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
> @@ -481,7 +482,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 2a872d439804..afc9b200a59b 100644
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
> @@ -493,7 +494,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index d2219373580a..793740cbd791 100644
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
> @@ -991,7 +992,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index dac5ba67a160..a245250970c8 100644
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
> @@ -828,7 +829,12 @@ &usb0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usb0_default>;
> +};
> +
> +&dwc3_0 {
> +	status = "okay";
>  	dr_mode = "host";
> +	snps,usb3_lpm_capable;
>  	phy-names = "usb3-phy";
>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>  	maximum-speed = "super-speed";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 6f0fcec28ae2..731b2d170344 100644
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
> @@ -805,24 +805,68 @@ uart1: serial@ff010000 {
>  			power-domains = <&zynqmp_firmware PD_UART_1>;
>  		};
>  
> -		usb0: usb@fe200000 {
> -			compatible = "snps,dwc3";
> +		usb0: usb0@ff9d0000 {

usb@ff9d0000

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
> +				status = "disabled";

I think it would be better to drop the status from dwc3_0, since it is a child
node of the already disabled usb0 node. With the current change, the board dts
has to enable usb0 and dwc3_0 to enable usb support, which is kind of
unexpected.

> +				reg = <0x0 0xfe200000 0x0 0x40000>;
> +				interrupt-parent = <&gic>;
> +				interrupt-names = "dwc_usb3", "otg";
> +				interrupts = <0 65 4>, <0 69 4>;
> +				#stream-id-cells = <1>;
> +				iommus = <&smmu 0x860>;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,refclk_fladj;
> +				snps,enable_guctl1_resume_quirk;
> +				snps,enable_guctl1_ipd_quirk;
> +				snps,xhci-stream-quirk;

The last four properties for snps are not documented (and not used by the
driver).

> +				/* dma-coherent; */
> +			};
>  		};
>  
> -		usb1: usb@fe300000 {
> -			compatible = "snps,dwc3";
> +		usb1: usb1@ff9e0000 {

usb@fe9e00000

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
> +				status = "disabled";

Same as above.

> +				reg = <0x0 0xfe300000 0x0 0x40000>;
> +				interrupt-parent = <&gic>;
> +				interrupt-names = "dwc_usb3", "otg";
> +				interrupts = <0 70 4>, <0 74 4>;
> +				#stream-id-cells = <1>;
> +				iommus = <&smmu 0x861>;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,refclk_fladj;
> +				snps,enable_guctl1_resume_quirk;
> +				snps,enable_guctl1_ipd_quirk;
> +				snps,xhci-stream-quirk;

Same as above.

Thanks,

Michael

> +				/* dma-coherent; */
> +			};
>  		};
>  
>  		watchdog0: watchdog@fd4d0000 {
