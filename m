Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD43D3D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhGWPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhGWPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627056772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NTO18YcF2qw6Kpg/GloKqP6tZBxoy9gh8XmkGeF9NE=;
        b=BQyAntwVzG499xyidEWBJMqaSIij1OoKwy0onDEGQEzCyrBBPwfo6U9hgpE/J4ARjhftKu
        3muF+py8nqnHphySG3hiwMTcJUmRHtkZlGJDoRr8lxv0IgUU1ylB1hJ1abi58lY68ZSItw
        KLOYydvC2lV/UDMoVrW9uscgByx3Nms=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-eIV-aMb1ME-BIoRi3_MHsw-1; Fri, 23 Jul 2021 12:12:50 -0400
X-MC-Unique: eIV-aMb1ME-BIoRi3_MHsw-1
Received: by mail-qk1-f200.google.com with SMTP id p123-20020a378d810000b02903ad5730c883so1432663qkd.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=1NTO18YcF2qw6Kpg/GloKqP6tZBxoy9gh8XmkGeF9NE=;
        b=iJFjJnYaNBgH1KEgFnkLz9BTFLy6Ao8qtsE+QwXW0Xc4Igdwk2fMDeV1UmX9Cj6JUW
         4dLGuxFTzvg+2YQAITz3yH3SguYSpPO4PHZ3Y9yhszOe/TvQmUzj93f4kI2oaQTsnZYu
         PEhm4IxxOdaxtfBPHLJwnkJ20WLijoUBnnO4Ii/tFCcY4txT6BMQMPbjXAx5oK8RRDzc
         99hkhA7FfCqrEWbWs9OIkjgrVKdR6rcVsjuhd2g/tsE8rT/wcziucTnVRLR5FqNwj7UJ
         zdlvZVbNk4GyrzL1ARRrFytaPU2ws4W0Ir7s/szJp1mBEOMoeFjytHWsNoc8jUrG+wCt
         NcZg==
X-Gm-Message-State: AOAM532LaJu0UO1Y4oFQYb6KYgMCZpqE/3jdTFK6QDMxE4i5LgdYTfGd
        f8ETgk5Q11MPlK9QpjrUUrfTQvV2xPWcAREDqIciprzdsVRHdVHu05w4JBcf0B92vDyfHTKXq7w
        2LMXSJd/yjuQLwuFzAkS6KYT+
X-Received: by 2002:a37:a557:: with SMTP id o84mr5316584qke.323.1627056770250;
        Fri, 23 Jul 2021 09:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzYXo962QZa+/2DWnJ5qoJGgdqtJlvieTRJp2rDEjkb+nPOP4CbJIp7neDMagHLOxSUTHzkQ==
X-Received: by 2002:a37:a557:: with SMTP id o84mr5316567qke.323.1627056770077;
        Fri, 23 Jul 2021 09:12:50 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id c11sm11667633qth.29.2021.07.23.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:12:49 -0700 (PDT)
Message-ID: <d529bd638b394c7c918ff4753cf5cf18afc99989.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with
 CONFIG_BACKLIGHT=n
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Arnd Bergmann <arnd@arndb.de>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Jul 2021 12:12:47 -0400
In-Reply-To: <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
References: <20210723091534.1730564-1-arnd@kernel.org>
         <CAKMK7uHG0T7kgHzrkxoGj+Cv1-5f=GaH1CviunoZd_wEL5G4YQ@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-23 at 11:24 +0200, Daniel Vetter wrote:
> On Fri, Jul 23, 2021 at 11:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When the backlight support is disabled, the driver fails to build:
> > 
> > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function
> > 'nv50_sor_atomic_disable':
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct
> > nouveau_connector' has no member named 'backlight'
> >  1665 |         struct nouveau_backlight *backlight = nv_connector-
> > >backlight;
> >       |                                                           ^~
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of
> > undefined type 'struct nouveau_backlight'
> >  1670 |         if (backlight && backlight->uses_dpcd) {
> >       |                                   ^~
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of
> > undefined type 'struct nouveau_backlight'
> >  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight-
> > >edp_info);
> >       |                                                                ^~
> > 
> > The patch that introduced the problem already contains some #ifdef
> > checks, so just add another one that makes it build again.
> > 
> > Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight
> > support for nouveau")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can we just toss the idea that BACKTLIGHT=n is a reasonable config for
> drm drivers using backlights, and add depends BACKLIGHT to all of
> them?

Yeah - I'm fine with this IMHO, at least for the drivers actually supporting
backlights in some manner (I assume this is most of them though)

> 
> I mean this is a perfect source of continued patch streams to keep us
> all busy, but beyond that I really don't see the point ... I frankly
> have better things to do, and especially with the big drivers we have
> making backlight optional saves comparitively nothing.
> -Daniel
> 
> > ---
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index 093e1f7163b3..fcf53e24db21 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -1659,20 +1659,23 @@ static void
> >  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct
> > drm_atomic_state *state)
> >  {
> >         struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
> > -       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> >         struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
> >         struct nouveau_connector *nv_connector =
> > nv50_outp_get_old_connector(state, nv_encoder);
> > -       struct nouveau_backlight *backlight = nv_connector->backlight;
> >         struct drm_dp_aux *aux = &nv_connector->aux;
> > -       int ret;
> >         u8 pwr;
> > 
> > +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> > +       struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
> > +       struct nouveau_backlight *backlight = nv_connector->backlight;
> > +
> >         if (backlight && backlight->uses_dpcd) {
> > -               ret = drm_edp_backlight_disable(aux, &backlight-
> > >edp_info);
> > +               int ret = drm_edp_backlight_disable(aux, &backlight-
> > >edp_info);
> > +
> >                 if (ret < 0)
> >                         NV_ERROR(drm, "Failed to disable backlight on
> > [CONNECTOR:%d:%s]: %d\n",
> >                                  nv_connector->base.base.id, nv_connector-
> > >base.name, ret);
> >         }
> > +#endif
> > 
> >         if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> >                 int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
> > --
> > 2.29.2
> > 
> 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

