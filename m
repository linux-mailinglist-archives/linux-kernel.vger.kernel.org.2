Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA73762CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhEGJ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhEGJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:28:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136DEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 02:27:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lewlP-00023a-JO; Fri, 07 May 2021 11:27:15 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lewlN-0007ID-SU; Fri, 07 May 2021 11:27:13 +0200
Date:   Fri, 7 May 2021 11:27:13 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        quanyang.wang@windriver.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejasp@xilinx.com,
        shubhrajyoti.datta@xilinx.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] clk: zynqmp: pll: Remove some dead code
Message-ID: <20210507092713.GM29775@pengutronix.de>
References: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:22:09 up 78 days, 12:46, 97 users,  load average: 0.07, 0.08,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 May 2021 13:24:32 +0200, Christophe JAILLET wrote:
> 'clk_hw_set_rate_range()' does not return any error code and 'ret' is
> known to be 0 at this point, so this message can never be displayed.
> 
> Remove it.
> 
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
> HOWEVER, the message is about 'clk_set_rate_range()', not
> 'clk_hw_set_rate_range()'. So the message is maybe correct and the
> 'xxx_rate_range()' function incorrect.

Thanks. The function is correct, as this is a clock provider and should use
the clk_hw. Removing the message is correct.

Michael

> ---
>  drivers/clk/zynqmp/pll.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index abe6afbf3407..af11e9400058 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -331,8 +331,6 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
>  	}
>  
>  	clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
> -	if (ret < 0)
> -		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, ret);
>  
>  	return hw;
>  }
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
