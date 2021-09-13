Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759194085EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhIMIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhIMIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:00:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE3C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:59:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so13163569wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Slbdck4Oox3BuAWU/xoGeuvQr4K3e0JpfLAX1oLndyY=;
        b=TV5CbZddrBKX78P7nI2kjJ2q2ioIuhK43xq0rydDNWRPh1Rjbr2WHKlwq6gpB//woi
         HGSjYbGL4u3wwBMN2D8J4FFbWmDrwi0sryOQHhTqydUZ9xfGnEOfUPOzUz+9hgLr/rUV
         WnemKQBkXLQQYpTkrMFJztckAXbVlCiJqjxFCnuCBzLvPZ/rmhZKCbPme+B6b6iC06G7
         LSTuoNj9RD/+UuNvZB3B+oYC5XzcsipRnf7awdmBPsvyZ5fcAzA18T0Q4PZSgF/XoY3g
         jEVnXVce+uX0XXPSGN2ahWgPsBIS6AJGn7X4tLfJlRvQKTz7yZOlsj5lNGQEidDvH6mE
         iqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Slbdck4Oox3BuAWU/xoGeuvQr4K3e0JpfLAX1oLndyY=;
        b=tEEWRRCBklVeg7JxcjTDi9zBFAOsPS4q34kwHDYhy+hRTz/sAi7+UNuazPsP+QCpOn
         YE2k4do8hwwa1PIqlOK7EObXMFGg3iRjIZHG+s/vOLrEP8cNuc0vyxdrIf/4pCXzO8Vj
         LGbFDuHCXWTipCPuvXNr9nu/+1b10+fJNdNmCrc2rArsqUKh3azr16BS176vIR/cDCXS
         8yhZrH9wgzbQAcqC1qelA+TYy+e5SXfuANUPiUMwYIypBmmi8HVEDkl1+f0oYQmbv7UW
         WpwS1ajmauOI5GZdI4xTK7REH5H6EGY4LyKo4SSXoKuWdkNe9Tx6oEohL1AqYwjiL2Gs
         ECzg==
X-Gm-Message-State: AOAM530KXA+Y1qGZTJjb8FpaHqrb3VNB6KpHZN91yPvWlLgE+3762uo4
        qxFo2PT4DyjEJqZhjFTOhyp4MCE7hXPhuRZS
X-Google-Smtp-Source: ABdhPJzLylWQRDNBgfIjIiWs6WzrTIDLfdTUHuZk9A1smafDzalNo2zuhd1U5ya8RC0ug93NkAUJAA==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr11103227wrc.296.1631519959679;
        Mon, 13 Sep 2021 00:59:19 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:9ebe:26f1:5acc:c894? ([2001:861:44c0:66c0:9ebe:26f1:5acc:c894])
        by smtp.gmail.com with ESMTPSA id y24sm6989408wma.9.2021.09.13.00.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 00:59:18 -0700 (PDT)
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
Message-ID: <58b26fbf-b491-3290-0192-f10d2d8df092@baylibre.com>
Date:   Mon, 13 Sep 2021 09:59:20 +0200
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

Applied to drm-misc-next

Thanks,
Neil
