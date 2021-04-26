Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D636B882
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhDZSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhDZSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6462C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:02:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n4-20020a05600c4f84b029013151278decso5516045wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sLlK+ON2myao5q9MqC74vluTzzv/E65V2uLXDsbBd8w=;
        b=odSsjA7DE6yWqHSyV1bybw+NBOWM//WiFglqqplSGIZYPc4E6d1EjE7GG5gTaMMBQl
         aDZzrD8DvjkY0PeQaQHmPSmXZx0+b4DERi3LLpX+fbDetMjCV14Np8sv5Is8RynkhV9O
         88KnQQ2hNuG+zXGDbdrWLZBVnmxXHF9MROLGMJpWK3zapYOEsX0FoObt06n04Ik/OmnM
         AEVIUPMaEuVakM1RHFfKq5AZ+xHQcADV9PK8/YQaKEbCcOPNn1MyLWwASODMRkCw7pCh
         Tj4n2Yc7Hu7xEs9JJU/OOYFIUE/m3Ij4dV8ka94Kg/OLcQgYBiOTdEYaLbmBtFCl1WVj
         ciXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sLlK+ON2myao5q9MqC74vluTzzv/E65V2uLXDsbBd8w=;
        b=oYvUCmmupd77/d2iTvY45otwfYtJtArfBB4OOcnmNyjTxGZmuTh72vtxzcmbK6plKf
         O818SVHzj+Dzgf7I/DfnMJ0nee67MQmDQVqjX0uNxDqq97PJ+Db9ddZxuy18eeqSNBOF
         6dS+rqQ5cW2ObVHGpAZA+9cWTWBkdVSooBM84AeC2fZftOsbRelidOJijphQ7iqVY0MQ
         mdNeFhI5onazYS9Ascw8ObZPrahtDq2Dc1+pJbtprDUDYnInTX6ALQXj1tRZ19B9GOTf
         6kyfhjfbQXSG7oZcPxZ366RbqYjZ7qNZCe2W76QQtd5zhLz+m57jYD5WdBlw8FXNHYof
         6Djg==
X-Gm-Message-State: AOAM530mk6tBSbf1I0StlMvAZkGB2mFONghhfZcQ9BkX7AIFGwMpHfzr
        YR69rJb8p9XnafatgSYKSNNk26YqOUluxUzp
X-Google-Smtp-Source: ABdhPJxQ+jECyTT9SugB177/Zfsr9dZJkYoiQJ/ctFv5IJ0sEXY5KRrXUoUmj5l8ddjRhtm4NfLI7Q==
X-Received: by 2002:a05:600c:2cd6:: with SMTP id l22mr14452735wmc.160.1619460144138;
        Mon, 26 Apr 2021 11:02:24 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b76e:7362:77c0:ddc3? ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id a9sm265091wmj.1.2021.04.26.11.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:02:23 -0700 (PDT)
Subject: Re: [PATCH -next] soc: amlogic: meson-clk-measure: remove redundant
 dev_err call in meson_msr_probe()
To:     Qiheng Lin <linqiheng@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210409110243.41-1-linqiheng@huawei.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3299a54f-0aeb-3dfa-dedb-d32f87de5ae9@baylibre.com>
Date:   Mon, 26 Apr 2021 20:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409110243.41-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 13:02, Qiheng Lin wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>  drivers/soc/amlogic/meson-clk-measure.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
> index e1957476a006..6dd190270123 100644
> --- a/drivers/soc/amlogic/meson-clk-measure.c
> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> @@ -626,10 +626,8 @@ static int meson_msr_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(base)) {
> -		dev_err(&pdev->dev, "io resource mapping failed\n");
> +	if (IS_ERR(base))
>  		return PTR_ERR(base);
> -	}
>  
>  	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>  					     &meson_clk_msr_regmap_config);
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
