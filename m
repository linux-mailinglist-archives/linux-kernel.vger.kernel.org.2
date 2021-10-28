Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835D043E5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJ1QX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhJ1QXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635438088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srx/wR4Z0jpwx5qACmRHg2e/sdqCTiZM1D5VqWblfyo=;
        b=dj2qn2E2unqrXygiITKL4j0SUB2sExa+jmcUSklF5Jm08NqW1QLmOIzJxtDI5GLnqS1O3V
        I/iS1NuHs7zne4qnWRc6/LPPctMXa6BSuV+MBgHjhh5XVedsLq9yOFhz9bEH/gFZA4W7p3
        Cf35STqxX5/ufojJhj+07A6P4cETfJ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-6W7UUTqfONOhZbAUIh6t2g-1; Thu, 28 Oct 2021 12:21:27 -0400
X-MC-Unique: 6W7UUTqfONOhZbAUIh6t2g-1
Received: by mail-wr1-f70.google.com with SMTP id c4-20020a056000184400b0016e0cc310b3so2318831wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srx/wR4Z0jpwx5qACmRHg2e/sdqCTiZM1D5VqWblfyo=;
        b=avbDkp1dTuRXs8zkH1i/YpAV0embQd4XfcPxSJPN16THJC32w9B8r53zOsxfK4gnqP
         erkVXHPnyAv6djBpMDkVQlCa4eZdHs67aJrQl52lISMruVYc3h+IqqmrOV9C7aciG13v
         rDyqlniNx776VI6e3SgswNQ7NmLRuGg7OGzEKcOLMlu/lWRAzYrusGNz5pV3/XOdAdA3
         yRyW9mK/+0FofVzFAaFqd+rAsrkyM/SJems8YqZIlQKS9XhCUOvYmDA+/Zl1rVPFJTM6
         KvsNEGuS0Jvw02o6vWM5wzcPUXaW5hdCD4M+Yla94zp9eHJvq67XcrHzvJovkXh+gl1t
         iagw==
X-Gm-Message-State: AOAM532ai8Sn9r0XMVasBWZmVJgkG1XPsNk/x/kROCaDQitWZYyLSync
        R3yFjBPTXggA/yBNcwOaYrEdxEQqieHPwJKzEmvTRKnRyauOpipuu0mwMP2TrsvJ046rBjJUI1i
        mXfjv60bfzomfoIF9G4hgP8iAEReWOcaKgGsXRJsw
X-Received: by 2002:a5d:4004:: with SMTP id n4mr7115178wrp.49.1635438085923;
        Thu, 28 Oct 2021 09:21:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyMKgzDB1igDUPyy00UI9mGxcyOY5krHyjEPwcdvs8cObzielWIajyvYSKRXyiHQOxa8HwjbrosORuHuSRvaM=
X-Received: by 2002:a5d:4004:: with SMTP id n4mr7115161wrp.49.1635438085772;
 Thu, 28 Oct 2021 09:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211026220848.439530-1-lyude@redhat.com> <20211026220848.439530-3-lyude@redhat.com>
In-Reply-To: <20211026220848.439530-3-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 28 Oct 2021 18:21:15 +0200
Message-ID: <CACO55tt8c6V-AT5J0bX+Dvw-+rNVXoN93a3t9SfPRV7d-qjvSg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v4 2/5] drm/nouveau/kms/nv50-: Explicitly check
 DPCD backlights for aux enable/brightness
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        Satadru Pramanik <satadru@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:09 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Since we don't support hybrid AUX/PWM backlights in nouveau right now,
> let's add some explicit checks so that we don't break nouveau once we
> enable support for these backlights in other drivers.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index 1cbd71abc80a..ae2f2abc8f5a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -308,7 +308,10 @@ nv50_backlight_init(struct nouveau_backlight *bl,
>                 if (ret < 0)
>                         return ret;
>
> -               if (drm_edp_backlight_supported(edp_dpcd)) {
> +               /* TODO: Add support for hybrid PWM/DPCD panels */
> +               if (drm_edp_backlight_supported(edp_dpcd) &&
> +                   (edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) &&
> +                   (edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
>                         NV_DEBUG(drm, "DPCD backlight controls supported on %s\n",
>                                  nv_conn->base.name);
>
> --
> 2.31.1
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

