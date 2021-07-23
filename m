Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933003D3DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGWPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGWPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627058093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBKfujrZeXlnAEPqRseOsz+DSjWxEDmI89ivOTZgHQY=;
        b=csRU00dRsLRFPNxfCslsC0dsN8Li0kWCgGRiVV/n6NyhVBcD8WVYOtiAIY/24XTDp+iy5/
        xbxOdgGYhxK69kt+1XK4RrktYldot/Ihs0ujtYTf2ruHsqzoxTzW3PJG1Iv5kfRAnArRIW
        NhNHt/XRAmEECKTHa4WKDkm9xeEkADo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-JZeeMcbGNJqLg7tgLd9N6g-1; Fri, 23 Jul 2021 12:34:51 -0400
X-MC-Unique: JZeeMcbGNJqLg7tgLd9N6g-1
Received: by mail-wr1-f70.google.com with SMTP id n1-20020a5d59810000b029013cd60e9baaso1189563wri.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBKfujrZeXlnAEPqRseOsz+DSjWxEDmI89ivOTZgHQY=;
        b=WtQyDUQuMGHYjECBmHOr0VO4mCi0NvguQ/uO6QUvg/hGGj2GK4SHamVrSi4EedD15S
         e/WiaSaZTDWQIXKDUqbpfF+Qv/FbQ5o8Ynfmvqoa/ZJsSp2KsqxdvYVDNb0YqP/sNNp7
         pXo1eiTVVn5/yaodkHPI/zqGtADJzh50UgMuhH2sFgGJQvhZ+t2HKIuJWTke0+Vvf0eM
         IP2XdbwDKpYb81W4gYYdRl9zeVGQpSdhqsoRwXO48A7F8Mrw/vfs1CjG3jC3yHjiKWjK
         WoIwo3vMqW/Bqsg6s7srZbJuP1BNvw9RUmPeKMG/krfpXmfd7XaqFw/5k64DsLfzLMSh
         ShPg==
X-Gm-Message-State: AOAM533A77fGbn93HwZ088+V3F3QtZVXu7OMVG2SWpUNwCpI70PD+x3f
        tm8/w3VEY/rpb4kamPS9G2LWxhNtf4WvFsO8KV23YipxKG6+2qHb2yQI7jQbBEIKxBXrDHpsGxC
        SnNXY1sK0tV8F0c/xnCeuL5atdWqewuloX8QS1lw8
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr6485184wrn.113.1627058090618;
        Fri, 23 Jul 2021 09:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjZmLFiXzbRdB1FSZxk6Ci9/11PUg5q7Gnq6fHY+P642HnHn3ZO13MsX1/M3WvfMfwQhNQ9sYSLAOwuVdUjA0=
X-Received: by 2002:adf:ec0c:: with SMTP id x12mr6485172wrn.113.1627058090493;
 Fri, 23 Jul 2021 09:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210723091534.1730564-1-arnd@kernel.org> <a618e29a-e4b7-bda4-a3e0-7dfd67d64e92@infradead.org>
 <CACO55tvQoCnjQWRJhrJ+8TzY5MuDDSUSnwd5AU8G1qsQYCSCBg@mail.gmail.com> <7ddd0c7c-9bdc-9ea3-c635-f1d141d1e870@infradead.org>
In-Reply-To: <7ddd0c7c-9bdc-9ea3-c635-f1d141d1e870@infradead.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 23 Jul 2021 18:34:39 +0200
Message-ID: <CACO55ttjQO5kUeEA7opvGLAwT+a1t0vAguncKDhB4bdy96K7LA@mail.gmail.com>
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

On Fri, Jul 23, 2021 at 6:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/23/21 8:15 AM, Karol Herbst wrote:
> > On Fri, Jul 23, 2021 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 7/23/21 2:15 AM, Arnd Bergmann wrote:
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> When the backlight support is disabled, the driver fails to build:
> >>>
> >>> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
> >>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
> >>>  1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
> >>>       |                                                           ^~
> >>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
> >>>  1670 |         if (backlight && backlight->uses_dpcd) {
> >>>       |                                   ^~
> >>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
> >>>  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> >>>       |                                                                ^~
> >>>
> >>> The patch that introduced the problem already contains some #ifdef
> >>> checks, so just add another one that makes it build again.
> >>>
> >>> Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> ---
> >>>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
> >>>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> >>> index 093e1f7163b3..fcf53e24db21 100644
> >>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> >>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> >>> @@ -1659,20 +1659,23 @@ static void
> >>>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> >>>  {
> >>>       struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> >>> -     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> >>>       struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
> >>>       struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> >>> -     struct nouveau_backlight *backlight = nv_connector->backlight;
> >>>       struct drm_dp_aux *aux = &nv_connector->aux;
> >>> -     int ret;
> >>>       u8 pwr;
> >>>
> >>> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> >>> +     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> >>> +     struct nouveau_backlight *backlight = nv_connector->backlight;
> >>> +
> >>>       if (backlight && backlight->uses_dpcd) {
> >>> -             ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> >>> +             int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
> >>> +
> >>>               if (ret < 0)
> >>>                       NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> >>>                                nv_connector->base.base.id, nv_connector->base.name, ret);
> >>>       }
> >>> +#endif
> >>>
> >>>       if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> >>>               int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> >>>
> >>
> >> Hm, only Lyude Paul replied to this patch:
> >>
> >> https://lore.kernel.org/lkml/20210714171523.413-1-rdunlap@infradead.org/
> >>
> >
> > what's actually the use case of compiling with
> > CONFIG_DRM_NOUVEAU_BACKLIGHT=n anyway?
>
> Dunno. In this case it was just a randconfig. Still, it needs to be
> handled in some way - such as the other suggestion in this thread.
>

sure, I was just curious if there was a specific use case or just
something random as you mentioned.

