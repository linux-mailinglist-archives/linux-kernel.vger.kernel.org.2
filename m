Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA173475EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhCXKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCXKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:22:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFCC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:22:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 14so622239wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ReYdg+qOxyzg7pfDHNN8JwOdhx/QxafMQjTjNtrXa8I=;
        b=fYqP4nrTK5V2tRC3ApY9z0UO8DcbwSs1H48dvXtuu0+ws3W8rcW7Wmorwzqb8haIBS
         Q5QNx9pIwkBWvtRzdvomARtKXwDRqOMZrU8sliEIRMeQk6T42odgrdjEC0fNs4XL844t
         Xft8F0ZGQTGRxKSIRO2C7zvr1hnFkfKDr6/c2T9NxUinnlfTuDGWoSiAaVXq6+o9/ZSX
         sD+2NBO/iOGnPDdM6/3KsupAV9qLP1PMaHHNWGArQCPA7sDHTaKYYNMbImt5B05Z94w+
         sZ6dHiGLa6oaQ3gWSFFOMSEFpRCrbWNWOTAMWrPbr+rpjitN5CnfKGFpg2yy3PxqGr+b
         F1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ReYdg+qOxyzg7pfDHNN8JwOdhx/QxafMQjTjNtrXa8I=;
        b=S9U+bjd/n7Mnww6o66tGwQwu9nCCJ117uyoN86/5lGdI0Opk73YmQxMwer09f7rjQE
         n4MIcnXV/Tt6dXXUcBbL1613IuIvUlNr+mwmzW9CGGxMfy2S4bJw3Vdyu0iuvjE0102V
         H2jolTVf7nIH+OzL40PKLvD8KORRKiDmHJBkPz767LZSczOpNzIuCrn1PsY3XK2bs1Yj
         aJupDcHaBIAMqFiSDFkPylnq9yuEzBJp7BuWqqUP3qpaZfaGVNxk4DkA7628FKphyjUI
         bpHR4G6b4RQUwNOr1xDyuTZwVVp0ksndvZ4iCk4fPI+/kZXhZ6MqyDKApO5Tsq7bASHc
         csJA==
X-Gm-Message-State: AOAM533jqUJZRH15W4WYziDeQxjH7EOCAVtEPfxTx+8rIbl7WgmlUTVk
        wxu5Gw9Ozt5WbUUikbroSDnczw==
X-Google-Smtp-Source: ABdhPJzUWAa2c6ks9s1E371QpDg5Le+5aHbahskQq8WdE1l/jSG3ic1jWi3CqJeZeIbfyCGvcYWh2A==
X-Received: by 2002:adf:a302:: with SMTP id c2mr2669695wrb.212.1616581375257;
        Wed, 24 Mar 2021 03:22:55 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:16a8:fbd2:45bb:a5b7? ([2a01:e0a:90c:e290:16a8:fbd2:45bb:a5b7])
        by smtp.gmail.com with ESMTPSA id x23sm1790457wmi.33.2021.03.24.03.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 03:22:54 -0700 (PDT)
Subject: Re: [PATCH v1] MAINTAINERS: Update Maintainers of DRM Bridge Drivers
To:     Robert Foss <robert.foss@linaro.org>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20210324102019.1251744-1-robert.foss@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <28a7ebe7-d54d-b36e-f093-89d57b15300f@baylibre.com>
Date:   Wed, 24 Mar 2021 11:22:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324102019.1251744-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On 24/03/2021 11:20, Robert Foss wrote:
> Add myself as co-maintainer of DRM Bridge Drivers. Repository
> commit access has already been granted.
> 
> https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/338
> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

+ CC: dri-devel@lists.freedesktop.org

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b705ba51c54..16ace8f58649 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5902,6 +5902,7 @@ F:	drivers/gpu/drm/atmel-hlcdc/
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Andrzej Hajda <a.hajda@samsung.com>
>  M:	Neil Armstrong <narmstrong@baylibre.com>
> +M:	Robert Foss <robert.foss@linaro.org>
>  R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>  R:	Jonas Karlman <jonas@kwiboo.se>
>  R:	Jernej Skrabec <jernej.skrabec@siol.net>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Welcome to the team, help is needed !

Neil
