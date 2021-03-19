Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232C334189F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCSJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCSJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:41:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:41:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso6930994wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dE/FMXXwTOcZLfKWiTm5qvJwQlSCibf7/ZnsQ3VuA+I=;
        b=cUvirTqY+bHdROH4xdfpGMrp7CwT1frnVIdSmYUtaWWWWj954Z8j45z71527sO+KrZ
         5WQkEOopheMKChAfrdE9h32SdNhfHFZO0zKs7NPsr2x5b5XK3DrR2cl0OZjZkpcwRPCD
         uyUg6tjYCdewlJ2318NC43fksCK75iQU6y4nAXvkOYfja309Ndyn/kcx+rSunDpADNqj
         7xGGjSPrCOPoP26K9qEQsLNvHBw5r4DrHb1BWvR97GcN4NcnYd3Zs5FrtkbZG8d9W1Nn
         R6AJBNeFdMZFJle8Ob1eyXT4ONSp1qP/ZoB9f8urGPwzK+mHzxAUFh4idR4bZzsc2sq8
         3sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dE/FMXXwTOcZLfKWiTm5qvJwQlSCibf7/ZnsQ3VuA+I=;
        b=rbvkPq/gyz58xCSOTFHF7hyMXBP3NwQDKqNlaDj8Wntc9xepbo+WY0XOI6XjuzXkvK
         3uY2O72YKBQGcPvIZ0B4AH4J70y7KNGfcZRnkAox6qd3Gt/FtUn13eYo2NiW4BBrwXjm
         0WvTeWCu5jQPxPh3c7pzgdEjvbHjcCrfxZG5Zo3RocrwepfZh09fXN0/cAG1fbQkeRjb
         7t7C8fn/VnIo0xkBl5JcbsDNtky3AlaQJZObBHYCfqVafF9oLyyj751u7TmjgJYPPkwQ
         jefvDaYCaCCdYVjriTcv7kN88aNvPBoy00dMqNiQOC7uA94towQzFX145sFYuyvg3224
         EBqQ==
X-Gm-Message-State: AOAM530D3a4Ux/OD3gjuQbWTPideBY59a3pU1A790BpfD+kwvt0ep5tr
        wMookU3ZaMw0qF6plQxiuJAM/w==
X-Google-Smtp-Source: ABdhPJyhmKqPRcT1Q2L0MAxywvHaux8gt0MC/4MXTIbjMyfjntyMA+cOtPLJ+giH8rEkY7Tb8COX6Q==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr2803941wmh.56.1616146877840;
        Fri, 19 Mar 2021 02:41:17 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:62a:14da:7a4b:4aee? ([2a01:e0a:90c:e290:62a:14da:7a4b:4aee])
        by smtp.gmail.com with ESMTPSA id m17sm7082516wrx.92.2021.03.19.02.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 02:41:17 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: Fix few typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210318110046.14830-1-unixbhaskar@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <fd1f66c1-b1ca-bfd2-8a04-64a9b7af4e3c@baylibre.com>
Date:   Fri, 19 Mar 2021 10:41:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318110046.14830-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2021 12:00, Bhaskar Chowdhury wrote:
> 
> s/initialy/initially/
> s/desined/designed/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 5e2236ec189f..3c55ed003359 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -45,7 +45,7 @@
>   * The ENCI is designed for PAl or NTSC encoding and can go through the VDAC
>   * directly for CVBS encoding or through the ENCI_DVI encoder for HDMI.
>   * The ENCP is designed for Progressive encoding but can also generate
> - * 1080i interlaced pixels, and was initialy desined to encode pixels for
> + * 1080i interlaced pixels, and was initially designed to encode pixels for
>   * VDAC to output RGB ou YUV analog outputs.
>   * It's output is only used through the ENCP_DVI encoder for HDMI.
>   * The ENCL LVDS encoder is not implemented.
> --
> 2.26.2
> 

Thanks,
Applied to drm-misc-next

Neil
