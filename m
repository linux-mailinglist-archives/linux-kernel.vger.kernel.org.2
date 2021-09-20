Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04048412435
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379990AbhITSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378547AbhITSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:24:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8923C08ED82
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:00:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23-20020a17090a591700b001976d2db364so431024pji.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdjk66ClBUEHOQPo5O8pA1o0FV9ziXIRLgjji0kwuh4=;
        b=GXc/nby8oxLKc3PPElYjdztWj1YGfkAPflMMyus5Xe/wB3d+zdLugKfbLT7Pqwt5Ir
         XY4JI4IvuLuczzd2eZQJOugP9XQtnX7EGXplnW/Z6t5IhsPFwaMuE1AHbMa2Kdt3muBb
         LVbZC8o+dHSX0DXVnuPvmPwChzBxc7/hlvMbzuNfly/WJUdxckC8U2D/EwcBgXYTb5j4
         m8GeUYEDK56MaWfgqr0KY8LVCb8Wmf3B7Dy+6n3nwFwyHIV451Q0qHN+SRPFbz4Qpj4x
         lMo76MufwJ7JA9tn2G4uiOpL1sM6kj19635m+SxzRxGok6OCDiz3aKwC+27X7AaMJ8Ny
         icHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdjk66ClBUEHOQPo5O8pA1o0FV9ziXIRLgjji0kwuh4=;
        b=lT/eo8se3ggorqFqwuF+G/ZenJFESf4o5kb03cNOp/yLo5v4qo60R2w0DD8+e8XsPQ
         EAnOsCSz6cOcT3uoJ1JbI2Ewtf6b+2uSG8hxhPkECkFf+ppWtbJY9xiX01sitidsTzM+
         5eZVaN7f7tGW4uUxb3GHuzKhdZdbxGv9tpS8wc4WN9D6Qi7j05Jis/+7p5n5YhR9cyIP
         7RhFkA9UdOJIiE1Uh7/QycF1QKCIZSHjx5kplsJVnCdbZKbi//sUtwQNeG5aoq+zR15c
         xagJglqLygQHNHjjwFWguxPGhKl6lSFe+CR8bao43KC5nOJrLPmXe4AT9xp1bCE1nlrg
         f8Ug==
X-Gm-Message-State: AOAM531qcUU5zKvjUZmExjM2VUS/b3IJwXCtsRPXVy9JyONow6uN+qb+
        Hhueh1yVmXU/gaoApEMCJL/pxA==
X-Google-Smtp-Source: ABdhPJwePHcQqWYde1cff7qtLVe6G+DpjcWltD5K1uAZ7fHOrweVgF/3qRwJ22HBdXQIXr73L76N7g==
X-Received: by 2002:a17:902:9b8b:b0:13c:aad1:8a9a with SMTP id y11-20020a1709029b8b00b0013caad18a9amr18836287plp.89.1632157228425;
        Mon, 20 Sep 2021 10:00:28 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i5sm28994pjk.47.2021.09.20.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:00:27 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:00:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 6/6] remoteproc: imx_rproc: change to ioremap_wc for
 dram
Message-ID: <20210920170024.GD2023964@p14s>
References: <20210910090621.3073540-1-peng.fan@oss.nxp.com>
 <20210910090621.3073540-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910090621.3073540-7-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:06:21PM +0800, Peng Fan (OSS) wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> DRAM is not io memory, so changed to ioremap_wc. This is also
> aligned with core io accessories. e.g. memcpy/memset and cpu direct
> access.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Reviewed-and-tested-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have applied patches 4, 5 and 6 of this set.

> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index ff620688fad94..4ae416ba50807 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -597,7 +597,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  			break;
>  
>  		/* Not use resource version, because we might share region */
> -		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
> +		priv->mem[b].cpu_addr = devm_ioremap_wc(&pdev->dev, res.start, resource_size(&res));
>  		if (!priv->mem[b].cpu_addr) {
>  			dev_err(dev, "failed to remap %pr\n", &res);
>  			return -ENOMEM;
> -- 
> 2.25.1
> 
