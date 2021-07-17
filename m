Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867C33CC332
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhGQMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 08:22:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34092 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGQMWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 08:22:22 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4jHq-00051D-Eo; Sat, 17 Jul 2021 14:19:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 1/3] clk: fractional-divider: Export approximation algo to the CCF users
Date:   Sat, 17 Jul 2021 14:19:17 +0200
Message-ID: <10550544.QTc0DxZM9B@diego>
In-Reply-To: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Juli 2021, 15:34:46 CEST schrieb Andy Shevchenko:
> At least one user currently duplicates some functions that are provided
> by fractional divider module. Let's export approximation algo and replace
> the open-coded variant.
> 
> As a bonus the exported function will get better documentation in place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

on Rockchip rk3288 and rk3399
Tested-by: Heiko Stuebner <heiko@sntech.de>

Also for dropping the Rockchip-specific copy in favor of the main
implementation
Acked-by: Heiko Stuebner <heiko@sntech.de>



> ---
> v2: fixed compilation error (LKP), successfully compile-tested on x86
>  drivers/clk/clk-fractional-divider.c | 11 +++++++----
>  drivers/clk/clk-fractional-divider.h |  9 +++++++++
>  drivers/clk/rockchip/clk.c           | 17 +++--------------
>  3 files changed, 19 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/clk/clk-fractional-divider.h
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index b1e556f20911..535d299af646 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -14,6 +14,8 @@
>  #include <linux/slab.h>
>  #include <linux/rational.h>
>  
> +#include "clk-fractional-divider.h"
> +
>  static inline u32 clk_fd_readl(struct clk_fractional_divider *fd)
>  {
>  	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
> @@ -68,9 +70,10 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
>  	return ret;
>  }
>  
> -static void clk_fd_general_approximation(struct clk_hw *hw, unsigned long rate,
> -					 unsigned long *parent_rate,
> -					 unsigned long *m, unsigned long *n)
> +void clk_fractional_divider_general_approximation(struct clk_hw *hw,
> +						  unsigned long rate,
> +						  unsigned long *parent_rate,
> +						  unsigned long *m, unsigned long *n)
>  {
>  	struct clk_fractional_divider *fd = to_clk_fd(hw);
>  	unsigned long scale;
> @@ -102,7 +105,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>  	if (fd->approximation)
>  		fd->approximation(hw, rate, parent_rate, &m, &n);
>  	else
> -		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
> +		clk_fractional_divider_general_approximation(hw, rate, parent_rate, &m, &n);
>  
>  	ret = (u64)*parent_rate * m;
>  	do_div(ret, n);
> diff --git a/drivers/clk/clk-fractional-divider.h b/drivers/clk/clk-fractional-divider.h
> new file mode 100644
> index 000000000000..4fa359a12ef4
> --- /dev/null
> +++ b/drivers/clk/clk-fractional-divider.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +struct clk_hw;
> +
> +void clk_fractional_divider_general_approximation(struct clk_hw *hw,
> +						  unsigned long rate,
> +						  unsigned long *parent_rate,
> +						  unsigned long *m,
> +						  unsigned long *n);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 049e5e0b64f6..b7be7e11b0df 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -22,6 +22,8 @@
>  #include <linux/regmap.h>
>  #include <linux/reboot.h>
>  #include <linux/rational.h>
> +
> +#include "../clk-fractional-divider.h"
>  #include "clk.h"
>  
>  /*
> @@ -178,10 +180,8 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
>  		unsigned long rate, unsigned long *parent_rate,
>  		unsigned long *m, unsigned long *n)
>  {
> -	struct clk_fractional_divider *fd = to_clk_fd(hw);
>  	unsigned long p_rate, p_parent_rate;
>  	struct clk_hw *p_parent;
> -	unsigned long scale;
>  
>  	p_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
>  	if ((rate * 20 > p_rate) && (p_rate % rate != 0)) {
> @@ -190,18 +190,7 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
>  		*parent_rate = p_parent_rate;
>  	}
>  
> -	/*
> -	 * Get rate closer to *parent_rate to guarantee there is no overflow
> -	 * for m and n. In the result it will be the nearest rate left shifted
> -	 * by (scale - fd->nwidth) bits.
> -	 */
> -	scale = fls_long(*parent_rate / rate - 1);
> -	if (scale > fd->nwidth)
> -		rate <<= scale - fd->nwidth;
> -
> -	rational_best_approximation(rate, *parent_rate,
> -			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
> -			m, n);
> +	clk_fractional_divider_general_approximation(hw, rate, parent_rate, m, n);
>  }
>  
>  static struct clk *rockchip_clk_register_frac_branch(
> 




