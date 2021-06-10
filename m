Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9653A21E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFJBhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:37:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33858 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJBhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:37:17 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CC678A2;
        Thu, 10 Jun 2021 03:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1623288920;
        bh=ZOPIF/Y2NL+RVtQmqfz7Yzk+FKKW1kdfWXCUZ0p+IYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIUIc8Ae0iR5Cdk4+JCLjml+9LuS7ep/EjFfxQ93Yi5dCVT9RpLe7OPxB/FzQwUK3
         /KZeyTbLUH0LNqQ8SM9Me9We5MpQPn73gkFAb2eJcw/ULwYBY9J30OyIgaB6Zhpnlf
         8pYgudO3SFYWbiZ5KYk8kwTXmzhjIMqOnioqw7Iw=
Date:   Thu, 10 Jun 2021 04:35:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 21/31] arm64: zynqmp: Move DP nodes to the end of file on
 zcu106
Message-ID: <YMFsRjXuYm0KMRMD@pendragon.ideasonboard.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
 <4d1c79f6f184367687f61608bb8e0f18d9121802.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d1c79f6f184367687f61608bb8e0f18d9121802.1623239033.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Wed, Jun 09, 2021 at 01:44:57PM +0200, Michal Simek wrote:
> This location is used by others DTs files that's why this move.

I like alphabetical order :-)

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index dbb8bfbb5c7f..4a0f3370bf7f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -160,17 +160,6 @@ &dcc {
>  	status = "okay";
>  };
>  
> -&zynqmp_dpdma {
> -	status = "okay";
> -};
> -
> -&zynqmp_dpsub {
> -	status = "okay";
> -	phy-names = "dp-phy0", "dp-phy1";
> -	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> -	       <&psgtr 0 PHY_TYPE_DP 1 3>;
> -};
> -
>  /* fpd_dma clk 667MHz, lpd_dma 500MHz */
>  &fpd_dma_chan1 {
>  	status = "okay";
> @@ -994,3 +983,14 @@ &usb0 {
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 3>;
> +};

-- 
Regards,

Laurent Pinchart
