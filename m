Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE713BF6DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGHIZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGHIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:25:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466DC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 01:22:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m1PJ3-0005mQ-LG; Thu, 08 Jul 2021 10:22:49 +0200
Subject: Re: [PATCH] clk: imx8: Unified initcall function
To:     Rudy Lo <luhuadong@163.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20210708081543.186820-1-luhuadong@163.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d5493844-cc7f-b432-c724-c0af97ff28eb@pengutronix.de>
Date:   Thu, 8 Jul 2021 10:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708081543.186820-1-luhuadong@163.com>
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

Hello Rudy,

On 08.07.21 10:15, Rudy Lo wrote:
> It is better to use builtin_platform_driver initcall for clk driver
> rather then module_platform_driver, refer to clk-imx8qxp.c file.

Commit messages should spell out why the change is needed, so
why do you think it's better to revert
9a976cd278ea ("clk: imx8m: Support module build")?

Cheers,
Ahmad

> 
> Signed-off-by: Rudy Lo <luhuadong@163.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c | 2 +-
>  drivers/clk/imx/clk-imx8mn.c | 2 +-
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index f1919fafb124..fa20b08e64f1 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -654,7 +654,7 @@ static struct platform_driver imx8mm_clk_driver = {
>  		.of_match_table = imx8mm_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mm_clk_driver);
> +builtin_platform_driver(imx8mm_clk_driver);
>  
>  MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 88f6630cd472..67b9ded112e4 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -605,7 +605,7 @@ static struct platform_driver imx8mn_clk_driver = {
>  		.of_match_table = imx8mn_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mn_clk_driver);
> +builtin_platform_driver(imx8mn_clk_driver);
>  
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 12837304545d..cdb40e61cef0 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -735,7 +735,7 @@ static struct platform_driver imx8mp_clk_driver = {
>  		.of_match_table = imx8mp_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mp_clk_driver);
> +builtin_platform_driver(imx8mp_clk_driver);
>  
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index c491bc9c61ce..54f17de30935 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -630,7 +630,7 @@ static struct platform_driver imx8mq_clk_driver = {
>  		.of_match_table = imx8mq_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mq_clk_driver);
> +builtin_platform_driver(imx8mq_clk_driver);
>  
>  MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
