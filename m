Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD332E7D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCEMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhCEMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:21:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5811C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 04:21:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lI9Sa-0001Ek-1H; Fri, 05 Mar 2021 13:21:36 +0100
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated with
 sdout
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        aford@beaconembedded.com, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
References: <20210115182909.314756-1-aford173@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <fbe03824-1397-c1f8-ac97-f500eaf60338@pengutronix.de>
Date:   Fri, 5 Mar 2021 13:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210115182909.314756-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adam,

On 15.01.21 19:29, Adam Ford wrote:
>  {
> +#ifdef CONFIG_OF
>  	if (imx_keep_uart_clocks) {
>  		int i;
>  
> -		imx_uart_clocks = clks;
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_prepare_enable(*imx_uart_clocks[i]);
> +		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> +		imx_enabled_uart_clocks = 0;
> +
> +		for (i = 0; i < clk_count; i++) {
> +			imx_uart_clocks[imx_enabled_uart_clocks] = of_clk_get(of_stdout, i);

of_stdout may be NULL if there is no stdout-path. You should check that earlier.

With this fixed, feel free to add:

Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> +
> +			/* Stop if there are no more of_stdout references */
> +			if (IS_ERR(imx_uart_clocks[imx_enabled_uart_clocks]))
> +				return;
> +
> +			/* Only enable the clock if it's not NULL */
> +			if (imx_uart_clocks[imx_enabled_uart_clocks])
> +				clk_prepare_enable(imx_uart_clocks[imx_enabled_uart_clocks++]);
> +		}
>  	}
> +#else
> +	/* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
> +	imx_enabled_uart_clocks = 0;
> +#endif
>  }
>  
>  static int __init imx_clk_disable_uart(void)
>  {
> -	if (imx_keep_uart_clocks && imx_uart_clocks) {
> +	if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
>  		int i;
>  
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_disable_unprepare(*imx_uart_clocks[i]);
> +		for (i = 0; i < imx_enabled_uart_clocks; i++) {
> +			clk_disable_unprepare(imx_uart_clocks[i]);
> +			clk_put(imx_uart_clocks[i]);
> +		};
> +		kfree(imx_uart_clocks);
>  	}
>  
>  	return 0;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 4f04c8287286..7571603bee23 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -11,9 +11,9 @@ extern spinlock_t imx_ccm_lock;
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
>  #ifndef MODULE
> -void imx_register_uart_clocks(struct clk ** const clks[]);
> +void imx_register_uart_clocks(unsigned int clk_count);
>  #else
> -static inline void imx_register_uart_clocks(struct clk ** const clks[])
> +static inline void imx_register_uart_clocks(unsigned int clk_count)
>  {
>  }
>  #endif
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
