Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6030F6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhBDPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:54:12 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42499 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbhBDPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:53:15 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8D3F71C000C;
        Thu,  4 Feb 2021 15:52:18 +0000 (UTC)
Date:   Thu, 4 Feb 2021 16:52:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: soc: atmel: fix type for same7
Message-ID: <20210204155218.GB3940495@piout.net>
References: <20210204154934.1880048-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204154934.1880048-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 16:49:25+0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A missing comma caused a build failure:
> 
> drivers/soc/atmel/soc.c:196:24: error: too few arguments provided to function-like macro invocation
> 
> Fixes: af3a10513cd6 ("drivers: soc: atmel: add per soc id and version match masks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> It is broken in the soc tree at the moment, I can pick up
> the fix directly if I get an Ack
> ---
>  drivers/soc/atmel/soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index a2967846809f..a490ad7e090f 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -191,7 +191,7 @@ static const struct at91_soc socs[] __initconst = {
>  	AT91_SOC(SAME70Q20_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>  		 AT91_CIDR_VERSION_MASK, SAME70Q20_EXID_MATCH,
>  		 "same70q20", "same7"),
> -	AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK
> +	AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>  		 AT91_CIDR_VERSION_MASK, SAME70Q19_EXID_MATCH,
>  		 "same70q19", "same7"),
>  	AT91_SOC(SAMS70Q21_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
