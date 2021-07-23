Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADC3D3B97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhGWNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235127AbhGWNXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C37B260EE6;
        Fri, 23 Jul 2021 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049014;
        bh=mDaV0aRlSDpaHYmvF8eJe6sIGjdm2h+Js4Gj2SK/RqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxX6K7fOmR817Ob8ThUFX4JcX62Bx7B6ItE27AfrtvrPnLQvvFgXq+nO3oBz+v/DI
         UPfINvUVg4OgB0U9AVTeHIj+CrWdLwPITsKgHoh1blKUMhsv8NhqX6SoqNJqLjqnQb
         Grd7RKcH/bKkDJrWr0gtiT4pBS7VvTpNdKKgkV+GIdz/XPR89nuchVHfT9Cso0jY4b
         C6TGkUWVngDfPs0oUgPS0mvwFRwzwVX2bK7VojOfy4LE8TC5nLeGRkQb30h6J7cbNa
         b+e05n+zL91gHuOF5WEgpo5wzSYyQ3bwp6rFFa6BQnickmoRSW+/qJJtwYmArww88D
         GKSoIx1FjnVHA==
Date:   Fri, 23 Jul 2021 22:03:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: fix imx_mmdc_probe build failure
Message-ID: <20210723140328.GA5901@dragon>
References: <20210723091450.1694746-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723091450.1694746-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:14:42AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are two definitions of imx_mmdc_probe(), the function just
> gained a third argument, but the empty macro did not get changed
> the same way:
> 
> arch/arm/mach-imx/mmdc.c: In function 'imx_mmdc_probe':
> arch/arm/mach-imx/mmdc.c:575:63: error: macro "imx_mmdc_perf_init" passed 3 arguments, but takes just 2
>   575 |         err = imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk);
>       |                                                               ^
> arch/arm/mach-imx/mmdc.c:537: note: macro "imx_mmdc_perf_init" defined here
>   537 | #define imx_mmdc_perf_init(pdev, mmdc_base) 0
>       |
> arch/arm/mach-imx/mmdc.c:575:15: error: 'imx_mmdc_perf_init' undeclared (first use in this function)
>   575 |         err = imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk);
>       |               ^~~~~~~~~~~~~~~~~~
> 
> Fixes: f07ec8536580 ("ARM: imx: add missing clk_disable_unprepare()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch, Arnd.  I already queued up the fix from
Colin Ian King [1] for this issue.

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=20fb73911fec01f06592de1cdbca00b66602ebd7

> ---
>  arch/arm/mach-imx/mmdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 4a6f1359e1e9..5ee43acf3635 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -534,7 +534,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
>  
>  #else
>  #define imx_mmdc_remove NULL
> -#define imx_mmdc_perf_init(pdev, mmdc_base) 0
> +#define imx_mmdc_perf_init(pdev, mmdc_base, ipg_clk) 0
>  #endif
>  
>  static int imx_mmdc_probe(struct platform_device *pdev)
> -- 
> 2.29.2
> 
