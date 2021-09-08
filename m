Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3387B4035BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbhIHHuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbhIHHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:49:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7EAC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:47:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n5so1756305wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fVr5v0iAW6pw1+B1n4WZvRBXwF+k69xSOMIkGqt2Po=;
        b=bse3DuwPwlB6Qd6cxFfxp6Z9BA4IVFiqOu1j5EqLZASJ5DIkrKZNDtXMc8t18DPX70
         qUzh2Es4khZc1f7ePIJAN8xtPpwjrbdCP4IRxpxtZgjt0eo8vkCBDTsb3Vsx8oEyWYmC
         fHriiT1781mBlE9QBmJelzRRnGf01e/HmcypCeqHKGNLmmlWS9YN+HJR+rE/ZqsHzy0d
         ZPk1grJc51rSnoqiTt9B+aoa5PhGRG+6UOf2Y6q8vw8iaNSnx3bBUQLDV8lbd2Up2I4M
         58evfazyiOy/pAg97GSNg7MP60oyV1kFJF7BzdHXBhEiIuCAn1IbCP0g9Y9/MLJDWqAQ
         r1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8fVr5v0iAW6pw1+B1n4WZvRBXwF+k69xSOMIkGqt2Po=;
        b=VDfR4SRKgu+R9JwxHJCqr8NWodA/j+O3CBHeKTdFt8rm31aSFz3n7QdhLsZ04LXA6t
         cMY6WcVtoRifLncRHphLq2MeO/gTwZMPy4b5iHzvGnnUCTAFcRTTX2MVWkynt5PaHrjI
         NI97mqvFw5ixJGritTa3D6gozH1YDmkL3zyuaZBLdpekG9aAyPFiLBG+QH8Oj73wD5kK
         Hmam+DDuuTg7drRSnujFgOKBdMwDRG4gEXlRpf+vUdTy68QH5L66JABnOk80SooPQkuk
         a0gXaBfdhUy5AZ5WdEkr76sD4WT57kcqvJadByFysAV21e6Oybr0cIVqLuigjPAjNd3v
         rbdA==
X-Gm-Message-State: AOAM533Jju19O+BFhQlxjpYGqAXftZe/h/zG95Df3klhwr7rKxTvYIYP
        FQeHS4lDYwmNntK94uwwrxRybukJw6P9xWt2
X-Google-Smtp-Source: ABdhPJxqjpFETGMyghSIxLdLr/Wc2YN9wnzACPmeZYTr48VcU+2U/dvy8U42hdVd2oHTk1VKhg2Vgg==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr2444892wru.310.1631087271373;
        Wed, 08 Sep 2021 00:47:51 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:19d:2e13:ec0a:9d59? ([2001:861:44c0:66c0:19d:2e13:ec0a:9d59])
        by smtp.gmail.com with ESMTPSA id i27sm1245410wmb.40.2021.09.08.00.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:47:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] soc: amlogic: canvas: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210908071544.603-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <dc885d03-7bf5-9441-f2fc-c8b22e725817@baylibre.com>
Date:   Wed, 8 Sep 2021 09:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908071544.603-1-caihuoqing@baidu.com>
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
>  drivers/soc/amlogic/meson-canvas.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> index d0329ad170d1..383b0cfc584e 100644
> --- a/drivers/soc/amlogic/meson-canvas.c
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -168,7 +168,6 @@ EXPORT_SYMBOL_GPL(meson_canvas_free);
>  
>  static int meson_canvas_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct meson_canvas *canvas;
>  	struct device *dev = &pdev->dev;
>  
> @@ -176,8 +175,7 @@ static int meson_canvas_probe(struct platform_device *pdev)
>  	if (!canvas)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	canvas->reg_base = devm_ioremap_resource(dev, res);
> +	canvas->reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(canvas->reg_base))
>  		return PTR_ERR(canvas->reg_base);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
