Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A964A3555C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhDFNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhDFNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:53:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEECC06174A;
        Tue,  6 Apr 2021 06:53:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id b17so6759737pgh.7;
        Tue, 06 Apr 2021 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OJw/MQDTwsE99RcSWN1zpL6Wxd6tbDfIwDMtU0pQS3c=;
        b=ry8ThBgJVfOJerbxjm02BnqFHaArr88tQqG8iKHZOPrTxvHkXHormbablrQThndRvD
         ZEmdIJV4Y+f5+hfInM7TTrZakUQiU+exxc+a48IGU91X3iUoaMl4m41XhALr5DTXaVHx
         SWvRq4ALJGqr0zGiR9/ATbrOXgKDAI4JzzKhOVGUCxTdx+OltYSSVu3/y6TNX0b5X39W
         wIfYYdXFd+jjyh5UNg7r9GabdX8lKOicCrV0HborB+pKktvw4tTvzCeXkZI9oZ3ViqH0
         cE1wK2X+H9At+OfBHIVycmGdGeZlq/1LVraNE+3qXsnBEQaldxVMSaVoDygf41exsbZS
         iEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OJw/MQDTwsE99RcSWN1zpL6Wxd6tbDfIwDMtU0pQS3c=;
        b=cQokQOCgSo1nAYR/ZyEQwk3Pw6kl4pXRSOV19fqTsyauzLbtY//bNZOOAcFLn14U/0
         WAmp/v+y4EEl5pQfPk+U9Qe6OpaADhFVT+vI5nzGqbSbdihVlHdeRPqRRpGEo87eOXxH
         T5Z6teEpsWJ3AFMvfhupMSiw9k2F9vfsNOHa8YhZi1/ULOddwLD4eMxc2OoGKkxZjlVz
         Wg8zOjZOQyZGdQCq6IMrFvQNjL5P//bD+ZU4a4zycIC/MuKwkuK0b2TtJb736OYszJQr
         LAEeRPQfaaLLpcOfiQVAS2VSnFHyV1+B0gssmr1i37mHsy5ojNDSHagf8faKXvmGGNp0
         71Nw==
X-Gm-Message-State: AOAM533WEHt36rWpvl/3qoyEsRvwG+8k0SXOTVzWsOpgy3obVCEReI28
        yzupljg7YB5NvumgFY2K9eg=
X-Google-Smtp-Source: ABdhPJzn3noEyLiqvdfFdzNy+7STwb3Skz3mKSaI0+XpYwKhn0vzij9IZJRbD3GXQER0wYY3WVWnew==
X-Received: by 2002:a63:e913:: with SMTP id i19mr17746329pgh.426.1617717205076;
        Tue, 06 Apr 2021 06:53:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id j22sm2593924pjz.3.2021.04.06.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:53:24 -0700 (PDT)
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
 <1617259087-5502-5-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 5/6] soc: mediatek: devapc: add debug register for new
 IC support
Message-ID: <23c0d15c-6cc2-dc40-e45a-c2fb749cec1f@gmail.com>
Date:   Tue, 6 Apr 2021 15:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617259087-5502-5-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2021 08:38, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> There are 3 debug info registers in new ICs while in legacy ones,
> we have only 2. When dumping the debug info, we need to check first
> if the 3rd debug register exists and then we can konw how to decipher
> the debug info.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-devapc.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index bcf6e3c..af55c01 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -26,9 +26,19 @@ struct mtk_devapc_vio_dbgs {
>  			u32 addr_h:4;
>  			u32 resv:4;
>  		} dbg0_bits;
> +
> +		/* Not used, reference only */
> +		struct {
> +			u32 dmnid:6;
> +			u32 vio_w:1;
> +			u32 vio_r:1;
> +			u32 addr_h:4;
> +			u32 resv:20;
> +		} dbg0_bits_ver2;
>  	};
>  
>  	u32 vio_dbg1;
> +	u32 vio_dbg2;
>  };
>  
>  struct mtk_devapc_data {
> @@ -37,6 +47,7 @@ struct mtk_devapc_data {
>  	u32 vio_sta_offset;
>  	u32 vio_dbg0_offset;
>  	u32 vio_dbg1_offset;
> +	u32 vio_dbg2_offset;
>  	u32 apc_con_offset;
>  	u32 vio_shift_sta_offset;
>  	u32 vio_shift_sel_offset;
> @@ -158,12 +169,29 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
>  	struct mtk_devapc_vio_dbgs vio_dbgs;
>  	void __iomem *vio_dbg0_reg;
>  	void __iomem *vio_dbg1_reg;
> +	void __iomem *vio_dbg2_reg;
> +	u32 vio_addr, bus_id;
>  
>  	vio_dbg0_reg = ctx->base + ctx->data->vio_dbg0_offset;
>  	vio_dbg1_reg = ctx->base + ctx->data->vio_dbg1_offset;
> +	vio_dbg2_reg = ctx->base + ctx->data->vio_dbg2_offset;

We should read this only if we have version2 of the devapc.

>  
>  	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
>  	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
> +	vio_dbgs.vio_dbg2 = readl(vio_dbg2_reg);
> +
> +	if (!ctx->data->vio_dbg2_offset) {

I think we should add a version field to mtk_devapc_data to distinguish the two
of them.

> +		/* arch version 1 */
> +		bus_id = vio_dbgs.dbg0_bits.mstid;
> +		vio_addr = vio_dbgs.vio_dbg1;
> +	} else {
> +		/* arch version 2 */
> +		bus_id = vio_dbgs.vio_dbg1;
> +		vio_addr = vio_dbgs.vio_dbg2;
> +
> +		/* To align with the bit definition of arch_ver 1 */
> +		vio_dbgs.vio_dbg0 = (vio_dbgs.vio_dbg0 << 16);

That's magic, better add another variable domain_id and do here:
domain_id = vio_dgbs.dbg0_bits_ver2.dmnid;

> +	}
>  
>  	/* Print violation information */
>  	if (vio_dbgs.dbg0_bits.vio_w)
> @@ -172,8 +200,7 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
>  		dev_info(ctx->dev, "Read Violation\n");
>  
>  	dev_info(ctx->dev, "Bus ID:0x%x, Dom ID:0x%x, Vio Addr:0x%x\n",
> -		 vio_dbgs.dbg0_bits.mstid, vio_dbgs.dbg0_bits.dmnid,
> -		 vio_dbgs.vio_dbg1);
> +		 bus_id, vio_dbgs.dbg0_bits.dmnid, vio_addr);
>  }
>  
>  /*
> 
