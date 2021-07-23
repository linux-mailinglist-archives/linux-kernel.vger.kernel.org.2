Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B23D3C44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhGWOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235438AbhGWOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627053356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hg7Wgll5Dqrto/c+cLJ/aZ8SYqDsqKJnk73SqfFyHqc=;
        b=fK3be8SkaWr/YhEko135ewzdb4KTwsW2WDb+qGEmtoBXGItPAh3efTUnDYcbF+EQm7Lm/J
        tIqZmLFHjVQQcdqcNccTyIj7ZHDRCZrDpkgO3XUCUV5ev/fprFgn8/EnfjfIMXf6z+1QvI
        C26NVxnG0gU9Ol4l+onk6WlP3J8q0/4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-_dXQgJpROGOxx9FyabIo2A-1; Fri, 23 Jul 2021 11:15:55 -0400
X-MC-Unique: _dXQgJpROGOxx9FyabIo2A-1
Received: by mail-wr1-f69.google.com with SMTP id u26-20020adfb21a0000b029013e2b4a9d1eso1118175wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg7Wgll5Dqrto/c+cLJ/aZ8SYqDsqKJnk73SqfFyHqc=;
        b=TSKvCFdp7+BkMXSpu/ZBKRE4EpKkTF8Oi/eV0PmI1I+gDmuFcUpt23cQJbRrZwX190
         ZFvvDTqf3ygbjZ/EP4BMI1vszgx783LjDnXFc5Zzn1DPgZ+rSXdrk/UB+tKD4AaereZh
         utXhdp5H6G1dtdGIcR0nLS7j1t/wy3imbUQqqSAq49d8cuKuRpohfoH/hk5YjcduoQ7D
         56g8tOkoVYC9ynD5vivIxmZgr8xrohzcDe4wcOXODeCNv/SIVzDx1HUM95MgOYjZNSlm
         RLkldz2UmtfQ0nTOr0ibu6zBV3AfAu1vPp/h4XO7dbU22TvgRmpOjBaBtuIqbL/zyX2C
         GFEQ==
X-Gm-Message-State: AOAM530quXrY9zkuTHHd16ZqDAPvJNf46Ad8xYAaMP+uFvWEaGQqECua
        oCLXxiePqe7aH/Dowq4eAW4PP4nm2tP4MtCz14Jn2vEctJCPuMJRy/LdTXESRBfIWBmOeN2DdrX
        WS3WCJ7paN70r1U6cF6VvCwLSY4GD4flslto1s0If
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr5053743wmk.1.1627053354279;
        Fri, 23 Jul 2021 08:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY8WT3or1Lwpu7iDbVDMw0gke7BYDmxM+rPUnWUEewCC1YlfLrsOiH2H5OFIGSgEJGHI7Q/9Go9PH9zpc3t5c=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr5053718wmk.1.1627053354043;
 Fri, 23 Jul 2021 08:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org> <a618e29a-e4b7-bda4-a3e0-7dfd67d64e92@infradead.org>
In-Reply-To: <a618e29a-e4b7-bda4-a3e0-7dfd67d64e92@infradead.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 23 Jul 2021 17:15:43 +0200
Message-ID: <CACO55tvQoCnjQWRJhrJ+8TzY5MuDDSUSnwd5AU8G1qsQYCSCBg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with CONFIG_BACKLIGHT=n
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/23/21 2:15 AM, Arnd Bergmann wrote:
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
> >       struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> > -     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> >       struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
> >       struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> > -     struct nouveau_backlight *backlight = nv_connector->backlight;
> >       struct drm_dp_aux *aux = &nv_connector->aux;
> > -     int ret;
> >       u8 pwr;
> >
> > +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> > +     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> > +     struct nouveau_backlight *backlight = nv_connector->backlight;
> > +
> >       if (backlight && backlight->uses_dpcd) {
> > -             ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > +             int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> > +
> >               if (ret < 0)
> >                       NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> >                                nv_connector->base.base.id, nv_connector->base.name, ret);
> >       }
> > +#endif
> >
> >       if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> >               int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> >
>
> Hm, only Lyude Paul replied to this patch:
>
> https://lore.kernel.org/lkml/20210714171523.413-1-rdunlap@infradead.org/
>

what's actually the use case of compiling with
CONFIG_DRM_NOUVEAU_BACKLIGHT=n anyway?

>
>
> --
> ~Randy
>

