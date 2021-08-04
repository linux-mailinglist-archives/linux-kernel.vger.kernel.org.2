Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC403E0650
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbhHDRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhHDRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:09:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96ABC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:08:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n11so1622385wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/eXGTMv90CrY+h6kFPapkl2kvVM9xop2+wNswN+X3CQ=;
        b=dnQFEvCjJrFdVRUPB6Pm3vM1P5voe5NcznpNN9giJk0vDGKbK76jzHfsKvJMTm4xVE
         tb1DsJjJCx+FFtOQBtCIiIETpvXsiAq2vIFKLpuH7e7VOXi2lHXQ1kWeweXCSU5J4kye
         XW5BZW+bMGJ/KDhNKXe7VbuW6DkXmLSpvjHwS1QqeAXCI65uGNSvqNOdbI0TuX2r+0py
         0kNi6lj4td4yhFetYHfRA4F/EE1FKLszsClRkWcsYtxGa86xuIYXLNVMax0KmpAMeQH9
         WhSNul7Uy1xHq846nmY07e8u9PbfaookHRyl2wPHBh4+5ldvPYOFH/CSOiwFKGfIu001
         o3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/eXGTMv90CrY+h6kFPapkl2kvVM9xop2+wNswN+X3CQ=;
        b=X7EzJ8zUbCNQcUOXG7WxCRdzyMTHHviFi0pfafPnkVGMJ06gC37WM/bTYHSw0Ww9N+
         UaunNw1zWfs+XXKiNi3MVQYq0lkRYi8dEZJMbsyki+f/JodrkWrpr6G/nKa1be/vAgjL
         7uUDHt9He3ho/Fq7+buA5yAS1p66xMmbmp03G3AC4dfO3mguR85XRAY+syoFABxHm4L0
         MVXSLPkyK1mM5A+ZAf4eqvdg6yz3mpvKTftqDiYuq6Nj0DDCIC2FAY33r2H0WRXKgxaF
         4fhV5YKgCQQ7F/TLUSldVkU6CDlzIDylyMFj0bl9t+UULFXXTyzujyG5ngXvg2WF+lZP
         3B1g==
X-Gm-Message-State: AOAM532WSDRWc6jWTPzXgA3CgHc/oHr+PKEcEShLFkLD7+ZBrowiDrLk
        I8LdPv+FAtvrdfDkDAh4I7o=
X-Google-Smtp-Source: ABdhPJyxEuNfD/DLY+3wo/r8+jwHbpOXBbsmEXEG3V6EbhJx0t1Gb9nR3pOGg1+CC2pMWCHojxlmkA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr10748720wma.33.1628096929356;
        Wed, 04 Aug 2021 10:08:49 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id f194sm6631026wmf.23.2021.08.04.10.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:08:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] soc: mediatek: mmsys: add MT8365 support
To:     Fabien Parent <fparent@baylibre.com>
Cc:     mkorpershoek@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210519161847.3747352-1-fparent@baylibre.com>
 <20210519161847.3747352-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d8c0e3c6-c7bf-251a-cdb9-7ca35d1dae13@gmail.com>
Date:   Wed, 4 Aug 2021 19:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210519161847.3747352-3-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

On 19/05/2021 18:18, Fabien Parent wrote:
> Add DSI mmsys connections for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/soc/mediatek/mt8365-mmsys.h | 60 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c    | 11 ++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8365-mmsys.h
> 
> diff --git a/drivers/soc/mediatek/mt8365-mmsys.h b/drivers/soc/mediatek/mt8365-mmsys.h
> new file mode 100644
> index 000000000000..2475aeb79791
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8365-mmsys.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8365_MMSYS_H
> +#define __SOC_MEDIATEK_MT8365_MMSYS_H
> +
> +#define MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0xf3c
> +#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL	0xf4c
> +#define MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN	0xf50
> +#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN	0xf54
> +#define MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN	0xf60
> +#define MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0xf64
> +#define MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0xf68
> +
> +#define MT8365_RDMA0_SOUT_COLOR0			0x1
> +#define MT8365_DITHER_MOUT_EN_DSI0			0x1
> +#define MT8365_DSI0_SEL_IN_DITHER			0x1
> +#define MT8365_RDMA0_SEL_IN_OVL0			0x0
> +#define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0			0x0
> +#define MT8365_DISP_COLOR_SEL_IN_COLOR0			0x0
> +#define MT8365_OVL0_MOUT_PATH0_SEL			BIT(0)
> +
> +static const struct mtk_mmsys_routes mt8365_mmsys_routing_table[] = {
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> +		MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
> +		MT8365_OVL0_MOUT_PATH0_SEL

I pushed this patch to v4.15-next/soc
As we now include the mask field in mtk_mmsys_routes I updated that in the patch.
Please let me know if I screwed something up.

Regards,
Matthias

> +	},
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> +		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
> +		MT8365_RDMA0_SEL_IN_OVL0
> +	},
> +	{
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
> +		MT8365_RDMA0_SOUT_COLOR0
> +	},
> +	{
> +		DDP_COMPONENT_COLOR0, DDP_COMPONENT_CCORR,
> +		MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
> +		MT8365_DISP_COLOR_SEL_IN_COLOR0
> +	},
> +	{
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +		MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
> +		MT8365_DITHER_MOUT_EN_DSI0
> +	},
> +	{
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +		MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
> +		MT8365_DSI0_SEL_IN_DITHER
> +	},
> +	{
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +		MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
> +		MT8365_RDMA0_RSZ0_SEL_IN_RDMA0
> +	},
> +};
> +
> +#endif /* __SOC_MEDIATEK_MT8365_MMSYS_H */
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 080660ef11bf..44aff822d035 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -13,6 +13,7 @@
>  #include "mtk-mmsys.h"
>  #include "mt8167-mmsys.h"
>  #include "mt8183-mmsys.h"
> +#include "mt8365-mmsys.h"
>  
>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>  	.clk_driver = "clk-mt2701-mm",
> @@ -52,6 +53,12 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>  	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>  };
>  
> +static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
> +	.clk_driver = "clk-mt8365-mm",
> +	.routes = mt8365_mmsys_routing_table,
> +	.num_routes = ARRAY_SIZE(mt8365_mmsys_routing_table),
> +};
> +
>  struct mtk_mmsys {
>  	void __iomem *regs;
>  	const struct mtk_mmsys_driver_data *data;
> @@ -157,6 +164,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>  		.compatible = "mediatek,mt8183-mmsys",
>  		.data = &mt8183_mmsys_driver_data,
>  	},
> +	{
> +		.compatible = "mediatek,mt8365-mmsys",
> +		.data = &mt8365_mmsys_driver_data,
> +	},
>  	{ }
>  };
>  
> 
