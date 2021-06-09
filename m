Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249C83A0EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhFIIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:32:59 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:22171 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhFIIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:32:58 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D449924000F;
        Wed,  9 Jun 2021 08:31:01 +0000 (UTC)
Date:   Wed, 9 Jun 2021 10:31:01 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: fix count of periph clocks passed to
 pmc_data_allocate
Message-ID: <YMB8RYhCY4WVQXg+@piout.net>
References: <20210609080145.44226-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609080145.44226-1-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Subject should have been:
clk: at91: sama5d2: fix count of periph clocks passed to pmc_data_allocate



On 09/06/2021 10:01:44+0200, Clément Léger wrote:
> When allocating clk_hw structure, only the periph32 clocks are considered.
> Since sama5d2_periphck are also added to the phws there is currently an
> out of bound write. Fix this by adding the count of periphck to periph32ck.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")

> ---
>  drivers/clk/at91/sama5d2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index 3d1f78176c3e..663b73a032ee 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -170,7 +170,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  
>  	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
>  					nck(sama5d2_systemck),
> -					nck(sama5d2_periph32ck),
> +					nck(sama5d2_periphck) + nck(sama5d2_periph32ck),
>  					nck(sama5d2_gck), 3);
>  	if (!sama5d2_pmc)
>  		return;
> -- 
> 2.32.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
