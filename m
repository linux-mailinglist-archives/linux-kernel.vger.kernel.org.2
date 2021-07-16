Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F723CBA34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhGPQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:02:35 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39729 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbhGPQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:02:33 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 58DD01C0005;
        Fri, 16 Jul 2021 15:59:35 +0000 (UTC)
Date:   Fri, 16 Jul 2021 17:59:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        claudiu.beznea@microchip.com, eugen.hristev@microchip.com,
        codrin.ciubotariu@microchip.com, emil.velikov@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: configs: at91: sama5: Use make savedefconfig
 and clean leftovers
Message-ID: <YPGs5qGih6R9DFWG@piout.net>
References: <20210716151447.833967-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716151447.833967-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2021 18:14:46+0300, Tudor Ambarus wrote:
> Even since the addition CONFIG_VIDEO_HANTRO was set to n because
> it did not respect the dependency chain. It doesn't respect it now
> either, remove it.
> 

Shouldn't you rather ensure it is enabled so we get it for sama5d4?

> Fixes: a0e6830c95b7 ("ARM: configs: at91: sama5: enable the Hantro G1 engine")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/configs/sama5_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 17db3b3e2dd3..1ccf84091dd7 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -207,7 +207,6 @@ CONFIG_AT_HDMAC=y
>  CONFIG_AT_XDMAC=y
>  CONFIG_STAGING=y
>  CONFIG_STAGING_MEDIA=y
> -CONFIG_VIDEO_HANTRO=m
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_IIO=y
>  CONFIG_AT91_ADC=y
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
