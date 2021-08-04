Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88AE3E0432
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhHDP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhHDP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:29:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247CC06179F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:28:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so3496156pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABQinGThgXjQH4ldJXoDYT9bEE6sztnsLgaWTHXyf1I=;
        b=bTMb9Bwz65pSpUsI5Q5vTUk7YbFv5GItIndqJOyf0xn3pF382FMPog7rjUbM62Rec6
         yxadZgJOJUZ2MOJAInGMwhm7qIhq3GnAkVsCaOcJun+Jdhk/kxrEnUMz6AcsoyuSHcSv
         BvYpMblyFOL56LS9pYJlNWuDNY2MRae3MDJnEzrIuYYIO5mBaj5zRo0Z38gYiwLXp+VD
         JJ2HHAsSllFYf4VY3v3lQG+VSP36E4VFQE2rt8L+sOu3ONLQM2MiQGmw6CCgJAD8XSsY
         g0McvEvZ2Q2JN+qzD2YWk95GRXurSRqVAtLaCsvp7e9v7RwndcgcsJJbdg74haRfVZtS
         IoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABQinGThgXjQH4ldJXoDYT9bEE6sztnsLgaWTHXyf1I=;
        b=kJ3Y2Fl6dIBF2EQNLegQn+C9t9CwPYlLnW05KmUIyVOaC9dM7rdm+Gn6O3eDC+QRi+
         FhpgmI3YKqTvW2mGkmMtcKAxywlADFmehRynCostHAoVvoAMPswKOAnDihQuNvkVaV/v
         /WElEhiyX6K1MUMlD8Pl7V4rL2hLjTVykcT4aQC6kCq/vxHnrSJxv6AcmJ+6gKhx4V+6
         G+3yW8WFUNkMimWl22OUiZ47qi01zclM31kknSAX1goDddCOBmOwQGaqp/6uyfZDSl2j
         XfkF87jlSmOQyxvltQMlIZLpmHochuKm9QA7lLN2c88CTjGnKFtrXxwkgD1jxUv5Dpg/
         KEtg==
X-Gm-Message-State: AOAM5310ucGP702WSIhQ5ePAMZgiB2U4/KB3Vz7a2wvmFt7Is14IkuZ8
        /ln7HHmUc4sf8lVQUjvpBTMwuw==
X-Google-Smtp-Source: ABdhPJxCRBnR8iM8jyZmuXvcXU3+BVIWG9EG+G5PUdy9yAdeHQClC+LOnBgdO+YhqTmLZLajqAQhzg==
X-Received: by 2002:a63:5815:: with SMTP id m21mr488033pgb.363.1628090918593;
        Wed, 04 Aug 2021 08:28:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k4sm4025561pgh.9.2021.08.04.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:28:37 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:28:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski@canonical.com,
        shawnguo@kernel.org, sam@ravnborg.org, linux@rempel-privat.de,
        daniel@0x0f.com, Max.Merchel@tq-group.com, geert+renesas@glider.be,
        fanghao11@huawei.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] remoteproc: mediatek: Support mt8195 scp
Message-ID: <20210804152835.GA3145709@p14s>
References: <20210803075922.11611-1-tinghan.shen@mediatek.com>
 <20210803075922.11611-6-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803075922.11611-6-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 03:59:22PM +0800, Tinghan Shen wrote:
> The SCP clock design is changed on mt8195 that doesn't need to control
> SCP clock on kernel side.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h |  1 +
>  drivers/remoteproc/mtk_scp.c    | 48 +++++++++++++++++++++++++++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 61901f5efa05..5ff3867c72f3 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -72,6 +72,7 @@ struct scp_ipi_desc {
>  struct mtk_scp;
>  
>  struct mtk_scp_of_data {
> +	int (*scp_clk_get)(struct mtk_scp *scp);
>  	int (*scp_before_load)(struct mtk_scp *scp);
>  	void (*scp_irq_handler)(struct mtk_scp *scp);
>  	void (*scp_reset_assert)(struct mtk_scp *scp);
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 9679cc26895e..36e48cf58ed6 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -312,6 +312,32 @@ static int scp_elf_read_ipi_buf_addr(struct mtk_scp *scp,
>  	return -ENOENT;
>  }
>  
> +static int mt8183_scp_clk_get(struct mtk_scp *scp)
> +{
> +	struct device *dev = scp->dev;
> +	int ret = 0;
> +
> +	scp->clk = devm_clk_get(dev, "main");
> +	if (IS_ERR(scp->clk)) {
> +		dev_err(dev, "Failed to get clock\n");
> +		ret = PTR_ERR(scp->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt8192_scp_clk_get(struct mtk_scp *scp)
> +{
> +	return mt8183_scp_clk_get(scp);
> +}
> +
> +static int mt8195_scp_clk_get(struct mtk_scp *scp)
> +{
> +	scp->clk = NULL;
> +
> +	return 0;
> +}
> +
>  static int mt8183_scp_before_load(struct mtk_scp *scp)
>  {
>  	/* Clear SCP to host interrupt */
> @@ -785,12 +811,9 @@ static int scp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto destroy_mutex;
>  
> -	scp->clk = devm_clk_get(dev, "main");
> -	if (IS_ERR(scp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> -		ret = PTR_ERR(scp->clk);
> +	ret = scp->data->scp_clk_get(scp);
> +	if (ret)
>  		goto release_dev_mem;
> -	}
>  
>  	/* register SCP initialization IPI */
>  	ret = scp_ipi_register(scp, SCP_IPI_INIT, scp_init_ipi_handler, scp);
> @@ -852,6 +875,7 @@ static int scp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct mtk_scp_of_data mt8183_of_data = {
> +	.scp_clk_get = mt8183_scp_clk_get,
>  	.scp_before_load = mt8183_scp_before_load,
>  	.scp_irq_handler = mt8183_scp_irq_handler,
>  	.scp_reset_assert = mt8183_scp_reset_assert,
> @@ -864,6 +888,19 @@ static const struct mtk_scp_of_data mt8183_of_data = {
>  };
>  
>  static const struct mtk_scp_of_data mt8192_of_data = {
> +	.scp_clk_get = mt8192_scp_clk_get,
> +	.scp_before_load = mt8192_scp_before_load,
> +	.scp_irq_handler = mt8192_scp_irq_handler,
> +	.scp_reset_assert = mt8192_scp_reset_assert,
> +	.scp_reset_deassert = mt8192_scp_reset_deassert,
> +	.scp_stop = mt8192_scp_stop,
> +	.scp_da_to_va = mt8192_scp_da_to_va,
> +	.host_to_scp_reg = MT8192_GIPC_IN_SET,
> +	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> +};
> +
> +static const struct mtk_scp_of_data mt8195_of_data = {
> +	.scp_clk_get = mt8195_scp_clk_get,
>  	.scp_before_load = mt8192_scp_before_load,
>  	.scp_irq_handler = mt8192_scp_irq_handler,
>  	.scp_reset_assert = mt8192_scp_reset_assert,
> @@ -877,6 +914,7 @@ static const struct mtk_scp_of_data mt8192_of_data = {
>  static const struct of_device_id mtk_scp_of_match[] = {
>  	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>  	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
> +	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> -- 
> 2.18.0
> 
