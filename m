Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B036B01C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhDZJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:00:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:00:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n4-20020a05600c4f84b029013151278decso4651753wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wK4naeGRGIl4BeVrASMOqtpAgrHp/pNm7sHfLvwF54E=;
        b=PxPgVAAlZnvmzStiU1Z2deNohrwVw0X40mkVaV5Dq++W4KUpFPpjbJRe3083M7Ot+H
         lqshyPaVezPvFlcko9PPpEM044pqnQpU+E/CDNjsZgdrTXaQMxznBiJPMs11EU+ZRXHf
         OYogvGpLKSuQTfe9+y+cSxRXTHYk0kRxwDsWpUMTzInl31/ixU5KS6jBtCBHWyjPgVVC
         bgJg2foLb1QS1nkMelHIiHoeOJ2pAAXt6b6AjnVx7wnKyp2rg45F4dMnVo4K2SY69Zxk
         KErBSB7657iBNUe0wwQ8NrBl9Arwvg8BJV39MCQG6swugUV62CVtmSOppVmy8CTkYgVL
         ApOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wK4naeGRGIl4BeVrASMOqtpAgrHp/pNm7sHfLvwF54E=;
        b=IEnI2qO/BPVdI3WMr2DFpqlzLtYv3CWNaWZTtbUUV7AtDZY/v7OE5Tt4H9YQyOr9/3
         GmXpa3IA2humsa6aXsznI1r2y4awoMJtLKQSZqdaYTh/+F193hHD4YgSzLLhoZU+bT3p
         APDMhHvFRnPmo0LjwvwgNjw+kX4WmtRj3FQEVf8zlHYbzW53Fg4UsL4wuDsvtF2Nl7Mj
         63Vyw8SvOl4k3w4f4n6CtKSvwyIQRIGb8pNV3sRGk10NXPug/SQTJHHxpP0dLfmdJJgW
         8wsTZg2a6SxZR74EtCwLBp6bJ6tmsQ/W7dgZ9/E76E7WzOSAJkcIiV9oP0KxnrYVnW3z
         dSAQ==
X-Gm-Message-State: AOAM533ul0yuIAWCI94vbmBR4h7O5gOe7l4A26l1XfsCS4S5pTiwKyZ5
        U4qow7l23PKU3iWWYHYDDrYvmQ==
X-Google-Smtp-Source: ABdhPJxPh52ELMKYVm/zy7jHFJaZ7+FE2YzMfYoin2xOlvx6NK/M9aoy18apnORVu6H2+WHFd+k4UA==
X-Received: by 2002:a1c:1bd1:: with SMTP id b200mr7437687wmb.3.1619427598897;
        Mon, 26 Apr 2021 01:59:58 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b76e:7362:77c0:ddc3? ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id h10sm19945297wrt.40.2021.04.26.01.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 01:59:58 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge: add missing word in Analogix help text
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Torsten Duwe <duwe@suse.de>, Maxime Ripard <maxime@cerno.tech>
References: <20210424061817.7339-1-rdunlap@infradead.org>
 <ecbe576f-1a96-a873-3716-6fa478a8269e@baylibre.com>
 <CAG3jFyv1kc3+B6SkVwdV7gNV+HUEWMAjmH8GSXaw8rDcHLadeQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <481c3f44-1686-2c58-29fa-c71fec520ba7@baylibre.com>
Date:   Mon, 26 Apr 2021 10:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAG3jFyv1kc3+B6SkVwdV7gNV+HUEWMAjmH8GSXaw8rDcHLadeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2021 09:42, Robert Foss wrote:
> 
> 
> On Mon, Apr 26, 2021, 09:15 Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>> wrote:
> 
> 
> 
>     Le 24/04/2021 à 08:18, Randy Dunlap a écrit :
>     > Insert a missing word "power" in Kconfig help text.
>     >
>     > Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
>     > Signed-off-by: Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>>
>     > Cc: Andrzej Hajda <a.hajda@samsung.com <mailto:a.hajda@samsung.com>>
>     > Cc: Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>>
>     > Cc: Robert Foss <robert.foss@linaro.org <mailto:robert.foss@linaro.org>>
>     > Cc: David Airlie <airlied@linux.ie <mailto:airlied@linux.ie>>
>     > Cc: Daniel Vetter <daniel@ffwll.ch <mailto:daniel@ffwll.ch>>
>     > Cc: dri-devel@lists.freedesktop.org <mailto:dri-devel@lists.freedesktop.org>
>     > Cc: Icenowy Zheng <icenowy@aosc.io <mailto:icenowy@aosc.io>>
>     > Cc: Vasily Khoruzhick <anarsoul@gmail.com <mailto:anarsoul@gmail.com>>
>     > Cc: Torsten Duwe <duwe@suse.de <mailto:duwe@suse.de>>
>     > Cc: Maxime Ripard <maxime@cerno.tech>
>     > ---
>     >  drivers/gpu/drm/bridge/analogix/Kconfig |    2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > --- linux-next-20210423.orig/drivers/gpu/drm/bridge/analogix/Kconfig
>     > +++ linux-next-20210423/drivers/gpu/drm/bridge/analogix/Kconfig
>     > @@ -6,7 +6,7 @@ config DRM_ANALOGIX_ANX6345
>     >       select DRM_KMS_HELPER
>     >       select REGMAP_I2C
>     >       help
>     > -       ANX6345 is an ultra-low Full-HD DisplayPort/eDP
>     > +       ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
>     >         transmitter designed for portable devices. The
>     >         ANX6345 transforms the LVTTL RGB output of an
>     >         application processor to eDP or DisplayPort.
>     >
> 
>     Reviewed-by: Neil Armstrong <narmstrongt@baylibre.com <mailto:narmstrongt@baylibre.com>>
> 
> 
> I think a typo in the email snuck in ;)
> 

Ah ah indeed !

Reviewed-by: Neil Armstrong <narmstrongt@baylibre.com>
