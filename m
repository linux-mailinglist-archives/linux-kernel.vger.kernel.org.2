Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03A36C7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhD0OT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhD0OTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:19:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA489C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:18:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so6495090wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z65TRtvxCHj7BauNi/chiq/yTCGlMnhafcBJVuv+uvc=;
        b=1JgQ6T8J5+DCIbKLYSb8X8pE6seOMZEzq7vwu9CDfatcw03IrdCxdpz2PUJFQHyVMA
         7aa//0VYhnb7ywY9TAUA+tm8ifFNcmCFp/xSU+VYV+m+OCZAsICOwiq9S23qeZOBzXZS
         zk1PU0t1LILKQNoMB//PlHqoB1GjsJU9D9spUoidCKxRtxFFwK5yRpKF2laM58dsJzSj
         Z8c+7LZ/GPKg3b4yJUgwsGQUmBxjr50KIX4ulSksWOt5Y7j3W8DZFdrxgi3JNNtqEAsa
         8BBv/93KQFvm5JJO+hJzzzVCFpxh/VA45XuuLlKz1Zo/Mz2t90zXt2p7mQUJIejikdsF
         LbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z65TRtvxCHj7BauNi/chiq/yTCGlMnhafcBJVuv+uvc=;
        b=bMvzEjLMutk3HTAH7GhuFSm2Z5/w5mNF3VX4/N6J4ERGh8ilWMCMYyV6VXYfuW5mhC
         wY4lV3E4/49WBRQKixyV5q5FcH9Y7nHXJO1ypcsAaVcHYV6Dj6dqlTO1Rfmfwd+136wE
         QF+peSRHZ1CzT7ksXGjUTRXmk9irmevzPfwqBc6LpRlscDKFdCOd14TEerfbOntJsb15
         Z57TueAXVjwrRPm0j4oiB70pKVNJuxMCHfuipFJnN2LSVfrPcEtD2epcRflBnXI3CLJM
         FoCYVcxyPZlNfagVfIviVfCIdVAy/17lhAhCivfw7pnVX8zK2VxLoB8AABsYG1rVRlsX
         KW1g==
X-Gm-Message-State: AOAM530Bm0aNg05f06Y9YZdX9uz9TeNS3I4QCoT4LQ6DHvotY033gjhS
        xsCuAFODGxwu4NvsD6fjpLdnX4KNemhopJKv
X-Google-Smtp-Source: ABdhPJxW+s/+TqK1U8f2ctaKezCda71MRK+oQxfwwiUVSdcChPpFQBSja3Rf9omQgoYxR0v9W0FerQ==
X-Received: by 2002:adf:f701:: with SMTP id r1mr16679257wrp.67.1619533116962;
        Tue, 27 Apr 2021 07:18:36 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2338:91ec:bf8:872b? ([2a01:e0a:90c:e290:2338:91ec:bf8:872b])
        by smtp.gmail.com with ESMTPSA id b14sm4365490wrf.75.2021.04.27.07.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:18:36 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: anx7625: Fix power on delay
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210427055320.32404-1-hsinyi@chromium.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <c1472ba7-f416-f1aa-38d3-f2a4e7694903@baylibre.com>
Date:   Tue, 27 Apr 2021 16:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210427055320.32404-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2021 07:53, Hsin-Yi Wang wrote:
> From anx7625 spec, the delay between powering on power supplies and gpio
> should be larger than 10ms.
> 
> Fixes: 6c744983004e ("drm/bridge: anx7625: disable regulators when power off")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 23283ba0c4f9..0a8db745cfd5 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -893,7 +893,7 @@ static void anx7625_power_on(struct anx7625_data *ctx)
>  		usleep_range(2000, 2100);
>  	}
>  
> -	usleep_range(4000, 4100);
> +	usleep_range(10000, 11000);
>  
>  	/* Power on pin enable */
>  	gpiod_set_value(ctx->pdata.gpio_p_on, 1);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
