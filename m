Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3762D3A3B90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFKGC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFKGCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:02:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A13610A5;
        Fri, 11 Jun 2021 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623391255;
        bh=G5fNaWMC3tJrhYe4hSWFBJEP1GPo85Wn6N+8X6LULmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvOKXoqLPWg2DL5x0sLR3jKcaLGDgemhNXYpdA4vtfzQv5BZ+aG1UVF6NEB3ZEE/y
         VKSvMaOBeEpJabWdr98IEW6B2Mbs1smhiZTGGm81Iy1QMsITnz5QWcHc2pnBHnPA12
         TiI7ZL+jfLMeuLe7Gc0p14QRnfd5OpcDBLeViF4XXac6nhYVQ9IbRqRaKy1X7T7wTa
         9zgC0eyoy4qX4/ZYQ5iMz22jmp1ROaH3qFse8G1ZnrZ0ss69dmSR3W4qTDIz01t9zQ
         /AYCJFbr4/JJD1LiaaZnPNSOIOHFrOCAVjaumhiBixqN0vTtZbLLSOjqkdmXKSDiSu
         nO4uq3H9HqJdQ==
Date:   Fri, 11 Jun 2021 11:30:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: owl-s500: Add ethernet support
Message-ID: <20210611060047.GC6950@thinkpad>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
 <926456e8a3700b257605534cf711a0bfb667fc36.1623358117.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926456e8a3700b257605534cf711a0bfb667fc36.1623358117.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:09:21AM +0300, Cristian Ciocaltea wrote:
> Add Ethernet MAC device tree node for Actions Semi S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index cd635f222d26..739b4b9cec8c 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -324,5 +324,15 @@ mmc2: mmc@b0238000 {
>  			dma-names = "mmc";
>  			status = "disabled";
>  		};
> +
> +		ethernet: ethernet@b0310000 {
> +			compatible = "actions,s500-emac", "actions,owl-emac";
> +			reg = <0xb0310000 0x10000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_ETHERNET>, <&cmu CLK_RMII_REF>;
> +			clock-names = "eth", "rmii";
> +			resets = <&cmu RESET_ETHERNET>;
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.32.0
> 
