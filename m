Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5523D385A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhGWJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhGWJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627035037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCnfwgoju9KJVJVxzdonbeNHiGdU31DcncEtq0QIxEc=;
        b=RR1G5IOVjaVtYWUEVafHinWCloyxgwV51/nXmPr1rwXPdYagpIp3UTcZwnit7uFtuML9Yl
        Y5nwl7xh/CNqrCKCZ8V6xR3uDRrS/gLWEYMdUH1wjdxrZXM5n2NwY2KhkjOvNRxVlK8vuN
        jjFjMHFeHKp1JBWu2aGdYdHbu0b2nVg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-w5WaShuyORGrn8Kt3hDbkw-1; Fri, 23 Jul 2021 06:10:36 -0400
X-MC-Unique: w5WaShuyORGrn8Kt3hDbkw-1
Received: by mail-wm1-f70.google.com with SMTP id j11-20020a05600c410bb02902278758ab90so1259207wmi.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCnfwgoju9KJVJVxzdonbeNHiGdU31DcncEtq0QIxEc=;
        b=LTn192UWkZI/QqDicyCYxhtfcjKm8fJtuYtVALg0zF6HPGCozSDnooPl2pw/wXOf3s
         KSucZh6LpuI4f7UVTMufnwqIGbN5WDYi9/83JgntvmpWA4M5ABUcfjHrX5aqjdliqQm9
         e4E89GZqLtUqQeTGXPrkxhpFMBaEpJOM8Svg50df4ra0iQpp7VsXy62B1UTgwQ9qBTgk
         wTJ+TC/vlensn9cLdpYks9eILJud+fHoA4OipLo0oxkKUaG/WVyDtQr+Ou9mauzxnLX/
         gYfoKZWyhpvAttWyaQkPYSo3PS+WqcFiMlzpqzv4FyiJ8IcjZ0M65AXW9BU60VnSkwWF
         PWiQ==
X-Gm-Message-State: AOAM5331OLA3yhZFz9lzccdTgYtccqak15/yKRAckSFjwq4EukL6QQ6J
        0Mc3MsDHd/2efdep8ptQpGySngvZ1d0D3tjqiy/d8G/dYoRvnuHLV8g5QcwwNMpfB0nMYdJN5gD
        NEQ4avSHV2byIVXpvBcjU+tJ1K90yop/MhcrC9Hv3
X-Received: by 2002:adf:a41e:: with SMTP id d30mr4467533wra.10.1627035035382;
        Fri, 23 Jul 2021 03:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEk6ZWVUT4qaXiQXBldx2Iegn3X9Qemm5Nc9ijAuV2VfNgdhxQZZMxtIZjhjex9O53QosaCdAUjTmMPzScWOw=
X-Received: by 2002:adf:a41e:: with SMTP id d30mr4467517wra.10.1627035035251;
 Fri, 23 Jul 2021 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org> <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 23 Jul 2021 12:10:24 +0200
Message-ID: <CACO55ttWCe2NLBiDW+nujiXTE1nGgNJy4C0q+5Aa6uh0OJ1sww@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with CONFIG_BACKLIGHT=n
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jul 23, 2021 at 11:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When the backlight support is disabled, the driver fails to build:
> >
> > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
> >  1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
> >       |                                                           ^~
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
> >  1670 |         if (backlight && backlight->uses_dpcd) {
> >       |                                   ^~
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
> >  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> >       |                                                                ^~
> >
> > The patch that introduced the problem already contains some #ifdef
> > checks, so just add another one that makes it build again.
> >
> > Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Can we just toss the idea that BACKTLIGHT=n is a reasonable config for
> drm drivers using backlights, and add depends BACKLIGHT to all of
> them?
>
> I mean this is a perfect source of continued patch streams to keep us
> all busy, but beyond that I really don't see the point ... I frankly
> have better things to do, and especially with the big drivers we have
> making backlight optional saves comparitively nothing.
> -Daniel
>

same, I'd just require BACKLIGHT as well tbh.

> > ---
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index 093e1f7163b3..fcf53e24db21 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -1659,20 +1659,23 @@ static void
> >  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> >  {
> >         struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> > -       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> >         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
> >         struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> > -       struct nouveau_backlight *backlight = nv_connector->backlight;
> >         struct drm_dp_aux *aux = &nv_connector->aux;
> > -       int ret;
> >         u8 pwr;
> >
> > +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> > +       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> > +       struct nouveau_backlight *backlight = nv_connector->backlight;
> > +
> >         if (backlight && backlight->uses_dpcd) {
> > -               ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > +               int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > +
> >                 if (ret < 0)
> >                         NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> >                                  nv_connector->base.base.id, nv_connector->base.name, ret);
> >         }
> > +#endif
> >
> >         if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> >                 int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> > --
> > 2.29.2
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>

