Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC574503C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhKOLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:47:30 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:62663 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhKOLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:47:05 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 2516de24;
        Mon, 15 Nov 2021 12:44:07 +0100 (CET)
Date:   Mon, 15 Nov 2021 12:44:07 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Janne Grunau <j@jannau.net>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        robh+dt@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115094332.13540-1-j@jannau.net> (message from Janne Grunau
        on Mon, 15 Nov 2021 10:43:32 +0100)
Subject: Re: [PATCH 1/1] arm64: dts: apple: change ethernet0 device type to
 ethernet
References: <20211115094332.13540-1-j@jannau.net>
Message-ID: <d3cad763b256e68e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Janne Grunau <j@jannau.net>
> Date: Mon, 15 Nov 2021 10:43:32 +0100
> 
> Fixes make dtbs_check errors for t8103-j274.dts due to missing pci
> properties.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Yes, that is better.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---8<---
> 
> change based on the same pattern as in
> arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> 
> ---
>  arch/arm64/boot/dts/apple/t8103-j274.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
> index 33a80f9501dc..02c36301e985 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j274.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
> @@ -60,7 +60,7 @@ &port01 {
>  
>  &port02 {
>  	bus-range = <3 3>;
> -	ethernet0: pci@0,0 {
> +	ethernet0: ethernet@0,0 {
>  		reg = <0x30000 0x0 0x0 0x0 0x0>;
>  		/* To be filled by the loader */
>  		local-mac-address = [00 10 18 00 00 00];
> -- 
> 2.33.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
