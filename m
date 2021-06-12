Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DF3A4D3D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhFLHGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLHGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42AC161248;
        Sat, 12 Jun 2021 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623481462;
        bh=KavCCSPixTnLQ43Ecp1rRwL8vEmLDi7nRxaggiZK8/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzaD2te/tV05iI6tuY94Mm9/yrfN8dMnMRnn3yhwXISiAqy0GAtR3WJ+zcw+opkF1
         E3Bv8Qt/fgL2nGGau5mZU3CYQ9GIrYT0d3MEuAihVlp5njD+95HEtvpUjv9sCtysgA
         1PXnCenS7hUDm/9qese2rGtGC/jyjLtS+LiA3FP6FV/aagZvD0LtLFCTmGHqyVWAVG
         cS78r9s1U3wr7Ow1Cd+c9797wdL3Kwh/D6aH74I2JLhYWoHlYWxw4n40HgyNqKlWDr
         Xb8AgrgoMGaYwJW3nC4QAYgCdO1hDCJq2EeGtEPZB3OrtQWcoaN7KxAvjxIb07z8db
         4WTBlbhm30pzw==
Date:   Sat, 12 Jun 2021 15:04:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sl: add PXP module
Message-ID: <20210612070416.GV29138@dragon>
References: <20210527210742.2609-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527210742.2609-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:07:42PM +0200, Andreas Kemnade wrote:
> While the EPDC is optional, all editions have the PXP module, so adding
> it to the corresponding .dtsi
> Information taken from freescale kernel, compared with the
> reference manual and tested by a separate program.
> 
> Since it does not depend on external wiring, the
> status = "disabled" is left out here.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 997b96c1c47b..6be83e863f19 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -762,8 +762,11 @@
>  			};
>  
>  			pxp: pxp@20f0000 {
> +				compatible = "fsl,imx6sl-pxp", "fsl,imx6ull-pxp";

"fsl,imx6sl-pxp" needs to be documented.

Shawn

>  				reg = <0x020f0000 0x4000>;
>  				interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6SL_CLK_PXP_AXI>;
> +				clock-names = "axi";
>  			};
>  
>  			epdc: epdc@20f4000 {
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
