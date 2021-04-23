Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976F93694E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbhDWOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhDWOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:39:35 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:38:58 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c84-20020a4a4f570000b02901e9af00ac1bso4510930oob.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j7H66Q86PkqXddsGRSzDhW4KjXrdQxkyswMmMQ3oN5g=;
        b=mlD/Ib2JrhwFrgExe+x3hpDMlp3RSrHYB2tNVu80feRxTbqvMd2QpOlutN+Rvkuj+T
         jBH8i54eqXVT66gSXFoYtUnLqdwYCLUUJQFjkS4kt8REhBbXQWZcBYxwpoyMfx1yNMNo
         M913qVUpb3psQIYYSm6wx7eqSNIv080KznTJ0cIbr4jzW3P+2pTq49VJAqtFwpFB6idM
         Qv4uBcCraytQe0aAXGWs4XVIS5ufcxmo8HxWNQU2rX/v1bQ3TvRsrDyL+PAeheN7A7ib
         EV6NHRAjFz+0xzRqDpi9cLCKAbRRcj4ZrC69Zw/jTNcUD3ij2d5xAHXhHo7YrKZxZYBm
         du+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7H66Q86PkqXddsGRSzDhW4KjXrdQxkyswMmMQ3oN5g=;
        b=PgCS2soQ4ie9h6uzMXzdzcohTXV6E+88EFQwJX3o60fRvGqo4fiuPH+8I7sUCQrgvk
         X5/juqoQUQfY1S17Rh+4VjrziBJxvwiAqxCasEhfIm3QW/efQpKdubDc9uJEnjkCHco1
         vkR8kZoTjbZgBqLejSxccuAkk3IPuzvjql1R5eKNCAI+hmf558aRWx531PayRft666Yn
         OMWaP7XDgCHXC/e3tVEzQarB9KqIUK6SbJFRV+9UJU+PxdiYZ2Uqt+g2mEhe+G+HF7ig
         ni+GaP/DhglgbKFGfZAmHchoGdcecQ0hhOtFEbo+qK9gjMA9EcDnzEvR1h0qoQxTsei1
         px6w==
X-Gm-Message-State: AOAM531J4WfidXf7GyJNj6b2WlmeLdSmv7WMQBleq9/BO8eFsvJ8I1bt
        0xpijSRbV9PtE+HycXrGz3xw/w==
X-Google-Smtp-Source: ABdhPJzZGbgXls4SipwM18uE0byctPAhPmlAZL5eg5eOD8s1W1zn+bjHr0I25Veo5FZM9qcw9Km5YQ==
X-Received: by 2002:a4a:765c:: with SMTP id w28mr3325562ooe.8.1619188737811;
        Fri, 23 Apr 2021 07:38:57 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q23sm1395627otc.7.2021.04.23.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:38:57 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:38:55 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/27] drm/bridge: ti-sn65dsi86: Cleanup managing of
 drvdata
Message-ID: <YILb/xBRWvJH7UAL@builder.lan>
References: <20210416223950.3586967-1-dianders@chromium.org>
 <20210416153909.v4.12.If5d4d4e22e97bebcd493b76765c1759527705620@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416153909.v4.12.If5d4d4e22e97bebcd493b76765c1759527705620@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Apr 17:39 CDT 2021, Douglas Anderson wrote:

> Let's:
> - Set the drvdata as soon as it's allocated. This just sets up a
>   pointer so there's no downside here.
> - Remove the useless call to i2c_set_clientdata() which is literally
>   the same thing as dev_set_drvdata().
> 
> No functional changes intended.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 2cbf619fbd27..a200e88fd006 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1238,6 +1238,8 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  	pdata = devm_kzalloc(dev, sizeof(struct ti_sn65dsi86), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
> +	dev_set_drvdata(dev, pdata);
> +	pdata->dev = dev;
>  
>  	pdata->regmap = devm_regmap_init_i2c(client,
>  					     &ti_sn65dsi86_regmap_config);
> @@ -1246,16 +1248,12 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  		return PTR_ERR(pdata->regmap);
>  	}
>  
> -	pdata->dev = dev;
> -
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &pdata->panel, NULL);
>  	if (ret) {
>  		DRM_ERROR("could not find any panel node\n");
>  		return ret;
>  	}
>  
> -	dev_set_drvdata(dev, pdata);
> -
>  	pdata->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>  	if (IS_ERR(pdata->enable_gpio)) {
>  		DRM_ERROR("failed to get enable gpio from DT\n");
> @@ -1287,8 +1285,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	i2c_set_clientdata(client, pdata);
> -
>  	pdata->aux.name = "ti-sn65dsi86-aux";
>  	pdata->aux.dev = dev;
>  	pdata->aux.transfer = ti_sn_aux_transfer;
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
