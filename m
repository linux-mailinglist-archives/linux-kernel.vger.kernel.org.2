Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FF3F17C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhHSLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbhHSLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:11:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B785BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:10:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mGfwY-0002l9-VI; Thu, 19 Aug 2021 13:10:43 +0200
Message-ID: <cbd278b1828d4b8fbfd885e56731d82355d2112b.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/3] arm: dts: imx: fix the schema check errors
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Aug 2021 13:10:39 +0200
In-Reply-To: <20210819071408.3856475-3-hongxing.zhu@nxp.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
         <20210819071408.3856475-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Am Donnerstag, dem 19.08.2021 um 15:14 +0800 schrieb Richard Zhu:
> - the ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#

I failed to parse this part of the commit message and expected to see
an actual change in the addresses of the ranges or something. I think
it would be better to phrase this something like: "group ranges
property by region" or something to make it clear that this is purely a
DTS representation change, with no functional change.

> - num-viewport is required, add it in imx6sx.dtsi.
> - only one propert is allowed in the compatible string, remove
>   "snps,dw-pcie".
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Other than the nit above, this is:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
>  arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
>  arch/arm/boot/dts/imx6sx.dtsi  | 7 ++++---
>  arch/arm/boot/dts/imx7d.dtsi   | 6 +++---
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 82e01ce026ea..cb43c72806a1 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -264,7 +264,7 @@ L2: cache-controller@a02000 {
>  		};
>  
>  		pcie: pcie@1ffc000 {
> -			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> +			compatible = "fsl,imx6q-pcie";
>  			reg = <0x01ffc000 0x04000>,
>  			      <0x01f00000 0x80000>;
>  			reg-names = "dbi", "config";
> @@ -272,8 +272,8 @@ pcie: pcie@1ffc000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			bus-range = <0x00 0xff>;
> -			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> -				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>, /* downstream I/O */
> +				 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
>  			num-viewport = <4>;
>  			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
> index b310f13a53f2..050365513836 100644
> --- a/arch/arm/boot/dts/imx6qp.dtsi
> +++ b/arch/arm/boot/dts/imx6qp.dtsi
> @@ -110,5 +110,5 @@ &mmdc0 {
>  };
>  
>  &pcie {
> -	compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
> +	compatible = "fsl,imx6qp-pcie";
>  };
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 8516730778df..0324f9e17389 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -1395,16 +1395,17 @@ pwm8: pwm@22b0000 {
>  		};
>  
>  		pcie: pcie@8ffc000 {
> -			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
> +			compatible = "fsl,imx6sx-pcie";
>  			reg = <0x08ffc000 0x04000>, <0x08f00000 0x80000>;
>  			reg-names = "dbi", "config";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			bus-range = <0x00 0xff>;
> -			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
> -				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000>, /* downstream I/O */
> +				 <0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
> +			num-viewport = <4>;
>  			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi";
>  			#interrupt-cells = <1>;
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index b0bcfa9094a3..0cb8c8df87ef 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -164,7 +164,7 @@ fec2: ethernet@30bf0000 {
>  	};
>  
>  	pcie: pcie@33800000 {
> -		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
> +		compatible = "fsl,imx7d-pcie";
>  		reg = <0x33800000 0x4000>,
>  		      <0x4ff00000 0x80000>;
>  		reg-names = "dbi", "config";
> @@ -172,8 +172,8 @@ pcie: pcie@33800000 {
>  		#size-cells = <2>;
>  		device_type = "pci";
>  		bus-range = <0x00 0xff>;
> -		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
> -			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
> +		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000>, /* downstream I/O */
> +			 <0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
>  		num-lanes = <1>;
>  		num-viewport = <4>;
>  		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;


