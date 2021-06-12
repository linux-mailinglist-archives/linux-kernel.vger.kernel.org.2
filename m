Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5741D3A4D74
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFLHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLHzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 467DA600EF;
        Sat, 12 Jun 2021 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623484432;
        bh=oCwkNHhkWKOxjdFxSnrTrgHE/Aq9OTaliKcLMCi2kGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3ynf+RHh5/BuZbJRA+x2AdP/KsD/WldeWCp0yWddTkROg2316TOAW2dL9PLW/qrM
         qRn+wnCMw9ER4cHHewFQpYu1M9cstKO8+zD7ZXo33SbeJNEZ8eW5YEjAFFqCuzPGP3
         H+rTL5lemg2FNZ1F7pIc0aP6KXRbLgmuIes2qZVHk6poFIP1mZvHVrUXUxjs5dG4p9
         mdBXJXXMRzZ1v/F6edxEzKZIg5km5jNdIgW2ufTlZtZMvDa1ZH2fPAtcEm6arzYNbg
         PXHXUiY47AT/rCoTCSYIx9UUgsi8BC/dESLBGUv73jyS/1+A+klNFtxUZf/e0NEE7v
         tH1uFnEMwdyvQ==
Date:   Sat, 12 Jun 2021 15:53:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: fix node name for the sysclk
Message-ID: <20210612075346.GZ29138@dragon>
References: <20210608112658.4087235-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608112658.4087235-1-olteanv@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:26:58PM +0300, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> U-Boot attempts to fix up the "clock-frequency" property of the "/sysclk" node:
> https://elixir.bootlin.com/u-boot/v2021.04/source/arch/arm/cpu/armv8/fsl-layerscape/fdt.c#L512
> 
> but fails to do so:
> 
>   ## Booting kernel from Legacy Image at a1000000 ...
>      Image Name:
>      Created:      2021-06-08  10:31:38 UTC
>      Image Type:   AArch64 Linux Kernel Image (gzip compressed)
>      Data Size:    15431370 Bytes = 14.7 MiB
>      Load Address: 80080000
>      Entry Point:  80080000
>      Verifying Checksum ... OK
>   ## Flattened Device Tree blob at a0000000
>      Booting using the fdt blob at 0xa0000000
>      Uncompressing Kernel Image
>      Loading Device Tree to 00000000fbb19000, end 00000000fbb22717 ... OK
>   Unable to update property /sysclk:clock-frequency, err=FDT_ERR_NOTFOUND
> 
>   Starting kernel ...
> 
> All Layerscape SoCs except LS1028A use "sysclk" as the node name, and
> not "clock-sysclk". So change the node name of LS1028A accordingly.

Wouldn't it more flexible to use alias/label for finding the node?
Using node name/path looks fragile. 

Shawn

> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index d0dddf19578a..03e1ca7fea9a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -66,7 +66,7 @@ CPU_PW20: cpu-pw20 {
>  		};
>  	};
>  
> -	sysclk: clock-sysclk {
> +	sysclk: sysclk {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <100000000>;
> -- 
> 2.25.1
> 
