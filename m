Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0241A35E54C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347302AbhDMRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:47:13 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:43641 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347267AbhDMRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:47:08 -0400
Received: by mail-pj1-f52.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso9380875pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gksf2GLCnKpMla39BjXy2uPj3pSI0JcCgVY9plAt1pE=;
        b=zuHvgXo2efl2BRQdU0ijTEf+emxCj+bbgf8l28IkAAX1cWJixQaG1e48MpNWWCPhPt
         KGlydlejOQ044wn/VmmJq7ZwHDi5SE3Ijoal/TrfExsFQr2zp9D5mRobPxFfdVR8SbXa
         XYoPL+BlHL9sEyST7DDcuG75+t8ie0xN6q+5q6hUYsDkXWOH9Z/c8uKvILrTnj3+Tq6H
         xIZa3dZH24Vl/QWQStHYdE2zhwHNJD+JOJE0y4aPePbZpH1YQxj1UXPosqChUj4EkTJf
         gc44h6YS7c9EbMSnZc+Vag8YI12yDThD5D51b2XzJfxK69f6ac+xi1DpN67HE15JBeLo
         bU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gksf2GLCnKpMla39BjXy2uPj3pSI0JcCgVY9plAt1pE=;
        b=eAVpXwQw9HPLoEoNP3jbt9LIHdJJCjUtC/+37gCEKaB3iO2GRY+TQgJVY2CUXA6Mwo
         0/soe2cThJBokQH7hG7tmsOkEIyu8RFG/Xv+tuaeJwHnfuUSFpY9JdYqpt8Zw3NLKr3h
         gaGual9AvPB3ZQlNQA1o7sbSsqY0lDnvSYK3H9aVbUwghccIjR6DhTZ2UiK8AFFpQiQl
         BERQyRaLx/vJiDwnd3RETmbOKdNNCSgPJI96udkp/kJPP3xImlJZ1hxAfKcrk0kfDtOY
         JqxZ/sgBAnvGn1s44Q2kb/uLTr9tKPsY5FZZ3kqMgDs4O71tK4pjO7BwKqUPqT5VtiBu
         xbaw==
X-Gm-Message-State: AOAM533e6OsT9jwnRCKUFhK/+o3iRgLiAPJCgPVSfepK804NO/KUQYeU
        9MQQ+uki5rru6GBkU150zeiUiw==
X-Google-Smtp-Source: ABdhPJzSvSAsMah5SEJY2Ov5zU42KJYL5D8va+YF5aDSoVMiZ7NWMJpdHnw7YLTnzZSuU2tnNSQtMg==
X-Received: by 2002:a17:90b:808:: with SMTP id bk8mr1258289pjb.128.1618335948386;
        Tue, 13 Apr 2021 10:45:48 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r1sm2864967pjo.26.2021.04.13.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:45:47 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:45:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 6/8] remoteproc: imx_rproc: initial support for
 mutilple start/stop method
Message-ID: <20210413174545.GD750651@xps15>
References: <1617846898-13662-1-git-send-email-peng.fan@oss.nxp.com>
 <1617846898-13662-7-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617846898-13662-7-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:54:56AM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add three methods IMX_RPROC_NONE(no need start/stop), IMX_RPROC_MMIO
> (start/stop through mmio) and IMX_RPROC_SMC(start/stop through ARM SMCCC).
> 
> The current SoCs supported are all using IMX_RPROC_MMIO, add a restrict
> in probe that only SoCs using IMX_RPROC_MMIO needs syscon regmap to
> access registers.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 50 +++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index c576e12d3817..a7fa9d7fc2d1 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -74,6 +74,15 @@ struct imx_rproc_att {
>  	int flags;
>  };
>  
> +/* Remote core start/stop method */
> +enum imx_rproc_method {
> +	IMX_RPROC_NONE,
> +	/* Through syscon regmap */
> +	IMX_RPROC_MMIO,
> +	/* Through ARM SMCCC */
> +	IMX_RPROC_SMC,
> +};
> +
>  struct imx_rproc_dcfg {
>  	u32				src_reg;
>  	u32				src_mask;
> @@ -81,6 +90,7 @@ struct imx_rproc_dcfg {
>  	u32				src_stop;
>  	const struct imx_rproc_att	*att;
>  	size_t				att_size;
> +	enum imx_rproc_method		method;
>  };
>  
>  enum imx_rproc_mode {
> @@ -194,6 +204,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
>  	.src_stop	= IMX7D_M4_STOP,
>  	.att		= imx_rproc_att_imx8mq,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mq),
> +	.method		= IMX_RPROC_MMIO,
>  };
>  
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
> @@ -203,6 +214,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
>  	.src_stop	= IMX7D_M4_STOP,
>  	.att		= imx_rproc_att_imx7d,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7d),
> +	.method		= IMX_RPROC_MMIO,
>  };
>  
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
> @@ -212,6 +224,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
>  	.src_stop	= IMX6SX_M4_STOP,
>  	.att		= imx_rproc_att_imx6sx,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx6sx),
> +	.method		= IMX_RPROC_MMIO,
>  };
>  
>  static int imx_rproc_start(struct rproc *rproc)
> @@ -578,15 +591,17 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  
>  	priv->mode = IMX_RPROC_NORMAL;
>  
> -	ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
> -	if (ret) {
> -		dev_err(dev, "Failed to read src\n");
> -		return ret;
> -	}
> +	if (priv->regmap) {
> +		ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
> +		if (ret) {
> +			dev_err(dev, "Failed to read src\n");
> +			return ret;
> +		}
>  
> -	if (!(val & dcfg->src_stop)) {
> -		priv->mode = IMX_RPROC_EARLY_BOOT;
> -		priv->rproc->state = RPROC_DETACHED;
> +		if (!(val & dcfg->src_stop)) {
> +			priv->rproc->state = RPROC_DETACHED;
> +			priv->mode = IMX_RPROC_EARLY_BOOT;
> +		}
>  	}
>  
>  	return 0;
> @@ -600,16 +615,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	struct rproc *rproc;
>  	struct regmap_config config = { .name = "imx-rproc" };
>  	const struct imx_rproc_dcfg *dcfg;
> -	struct regmap *regmap;
> +	struct regmap *regmap = NULL;
>  	int ret;
>  
> -	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "failed to find syscon\n");
> -		return PTR_ERR(regmap);
> -	}
> -	regmap_attach_dev(dev, regmap, &config);
> -
>  	/* set some other name then imx */
>  	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
>  			    NULL, sizeof(*priv));
> @@ -622,6 +630,16 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  		goto err_put_rproc;
>  	}
>  
> +	if (dcfg->method == IMX_RPROC_MMIO) {
> +		regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> +		if (IS_ERR(regmap)) {
> +			dev_err(dev, "failed to find syscon\n");
> +			ret = PTR_ERR(regmap);
> +			goto err_put_rproc;
> +		}
> +		regmap_attach_dev(dev, regmap, &config);
> +	}

I would move this to imx_rproc_detect_mode() and get rid of the "if
(priv->regmap)" that is there.

> +
>  	priv = rproc->priv;
>  	priv->rproc = rproc;
>  	priv->regmap = regmap;
> -- 
> 2.30.0
> 
