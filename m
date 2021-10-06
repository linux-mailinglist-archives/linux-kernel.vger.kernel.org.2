Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245584242AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhJFQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhJFQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633537821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljugr8xYdJo7W0S7wZ1H4kpTYrrrY7cxZ+QUOs2N9UQ=;
        b=B9G18LG3X1/8ETee4pnUeSXHpS/pK0RlZHSY7slTCygIU6qRWxiZ99gvhI+MK4dINwr1Yq
        +BSuGsf1xeJT2rTxyH4fja7hjmEVCMBJEM3mCACFMh48JndSeEmEjV5HKAON1y5e6k5hod
        yiGPsPNmLgJ8kJJ1qsMqq6FNf4nK9vw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-vZSTinNaOWuKR0tHdHxgYw-1; Wed, 06 Oct 2021 12:30:20 -0400
X-MC-Unique: vZSTinNaOWuKR0tHdHxgYw-1
Received: by mail-wr1-f70.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so2332186wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljugr8xYdJo7W0S7wZ1H4kpTYrrrY7cxZ+QUOs2N9UQ=;
        b=417+XmhdOX6NR9V3TH9y8Ky13DqRAKEdgDj3f7tB/Ay/Ay222cmMLSaGPceBDxaeqS
         5KeOmwAPuDYq1FrxuMFZ7FTAYvKXAf8Rj3NJ5yAdg8M9/fcD8u6+KGbhnvp5hsBGk5zq
         Ho84vapN7MLxS2+kZqyQBp1IH2rOJphXIXiwEvd2mNoNWsoXrEZYIGvKLW+AMc0O46C3
         AMuyiShPB0UVBSurlFNL6Cb3fPjueP1+A7WBireFTWh+QFCeNx/8Rw00VnoSJ7POT3Yn
         7ZsOfIyov1xOne9nQoRaG7qaMQ12b+KJTfbGBwaqwU21FGCOithPOzqEgsOsi3Kfykx7
         7X3w==
X-Gm-Message-State: AOAM530u01SOLeqKbqNMykoCFYlRKP4JikdLhSCUBPezJZtYMEQ3z1ee
        5gnL45KcCwhPU88EYHsZKksok8HAyeyRiAel0UxbCPAZ6gg3lE/pgXYQqob9bdtU9lGtm+gu2w3
        G9o+TLnUUryA3HkUQHzo4k0S2M/LQ6EJ5IFoY3LTu
X-Received: by 2002:adf:a48e:: with SMTP id g14mr26148155wrb.11.1633537818828;
        Wed, 06 Oct 2021 09:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaown5rjXY7mQV5Hye51uwbkDUn6obL2IN464EW1FNLtOpErXXEji0g/kFgw0COlTE8icr8YVIyFdXOgO8M+U=
X-Received: by 2002:adf:a48e:: with SMTP id g14mr26148135wrb.11.1633537818634;
 Wed, 06 Oct 2021 09:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211006024018.320394-1-lyude@redhat.com> <20211006024018.320394-3-lyude@redhat.com>
In-Reply-To: <20211006024018.320394-3-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 6 Oct 2021 18:30:07 +0200
Message-ID: <CACO55tuMWVgsd44s1sAvgrKDHFZT2Z3F+CSqAh34_XaekYWuHA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v3 2/5] drm/nouveau/kms/nv50-: Explicitly check
 DPCD backlights for aux enable/brightness
To:     Lyude Paul <lyude@redhat.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 4:41 AM Lyude Paul <lyude@redhat.com> wrote:
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

where does the DP_EDP_BACKLIGHT_AUX_ENABLE_CAP come from? afaik
drm_edp_backlight_supported checks for
DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP and
DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP so wondering if this was
intentional or a typo

> +                   (edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP)) {
>                         NV_DEBUG(drm, "DPCD backlight controls supported on %s\n",
>                                  nv_conn->base.name);
>
> --
> 2.31.1
>

