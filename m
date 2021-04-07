Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC8357288
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbhDGQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbhDGQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:59:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C44C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:59:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w10so8036893pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eLTW/ZkkTyCTqB6iu1rtru6bTgFZgwWXKzMypqfmgqM=;
        b=CWft3GmsUrXx8JEx6CTw6lEYf09sLZpZHvKpi5RwVM/iZ5pPKg4uL3juo2C0uAPiGs
         TA5CMBZzMlayQY7L+nNPBBMQd/PD8K1YYNq4Yts/dPbs7lYkxlnTz67CxLJm03UE1lEU
         erOmFzKOHZsgZ0ON+xqljZ4OeKRESwnMbZFTq5jwS7LwGwA8ZZyuUr2i09LBqedcqxtw
         4aKqK2hVH32npqBCmKhouZz3LXi3f0//zYnMkphkeXGn/k6XlFJyBA4JBBPUuKOZdMGW
         hnsHQAFc+vYkmh13vrhQDHrdyr15kXIt1RlbV4jhrk9iMhwq9Sy5oO224Bf5/BNbw4nP
         YnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLTW/ZkkTyCTqB6iu1rtru6bTgFZgwWXKzMypqfmgqM=;
        b=r+3fZe4XRXEh6eywKi1iCMq5koy8Zp35XhvabQZNssTPTYz1bE4DC4yW9KvLn+rOwn
         G53cPsN+ZNjzYZ01rnZUdcYcJBvIL9/MfNwTtsYpdwTh0/lAnwOzyLVFJxbCpmwPEksB
         er8Pf4DtXhw4/MmtRgiQ9fgg7UNqjv7wvrXufVXF9BHg2+IIsceQdF1APIYEOriQPwD8
         ItT1Czyf6eX9wRsMyPOW/5uHYx3actES+/yyDluXHJgb8A2jEkw1HQXRCnlCjvGAI7hI
         +oZlcxTkw+/iwp0HLD3MpuXSufdQ6lU3ykiWA/elySGW/p87V74czEpVtgfH8dXA/mFm
         S6lQ==
X-Gm-Message-State: AOAM531q8yyQ4xR3h1psDlqPt9Ki2s+fLelNBrDhOSm+O7inn9cAArr1
        ORp0qs1vYV8l1RKCqzU+Kr/R5Q==
X-Google-Smtp-Source: ABdhPJxlOKgAaT/UdnWkhWXesWaSW3c/InbpMcfAXw2FRlscSoekEPYJdP3Vry++OB5sfM4mN3m1Sg==
X-Received: by 2002:a63:e242:: with SMTP id y2mr4342156pgj.298.1617814785732;
        Wed, 07 Apr 2021 09:59:45 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j22sm5701327pjz.3.2021.04.07.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:59:45 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:59:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 3/4] remoteproc: imx: move memory parsing to rproc_ops
Message-ID: <20210407165943.GE418374@xps15>
References: <1617082235-15923-1-git-send-email-peng.fan@oss.nxp.com>
 <1617082235-15923-4-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617082235-15923-4-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:30:34PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use the rproc_ops::prepare() hook for doing memory resources
> reallocation when reattach an remote procesor.

s/when reattach an remote/when reattaching a remote/

> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index b05aae0ad7a2..7cd09971d1a4 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -317,7 +317,7 @@ static int imx_rproc_mem_release(struct rproc *rproc,
>  	return 0;
>  }
>  
> -static int imx_rproc_parse_memory_regions(struct rproc *rproc)
> +static int imx_rproc_prepare(struct rproc *rproc)
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  	struct device_node *np = priv->dev->of_node;
> @@ -363,10 +363,7 @@ static int imx_rproc_parse_memory_regions(struct rproc *rproc)
>  
>  static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
> -	int ret = imx_rproc_parse_memory_regions(rproc);
> -
> -	if (ret)
> -		return ret;
> +	int ret;
>  
>  	ret = rproc_elf_load_rsc_table(rproc, fw);
>  	if (ret)
> @@ -399,6 +396,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  }
>  
>  static const struct rproc_ops imx_rproc_ops = {
> +	.prepare	= imx_rproc_prepare,
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.kick		= imx_rproc_kick,
> -- 
> 2.30.0
> 
