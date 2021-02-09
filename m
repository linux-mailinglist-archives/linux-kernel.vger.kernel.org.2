Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186093152DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhBIPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBIPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:32:51 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07CC061786;
        Tue,  9 Feb 2021 07:32:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 18so8699617oiz.7;
        Tue, 09 Feb 2021 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLCA6IO40snskjJZDTwax4cOB0Hc4fTsIea1GRHbYqw=;
        b=kvnEwEIFrahzPVo3mkc68ni3hvFkTJo4jgIwH+zPLtWKNynGXxGa8nZObbKLW2IDmI
         3a46th3LHZDoBQmxtnfcccl8FMuftmUNv9bRdyh7WTYluEcZfsBmJEuEXMZByHuH7Uo5
         yCnASweu6IkfTBZw0kjB7MfRDg7ldqtvk4B+7XER9bVogg7krsCSAt7pu5Qy5kU0ZNPH
         PDyNjk/b5YpSvphU+rSIQe2EpwlgjF4Wvo+qkxEgZWTFnAIgX+W0v7CtusZG63z3e8a0
         a6PbGRsH9E2xPpEPvANeKbRttFtVWU9J7Zrh51lH9SnVq6+St1kDZk5p1GoCI8Yt+yPm
         CemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLCA6IO40snskjJZDTwax4cOB0Hc4fTsIea1GRHbYqw=;
        b=IBZHwbAFZwsdMWB9R5tYGGHlQXMYMaTJCd/K2FZyDdZeSjvKStzvFPuak3p9xJ78VL
         5zGnAH7UYpITUxjfxMGYkmAkZ+qkHbQGPhjdg99vs/NRtTHyYtkk7DRE8LzIPH+SK0Pz
         SuNsf3OWR7KgyyYhL7187QeYStSXwArlldrV7xaB6D/U6rVoBNubLT6GpkNud55Vqb81
         V1osWuYvOBIapC6WlhTnlD+4DI64OoYstE4yWF6+97wN0QW7qN+UIeHVxcc0rDaX8j1A
         +lMjg1NwG4t4NI2Dsf7ezRVv41lGxvL3BR8UOEDSfx4ELH8K5xfE1fgmADbp+yGxMY1k
         ySAg==
X-Gm-Message-State: AOAM530Mga7JHmQBerGTXDgmC763MgiBqPpIizfYwZdSKWQgBTYDwVlZ
        /os9F71/jfO7mSwpenbF6Ec=
X-Google-Smtp-Source: ABdhPJyiqVTRbNHqwEOslyBfXgEDo8uRefp2GZczvabIoa5IJcgps061q+D4OOvLoVupWlnLpGk2WQ==
X-Received: by 2002:aca:4a4c:: with SMTP id x73mr2753987oia.97.1612884729290;
        Tue, 09 Feb 2021 07:32:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm4327754oij.29.2021.02.09.07.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 07:32:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Feb 2021 07:32:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/8] drm/mediatek: add component POSTMASK
Message-ID: <20210209153206.GA19067@roeck-us.net>
References: <20210202081237.774442-1-hsinyi@chromium.org>
 <20210202081237.774442-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202081237.774442-3-hsinyi@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:12:31PM +0800, Hsin-Yi Wang wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add component POSTMASK.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
[ ... ]
>  
> +void mtk_postmask_config(struct device *dev, unsigned int w,

static

> +			unsigned int h, unsigned int vrefresh,
> +			unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +
> +	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,
> +		      DISP_POSTMASK_SIZE);
> +	mtk_ddp_write(cmdq_pkt, POSTMASK_RELAY_MODE, &priv->cmdq_reg,
> +		      priv->regs, DISP_POSTMASK_CFG);
> +}
> +
> +void mtk_postmask_start(struct device *dev)

static

> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +
> +	writel(POSTMASK_EN, priv->regs + DISP_POSTMASK_EN);
> +}
> +
> +void mtk_postmask_stop(struct device *dev)

static

> +{
> +	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
> +
> +	writel_relaxed(0x0, priv->regs + DISP_POSTMASK_EN);
> +}
> +
>  static void mtk_aal_config(struct device *dev, unsigned int w,
>  			   unsigned int h, unsigned int vrefresh,
>  			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> @@ -413,6 +445,14 @@ static const struct mtk_ddp_comp_funcs ddp_ovl = {
>  	.bgclr_in_off = mtk_ovl_bgclr_in_off,
>  };
>  
> +static const struct mtk_ddp_comp_funcs ddp_postmask = {
> +	.clk_enable = mtk_ddp_clk_enable,
> +	.clk_disable = mtk_ddp_clk_disable,
> +	.config = mtk_postmask_config,
> +	.start = mtk_postmask_start,
> +	.stop = mtk_postmask_stop,
> +};
> +
>  static const struct mtk_ddp_comp_funcs ddp_rdma = {
>  	.clk_enable = mtk_rdma_clk_enable,
>  	.clk_disable = mtk_rdma_clk_disable,
> @@ -448,6 +488,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
>  	[MTK_DISP_MUTEX] = "mutex",
>  	[MTK_DISP_OD] = "od",
>  	[MTK_DISP_BLS] = "bls",
> +	[MTK_DISP_POSTMASK] = "postmask",
>  };
>  
>  struct mtk_ddp_comp_match {
> @@ -457,36 +498,37 @@ struct mtk_ddp_comp_match {
>  };
>  
>  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> -	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
> -	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },
> -	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
> -	[DDP_COMPONENT_CCORR]	= { MTK_DISP_CCORR,	0, &ddp_ccorr },
> -	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
> -	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
> -	[DDP_COMPONENT_DITHER]	= { MTK_DISP_DITHER,	0, &ddp_dither },
> -	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, &ddp_dpi },
> -	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, &ddp_dpi },
> -	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, &ddp_dsi },
> -	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, &ddp_dsi },
> -	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, &ddp_dsi },
> -	[DDP_COMPONENT_DSI3]	= { MTK_DSI,		3, &ddp_dsi },
> -	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> -	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> -	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> -	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, &ddp_ovl },
> -	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, &ddp_ovl },
> -	[DDP_COMPONENT_OVL_2L0]	= { MTK_DISP_OVL_2L,	0, &ddp_ovl },
> -	[DDP_COMPONENT_OVL_2L1]	= { MTK_DISP_OVL_2L,	1, &ddp_ovl },
> -	[DDP_COMPONENT_OVL_2L2] = { MTK_DISP_OVL_2L,    2, &ddp_ovl },
> -	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
> -	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
> -	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
> -	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, &ddp_rdma },
> -	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, &ddp_rdma },
> -	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, &ddp_rdma },
> -	[DDP_COMPONENT_UFOE]	= { MTK_DISP_UFOE,	0, &ddp_ufoe },
> -	[DDP_COMPONENT_WDMA0]	= { MTK_DISP_WDMA,	0, NULL },
> -	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
> +	[DDP_COMPONENT_AAL0]		= { MTK_DISP_AAL,	0, &ddp_aal },
> +	[DDP_COMPONENT_AAL1]		= { MTK_DISP_AAL,	1, &ddp_aal },
> +	[DDP_COMPONENT_BLS]		= { MTK_DISP_BLS,	0, NULL },
> +	[DDP_COMPONENT_CCORR]		= { MTK_DISP_CCORR,	0, &ddp_ccorr },
> +	[DDP_COMPONENT_COLOR0]		= { MTK_DISP_COLOR,	0, &ddp_color },
> +	[DDP_COMPONENT_COLOR1]		= { MTK_DISP_COLOR,	1, &ddp_color },
> +	[DDP_COMPONENT_DITHER]		= { MTK_DISP_DITHER,	0, &ddp_dither },
> +	[DDP_COMPONENT_DPI0]		= { MTK_DPI,		0, &ddp_dpi },
> +	[DDP_COMPONENT_DPI1]		= { MTK_DPI,		1, &ddp_dpi },
> +	[DDP_COMPONENT_DSI0]		= { MTK_DSI,		0, &ddp_dsi },
> +	[DDP_COMPONENT_DSI1]		= { MTK_DSI,		1, &ddp_dsi },
> +	[DDP_COMPONENT_DSI2]		= { MTK_DSI,		2, &ddp_dsi },
> +	[DDP_COMPONENT_DSI3]		= { MTK_DSI,		3, &ddp_dsi },
> +	[DDP_COMPONENT_GAMMA]		= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> +	[DDP_COMPONENT_OD0]		= { MTK_DISP_OD,	0, &ddp_od },
> +	[DDP_COMPONENT_OD1]		= { MTK_DISP_OD,	1, &ddp_od },
> +	[DDP_COMPONENT_OVL0]		= { MTK_DISP_OVL,	0, &ddp_ovl },
> +	[DDP_COMPONENT_OVL1]		= { MTK_DISP_OVL,	1, &ddp_ovl },
> +	[DDP_COMPONENT_OVL_2L0]		= { MTK_DISP_OVL_2L,	0, &ddp_ovl },
> +	[DDP_COMPONENT_OVL_2L1]		= { MTK_DISP_OVL_2L,	1, &ddp_ovl },
> +	[DDP_COMPONENT_OVL_2L2]		= { MTK_DISP_OVL_2L,    2, &ddp_ovl },
> +	[DDP_COMPONENT_POSTMASK0]	= { MTK_DISP_POSTMASK,	0, &ddp_postmask },
> +	[DDP_COMPONENT_PWM0]		= { MTK_DISP_PWM,	0, NULL },
> +	[DDP_COMPONENT_PWM1]		= { MTK_DISP_PWM,	1, NULL },
> +	[DDP_COMPONENT_PWM2]		= { MTK_DISP_PWM,	2, NULL },
> +	[DDP_COMPONENT_RDMA0]		= { MTK_DISP_RDMA,	0, &ddp_rdma },
> +	[DDP_COMPONENT_RDMA1]		= { MTK_DISP_RDMA,	1, &ddp_rdma },
> +	[DDP_COMPONENT_RDMA2]		= { MTK_DISP_RDMA,	2, &ddp_rdma },
> +	[DDP_COMPONENT_UFOE]		= { MTK_DISP_UFOE,	0, &ddp_ufoe },
> +	[DDP_COMPONENT_WDMA0]		= { MTK_DISP_WDMA,	0, NULL },
> +	[DDP_COMPONENT_WDMA1]		= { MTK_DISP_WDMA,	1, NULL },
>  };
>  
>  static bool mtk_drm_find_comp_in_ddp(struct device *dev,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index bb914d976cf5d..cd1dec6b4cdf2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -30,6 +30,7 @@ enum mtk_ddp_comp_type {
>  	MTK_DISP_UFOE,
>  	MTK_DSI,
>  	MTK_DPI,
> +	MTK_DISP_POSTMASK,
>  	MTK_DISP_PWM,
>  	MTK_DISP_MUTEX,
>  	MTK_DISP_OD,
