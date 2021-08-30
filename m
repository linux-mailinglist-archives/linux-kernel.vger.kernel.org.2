Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D513FB350
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhH3Jlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhH3Jlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:41:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:40:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so14227827wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mwnp8lXqAWtY97H6jhxlOc6+33xl4IxpqyfeHtfhl08=;
        b=vadNIG9LW9KJMecoyYHe64z3dQEzghEwqX7Qz5fr2vv9R1MHOeXphCsXvUX3iIIdw3
         WzN6nr5sIb9Zsh9UZu3WhstfPwkQfouiW1vSY2TaMIpXsF37e8koOTRwqTTL9ebWdL8D
         ES8SqghaLOLIlZfoUEfMr+5EgvqTddUfMDr5UeoAU24svPGpTbawKB0C5dGBe13RDPuk
         o+kATH1urtQjdKcLMFUR6+z9Op7k0IgohCPAFk6kl7lOZXeb62n39zweJhzl/3xLDF+y
         DWtLanOyCiRP6/5y5+uDrNScTQ4q1oWex3f78vW8Iv0MNqCQtVPaYVW3yNoJpaZ0CQit
         5EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mwnp8lXqAWtY97H6jhxlOc6+33xl4IxpqyfeHtfhl08=;
        b=hgmRzdLP1XaTKm786schXkYY+mTHf0F9IcYhf28UNSES2DAzvkP1s70bMw2ndRvqf0
         esM0RYV3kgCfrLbt+zej0EBjphoyu0CiSxynxB2YwuMapn6aPb9XKeTPyi2MHRrCj7GB
         yeIV/R87NyAd1g5tae45vckEhLccOpJo7ExgS1wdUNfKVgf4Je9M7ZcnEB1NA7QN30XM
         no+xCz2ze6GtEYkMws4RSsSIZQtlkP12ZbSnEPOKKFsfvPAEnuaLvk2CWYLLY1b8MV4a
         9Hl6K1wHNP+OSOkuV0hikVqD6Uj+JuAoxb010PG6VWBz2ugtEPKHxNHq+XHwKfEg5nno
         jFrQ==
X-Gm-Message-State: AOAM530t9HtHyDMuuBK/tb6BSzazqkOxa9k+Bz4/GifEN/ouP6oHbHNZ
        yLho/qDwprnwP93Jkuhb3AZLBQkQSkbQV/zv
X-Google-Smtp-Source: ABdhPJw0Pm1y56ZsUyxznbuyUlcjOAhBeLtCCFpnNpO3OE5O6Vwu/rMwOu2t0V3Qva7IpNzA4DwFzg==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr21326234wml.62.1630316454041;
        Mon, 30 Aug 2021 02:40:54 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:2ecd:4eac:486d:7a1? ([2001:861:44c0:66c0:2ecd:4eac:486d:7a1])
        by smtp.gmail.com with ESMTPSA id k25sm15789822wrd.42.2021.08.30.02.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 02:40:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/bridge: it66121: Wait for next bridge to be
 probed
To:     Paul Cercueil <paul@crapouillou.net>, Phong LE <ple@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, list@opendingux.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210827163956.27517-1-paul@crapouillou.net>
 <20210827163956.27517-2-paul@crapouillou.net>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <c0d7aae8-5324-44b8-c412-8a6ed3bb3729@baylibre.com>
Date:   Mon, 30 Aug 2021 11:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827163956.27517-2-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2021 18:39, Paul Cercueil wrote:
> If run before the next bridge is initialized, of_drm_find_bridge() will
> give us a NULL pointer.
> 
> If that's the case, return -EPROBE_DEFER; we may have more luck next
> time.
> 

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index b130d01147c6..9dc41a7b9136 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -924,6 +924,9 @@ static int it66121_probe(struct i2c_client *client,
>  	ctx->next_bridge = of_drm_find_bridge(ep);
>  	of_node_put(ep);
>  
> +	if (!ctx->next_bridge)
> +		return -EPROBE_DEFER;
> +
>  	i2c_set_clientdata(client, ctx);
>  	mutex_init(&ctx->lock);
>  
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
