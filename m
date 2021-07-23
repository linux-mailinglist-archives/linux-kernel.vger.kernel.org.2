Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57F3D3864
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhGWJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230478AbhGWJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627035163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9pRT+TDioDd0ny044PT7McbtP/VkEKPsqs+fpZmGxs=;
        b=J7JeJ/MsgtN8LiIlmC4RdV5A5qwymwDJgW19USuvqNu8/jQuYjPIRG9/ziPHx4g/o9W0RA
        581/Ef0jpzLIJyGRo/4aOThKmSZ0UtdOpSDj6dhRKW1WwTS5DGlb8ph2PJzAOzCP0m3hPC
        ZRMtJM2owgl8smwAj4RZDja7xhZuGLQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-W7I2oJXoPsyIiHS7TCBRtQ-1; Fri, 23 Jul 2021 06:12:41 -0400
X-MC-Unique: W7I2oJXoPsyIiHS7TCBRtQ-1
Received: by mail-wr1-f69.google.com with SMTP id f2-20020a5d50c20000b0290138092aea94so776777wrt.20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9pRT+TDioDd0ny044PT7McbtP/VkEKPsqs+fpZmGxs=;
        b=Laa55TiqU0YzlOmaTkQyZ2+yavFd4M/tz4bQVDhrLr0I647SWzyJTChv+pxm8L319F
         OX8lfSUKirN1AQbpM91nwCG/DeZG6T6bwsxGqTeX8PVwUREFUM26tPbRimNIBJP1gPCT
         fjfKni/BitPHkDSYLbWcaSbK1eS/CaZ/N/hmiGkMW/Iq4KaM7taC/vCBoy4C0npsAIJE
         s12m0mcdi0w5/mAfD6wJqifJMiuZHRgHyzrHo+YjdNfyKHJnRLDscM/qMd0gneCaxy3E
         U5cdu7rc5HSLbrSJ2J+FFhB+dqq0wAaB9kEs1VEqhYYzu4JyihPsaXTcjLru4BppkFS+
         ZT9w==
X-Gm-Message-State: AOAM53018DC4LMhJMhOoXJmmwqqSvJi/5kaFp16RfxIeraeoYW00CckB
        3ie+uO+2duhi2LdH8WM6zxR9oQ2OoHt+aPAklMDjWEND9iGVamvdO1S2fd9UqFWScyh6NVNV21T
        sQyjOFRr/Y9JIVDuZPp0n/zkVHjJwLOmq5/IiyRQQ
X-Received: by 2002:a05:600c:3ba7:: with SMTP id n39mr3755665wms.164.1627035160618;
        Fri, 23 Jul 2021 03:12:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2n0dFuqSnizQabm+vXjBCnDF5inrP51MQVNclVAB1hSAcJbJ3coTLI37aBZNo+JsNAeWu1UbltRxODh+umPQ=
X-Received: by 2002:a05:600c:3ba7:: with SMTP id n39mr3755652wms.164.1627035160411;
 Fri, 23 Jul 2021 03:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org> <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
 <CACO55ttWCe2NLBiDW+nujiXTE1nGgNJy4C0q+5Aa6uh0OJ1sww@mail.gmail.com>
In-Reply-To: <CACO55ttWCe2NLBiDW+nujiXTE1nGgNJy4C0q+5Aa6uh0OJ1sww@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 23 Jul 2021 12:12:29 +0200
Message-ID: <CACO55tvfzMiwfh87M=x3d_KWm41btDVHEGxPQLV0+iSskPQzWA@mail.gmail.com>
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

On Fri, Jul 23, 2021 at 12:10 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Fri, Jul 23, 2021 at 11:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, Jul 23, 2021 at 11:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When the backlight support is disabled, the driver fails to build:
> > >
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
> > >  1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
> > >       |                                                           ^~
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
> > >  1670 |         if (backlight && backlight->uses_dpcd) {
> > >       |                                   ^~
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
> > >  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > >       |                                                                ^~
> > >
> > > The patch that introduced the problem already contains some #ifdef
> > > checks, so just add another one that makes it build again.
> > >
> > > Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Can we just toss the idea that BACKTLIGHT=n is a reasonable config for
> > drm drivers using backlights, and add depends BACKLIGHT to all of
> > them?
> >
> > I mean this is a perfect source of continued patch streams to keep us
> > all busy, but beyond that I really don't see the point ... I frankly
> > have better things to do, and especially with the big drivers we have
> > making backlight optional saves comparitively nothing.
> > -Daniel
> >
>
> same, I'd just require BACKLIGHT as well tbh.
>

ehhh, get rid of DRM_NOUVEAU_BACKLIGHT I meant.

> > > ---
> > >  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > index 093e1f7163b3..fcf53e24db21 100644
> > > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > > @@ -1659,20 +1659,23 @@ static void
> > >  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> > >  {
> > >         struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> > > -       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> > >         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
> > >         struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> > > -       struct nouveau_backlight *backlight = nv_connector->backlight;
> > >         struct drm_dp_aux *aux = &nv_connector->aux;
> > > -       int ret;
> > >         u8 pwr;
> > >
> > > +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> > > +       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> > > +       struct nouveau_backlight *backlight = nv_connector->backlight;
> > > +
> > >         if (backlight && backlight->uses_dpcd) {
> > > -               ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > > +               int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > > +
> > >                 if (ret < 0)
> > >                         NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> > >                                  nv_connector->base.base.id, nv_connector->base.name, ret);
> > >         }
> > > +#endif
> > >
> > >         if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> > >                 int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> > > --
> > > 2.29.2
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> >

