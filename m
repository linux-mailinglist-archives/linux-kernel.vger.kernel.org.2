Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB943C8B25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhGNSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 14:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhGNSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626288310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZAdf0GJIbLpyyVrXbwjxcRS9oM/2mE5p8d6as6VgdU=;
        b=Y4225D4M+yn1TxmDXHNDZzkXBmrB5iYZXO/hrkJ3YXZQGRHuV/OmdE687KB0NHpiJCpgMm
        3I5VAsAyOCc6d1XnhjEtSwSqbh272DQ4Y0GfWaGnFCcRNxJJ0RlFif9lOqtj9w7vBdwcAK
        6wONMuIdtE/X9q3NFaJL4+Ytxs78DBg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Aup0fPhsM7uyW4wZPLJMmQ-1; Wed, 14 Jul 2021 14:45:09 -0400
X-MC-Unique: Aup0fPhsM7uyW4wZPLJMmQ-1
Received: by mail-qt1-f197.google.com with SMTP id p20-20020a05622a0494b029024f09fe9ec9so2516736qtx.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 11:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=1ZAdf0GJIbLpyyVrXbwjxcRS9oM/2mE5p8d6as6VgdU=;
        b=PDL7bhB//dzPP9RhBUyWolBGNCi/GLW/8I0JxMf/+9W6CzIRrOo2ZSn6+X5RnvCnNE
         LJUkhlNfpLRd4jk78zNmIUGNPnPm6eK7hOrHvxZ5m779oahZck6tLSMFLgv6fHqW6OHJ
         a3poAvkrnWinMMFJ9dTSHXzQBXIIqsqF8zGOFaMJS9pgElW2TH/+G/fwFmjIkMYRjPdc
         EaIHcOPQRaZoIjf3s02ec0bLLTav0dmMpnJBrT6Y1PBqAEQeDLL2Xe42FfuPC9Yo/RdK
         uAnhteTgZi73iCHityftOwgRwcJuhX+cR7W1PeG+Mxd6JvPbfY1J0jz9buiIJXbbpWMS
         pbMw==
X-Gm-Message-State: AOAM531kWaMmlJFTk2J4hHIIadvAfKEEhiKtfbiuTQJNCcGf7AGMxx41
        ShSFaNQEvu35ADw1eor8Sw8PJbWhUnVqr+Vr88xYJCgORG8pdU3cHwwBR6OKzZLF7PfMT0EMJvu
        JryMWeH3KyJwCeUx3Ea7ZuVWx
X-Received: by 2002:a05:620a:31aa:: with SMTP id bi42mr11236395qkb.425.1626288308708;
        Wed, 14 Jul 2021 11:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk7kMcvMar0jLNDySN2hM8tTHtPUpoD6ejpE/O4waO1AawEFynsB5XM12PtGqCXW7BIy7C9w==
X-Received: by 2002:a05:620a:31aa:: with SMTP id bi42mr11236374qkb.425.1626288308567;
        Wed, 14 Jul 2021 11:45:08 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j3sm1354331qka.96.2021.07.14.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:45:08 -0700 (PDT)
Message-ID: <281cfad8220d37683ac433f583e37f5f2667aedd.camel@redhat.com>
Subject: Re: [PATCH] drm/dp: For drm_panel_dp_aux_backlight(), init
 backlight as disabled
From:   Lyude Paul <lyude@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Rajeev Nandan <rajeevny@codeaurora.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Jul 2021 14:45:06 -0400
In-Reply-To: <20210714101744.1.Ifc22696b27930749915e383f0108b7bcdc015a6e@changeid>
References: <20210714101744.1.Ifc22696b27930749915e383f0108b7bcdc015a6e@changeid>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-07-14 at 10:17 -0700, Douglas Anderson wrote:
> Even after the DP AUX backlight on my board worked OK after applying
> the patch ("drm/panel-simple: Power the panel when probing DP AUX
> backlight") [1], I still noticed some strange timeouts being reported
> by ti_sn_aux_transfer(). Digging, I realized the problem was this:
> * Even though `enabled` in `struct dp_aux_backlight` was false, the
>   base backlight structure (`base` in that structure) thought that the
>   backlight was powered on.
> * If userspace wrote to sysfs in this state then we'd try to enable
>   the backlight.
> * Unfortunatley, enabling the backlight didn't work because the panel
>   itself wasn't powered.
> 
> We can only use the backlight if the panel is on and the panel is not
> officially on when we probe (it's temporarily just on enough for us to
> talk to it).
> 
> The important thing we want here is to get `BL_CORE_FBBLANK` set since
> userspace can't mess with that. This will keep us disabled until
> drm_panel enables us, which means that the panel is enabled
> first. Ideally we'd just set this in our `props` before calling
> devm_backlight_device_register() but the comments in the header file
> are pretty explicit that we're not supposed to much with the `state`
> ourselves. Because of this, there may be a small window where the
> backlight device is registered and someone could try to tweak with the
> backlight. This isn't likely to happen and even if it did, I don't
> believe this causes any huge problem.
> 
> [1]
> https://lore.kernel.org/lkml/20210714093334.1.Idb41f87e5abae4aee0705db7458b0097fc50e7ab@changeid/
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/drm_dp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c
> b/drivers/gpu/drm/drm_dp_helper.c
> index e8eec20ab364..b5f75ca05774 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -3568,6 +3568,8 @@ int drm_panel_dp_aux_backlight(struct drm_panel
> *panel, struct drm_dp_aux *aux)
>         if (IS_ERR(bl->base))
>                 return PTR_ERR(bl->base);
>  
> +       backlight_disable(bl->base);
> +
>         panel->backlight = bl->base;
>  
>         return 0;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

