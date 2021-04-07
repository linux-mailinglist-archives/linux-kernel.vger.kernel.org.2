Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D545E3572DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbhDGRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:13:38 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:20001 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhDGRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:13:35 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CB39A240005;
        Wed,  7 Apr 2021 17:13:23 +0000 (UTC)
Date:   Wed, 7 Apr 2021 19:13:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and
 utmi support
Message-ID: <YG3oM6DhTwKfPrAG@piout.net>
References: <20210407170053.298056-1-eugen.hristev@microchip.com>
 <20210407170053.298056-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407170053.298056-3-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/04/2021 20:00:53+0300, Eugen Hristev wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Select PLL, generic clock and UTMI support for SAMA7G5.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 5eb2a9206f42..f52b46bccd85 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -60,6 +60,9 @@ config SOC_SAMA5D4
>  config SOC_SAMA7G5
>  	bool "SAMA7G5 family"
>  	depends on ARCH_MULTI_V7
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL
> +	select HAVE_AT91_UTMI

Shouldn't that be squashed in 1/3?

>  	select SOC_SAMA7
>  	help
>  	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
