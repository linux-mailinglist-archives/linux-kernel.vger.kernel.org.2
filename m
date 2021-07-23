Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87723D37A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhGWIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhGWIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:44:10 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C99C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:24:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t14so1244174oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e30m4UPG96stOKc9AAKHmmDvPceuMEjTC/oE9rnemL8=;
        b=kqGrIiB/LDwg0WCxZ8DhN1/fGwYijFuvJQbIO3b1viS2rD29dJRysDWAOVB8Rubitl
         AyY7ROW2xqDesH1d5+Sdx1fg6fqsPqp+Gjj9A8S8OibqPvLsWW998o0xN7+OXzkM+nVl
         WGFurJZj5+2B5v68/fEm3CkgfS8MCZTQB3v6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e30m4UPG96stOKc9AAKHmmDvPceuMEjTC/oE9rnemL8=;
        b=T3wZXsroLr1BYoUKnmVQlxbGhzm0Mx8YvdCoIG9+de2kVq+UYj51x8IR86B3q7OtU+
         tC2NLsANPleH0YQ1QTE2neUvxCMp+E43ENWoydrWVMO6x2dLse7kFhCtc801mg9GW8hH
         JgVpsttxxB+ehaumnk7OvZYO5zamLfFNv0vTHLMFn42+F/XZZlCSygk2q+Fs2NqO8bKh
         sQFC/uMT52tfXXJdsaXBvDlLQRD3uzPoW1utfSGrem3pWiZooHJDcjUwuZY3xKgcdFKo
         JoHI4HclgxmzRn+OM/RsUnewjQFjBIYCYAleM3yy0s8j3R9ggIH5ZEOsclWWqeHkIPOS
         x56A==
X-Gm-Message-State: AOAM530JVsEWT+DSsYj4lqyx3L3jLmLzpXqwiWnumHMSxnjlKcHPeXaJ
        /OVQIqni7XkIEEQjjpdkiSSpCUkV7rRDUxc0taSqRw==
X-Google-Smtp-Source: ABdhPJy2No+cuZ76/SxEQnH4zinzF2kmRucefQc9Y7v0x1BAgQW8WF9jPryfnWoCo+N0dsICDiQ1KmHu4e+YHQ1LzpI=
X-Received: by 2002:aca:3085:: with SMTP id w127mr7843600oiw.101.1627032283413;
 Fri, 23 Jul 2021 02:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org>
In-Reply-To: <20210723091534.1730564-1-arnd@kernel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 23 Jul 2021 11:24:32 +0200
Message-ID: <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with CONFIG_BACKLIGHT=n
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Lyude Paul <lyude@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When the backlight support is disabled, the driver fails to build:
>
> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
>  1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
>       |                                                           ^~
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
>  1670 |         if (backlight && backlight->uses_dpcd) {
>       |                                   ^~
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
>  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>       |                                                                ^~
>
> The patch that introduced the problem already contains some #ifdef
> checks, so just add another one that makes it build again.
>
> Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Can we just toss the idea that BACKTLIGHT=n is a reasonable config for
drm drivers using backlights, and add depends BACKLIGHT to all of
them?

I mean this is a perfect source of continued patch streams to keep us
all busy, but beyond that I really don't see the point ... I frankly
have better things to do, and especially with the big drivers we have
making backlight optional saves comparitively nothing.
-Daniel

> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 093e1f7163b3..fcf53e24db21 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1659,20 +1659,23 @@ static void
>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
>  {
>         struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> -       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
>         struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> -       struct nouveau_backlight *backlight = nv_connector->backlight;
>         struct drm_dp_aux *aux = &nv_connector->aux;
> -       int ret;
>         u8 pwr;
>
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> +       struct nouveau_backlight *backlight = nv_connector->backlight;
> +
>         if (backlight && backlight->uses_dpcd) {
> -               ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> +               int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> +
>                 if (ret < 0)
>                         NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
>                                  nv_connector->base.base.id, nv_connector->base.name, ret);
>         }
> +#endif
>
>         if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
>                 int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
