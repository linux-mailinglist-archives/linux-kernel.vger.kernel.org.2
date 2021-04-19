Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493B13640BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbhDSLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhDSLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618832737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koc049HugtBARt6EjAzw6mtyEEpABQogvtRQVut/VZw=;
        b=GEur+LenmPvp9lKyUHZChpvuWmoyxxQC9YnqfBDrS/aWEFy5egNbqlDUXL/3tDQ5wKanGY
        L6j8cdNM9cdQsXxddr6ECbxgXU5zuQGqbTA8VCCCsicHGkXjzgkkaXVfsOvmVNcUFGgEn+
        bxoc1nsRvS2wNzXSfww5fRAmkM3EEto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-1hoqbY_sMMmP5_glJDUobA-1; Mon, 19 Apr 2021 07:45:34 -0400
X-MC-Unique: 1hoqbY_sMMmP5_glJDUobA-1
Received: by mail-wr1-f69.google.com with SMTP id d15-20020a5d538f0000b02901027c18c581so8852460wrv.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koc049HugtBARt6EjAzw6mtyEEpABQogvtRQVut/VZw=;
        b=Eat5Ki/Mz0INS0fEg3P6XdoKXPWvK3yLXk5lwhucKHSmiuux4esKXhEVsPxFY1TOEz
         MZ0XNVe38FWjJ1gOfQGjAmcssmT1EP8zQTc1tmEpOQclTZSqdzKwrZSZt1qZNUh9z1mn
         3VcL0exJNWzsYsH0YP9nLm/pQ2pz4Yq71/ER9mmWyHc67ZnKi8qgEKUzDgHK60jOCR3z
         6fn4pbCmljKUNhq8hZ19hyIooXYOghux22adioaZSGH29EE8V47C/cat4xDp3NuFehdl
         EpWkLziQozw43R3xkQ070XRWPhKBvAjJP8hbJLZmSzfZTDw6D8EeI88F96g2tB1s5kry
         8gHQ==
X-Gm-Message-State: AOAM530QzbkUakLxomRsKyyieHAKpmGWxs8zpM7JGsYYdE3C+ORvl2lU
        6+QxOStoyXJcJ7DkI0newUzfkp7ZQsqWDpQkN27Vqvghmy7woUS4qk9+1n9Uc3NGd+4KB7ohNBX
        mwv3OSem7T1VwGznDS6D3VIm6LVTbwn29eIQ3/YI5
X-Received: by 2002:a5d:6983:: with SMTP id g3mr13595814wru.415.1618832733324;
        Mon, 19 Apr 2021 04:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMWuQi4zxk85zmf73Pwt63xQbdTQuszlMMCk8bIRtx2iSyg8ZGa26+dC0kfmhUNyg8Km1sHUnjbaHgtAhKXgI=
X-Received: by 2002:a5d:6983:: with SMTP id g3mr13595801wru.415.1618832733209;
 Mon, 19 Apr 2021 04:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210416143725.2769053-1-lee.jones@linaro.org> <20210416143725.2769053-10-lee.jones@linaro.org>
In-Reply-To: <20210416143725.2769053-10-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 19 Apr 2021 13:45:22 +0200
Message-ID: <CACO55tvWgRUnLsLY+d1-j3tjFQbOgzZzWszfNPjx0d1K+Smw5A@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/nouveau/dispnv04/crtc: Demote non-conforming
 kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Apr 16, 2021 at 4:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set_regs'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set_regs'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'adjusted_mode' not described in 'nv_crtc_mode_set'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'x' not described in 'nv_crtc_mode_set'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'y' not described in 'nv_crtc_mode_set'
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'old_fb' not described in 'nv_crtc_mode_set'
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> index f9e962fd94d0d..f9a276ea5a9e0 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
>         regp->Attribute[NV_CIO_AR_CSEL_INDEX] = 0x00;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> @@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
>         return ret;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

