Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8599A3C8B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbhGNSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239819AbhGNSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626288438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZAdf0GJIbLpyyVrXbwjxcRS9oM/2mE5p8d6as6VgdU=;
        b=a9BQmLfRtzP8ErEddIG1AUD0VJ2LVQE7R3DKjm/q6N1IZY3fqUMmIjZiU9KfpVuZ32+E/t
        pXLXbpxBfGPDR0PY6eKOEH7OZHfDkXc0DBlwhY/AICQGMCmNbN5Bo1c1j1j2Ud/DS2JTNn
        yqiO6VgLmPOKdsDhjQB1BUtrnWiJFGQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-GceU5Ge-OHWHUCrTf1uV2Q-1; Wed, 14 Jul 2021 14:47:16 -0400
X-MC-Unique: GceU5Ge-OHWHUCrTf1uV2Q-1
Received: by mail-qt1-f199.google.com with SMTP id j16-20020ac855100000b029025bf786be09so2468430qtq.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=1ZAdf0GJIbLpyyVrXbwjxcRS9oM/2mE5p8d6as6VgdU=;
        b=uDhjsThH3fuSCvF/m9POGF+FibQsWP+0VdGB0Qs5BhdB1MaFLrxu76p3xwuIICSFbJ
         koWG6KFVnVGqWGyN0WZwWy3NeVeC7/A8IjSBOlfnqs/5aKYxX0uwHf2R+z0D8XQw110d
         hCuVDFDXEHjEBW7WxfNNVEWoZkR1OgOhGh+1vGawh5WUMvYXnBZfzCOi5eKZfxbs+sUq
         WBKgJlsq3ruDVln+gJgMMQ7aBccRLl2uVQ9fDm/4OZtCr0eBpuWAJO3d8tx3I9ldpD2r
         zeK35VFQF9dNrQyxmhO27s4K/83KDk/U4F0YVMm+5mVd1AzAd1Bw2ut8j5MOa0pKebDD
         UdHA==
X-Gm-Message-State: AOAM531sy+kVoTnWzhuSldeJ/2TjMQrKaQPsnylesUBIgAD3WxwmPkya
        1TvgYpk5ikC5oSbNAyQ8Fc8sUPG4OKPPkqqTFjn/PcF9hF3aiZZzGoKiwYb87tvWAAOqC9Oh81Q
        fOLVOoeR/pjilUAd8cPZ2+f7G
X-Received: by 2002:a37:92c6:: with SMTP id u189mr11120309qkd.237.1626288436373;
        Wed, 14 Jul 2021 11:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyuPjo6u3d3oihQtSUPwjxpsOvapJdz8AnSL3MR4aGpMOemxXK7gfWNaVRhGG4ZtPhG0lJQg==
X-Received: by 2002:a37:92c6:: with SMTP id u189mr11120295qkd.237.1626288436230;
        Wed, 14 Jul 2021 11:47:16 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id d24sm1398962qkk.61.2021.07.14.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:15 -0700 (PDT)
Message-ID: <64687ac7602bfd44914ca5b31fe70bb8b87ef313.camel@redhat.com>
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
Date:   Wed, 14 Jul 2021 14:47:14 -0400
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

