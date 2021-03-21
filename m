Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B919343060
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 01:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCUACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 20:02:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49070 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhCUACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 20:02:08 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A50E6EF;
        Sun, 21 Mar 2021 01:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616284926;
        bh=fnusObNqvVt7+kv3aLltd17k8J0BczhLYWNPm2HQvn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SolZj52enTJVdBHSnRXhfzk0+tEK91JrIJgPChRU9nhUQtol3TwkpT+DZ7DjWMvcp
         TBxpqxYUuLXcgENvWQ5zqSdiJ/bJWj8yrxcHuRpGc+wrcopvr+r8RjO3paLOnhqAW5
         GwAkdnoVZAz4AyT/lLMCI7fzvJu0iALavKH7tg3s=
Date:   Sun, 21 Mar 2021 02:01:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     quanyang.wang@windriver.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rohit Visavalia <RVISAVAL@xilinx.com>
Subject: Re: [PATCH 1/2] clk: zynqmp: pll: add set_pll_mode to check
 condition in zynqmp_pll_enable
Message-ID: <YFaM1uCqM+c1ZOoX@pendragon.ideasonboard.com>
References: <20210319100717.507500-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210319100717.507500-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quanyang,

Thank you for the patch.

On Fri, Mar 19, 2021 at 06:07:17PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> If there is a IOCTL_SET_PLL_FRAC_MODE request sent to ATF ever,
> we shouldn't skip invoking PM_CLOCK_ENABLE fn even though this
> pll has been enabled. In ATF implementation, it will only assign
> the mode to the variable (struct pm_pll *)pll->mode when handling
> IOCTL_SET_PLL_FRAC_MODE call. Invoking PM_CLOCK_ENABLE can force
> ATF send request to PWU to set the pll mode to PLL's register.
> 
> There is a scenario that happens in enabling VPLL_INT(clk_id:96):
> 1) VPLL_INT has been enabled during booting.
> 2) A driver calls clk_set_rate and according to the rate, the VPLL_INT
>    should be set to FRAC mode. Then zynqmp_pll_set_mode is called
>    to pass IOCTL_SET_PLL_FRAC_MODE to ATF. Note that at this point
>    ATF just stores the mode to a variable.
> 3) This driver calls clk_prepare_enable and zynqmp_pll_enable is
>    called to try to enable VPLL_INT pll. Because of 1), the function
>    zynqmp_pll_enable just returns without doing anything after checking
>    that this pll has been enabled.
> 
> In the scenario above, the pll mode of VPLL_INT will never be set
> successfully. So adding set_pll_mode to chec condition to fix it.

s/chec/check/

> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/clk/zynqmp/pll.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index 92f449ed38e5..f1e8f37d7f52 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -14,10 +14,12 @@
>   * struct zynqmp_pll - PLL clock
>   * @hw:		Handle between common and hardware-specific interfaces
>   * @clk_id:	PLL clock ID
> + * @set_pll_mode:	Whether an IOCTL_SET_PLL_FRAC_MODE request be sent to ATF
>   */
>  struct zynqmp_pll {
>  	struct clk_hw hw;
>  	u32 clk_id;
> +	bool set_pll_mode;
>  };
>  
>  #define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
> @@ -81,6 +83,8 @@ static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
>  	if (ret)
>  		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
>  			     __func__, clk_name, ret);
> +	else
> +		clk->set_pll_mode = true;
>  }
>  
>  /**
> @@ -240,9 +244,14 @@ static int zynqmp_pll_enable(struct clk_hw *hw)
>  	u32 clk_id = clk->clk_id;
>  	int ret;
>  
> -	if (zynqmp_pll_is_enabled(hw))
> +	/* Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE request
> +	 * that has been sent to ATF.
> +	 */

Very small issue, multiline kerneldoc comments are supposed to start
with a '/*' on its own line:

	/*
	 * Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE
	 * request that has been sent to ATF.
	 */

> +	if (zynqmp_pll_is_enabled(hw) && (!clk->set_pll_mode))
>  		return 0;
>  
> +	clk->set_pll_mode = false;
> +
>  	ret = zynqmp_pm_clock_enable(clk_id);
>  	if (ret)
>  		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",

This fixes the DPSUB clock issue, so

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I however wonder if this is the best solution. Shouldn't we instead fix
it on the ATF side, to program the hardware when zynqmp_pll_set_mode()
is called if the clock is already enabled ?

Just reading the code, I can immediately see another potential issue in
zynqmp_pll_set_mode(). The function is called from
zynqmp_pll_round_rate(), which seems completely wrong, as
zynqmp_pll_round_rate() is supposed to only perform rate calculation,
not program the hardware. Am I missing something, or does the PLL
implementation need to be reworked more extensively than this ?

-- 
Regards,

Laurent Pinchart
