Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0211A38273F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhEQIoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhEQIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:43:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D522C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:42:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k5-20020a05600c4785b0290174b7945d7eso2657814wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXxaT8nwWGbSA3y71Sv2dFK7xUB5sHLPcIFAVGVS5/o=;
        b=xKt2I5INi0ltOoKuJqoyxEaSp+X9Itm/nppkVkA2uNvGcJa98/ZsMPQOTzXP5a6xkX
         sDR5uJyjuz4zrQOplIHLLKDvMlBMuLeKCJBY3xwwRiW1G1tp3NRY9T8l+yVvWZLp+nAp
         hQaZhGEQmfOyHbztaPk+bf/zWzu2tEt/gZwVl1UeOEjcKg+z/rLbugGdcrvFMj5srlXu
         cfgXToN4KCjFtiWgHamsSc0oVVmQ/ualErnm2+xuwiJLq9MM73zYtmxpJnUi7CW1NU0S
         t6m1ESXgfDzjx/VS3YurE6B8Q5kWMIsd9CufeAhKcn4OQnt7CcQD7nJzv4xggGCHDm+h
         yZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zXxaT8nwWGbSA3y71Sv2dFK7xUB5sHLPcIFAVGVS5/o=;
        b=i5z6YYfdJIrFFG5W+6LmnMZr1gpOugxkba4C3uVLnrpISkbj2AekHiF5mzCGIlkzlS
         FjmbP42TNny6+86jWYEPasjtLJu1vOtOGSs6O+bq8I6dKQYzyrX29w8T1ftd6rrTrKxO
         1Xia895gkoIAboeg5/q3OD0QyHHOF7E1nu3B/n0sgKWwhIsHyaZsQa8WVU/XN2Q7HE88
         lkKUGcpXMxlVbTC5weH/mkiYX6uWUhrj3PeLTo6wtl6g+jWgnSHX4AMr0em9YvTUeQl7
         WEwh8zXzLrjGtste4dH1voDoofhj67m3wSf8TTMFkSqHJPLckBr0Q9Lx5t3Z+yv6ubVw
         xCBw==
X-Gm-Message-State: AOAM532ubToqCNUegLOe9D1Vi/OAN0tjV0XnqdXiJ+sMH9qcLf5DJECI
        YkSqr18X1cK9uWcI9UigentpYOebgA0XdU3R
X-Google-Smtp-Source: ABdhPJxnfbUUFBq8SHWIEOb1yzYUGtz36OYX9EnYlPiOSVu236fyQ9xAjk6p3KB12c/i/XwvElJEXA==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr22409712wmq.133.1621240960771;
        Mon, 17 May 2021 01:42:40 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:3044:ffc:eaa9:6a70? ([2a01:e0a:90c:e290:3044:ffc:eaa9:6a70])
        by smtp.gmail.com with ESMTPSA id 6sm15759027wry.60.2021.05.17.01.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 01:42:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm: bridge: it66121: fix an error code in
 it66121_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Phong LE <ple@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YJ+ZX3BdKPAN0pUZ@mwanda>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <638a3344-3222-87a1-d500-0d49960088a1@baylibre.com>
Date:   Mon, 17 May 2021 10:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJ+ZX3BdKPAN0pUZ@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2021 11:50, Dan Carpenter wrote:
> This code is passing the wrong variable to PTR_ERR() so it doesn't
> return the correct error code.
> 
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index d8a60691fd32..6980c9801d0d 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -943,7 +943,7 @@ static int it66121_probe(struct i2c_client *client,
>  	ctx->regmap = devm_regmap_init_i2c(client, &it66121_regmap_config);
>  	if (IS_ERR(ctx->regmap)) {
>  		ite66121_power_off(ctx);
> -		return PTR_ERR(ctx);
> +		return PTR_ERR(ctx->regmap);
>  	}
>  
>  	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
> 

Thanks !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applying to drm-misc-fixes
