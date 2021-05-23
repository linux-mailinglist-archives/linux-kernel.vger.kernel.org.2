Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304AA38D915
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 07:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEWFNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 01:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhEWFNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 01:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EC3961175;
        Sun, 23 May 2021 05:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621746710;
        bh=JzbkgxHVP+qyg6EWN9dyTFjhQejudhV0HgHDOpVmfgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy2jgXlWFk1fWIWJOepwyGf+2J5zWqRMda7EP+JHTL07lONVDpJCIrRXcWZTC6yeH
         93MHuJQQ8eAyKSz/brX0JlAxluq4r+Y7QL4OgTT+HVoNet8rOxUVqj34FbVG+C5sy/
         etuUmeleCqm3mRomjUozCT3IBan/N10W4l7DiemCs0X/v03Rnlmlp8Q6wbiTW0+rYG
         r2qQ7isgCpH+pp+L8OfF0EWxEHHPFw7uf27UkHbQ+MXcyN2WcJjkVhq6dYD/NiEgP1
         qX8OqOjaDlZubuunxTVIullceLg2k1tCqFi1VF1hKjGN6eA44rpUTe/d5BR9R5ctAz
         Wn7R4FkNk9yvQ==
Date:   Sun, 23 May 2021 13:11:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH -next] ARM: imx: add missing clk_disable_unprepare() in
 imx_mmdc_remove()
Message-ID: <20210523051145.GW8194@dragon>
References: <20210517111523.477889-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517111523.477889-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 07:15:23PM +0800, Yang Yingliang wrote:
> clock source is prepared and enabled by clk_prepare_enable()
> in probe function, but no disable or unprepare in remove.
> 
> Fixes: 9454a0caff6a ("ARM: imx: add mmdc ipg clock operation for mmdc")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/arm/mach-imx/mmdc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 0dfd0ae7a63d..7d87fa8c70a9 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -77,6 +77,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
>  	{ /* sentinel */ }
>  };
>  
> +struct clk *mmdc_ipg_clk;

Missing static.  But an even better change should be putting it into
struct mmdc_pmu, I guess.

Shawn

>  #ifdef CONFIG_PERF_EVENTS
>  
>  static enum cpuhp_state cpuhp_mmdc_state;
> @@ -463,6 +464,7 @@ static int imx_mmdc_remove(struct platform_device *pdev)
>  	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
>  	perf_pmu_unregister(&pmu_mmdc->pmu);
>  	kfree(pmu_mmdc);
> +	clk_disable_unprepare(mmdc_ipg_clk);
>  	return 0;
>  }
>  
> @@ -536,7 +538,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	void __iomem *mmdc_base, *reg;
> -	struct clk *mmdc_ipg_clk;
>  	u32 val;
>  	int err;
>  
> -- 
> 2.25.1
> 
