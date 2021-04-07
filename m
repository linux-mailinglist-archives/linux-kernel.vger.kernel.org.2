Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F735729C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbhDGRDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348056AbhDGRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:03:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207FC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:03:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso1628436pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OgOPSgL3WiygH+uUV8x/1kUBrNk6ThiWBWKBYjCNOos=;
        b=fh0gWlRcIbbF6xKO5z/LxMjDIZNrHePyHjhMPqTy+wFVqtYNAkKe6+wnEuuoO6wYUK
         B04s2gUWEzDEQd1nkf2DLQlEuplS0bIVc8EMkjyQiW3PFEFg/11pdsPyaxfulmHyhrLv
         GInz6FPKUIvELLSkso7nwJZUej5pRMyEZp56ixFLdDkTuc+AcxXqX0XrSioNAWk4VYb4
         33SzjeZ/xjINLsS6UaVKGh5VIcbg9gnVaLAFLc5uk+77yrxa3mapUoT1pD7553bF5+IG
         PaPjZD07Gr94j1dEOqZSeWkC4Sgw1jO0+P8t1VxLjsJWjr3lKa4RTGuBZkkIcERN2Ivn
         UqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgOPSgL3WiygH+uUV8x/1kUBrNk6ThiWBWKBYjCNOos=;
        b=pn+NdpJsDBfB3c19XKvTegIUHK6hvQPv5OJ9kVfKBSddONa+FlMgZ9EA/669yacvTZ
         Sg/0Q2Z+JO3oIcgKRr8r38a7s71e+Vmjr/nSFv3hx3rcTcGv83uyAkPc9e8Ac+sGAksK
         m7c3SAe+iOpkhWlQ4KSDFtyUcZmPBDshvLrBtWakDRWlv44rL3CtDQzqmqBs1TD2QiSF
         Xl0K7MfsIdb+rsumT1OVNnfvTh+AcPyzKUixe0zQBFObtN+/m1xIxwgzeCDqTuBvjB7c
         uIFjPj09LEqThpZ+HOXhyOqJ6elKadcJWBJB66jCZE2jouVKVoCr7WCrHiC94070OBP5
         0WEQ==
X-Gm-Message-State: AOAM532D9taIjNrCjbBtvL6g7yR1J9eT/gNyxPdbXJKem9lNORaaW7Ow
        //bVBpXhQAFri2KxO2fRRquuLQ==
X-Google-Smtp-Source: ABdhPJwfHlXEqzxul/2I6UT1RUGFJn+u9iKMSmWadLvNa7wATRwgHFPMsq2N7ngHmelKqjFlW8I1iQ==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr4440084pjq.210.1617814996878;
        Wed, 07 Apr 2021 10:03:16 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w1sm15703544pgh.26.2021.04.07.10.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 10:03:16 -0700 (PDT)
Date:   Wed, 7 Apr 2021 11:03:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 4/4] remoteproc: imx_rproc: support remote cores
 booted before Linux Kernel
Message-ID: <20210407170314.GF418374@xps15>
References: <1617082235-15923-1-git-send-email-peng.fan@oss.nxp.com>
 <1617082235-15923-5-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617082235-15923-5-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:30:35PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
>  - Add rsc_table to hold the resource table published by remote cores.
>  - Add attach hook.
>  - Add imx_rproc_get_loaded_rsc_table to get resource table published by
>    remote processors.
>  - Add imx_rproc_detect_mode to detect remote cores' working mode.
>

This is describing _what_ is being done rather than _why_ it is done.

Moreover for patches 1 an 3 the subject line is tagged with "imx" while patches
2 and 4 have "imx_rproc".  I don't mind which one is used as long as it is
consistent.
 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7cd09971d1a4..d6338872c6db 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -95,6 +95,7 @@ struct imx_rproc {
>  	struct mbox_chan		*rx_ch;
>  	struct work_struct		rproc_work;
>  	struct workqueue_struct		*workqueue;
> +	void __iomem			*rsc_table;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
> @@ -395,8 +396,26 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  			__func__, vqid, err);
>  }
>  
> +static int imx_rproc_attach(struct rproc *rproc)
> +{
> +	return 0;
> +}
> +
> +static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +
> +	/* The resource table has already been mapped in imx_rproc_addr_init */
> +	if (!priv->rsc_table)
> +		return NULL;
> +
> +	*table_sz = SZ_1K;
> +	return (struct resource_table *)priv->rsc_table;
> +}
> +
>  static const struct rproc_ops imx_rproc_ops = {
>  	.prepare	= imx_rproc_prepare,
> +	.attach		= imx_rproc_attach,
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.kick		= imx_rproc_kick,
> @@ -404,6 +423,7 @@ static const struct rproc_ops imx_rproc_ops = {
>  	.load		= rproc_elf_load_segments,
>  	.parse_fw	= imx_rproc_parse_fw,
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
> @@ -470,6 +490,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		}
>  		priv->mem[b].sys_addr = res.start;
>  		priv->mem[b].size = resource_size(&res);
> +		if (!strcmp(node->name, "rsc_table"))
> +			priv->rsc_table = priv->mem[b].cpu_addr;
>  		b++;
>  	}
>  
> @@ -536,6 +558,25 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
>  	mbox_free_channel(priv->rx_ch);
>  }
>  
> +static int imx_rproc_detect_mode(struct imx_rproc *priv)
> +{
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +	struct device *dev = priv->dev;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
> +	if (ret) {
> +		dev_err(dev, "Failed to read src\n");
> +		return ret;
> +	}
> +
> +	if (!(val & dcfg->src_stop))
> +		priv->rproc->state = RPROC_DETACHED;
> +
> +	return 0;
> +}
> +
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -590,6 +631,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  		goto err_put_mbox;
>  	}
>  
> +	ret = imx_rproc_detect_mode(priv);
> +	if (ret)
> +		goto err_put_mbox;
> +

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	priv->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(priv->clk)) {
>  		dev_err(dev, "Failed to get clock\n");
> -- 
> 2.30.0
> 
