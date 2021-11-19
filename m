Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46950457536
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhKSRV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:21:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41789C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:18:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b12so19321856wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FP9hwialv6yAEl5OHXjo4xWuTQn68GpOH2rXlR/66qQ=;
        b=MuVMdJD3i6iM7EYol8YYUwOgrVkgeoYnCxECTuxTp1DkJEPyBXogLbS+0BLm/BesNc
         5C1njJ+iZK4CmF+o4JS1nsHTp1HZauczmWlX9uTKS47QN/tRrq1CCb6BcUFNaDB6TUJd
         Oplxn2eTRvF08OVt0TVxP0wg9173tQ3QZyrhcYsqM/7idBy/8QtQbAjZ9gGdnBY3DnU6
         S+2syCl7sL16NDP2EWzts51NPHYI78qdJHomqglMxIrN2yEJt/KWxyCunP/tR8j8zlJ+
         YmYEBCu9deEMXB4AojU7nrPhLxPZQS2M1JPc09XLNrpu1l2Vw0IbtJzZQyCoA1ZYaAcm
         YvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FP9hwialv6yAEl5OHXjo4xWuTQn68GpOH2rXlR/66qQ=;
        b=vNcTN/1gMSRvc3+YMH0ENdvBZiXMqbTYJq9W5GUNpdrrRtpdpBZgodbTlIHam9yE1K
         SVkIB1hM3y/LwrGElGgffqHFpGmzMccfSiajT6DxkLCcLwje62hR6bk7cb+2tdvV5eoe
         soGM/kzqz7r93yHV4ptNCvDniAf2tTYtQ+w88rjJZecSE8BGwZb4+kGE65Y54Yl59m5H
         j4h0CGqs1eAPOK55j6IYJsuaoaFGn+VG0ukjpAT/LzZy/vSJKwMgXowWFRHPTzviZzK7
         QNQWAjMLN312OB5E8r8hVCofQ8K9YeFlcPBVolX9fsipvPFR9i9xlvnEHaBBdBLmJxMe
         1P/g==
X-Gm-Message-State: AOAM530Rk27rVBr0hVwYKuSev/HEaZcgUnpqkBZOXORsYTzuU84028ih
        ZtvgntJRIRkY9cIO7/I6XzTorw==
X-Google-Smtp-Source: ABdhPJz7rGeQ3uY7+i432blgA51XM/NysPQuKduVTwISoTtJKsk/0HgDfWQCa+KDLzxoI19YoqhHKg==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr9083862wri.381.1637342301747;
        Fri, 19 Nov 2021 09:18:21 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id t1sm400914wre.32.2021.11.19.09.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:18:21 -0800 (PST)
Subject: Re: [PATCH 3/6] nvmem: mtk-efuse: support minimum one byte access
 stride and granularity
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-3-chunfeng.yun@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2ba27f8a-6d10-3a7a-45b2-dbe503c79d47@linaro.org>
Date:   Fri, 19 Nov 2021 17:18:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211107075646.4366-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2021 07:56, Chunfeng Yun wrote:
> In order to support nvmem bits property, should support minimum 1 byte
> read stride and minimum 1 byte read granularity at the same time.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Applied thanks,

--srini

> ---
>   drivers/nvmem/mtk-efuse.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 6a537d959f14..e9a375dd84af 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -19,11 +19,12 @@ static int mtk_reg_read(void *context,
>   			unsigned int reg, void *_val, size_t bytes)
>   {
>   	struct mtk_efuse_priv *priv = context;
> -	u32 *val = _val;
> -	int i = 0, words = bytes / 4;
> +	void __iomem *addr = priv->base + reg;
> +	u8 *val = _val;
> +	int i;
>   
> -	while (words--)
> -		*val++ = readl(priv->base + reg + (i++ * 4));
> +	for (i = 0; i < bytes; i++, val++)
> +		*val = readb(addr + i);
>   
>   	return 0;
>   }
> @@ -45,8 +46,8 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
> -	econfig.stride = 4;
> -	econfig.word_size = 4;
> +	econfig.stride = 1;
> +	econfig.word_size = 1;
>   	econfig.reg_read = mtk_reg_read;
>   	econfig.size = resource_size(res);
>   	econfig.priv = priv;
> 
