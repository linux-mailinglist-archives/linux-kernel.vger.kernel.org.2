Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363303DB403
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhG3G4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237463AbhG3G4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C549E60F6B;
        Fri, 30 Jul 2021 06:56:38 +0000 (UTC)
Subject: Re: [PATCH] m68k: coldfire: return success for clk_enable(NULL)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Defang Bo <bodefang@126.com>, Steven King <sfking@fdwdc.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210729122702.GA27150@kili>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <10e74100-2f3b-6c71-3e13-ba9a33766bf1@linux-m68k.org>
Date:   Fri, 30 Jul 2021 16:56:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729122702.GA27150@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/7/21 10:27 pm, Dan Carpenter wrote:
> The clk_enable is supposed work when CONFIG_HAVE_CLK is false, but it
> returns -EINVAL.  That means some drivers fail during probe.
> 
> [    1.680000] flexcan: probe of flexcan.0 failed with error -22
> 
> Fixes: c1fb1bf64bb6 ("m68k: let clk_enable() return immediately if clk is NULL")
> Fixes: bea8bcb12da0 ("m68knommu: Add support for the Coldfire m5441x.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan.
Applied to the m68knommu git tree, for-next branch, with Marc's Acked-by added.

Regards
Greg


> ---
> I can't actually compile test this, but it's correct.
> 
>   arch/m68k/coldfire/clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 2ed841e94111..d03b6c4aa86b 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -78,7 +78,7 @@ int clk_enable(struct clk *clk)
>   	unsigned long flags;
>   
>   	if (!clk)
> -		return -EINVAL;
> +		return 0;
>   
>   	spin_lock_irqsave(&clk_lock, flags);
>   	if ((clk->enabled++ == 0) && clk->clk_ops)
> 
