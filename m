Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE76D4035B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbhIHHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351219AbhIHHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:49:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575EC0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:47:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y132so984722wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iD5JAWMZKf4nhnTOd/3EZmehWhVW0/THDtH48VyDTSY=;
        b=y9Dfimdpu8K4LyP3jFYqVM9nQdIJBlz2+nDcK2LsdViVJLLfaQGKFNNhgmNhqb3ZYj
         rH9A1QTsmX9r/rp3K49tx6IFUXYQfQi5peBCyvZfnMNsG1clq+CJyWEcWTPwXiekz7um
         8fv2gie28kGYspTs+pBxIdo2Sw/t6w7V68fsyT9HoSInD4qVjz+MHWLGm2YH+HYpZvXZ
         vKLfIGUswyk2sIe67VWCvLrluElvuSpYCWHY58uW9NwgaT8P1j8wUKXq7QpJTYoLTfH+
         Y+oHAqzF2ESbhJyrZ2hSZJQQZ/bfxea7/W8hG3Le+vrc95ul7nFSsvnTCaCBPaNCQb+A
         /PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iD5JAWMZKf4nhnTOd/3EZmehWhVW0/THDtH48VyDTSY=;
        b=Oeg/3OX5oyMOXRZrQ3QrkIRYiueF9P1biZ1ie2sOwZ8u4k8t806ffx5eK7SDf2c2jG
         pPcLC1KQRQq7F5DeDm1M4w9vwbLbbgJyGYSzkkh3WIOPpjuCMlUAtC6BVTjrS/XG+jCq
         Kk9cWNcv3PODuS5y8NGHKV4PEF0f09Cc4uHza/EVQovVwqwIXu1rznlGUUDjem+Zyh+J
         l/iaBMC8ShrAbymcoFnYNDtXglIrrUzfKug7Dl29hvKkWwEiOiVrrhQu3e+OfBxRam7/
         aP3tHW7qiLlZmRtLFZQOrYczSZq91NE0x+mzz45QRUkwEJhdd9tWaQkBA1bFAe5o6lqM
         GhUQ==
X-Gm-Message-State: AOAM533Tp1BJctKavc+FIIf6pzwb8ro/e5AFhUlT22QEhEGoORArBXiM
        tn9dMQH+afZeToVAMUTUya5wYb4L59Z3WA0T
X-Google-Smtp-Source: ABdhPJwrYc0Tyg5rrojfsiaH/VOzUTLDvtXfCohm3UjsJul/5gg30FEzSZlUzWia0ECjM/Mjo1F9RQ==
X-Received: by 2002:a05:600c:3b15:: with SMTP id m21mr2126503wms.162.1631087278059;
        Wed, 08 Sep 2021 00:47:58 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:19d:2e13:ec0a:9d59? ([2001:861:44c0:66c0:19d:2e13:ec0a:9d59])
        by smtp.gmail.com with ESMTPSA id z7sm1474364wre.72.2021.09.08.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:47:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] soc: amlogic: meson-clk-measure: Make use of the
 helper function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210908071544.603-1-caihuoqing@baidu.com>
 <20210908071544.603-2-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <85221044-5d7c-5b33-7704-5558b7992fa6@baylibre.com>
Date:   Wed, 8 Sep 2021 09:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908071544.603-2-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2021 09:15, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/soc/amlogic/meson-clk-measure.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
> index 6dd190270123..3f3039600357 100644
> --- a/drivers/soc/amlogic/meson-clk-measure.c
> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> @@ -606,7 +606,6 @@ static int meson_msr_probe(struct platform_device *pdev)
>  {
>  	const struct meson_msr_id *match_data;
>  	struct meson_msr *priv;
> -	struct resource *res;
>  	struct dentry *root, *clks;
>  	void __iomem *base;
>  	int i;
> @@ -624,8 +623,7 @@ static int meson_msr_probe(struct platform_device *pdev)
>  
>  	memcpy(priv->msr_table, match_data, sizeof(priv->msr_table));
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
