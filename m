Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547C43693B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhJURn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJURnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:43:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:41:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f21so942258plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wjkL1M46brws6JUD91gGE9nrGWZDkt+GYrNQD2kz+m8=;
        b=ULa4ja1DxUaFql3k+NQDCw+GE2tpfakdVAljWPOrsJt+NBoKh2f0DItAwN+jUjcY9H
         k7f7DrbEPoc5UN8pYBiaqYbke7pcEn1DMauH0T0Ozx+VmGDCkAMiHn0TQ2tG7UjBtrFx
         9V+oMoju8QLX/0Suel9ZUv/MtxBB6vrcNFTZ3rvYi8y9DCcYK8m0fXSf4PTTFdn9lrGt
         ZM06avbr5hktRf4yQhFqbmVrXIhYOHzZPfUVE3VP7rEgXftCZfEW6XFGMJKeR1eW9wkr
         Xjomjtxng2cHkzCxpvZXN2U4WHjaamfIwDsIbKUD8xb4KruX4GVJxQI9PiBSnCS0Bb+R
         4p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjkL1M46brws6JUD91gGE9nrGWZDkt+GYrNQD2kz+m8=;
        b=7pcNVRwET1CVsWtzCFU58h2CaQ65YhSbPsaoB7/aQ0FOPHS1aZN0Ea7RABSVu7ru+G
         T2M6EVETBcPdDaYRkeoGE3c2PTQKyzcEWbeidZS0vlGBmaPrEGARvuNArlRvhbCtsOSp
         MUECj8/MU2iK3PwcU4Z6qUB99cBvHLwdzFPBSqXmbllmyrNL5RvRXMWsmE/oUPe5JwhM
         aATB4NEeGbOsMS5TQpXdcmAx6IzNX9yLznUo34PuFJ7jg+rGpTdxp2z0T8AQOyN7GkM4
         UjGoJR9HLYU90kKuiQ1Gg/7p+OURDP3rMMLt/deoYuDHjLLUlYhib4jp8ay5uR1N1WJs
         fTcg==
X-Gm-Message-State: AOAM532rab+AYTalDwgNWhbJE0lcXuLQPOylFVMDxCkTWp1UQxpym6FP
        RdpVFiDKfWEdPNaffov0EBfhTw==
X-Google-Smtp-Source: ABdhPJxGEHVTaXW2f3YMcR46zLfjucO2r8CQ5ZA6JjPFnpwZqgXAXBzuizFsKcn3wHuyk/O8urgm7Q==
X-Received: by 2002:a17:902:c206:b0:13f:68f:675c with SMTP id 6-20020a170902c20600b0013f068f675cmr6666969pll.8.1634838068394;
        Thu, 21 Oct 2021 10:41:08 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s25sm6572669pfm.138.2021.10.21.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:41:06 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:41:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hongxing.zhu@nxp.com, peng.fan@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Fix a resource leak in the remove
 function
Message-ID: <20211021174104.GA3562838@p14s>
References: <d28ca94a4031bd7297d47c2164e18885a5a6ec19.1634366546.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28ca94a4031bd7297d47c2164e18885a5a6ec19.1634366546.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 08:44:28AM +0200, Christophe JAILLET wrote:
> 'priv->workqueue' is destroyed in the error handling path of the probe but
> not in the remove function.
> 
> Add the missing call to release some resources.
> 
> Fixes: 2df7062002d0 ("remoteproc: imx_proc: enable virtio/mailbox")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. I'm not sure if the added function call is at
> the right place in the remove function.
> Review with care.
> ---
>  drivers/remoteproc/imx_rproc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index ff8170dbbc3c..0a45bc0d3f73 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -804,6 +804,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
>  	imx_rproc_free_mbox(rproc);
> +	destroy_workqueue(priv->workqueue);

This seems to be the right thing to do. Peng - please review and test on your
side.

Thanks,
Mathieu

>  	rproc_free(rproc);
>  
>  	return 0;
> -- 
> 2.30.2
> 
