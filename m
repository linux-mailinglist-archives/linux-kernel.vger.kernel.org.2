Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D130452D25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhKPIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhKPIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:53:28 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:50:31 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bk14so40951535oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEjJ77+UyJwVlPULZ4jyz+pU/j+PKMrGW1TigVTD6KA=;
        b=VgSubul8sBxv+qgCERzD8MvC1scC+FnFNWf12Dg0QDssMijQSpkE6i6w/lPeVspc+W
         MFnDBjmo9VE7m0OdSirJbSOzmUdcSKmga7+4wYrFxUgV/2/nA8dD29g2dshb6tthUxww
         dSbPHdDxxbqyLUGRw9BYgsD/k4ZSw4Z4Mlr0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEjJ77+UyJwVlPULZ4jyz+pU/j+PKMrGW1TigVTD6KA=;
        b=67kXMDGswsjwyx/3jB4DpYkT2qoc5sCyZkWSpv1bbIuREwSezTUUrmpSvtBBivazLA
         vYZFIv8AOO1WE1OU+MOW2dhqKudGP+iNw0EGmfK1CB7htayo4sgdGEm8+t+BAHaaHVqn
         LV7OKPcJk6mKH/pM3yKGmbNm8cD4b3RJQYwCXKECXHYyekatnLnvMPUFuaQ32Boq8fCy
         97TAe//0Q9IFVvfYsFox2/JneqJ8OjafCIS3LwBbJx4ddeyFj/6RaZvMtyBaMTVgRiqL
         7uFE37ZuLSOBcELa0X0DE3dqnmkzSHih0ZdEVTugbf8fqUluc/l25Enq0tvYO3uXDXDQ
         vGxA==
X-Gm-Message-State: AOAM5320y8xT0CCcMnG9ePJsYlvrV0WsEpT5OQ+P6jPpiTOgnpi2ZQKI
        lmyP51gPkKux4jPgjP8Wo55/roZGhuXVxsNrres+2Q==
X-Google-Smtp-Source: ABdhPJxDVhU01pH2Yg3VeM0lg0LzD0oc91nPo2b/uM76zBNm/7ZeCVtJB6saqXlaUPaWtvcGeZnDgnsGxlkpVia2jhg=
X-Received: by 2002:a05:6808:118a:: with SMTP id j10mr51262797oil.101.1637052631363;
 Tue, 16 Nov 2021 00:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20211115160135.25451-1-angus@akkea.ca> <87czn01odd.fsf@intel.com>
In-Reply-To: <87czn01odd.fsf@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 16 Nov 2021 09:50:20 +0100
Message-ID: <CAKMK7uHVS-SSVHYy132NuaDfsEgF4SBa69rjSVT4zEm8PzSXJA@mail.gmail.com>
Subject: Re: [PATCH] drm: drm_probe_helper: add modes upto 1920x1080
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Angus Ainslie <angus@akkea.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, kernel@puri.sm,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 9:44 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
>
> Cc: Ville
>
> On Mon, 15 Nov 2021, Angus Ainslie <angus@akkea.ca> wrote:
> > Lots of monitors nowdays support more than 1024x768 so if the EDID is
> > unknown then add resolutions upto 1920x1080.
>
> IIUC it's supposed to be the fallback that's pretty much guaranteed to
> work. What's going to happen if we add 1920x1080 and it fails?

Yeah unless we are now in a times where monitors fail to light up
these very low resolutions then I don't think adding more here is a
good idea. This absolute fallback list is _not_ about making things
good, but about getting anything onto the screen. If we really, really
need this (and then it needs good reasons) then a defensive approach
might be to add more modes, but still leave the old 1024x768 as the
preferred one. That would avoid any regression potential.

Otherwise this just becomes a game of "I want to have the best mode
for my broken screen without working edid as the default", which is
no-go.
-Daniel

> BR,
> Jani.
>
> >
> > Signed-off-by: Angus Ainslie <angus@akkea.ca>
> > ---
> >  drivers/gpu/drm/drm_probe_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> > index e7e1ee2aa352..5ad66ae9916e 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -517,7 +517,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
> >
> >       if (count == 0 && (connector->status == connector_status_connected ||
> >                          connector->status == connector_status_unknown))
> > -             count = drm_add_modes_noedid(connector, 1024, 768);
> > +             count = drm_add_modes_noedid(connector, 1920, 1080);
> >       count += drm_helper_probe_add_cmdline_mode(connector);
> >       if (count == 0)
> >               goto prune;
>
> --
> Jani Nikula, Intel Open Source Graphics Center



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
