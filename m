Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5635E508
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbhDMR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:29:41 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:42951 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbhDMR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:29:39 -0400
Received: by mail-pj1-f46.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so9369034pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2QhzyojWbvybLlPtewmMNO5cATZp5zhGPpcdHGJXGg=;
        b=BKlDaTeHzuJv+GEQuFg1n4srYnuQrdQZmp5Fdc4/vh9SPNKr6d0mCK8+K/n363EDR4
         GfiqaR+iULjCzNK1G+mIwSzUbnujjFaVCnL3PWPY4UUGcBLL3+fKpxppIhqT1at8qII4
         w86hiSsfwaiVoV/14NHwhE12RAmg0vGLJ8elj2dzlcR9gEv4hz7+j6fjHHVdxKU3rX98
         Z6n7pCAC3gSgO7s66c1I/UoIwNzsSQrOAXXHn/YAnqn2k9ZrrMOkWObGYRTiA0CDDtbu
         FGoXs223kiZ7/iv1MQsr3DT+S0tUPYp2i3iOJ7+RUATTJsDh72ct0zYnPMKZGd9rcfuR
         QAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2QhzyojWbvybLlPtewmMNO5cATZp5zhGPpcdHGJXGg=;
        b=EK5ADHl4HBpCbcuoPYstCZ2ShQ4qq0nV2Bdy7bpQyTG1mnqQb7c+jW3uiJJTzoP6CW
         SQ9mmMATtyVo/C/YJd+q3WrOSz9CfpVAijPJJX7mEbsdXkFnMcXPXl2sV2XUhQ0smX5/
         iROlk5lGh9Hs6nabv8x8vCuvxDicPelWE5UHQj6nIyvq4wdtA4ZC0//uHgbL9OPGXcUu
         7XIDlSZCCVfuf3JVHSlmK1Ukfrcer8GWQgOMQAXf/WO8jBfurdKPhXQCaRPtuYfKsxHG
         aWRwySrgGX5z+ChZo7Y+f39adi7f9MkZo9f8Nja3o/qf1Pxgqs6VEAGdSu1dTEkkEi7h
         WWbg==
X-Gm-Message-State: AOAM530getUCDRxRIDs4wUa2uThQo7rsnbFtl1DMcGRGToAG3TK94Hlq
        mcp2mivu3ZSxWDvLy+GItT2Xew==
X-Google-Smtp-Source: ABdhPJwTxPoyVSCF3F3SSBLBa01eeTFoMvtF4Ia5XzqeZQ/iVhPz30mD+ZynMqgzzxKnZC6z1Ry5wA==
X-Received: by 2002:a17:90a:5217:: with SMTP id v23mr1092282pjh.161.1618334900010;
        Tue, 13 Apr 2021 10:28:20 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w1sm15075490pgh.26.2021.04.13.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:28:19 -0700 (PDT)
Date:   Tue, 13 Apr 2021 11:28:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/8] remoteproc: imx_rproc: make clk optional
Message-ID: <20210413172817.GB750651@xps15>
References: <1617846898-13662-1-git-send-email-peng.fan@oss.nxp.com>
 <1617846898-13662-5-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617846898-13662-5-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:54:54AM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> To i.MX7ULP, M4 is the master to control everything, so it not need
> clk from A7.
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index d6338872c6db..ca17f520d904 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -635,7 +635,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_put_mbox;
>  
> -	priv->clk = devm_clk_get(dev, NULL);
> +	priv->clk = devm_clk_get_optional(dev, NULL);

Overnight the clock becomes optional for all remote processors?  Why not call
devm_clk_get() or devm_clk_get_optional() based on the remote processor type in
a new function called imx_rproc_clk_get()?

>  	if (IS_ERR(priv->clk)) {
>  		dev_err(dev, "Failed to get clock\n");
>  		ret = PTR_ERR(priv->clk);
> -- 
> 2.30.0
> 
