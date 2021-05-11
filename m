Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874EC379D60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEKDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEKDIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDA161004;
        Tue, 11 May 2021 03:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620702424;
        bh=Dl3YW3teGKKFwFsnU3XVBmdwvV1e/pCsXI5071YVVyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnG6NjRjzEzULKYDV1rv2mRoLTS+f/rA9knulz6KAyV1swYFgVP60BcaFdwnWFL31
         ZOMx5Lm9D/UULcMDGtumOIX8Rv5tBlipj0zYZG7FfMNx0wkUSIK8MsTh+Uf4etyu02
         zP4op0Rr3EAgBAKH9Cc6SUrlui9pQvvBh9xx9rTvUHbjBaGErzYwobNljvLmggyqZV
         JlqI4NmHRZifq2toZti97R6wqtyl2F+WxUSPRMHg7U3alHdHbe144EPwJLxRkOHXoK
         UELbt+Dq6i2P9kmB0SsmJtqm0D46ipidWgnYxCdmhqywemJA9FvE8XlgN4Z866srmD
         wKnGBQX0WaVqg==
Date:   Tue, 11 May 2021 11:06:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kornel Duleba <mindal@semihalf.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        robh+dt@kernel.org, mw@semihalf.com, tn@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Message-ID: <20210511030658.GG3425@dragon>
References: <20210407123438.224551-1-mindal@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407123438.224551-1-mindal@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Claudiu

On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> Currently all PCIE windows point to bus address 0x0, which does not match
> the values obtained from hardware during EA.
> Replace those values with CPU addresses, since in reality we
> have a 1:1 mapping between the two.
> 
> Signed-off-by: Kornel Duleba <mindal@semihalf.com>

Claudiu,

Do you have any comment on this?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 262fbad8f0ec..85c62a6fabb6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -994,19 +994,19 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
>  			msi-map = <0 &its 0x17 0xe>;
>  			iommu-map = <0 &smmu 0x17 0xe>;
>  				  /* PF0-6 BAR0 - non-prefetchable memory */
> -			ranges = <0x82000000 0x0 0x00000000  0x1 0xf8000000  0x0 0x160000
> +			ranges = <0x82000000 0x1 0xf8000000  0x1 0xf8000000  0x0 0x160000
>  				  /* PF0-6 BAR2 - prefetchable memory */
> -				  0xc2000000 0x0 0x00000000  0x1 0xf8160000  0x0 0x070000
> +				  0xc2000000 0x1 0xf8160000  0x1 0xf8160000  0x0 0x070000
>  				  /* PF0: VF0-1 BAR0 - non-prefetchable memory */
> -				  0x82000000 0x0 0x00000000  0x1 0xf81d0000  0x0 0x020000
> +				  0x82000000 0x1 0xf81d0000  0x1 0xf81d0000  0x0 0x020000
>  				  /* PF0: VF0-1 BAR2 - prefetchable memory */
> -				  0xc2000000 0x0 0x00000000  0x1 0xf81f0000  0x0 0x020000
> +				  0xc2000000 0x1 0xf81f0000  0x1 0xf81f0000  0x0 0x020000
>  				  /* PF1: VF0-1 BAR0 - non-prefetchable memory */
> -				  0x82000000 0x0 0x00000000  0x1 0xf8210000  0x0 0x020000
> +				  0x82000000 0x1 0xf8210000  0x1 0xf8210000  0x0 0x020000
>  				  /* PF1: VF0-1 BAR2 - prefetchable memory */
> -				  0xc2000000 0x0 0x00000000  0x1 0xf8230000  0x0 0x020000
> +				  0xc2000000 0x1 0xf8230000  0x1 0xf8230000  0x0 0x020000
>  				  /* BAR4 (PF5) - non-prefetchable memory */
> -				  0x82000000 0x0 0x00000000  0x1 0xfc000000  0x0 0x400000>;
> +				  0x82000000 0x1 0xfc000000  0x1 0xfc000000  0x0 0x400000>;
>  
>  			enetc_port0: ethernet@0,0 {
>  				compatible = "fsl,enetc";
> -- 
> 2.31.1
> 
