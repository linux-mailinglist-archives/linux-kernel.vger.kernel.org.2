Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179D13FD514
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhIAIPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbhIAIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:15:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 01:14:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t15so3133333wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0kNi+lHjT7XSbTIRmVqe8NrtAKLHSCB9511ZIsHzw8c=;
        b=Xk/9LzB/mLcmSdOGB85ZKeBG/oBz6bm38CwERpRHUUJ9AaKuMsCwhkgLCG/+X5i3AK
         EIZmCVrrTF5rVnqiL//gSzJcTyed9aBeMW/ySQbiPqWnVisNDoFUtbgFWSq04YBzBA6G
         VJ9+xAt5UnHDNSI1qsIuUBTU+G66rVMHY8VUj2u04wca76ogcfkX0RI4LgbE0eQRBOMg
         /6wpLebSIHUkpsD/TFuzRqYf93nhprwpP27S3iyarcyyvSi/6zvj6kWL/JWSUBY81+wl
         S/fMlaFJfSzvh/4SNPZo2cVhEV5isuofxeahTxn0ECQYFU4DMSU5G6h6D1lvFe+LuZEe
         M+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0kNi+lHjT7XSbTIRmVqe8NrtAKLHSCB9511ZIsHzw8c=;
        b=g96pvYja9L6NnOPz24iTpAG4Vdmst5YA59vWPfxIx0VyfmHKS14IauqWtPvgK6YB4l
         s1MmQjalOdKYtwmHGGj3fxQtZ5pCw/kScmYiJI0PJ/XYpOpN79E8HTeEokw6bb11j6IH
         +6RGAf6aOJaIVhCuSZduxRbcXSYlWQot0cYdtCgmtqKevqQU0YoTBRZN4Khp6Qr7NCsA
         xtOS66Aq4oNleK/jqBrD2Dqn81211kgtD5yH03SRyii3vrL93tZh3LGjSib0cE7poBl/
         08Nv/GOMC0c0uZdiGm0PyNSyEK0btsRSWTxdxFXvWpHRe3GOdv1r7MWUVT8EEhqE9HDZ
         c7jQ==
X-Gm-Message-State: AOAM530it/QO59i4UdUMLHu22rhqkrAVsrOemOeSssBvneEiUj5f9b3Y
        ZHZP9T7kaG2hKgkbROL6qghZPUVL2sucXcv0
X-Google-Smtp-Source: ABdhPJyxbURZu+cLTiD/wlnG7JzpRrfrVGAn3YWSSrKy3Nz3G7pMEs0idSjVO2BC50bYQzXi63uBLA==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr36999170wrx.40.1630484089188;
        Wed, 01 Sep 2021 01:14:49 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:dc57:bccf:6106:11d1? ([2001:861:44c0:66c0:dc57:bccf:6106:11d1])
        by smtp.gmail.com with ESMTPSA id t7sm22625455wrq.90.2021.09.01.01.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:14:48 -0700 (PDT)
Subject: Re: [PATCH] media: meson: ge2d: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210901055154.6829-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <afd73707-2bbd-611a-2498-df8c7f109275@baylibre.com>
Date:   Wed, 1 Sep 2021 10:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901055154.6829-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 07:51, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/media/platform/meson/ge2d/ge2d.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/meson/ge2d/ge2d.c b/drivers/media/platform/meson/ge2d/ge2d.c
> index 9b1e973e78da..ccda18e5a377 100644
> --- a/drivers/media/platform/meson/ge2d/ge2d.c
> +++ b/drivers/media/platform/meson/ge2d/ge2d.c
> @@ -922,7 +922,6 @@ static int ge2d_probe(struct platform_device *pdev)
>  	struct reset_control *rst;
>  	struct video_device *vfd;
>  	struct meson_ge2d *ge2d;
> -	struct resource *res;
>  	void __iomem *regs;
>  	int ret = 0;
>  	int irq;
> @@ -937,8 +936,7 @@ static int ge2d_probe(struct platform_device *pdev)
>  	ge2d->dev = &pdev->dev;
>  	mutex_init(&ge2d->mutex);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	regs = devm_ioremap_resource(ge2d->dev, res);
> +	regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
