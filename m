Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDA3FC9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbhHaOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhHaOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:36:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06657C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:35:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so28070893wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4rZGwfZEIOrCqcjibED3N9c7CMYt/1s+laPidanJ9U=;
        b=yC/J2IkaFivBRU9NGiW59trje7d4yntYagBVo9vlQoNWteSJIXEi+XV1UN92LQXU6Y
         6X+b1KiPiOuE0hH9FDgslu7r9hvH7P1KkUXuKL+2BDJnLDMtlb7yZkAhciDqUppAOdx9
         cjcp2KWoXQIDBLLoadxkk9MFxIjtU2mFpVIX6OC6Lg1X2zAZFt1mItcD5/zuvAjBsbwq
         Xwrhr6/tGl5uf6t/ImCIhMMM0L9ucBr9VrsuIps+nHNZUa/DJPkvLzRtcXVn8b+XUT7K
         wox/1EqzDbBcObZAKMxZNbe6AC80atzRyp7evrBnWvdIx2ainMfCLIZ/b86bm9k0CO2P
         xrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t4rZGwfZEIOrCqcjibED3N9c7CMYt/1s+laPidanJ9U=;
        b=LnnOBwsrxbkQ7tM49LjBzU4pYMi+9EaaKDbNgR0ZshF2E/B50odopJvwlR4CFVU1QU
         XfrdNpAs/o2t8vpuwAWl2s6udGzY1JlUMD+57Qew2blBcY9pEHW8BIa2J4XQN1b7Bo+h
         ASHUqK/LBwrsu00Zml4U88s0FLRdGecLeVo7tqwhk3c9OOSgpQHr2xlbvZkYMvaxZhEq
         LkT8VgEYiDP2o//BJe2vzI98uG+JEvHGnRK1WDRMKdQ9JDV04EIBDLUG9f0ZUUj2g6Uj
         +Ja4R+x3Ztoq9/bPvFrZ+CBFfMTiWbUY8muTkmeFurzlG9Gm0KKhLn3RCuPOrrCZgZnT
         jf4g==
X-Gm-Message-State: AOAM530hN+BuxdI1j1bQ28Cl3BURxd8ZX7oylyDA6QmY+eTnybqDVUXn
        AtgFm3Z2PsvjHbMgycpG4zb5ywB4okcPyyWB
X-Google-Smtp-Source: ABdhPJz1pzwOW6HFn9CswPOaXqf3E3MWOvhHxsRINvTlHKrnGPthKiywMBDC/0mPhZNzBg8b+xY76g==
X-Received: by 2002:a5d:490d:: with SMTP id x13mr31431795wrq.412.1630420544859;
        Tue, 31 Aug 2021 07:35:44 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:fc41:6c:2c4e:2156? ([2001:861:44c0:66c0:fc41:6c:2c4e:2156])
        by smtp.gmail.com with ESMTPSA id c24sm18471493wrb.57.2021.08.31.07.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:35:44 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: Make use of the helper function
 devm_platform_ioremap_resourcexxx()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210831135644.4576-1-caihuoqing@baidu.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <896e4f35-f410-41e8-50ad-ed16c65cab45@baylibre.com>
Date:   Tue, 31 Aug 2021 16:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831135644.4576-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2021 15:56, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
> 
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c     | 3 +--
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index bc0d60df04ae..7f41a33592c8 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -206,8 +206,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	priv->compat = match->compat;
>  	priv->afbcd.ops = match->afbcd_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vpu");
> -	regs = devm_ioremap_resource(dev, res);
> +	regs = devm_platform_ioremap_resource_byname(pdev, "vpu");
>  	if (IS_ERR(regs)) {
>  		ret = PTR_ERR(regs);
>  		goto free_drm;
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 2ed87cfdd735..0afbd1e70bfc 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -978,7 +978,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  	struct dw_hdmi_plat_data *dw_plat_data;
>  	struct drm_bridge *next_bridge;
>  	struct drm_encoder *encoder;
> -	struct resource *res;
>  	int irq;
>  	int ret;
>  
> @@ -1042,8 +1041,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>  		return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	meson_dw_hdmi->hdmitx = devm_ioremap_resource(dev, res);
> +	meson_dw_hdmi->hdmitx = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(meson_dw_hdmi->hdmitx))
>  		return PTR_ERR(meson_dw_hdmi->hdmitx);
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
