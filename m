Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5782D3418FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCSJ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhCSJ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616147864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsREr7KDpE+wzs5UrnU5bq27soizKgijk7jOaTMCif8=;
        b=V6Iqbxz2n64U1zJiA+9pWxx/O9XKThGpYU1nL0vMh0o73DI3C6KVY7Yq3J+riehiyRew1j
        RPaKb+nKRWE5kV/lJDhbEHuKLbmBmcXU/t4380hYiv9z39PiQxQgrEzOlr8FZsdnPpM066
        tsQSUnKMrVhrqa2iv3o/NTLL1oYX+pw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-GlZkE8ejObm02w0ksU8xvQ-1; Fri, 19 Mar 2021 05:57:42 -0400
X-MC-Unique: GlZkE8ejObm02w0ksU8xvQ-1
Received: by mail-wr1-f71.google.com with SMTP id y5so21561227wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsREr7KDpE+wzs5UrnU5bq27soizKgijk7jOaTMCif8=;
        b=UTJZsenQfpuNZfNUcQM9zmIzaLiqJLD7fLAlbMOeUtsRpbQM0Fj1QPIkhITGuppVsz
         QCOEWt87lW13PLj5IkV8lTm1khUUIfxLqH2try+Ja8wCmZPPbSuj7osg8V3lPtwvpU71
         9IXSQgEnmYlqXVXHx/yiJFwhdodMa98pW+gK8041YrrsVRuw3JH0+TS18LSCn3Z8sfUS
         rwWaH8t/PJAtk//nec34kaB/yCFLM4C2rcSPKFh/A3r7HeuF9F6hTGc4I011a2IrZOGD
         ns+p6C/mHxY8rMOTUjIHxNOuk56KnBWZfBt0A/f0lBZrXyH5lqn6/ZX/Tbk+1nAiOrcu
         WHVg==
X-Gm-Message-State: AOAM531E18DNRhLR7mtISGc+i1N/qF/YYn9guQ9RiRL8t6ODwokPIaoi
        /CPTel1FI7fX1OjHwktZBTjLXyGkZWnRIm2pCjQCZmZ59e7xDs9OsgKtcbEZiUT4suysg99HIg0
        bW46K3bb/D/xeRzD/xtYh3UwjEt1r/eIAy0eoBVPW
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr3005064wmg.171.1616147861271;
        Fri, 19 Mar 2021 02:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsfPewyX1Blixhz1/TwL1Ho9nuqLqhf9NMZtw3nWuN8DcHlGRHQ08GhxRWzE7D+tyku9OEoToJb5cXiQ8FNE8=
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr3005053wmg.171.1616147861146;
 Fri, 19 Mar 2021 02:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210319082428.3294591-1-lee.jones@linaro.org> <20210319082428.3294591-13-lee.jones@linaro.org>
In-Reply-To: <20210319082428.3294591-13-lee.jones@linaro.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Mar 2021 10:57:30 +0100
Message-ID: <CACO55tvitU6wHR1DVNAx1rGVEYRCs_PKQpdgrARPTMZgg3K_Tg@mail.gmail.com>
Subject: Re: [PATCH 12/19] drm/nouveau/dispnv04/crtc: Demote non-conforming
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

On Fri, Mar 19, 2021 at 9:25 AM Lee Jones <lee.jones@linaro.org> wrote:
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

Reviewed-by: Karol Herbst <kherbst@redhat.com>

