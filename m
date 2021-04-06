Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2A355573
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbhDFNlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDFNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:41:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D09C06174A;
        Tue,  6 Apr 2021 06:41:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so8599410wrz.9;
        Tue, 06 Apr 2021 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qklMtpnFh5J5Dsu48LFQMJDK+GDGgx9EDr9EU819CxU=;
        b=JXU5+afhpmqz3s79d6W4embKeBxGq+5VP/jgfpjVz+QNZvQ4/gBxi9nRmOdYwEOSz4
         pymCG55qWmaSYUiAmrHsEmJtdsFzwTn/uviHtZkYFsJaCtQJSmdpNtjb2V/EOntK7EeY
         XGfzyMRY32vXyLyGfLZrgyjWTla2wZoxgQWdIja37Ygr9ik6UdlRLASrXubenE7MSK5X
         RNxwqkZxL7jfDHQ0fmByzK55mgRSo0ZNpAiHThkFh7KGRHYZbYRlQCQDteGP/Zb5xQqs
         JPdGqG3uuopEUEA4NSsd+W0HWwJkPfssshHQec9wHsSJKSQk4iBA9etJKYMi1DmO0pLl
         laUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qklMtpnFh5J5Dsu48LFQMJDK+GDGgx9EDr9EU819CxU=;
        b=Fg+xosGc+7Tk8laz+6pxecpj7v5NNtNU6y8GKmduZqNHY+nrtD6YjyiJPglTSDVWJ6
         cyXplnrxD0oK3oQJpD8ZAZs4nmqnvt335H/uuR5ZcVWF5L/06nGxhyL5ebHnmpDm3hDy
         9fWk6J2TygRQZEmHfw7Vmh7L12ab3r3ZQ1xtSM/yscqKdnJ8hpgnyVB4xL6WFqAfvHGZ
         aBegjqvsVp5asjZQgI6Cj6YF0m6aGMBuBkf0VGx8EpaPq+u94KP15+K+oZ580QzyNIiB
         zQXuesVHJy3A5KpEzfno8Y4LlDO9Ld5YAF3ok4vBCNCUTrhWEKAE8qXY+7capz8Wd3WN
         NxCg==
X-Gm-Message-State: AOAM530bQ5ogXT4DHQ7BBaVjsfXcOMmVg/1LFZ18hu2xLxKrQ7VV/z+h
        2LbU5nxXVWEc1EwwVs/+/OQ=
X-Google-Smtp-Source: ABdhPJwyg/Mb/15E0YTxtFvcV888RO6L7pQfcpaGvAIsJ88MyIZjILLZHAsIXVUmaZCyc6MlfIjNdg==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr10247647wrx.36.1617716502095;
        Tue, 06 Apr 2021 06:41:42 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l4sm2870959wmh.8.2021.04.06.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:41:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] soc: mediatek: devapc: move 'vio_idx_num' info to
 DT
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
 <1617259087-5502-2-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <39794302-7993-4f9c-b28c-577fdb0265a3@gmail.com>
Date:   Tue, 6 Apr 2021 15:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617259087-5502-2-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2021 08:38, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> For new ICs, there are multiple devapc HWs for different subsys.
> The number of devices controlled by each devapc (i.e. 'vio_idx_num'
> in the code) varies.
> We move this info from compatible data to DT so that we do not need
> to add n compatible for a certain IC which has n devapc HWs with
> different 'vio_idx_num', respectively.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-devapc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index f1cea04..a0f6fbd 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -32,9 +32,6 @@ struct mtk_devapc_vio_dbgs {
>  };
>  
>  struct mtk_devapc_data {
> -	/* numbers of violation index */
> -	u32 vio_idx_num;
> -
>  	/* reg offset */
>  	u32 vio_mask_offset;
>  	u32 vio_sta_offset;
> @@ -49,6 +46,7 @@ struct mtk_devapc_data {
>  struct mtk_devapc_context {
>  	struct device *dev;
>  	void __iomem *infra_base;
> +	u32 vio_idx_num;

We should try to stay backwards compatible (newer kernel with older DTS). I
think we don't need to move vio_idx_num to mtk_devapc_context. Just don't
declare it in the per SoC match data. More details see below...

>  	struct clk *infra_clk;
>  	const struct mtk_devapc_data *data;
>  };
> @@ -60,10 +58,10 @@ static void clear_vio_status(struct mtk_devapc_context *ctx)
>  
>  	reg = ctx->infra_base + ctx->data->vio_sta_offset;
>  
> -	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> +	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
>  		writel(GENMASK(31, 0), reg + 4 * i);
>  
> -	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1, 0),
> +	writel(GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1), 0),
>  	       reg + 4 * i);
>  }
>  
> @@ -80,15 +78,15 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
>  	else
>  		val = 0;
>  
> -	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
> +	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
>  		writel(val, reg + 4 * i);
>  
>  	val = readl(reg + 4 * i);
>  	if (mask)
> -		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +		val |= GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1),
>  			       0);
>  	else
> -		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->data->vio_idx_num) - 1,
> +		val &= ~GENMASK(VIO_MOD_TO_REG_OFF(ctx->vio_idx_num - 1),
>  				0);
>  
>  	writel(val, reg + 4 * i);
> @@ -216,7 +214,6 @@ static void stop_devapc(struct mtk_devapc_context *ctx)
>  }
>  
>  static const struct mtk_devapc_data devapc_mt6779 = {
> -	.vio_idx_num = 511,
>  	.vio_mask_offset = 0x0,
>  	.vio_sta_offset = 0x400,
>  	.vio_dbg0_offset = 0x900,
> @@ -256,6 +253,9 @@ static int mtk_devapc_probe(struct platform_device *pdev)
>  	if (!ctx->infra_base)
>  		return -EINVAL;
>  
> +	if (of_property_read_u32(node, "vio_idx_num", &ctx->vio_idx_num))
> +		return -EINVAL;
> +

...only read the property if  vio_idx_num == 0.
What do you think?

Regards,
Matthias

>  	devapc_irq = irq_of_parse_and_map(node, 0);
>  	if (!devapc_irq)
>  		return -EINVAL;
> 
