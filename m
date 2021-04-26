Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8EE36ACC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhDZHQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhDZHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:16:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1A0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:15:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n127so17536762wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dnRv0hx7T2iwOT1O1w9fhtRjWFNst0K+ucU5RxAsI0U=;
        b=CeWnh2LbEWabetknFejFcJIDf/OyIRMgwnzJCibLEdA1mrBHcwD038VvBwEracDC51
         w0glPFhn1dzvGTfnN3mljzyH21L96E1IsG8FGzbhjIbX1GXvTosJfgV8soIucfRPICpY
         /nFpBXhCrev0R+4N2L0J7KMxVSs/TcAS5cxM6KpAwk0873GVyEgx7Ht9dX7w2h1NbzVJ
         R9xn+EO6b6o2UCGWzEpH/LHlymsMNiC7cZGwfYVw5iaKV+AepgSgff2rkjuuaadiDwBa
         EEUXkUOW6MPJRk2OZCKo6cZJqo582rV1RCENBv6JXQUQvLTbNeE18QVubrltWB6B97zC
         O+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dnRv0hx7T2iwOT1O1w9fhtRjWFNst0K+ucU5RxAsI0U=;
        b=G7Wt4qQa1HA2sfa0EjC7cX5iwHHaMOqC+4hI3YIG5i2pwz9lPM0HtzqaFfNFeHf8s0
         hq8MGnrehaSJ/AAD8E8b4r4OhF/iYKGN5gW2YWBx+eN1MO7/3OGAb8Iz4grBTfFiRtMa
         Ca8SHZHUBIw+cosj/8yaz5496WSNumoLZBbVhJItQsDtHBC9zHCgRVa6QGA3EbSpxDBt
         01CZ+SpiXJT3kWwG1WzyOBt5WdkixSBf/A6JGiYTLgKV4/IMomN6C2I8q5u8x2U7pfDi
         ShlDdSKMaEi+mC5zGsm6q6MxcdEs8RbF1M46G80GWHuyQOHFTKQ//5RfArkOGAYjUWfs
         K1ng==
X-Gm-Message-State: AOAM530HmzwHZojzlZxVx2cFy2Bn5Op/3wSoNhpmwhCIu809DKIuTyIw
        ZF/CxsyLGmkAE7D2+acPkQA9pA==
X-Google-Smtp-Source: ABdhPJw+LljXF/i5dij4rTrhjsbP0UeJSjI2KzKG7Mv+o6cUOME7Jt3lZXQa5cQ0yRYx1HRY999q4g==
X-Received: by 2002:a05:600c:b4b:: with SMTP id k11mr20089414wmr.129.1619421319330;
        Mon, 26 Apr 2021 00:15:19 -0700 (PDT)
Received: from Armstrongs-MacBook-Pro.local ([2a01:e0a:90c:e290:9d7d:4b49:ce60:a152])
        by smtp.gmail.com with ESMTPSA id q128sm4566253wma.39.2021.04.26.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 00:15:18 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge: add missing word in Analogix help text
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Torsten Duwe <duwe@suse.de>, Maxime Ripard <maxime@cerno.tech>
References: <20210424061817.7339-1-rdunlap@infradead.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <ecbe576f-1a96-a873-3716-6fa478a8269e@baylibre.com>
Date:   Mon, 26 Apr 2021 09:15:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210424061817.7339-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/04/2021 à 08:18, Randy Dunlap a écrit :
> Insert a missing word "power" in Kconfig help text.
> 
> Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Icenowy Zheng <icenowy@aosc.io>
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Torsten Duwe <duwe@suse.de>
> Cc: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210423.orig/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ linux-next-20210423/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -6,7 +6,7 @@ config DRM_ANALOGIX_ANX6345
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C
>  	help
> -	  ANX6345 is an ultra-low Full-HD DisplayPort/eDP
> +	  ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
>  	  transmitter designed for portable devices. The
>  	  ANX6345 transforms the LVTTL RGB output of an
>  	  application processor to eDP or DisplayPort.
> 

Reviewed-by: Neil Armstrong <narmstrongt@baylibre.com>
