Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060AD355580
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbhDFNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDFNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:43:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEF4C06174A;
        Tue,  6 Apr 2021 06:43:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w10so4898267pgh.5;
        Tue, 06 Apr 2021 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jSs0GImijstRdBi/hnd8BpYG0s2XqMpukkAAlW6Mojo=;
        b=opLce27cL+3ZlmbaKha0CMsQyLnq5SwVfZwLI7r7Mi8H0hvPw8fUyx+eCwBVIBuhdR
         nFTnEcxKkIXEiwTCr/1/H3p9juxLV7FZKjlA4EzKa8l4c6mSeUoH/2xky4vO9+4oeolP
         8s+I8xFM5+joUQqZLBO6Hvb4MRwcFaOxYSrWrLQ56lMDET7muIu02FrqZ0mwzuKzmdEA
         at41fKHrLEHDlJrdveavN8LMfzUD4C3kfTKKcSBCbtixhf5LI/XcvGKPN4BzdB6JiHit
         aKmj/m7VzAN2ijPHlM0rRjF2k6s6Lutc8lhV46zlTxaNuQq/5BnhMnQKzTuMZJ4PGT5W
         9dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jSs0GImijstRdBi/hnd8BpYG0s2XqMpukkAAlW6Mojo=;
        b=fiU+it4hBZmKtGH9TK6xlzZpPZDdbrWDDhVTgWdPbTjRaV0nCpd6LoGvzhjUDtpJGg
         jeUapoO2zDvLil+k4yXOsGnXbHB8F+nEQ2zGnHd09J47xYxb72ezK8ZPS3fpOpm3qq6c
         pMhN8vEc5hW+fd8DY8aRUvYC6/cTE42h9jcKWGdL0dteUyESGFb4oLxlME7a3Tn/1NUU
         4i5J7zaI0yN+cuqOZXE+dkUf7l9QzqqdLcwzczR9EfB78QUX99us6Pwc4A/zAtIJK19o
         uAYm1OVHagAYSEZpWOgSzZE+MqJQ8/hfZhlz9fKtrH+phjSqlTwM3IL0QgFM+GxTDGPf
         kXsQ==
X-Gm-Message-State: AOAM531sbrJa51zm3L7ZVlIp2mr8Y0xhrapLoUAZLBlmRC+VxQoO5hQX
        qK8ZxYHQeUSF5LFSWHRuYX8=
X-Google-Smtp-Source: ABdhPJw4eZiisfrOoYDIWxTG5w9zSLLx4Ne+quT5NeHqLNvnTTR79P3ttNpkO/OU0fJ026VzH/i6WA==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr27823666pge.304.1617716606266;
        Tue, 06 Apr 2021 06:43:26 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id g15sm2294162pjd.2.2021.04.06.06.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:43:25 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] soc: mediatek: devapc: rename variable for new IC
 support
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
 <1617259087-5502-4-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a76686d1-3544-fcb9-4c3e-1498ec29ff47@gmail.com>
Date:   Tue, 6 Apr 2021 15:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617259087-5502-4-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the commit subject:
"soc: mediatek: devapc: rename variable for new IC support"
maybe something like:
"soc: mediatek: devapc: rename register variable infra_base"

Other then that looks good to me.

On 01/04/2021 08:38, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> For new ICs, there are multiple devapc HWs for different subsys.
> For example, there is devapc respectively for infra, peri, peri2, etc.
> So we rename the variable 'infra_base' to 'base' for code readability.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-devapc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index 68c3e35..bcf6e3c 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -45,7 +45,7 @@ struct mtk_devapc_data {
>  
>  struct mtk_devapc_context {
>  	struct device *dev;
> -	void __iomem *infra_base;
> +	void __iomem *base;
>  	u32 vio_idx_num;
>  	struct clk *infra_clk;
>  	const struct mtk_devapc_data *data;
> @@ -56,7 +56,7 @@ static void clear_vio_status(struct mtk_devapc_context *ctx)
>  	void __iomem *reg;
>  	int i;
>  
> -	reg = ctx->infra_base + ctx->data->vio_sta_offset;
> +	reg = ctx->base + ctx->data->vio_sta_offset;
>  
>  	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
>  		writel(GENMASK(31, 0), reg + 4 * i);
> @@ -71,7 +71,7 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
>  	u32 val;
>  	int i;
>  
> -	reg = ctx->infra_base + ctx->data->vio_mask_offset;
> +	reg = ctx->base + ctx->data->vio_mask_offset;
>  
>  	if (mask)
>  		val = GENMASK(31, 0);
> @@ -113,11 +113,11 @@ static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
>  	int ret;
>  	u32 val;
>  
> -	pd_vio_shift_sta_reg = ctx->infra_base +
> +	pd_vio_shift_sta_reg = ctx->base +
>  			       ctx->data->vio_shift_sta_offset;
> -	pd_vio_shift_sel_reg = ctx->infra_base +
> +	pd_vio_shift_sel_reg = ctx->base +
>  			       ctx->data->vio_shift_sel_offset;
> -	pd_vio_shift_con_reg = ctx->infra_base +
> +	pd_vio_shift_con_reg = ctx->base +
>  			       ctx->data->vio_shift_con_offset;
>  
>  	/* Find the minimum shift group which has violation */
> @@ -159,8 +159,8 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
>  	void __iomem *vio_dbg0_reg;
>  	void __iomem *vio_dbg1_reg;
>  
> -	vio_dbg0_reg = ctx->infra_base + ctx->data->vio_dbg0_offset;
> -	vio_dbg1_reg = ctx->infra_base + ctx->data->vio_dbg1_offset;
> +	vio_dbg0_reg = ctx->base + ctx->data->vio_dbg0_offset;
> +	vio_dbg1_reg = ctx->base + ctx->data->vio_dbg1_offset;
>  
>  	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
>  	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
> @@ -198,7 +198,7 @@ static irqreturn_t devapc_violation_irq(int irq_number, void *data)
>   */
>  static void start_devapc(struct mtk_devapc_context *ctx)
>  {
> -	writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);
> +	writel(BIT(31), ctx->base + ctx->data->apc_con_offset);
>  
>  	mask_module_irq(ctx, false);
>  }
> @@ -210,7 +210,7 @@ static void stop_devapc(struct mtk_devapc_context *ctx)
>  {
>  	mask_module_irq(ctx, true);
>  
> -	writel(BIT(2), ctx->infra_base + ctx->data->apc_con_offset);
> +	writel(BIT(2), ctx->base + ctx->data->apc_con_offset);
>  }
>  
>  static const struct mtk_devapc_data devapc_mt6779 = {
> @@ -249,8 +249,8 @@ static int mtk_devapc_probe(struct platform_device *pdev)
>  	ctx->data = of_device_get_match_data(&pdev->dev);
>  	ctx->dev = &pdev->dev;
>  
> -	ctx->infra_base = of_iomap(node, 0);
> -	if (!ctx->infra_base)
> +	ctx->base = of_iomap(node, 0);
> +	if (!ctx->base)
>  		return -EINVAL;
>  
>  	if (of_property_read_u32(node, "vio_idx_num", &ctx->vio_idx_num))
> 
