Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578C73A4C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFLCd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 22:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhFLCd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 22:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3351D6128A;
        Sat, 12 Jun 2021 02:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623465090;
        bh=pEJF+vsm1MHKMEFT04SjKyemkTdIxradSFMr4RBmezU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQOMdgONzcHWkZ4P9Yu2TSnZMQUkvMU0o8Aqu6XWr4RmUb43cpr7599oY9ZpJqyh8
         JMnwGQgECBpnLyag0nhz3fXmSJqY7x0yRVyueAlEGv+buNGP3RQlniCIQyQaviUN8t
         PgJbyF3s+9d3W/yLMLlKHO9y7RW/N++1+C9xv+/t2MQ0xdeWwfbNIsIZSu9JFgmdhY
         ou9xgYa8EwiY0MrMuUcEp4ZaSRes5gp6/lBgl9SG1v1SzPNPaiHwhn5z9HaTY41JuQ
         hf5/I7uRgpUOHQYx2qSof59TgWsg0kheusPnkvMF3gmsUxxLRNuLejM+wkikMB/y9Z
         W+IKt7J+bVy8w==
Date:   Sat, 12 Jun 2021 10:31:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH -next 1/2] ARM: imx: add missing iounmap() in
 imx_mmdc_remove()
Message-ID: <20210612023124.GF29138@dragon>
References: <20210524070700.3032039-1-yangyingliang@huawei.com>
 <20210524070700.3032039-2-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524070700.3032039-2-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 03:06:59PM +0800, Yang Yingliang wrote:
> mmdc_base need be unmapped in imx_mmdc_remove().
> 
> Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/arm/mach-imx/mmdc.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 0dfd0ae7a63d..c313eb1f614c 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -77,6 +77,8 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
>  	{ /* sentinel */ }
>  };
>  
> +static void __iomem *mmdc_base;
> +

I do not like such variables.  Can we have a data structure holding this
and the clock that patch 2/2 is adding?  Also please consider to
consolidate the mmdc_base in' struct mmdc_pmu'.

Shawn

>  #ifdef CONFIG_PERF_EVENTS
>  
>  static enum cpuhp_state cpuhp_mmdc_state;
> @@ -456,16 +458,6 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
>  	return mmdc_num;
>  }
>  
> -static int imx_mmdc_remove(struct platform_device *pdev)
> -{
> -	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
> -
> -	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
> -	perf_pmu_unregister(&pmu_mmdc->pmu);
> -	kfree(pmu_mmdc);
> -	return 0;
> -}
> -
>  static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_base)
>  {
>  	struct mmdc_pmu *pmu_mmdc;
> @@ -528,14 +520,26 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
>  }
>  
>  #else
> -#define imx_mmdc_remove NULL
>  #define imx_mmdc_perf_init(pdev, mmdc_base) 0
>  #endif
>  
> +static int imx_mmdc_remove(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_PERF_EVENTS
> +	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
> +
> +	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
> +	perf_pmu_unregister(&pmu_mmdc->pmu);
> +	kfree(pmu_mmdc);
> +#endif
> +	iounmap(mmdc_base);
> +	return 0;
> +}
> +
>  static int imx_mmdc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	void __iomem *mmdc_base, *reg;
> +	void *reg;
>  	struct clk *mmdc_ipg_clk;
>  	u32 val;
>  	int err;
> -- 
> 2.25.1
> 
