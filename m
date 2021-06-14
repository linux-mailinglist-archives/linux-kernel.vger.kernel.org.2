Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4899E3A6B28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhFNQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:02:45 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40759 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhFNQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:02:44 -0400
Received: by mail-ed1-f43.google.com with SMTP id t3so47232088edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAo6qWwfla/zQj4s5qtRwWaGJwCOG62qXo2Ky4GvdO4=;
        b=Jb2xnKKkCCR/EiTZ5CEdmKXDLgjYj4rhWlVhQuoeu3sR9nbdcxeviCq/uYXn5NWLRq
         AILGo2aEeU+vfk0aJzYGovAfpCC6iz89eclFfcu0fXL0Dxujz4s6hb7umVcP4rua6S1R
         kDDBfjsdH8FSfLyG8ctXEO7UpFKt7x4MZTgKusDQJOS+h0FSWBCRzaXoxbDHyjV1vqfK
         u+PYdsdZaUNbAm5PdLih3BtpZ+h9C04OIQj8qQzufv3BN/w1zo2kvKUiWyoMaMkTI89T
         pDQHpQuyCyHANWk+SnGN3qDl6+6bcPD2VmMRSuVi15dBED7/kKbOQA/U3uxpbvu0Vlcn
         ehWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAo6qWwfla/zQj4s5qtRwWaGJwCOG62qXo2Ky4GvdO4=;
        b=PDAjcN7/uJBgWLSSbfsq8Y4vC0TvlujnKQ/1/3r2Zcs4WLgfaT/NsM1e2/9zRNIOML
         x3Rbctze2FPQvjnkVRqcla0yVnII4DzKK1APocxRAQztTkD4GzA8U+gYxrySN1yYPm5H
         5ZDDLtef8pDSCLdr5MbDybtYPAprnMk8xF+VGK7D8ywOPQ/in2uFfIUAhfeFyiGooLfN
         KAmaec9PC8IV/M9BPvaQeZadljrhuLMg3RP+1pi2wtxPTndKxzlejnpfB4cdUzQj76V6
         HzrElRSuJgy31iRXOFY5FtYk/ZOh/549TlIDEeNWgk89FHK1v6Osld+O5d+iMNHyUqDt
         DNKg==
X-Gm-Message-State: AOAM530pJM3JDa6JG4mGYUr1YhK1g7tpiC0OMk6guP4nzDHaFIWFKUQV
        LDy+j2Q9rq7VsWoFSazW1PygOeIUD/EdvWa11sg=
X-Google-Smtp-Source: ABdhPJykGh542EKVwndcqL7v7940RKSkiGDcrluyyKSF5XTLYi6zV7rLIAdPrZGXPgPgmJt64op0LE55eutXVy+WicA=
X-Received: by 2002:a50:ee18:: with SMTP id g24mr17905076eds.11.1623686380809;
 Mon, 14 Jun 2021 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210608174320.37429-1-wse@tuxedocomputers.com>
 <20210608174320.37429-3-wse@tuxedocomputers.com> <20210610105524.4dd2a40f@eldfell>
In-Reply-To: <20210610105524.4dd2a40f@eldfell>
From:   Mario Kleiner <mario.kleiner.de@gmail.com>
Date:   Mon, 14 Jun 2021 17:59:29 +0200
Message-ID: <CAEsyxyjZoLSZSu76aJ6a_Hg_b=eH2Am6ioM=cLz05ciVDEqboQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Harry Wentland <harry.wentland@amd.com>,
        "Li, Sun peng (Leo)" <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, tzimmermann@suse.de,
        Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 9:55 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Tue,  8 Jun 2021 19:43:15 +0200
> Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> > Add a new general drm property "active bpc" which can be used by graphic drivers
> > to report the applied bit depth per pixel back to userspace.
> >

Maybe "bit depth per pixel" -> "bit depth per pixel color component"
for slightly more clarity?

> > While "max bpc" can be used to change the color depth, there was no way to check
> > which one actually got used. While in theory the driver chooses the best/highest
> > color depth within the max bpc setting a user might not be fully aware what his
> > hardware is or isn't capable off. This is meant as a quick way to double check
> > the setup.
> >
> > In the future, automatic color calibration for screens might also depend on this
> > information being available.
> >
> > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
> >  drivers/gpu/drm/drm_connector.c   | 41 +++++++++++++++++++++++++++++++
> >  include/drm/drm_connector.h       | 15 +++++++++++
> >  3 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > index 268bb69c2e2f..7ae4e40936b5 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
> >               *val = 0;
> >       } else if (property == connector->max_bpc_property) {
> >               *val = state->max_requested_bpc;
> > +     } else if (property == connector->active_bpc_property) {
> > +             *val = state->active_bpc;
> >       } else if (connector->funcs->atomic_get_property) {
> >               return connector->funcs->atomic_get_property(connector,
> >                               state, property, val);
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index 7631f76e7f34..c0c3c09bfed0 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -1195,6 +1195,14 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
> >   *   drm_connector_attach_max_bpc_property() to create and attach the
> >   *   property to the connector during initialization.
> >   *
> > + * active bpc:
> > + *   This read-only range property tells userspace the pixel color bit depth
> > + *   actually used by the hardware display engine on "the cable" on a
> > + *   connector. The chosen value depends on hardware capabilities, both
> > + *   display engine and connected monitor, and the "max bpc" property.
> > + *   Drivers shall use drm_connector_attach_active_bpc_property() to install
> > + *   this property.
> > + *
>
> This description is now clear to me, but I wonder, is it also how
> others understand it wrt. dithering?
>
> Dithering done on monitor is irrelevant, because we are talking about
> "on the cable" pixels. But since we are talking about "on the cable"
> pixels, also dithering done by the display engine must not factor in.
> Should the dithering done by display engine result in higher "active
> bpc" number than what is actually transmitted on the cable?
>
> I cannot guess what userspace would want exactly. I think the
> strict "on the cable" interpretation is a safe bet, because it then
> gives a lower limit on observed bpc. Dithering settings should be
> exposed with other KMS properties, so userspace can factor those in.
> But to be absolutely sure, we'd have to ask some color management
> experts.
>
> Cc'ing Mario in case he has an opinion.
>

Thanks. I like this a lot, in fact such a connector property was on my
todo list / wish list for something like that!

I agree with the "active bpc" definition here in this patch and
Pekka's comments. I want what goes out over the cable, not including
any effects of dithering. At least AMD's amdpu-kms driver exposes
"active bpc" already as a per-connector property in debugfs, and i use
reported output from there a lot to debug problems with respect to HDR
display or high color precision output, and to verify i'm not fooling
myself wrt. what goes out, compared to what dithering may "fake" on
top of it.

Software like mine would greatly benefit from getting this directly
off the connector, ie. as a RandR output property, just like with "max
bpc", as mapping X11 output names to driver output names is a guessing
game, directing regular users to those debugfs files is tedious and
error prone, and many regular users don't have root permissions
anyway.

Sometimes one wants to prioritize "active bpc" over resolution or
refresh rate, and especially on now more common HDR displays, and
actual bit depth also changes depending on bandwidth requirements vs.
availability, and how well DP link training went with a flaky or loose
cable, like only getting 10 bpc for HDR-10 when running on less than
maximum resolution or refresh rate, and the cable "just right". This
can be very puzzling without actual feedback over true "active bpc".

It would also be very beneficial to also have reporting and control
over gpu dithering state via a read/write property. Some drivers like
nouveau-kms have that, and i think some older non-atomic amd drivers
had it at some point in time iirc, which was useful, also for
debugging of dithering induced issues, when one wants to pass-through
a 8 bpc framebuffer unmodified to special display equipment, and
dithering silently kicked in and is messing things up.

And a read only property for DSC active would be good to account for the future.

> Since "active bpc" is related to "max bpc", the both should follow the
> same definition. Do they do that now?
>
> Maybe a clarifying note about interaction with dithering would still be
> good to have here.
>
+1

>
> I recall reading some comments from you about having problems with
> making this immutable. Is it properly immutable now?
>
> That is, drm_info reports the property as "(immutable)".
> https://github.com/ascent12/drm_info
>
> If we are not sure if DSC could result in lower observed bpc than
> "active bpc", then DSC state would need to be exposed as a KMS property
> too, with a note that it invalidates what "active bpc" shows. Or maybe
> "active bpc" should be "unknown" in that case?
>

Yes. Or could we have some way of disabling DSC per connector in the
future? I'm not familiar with current implementations, but i'd very
much would like to have a selectable tradeoff if i want a "pure" video
signal and maybe not get some high resolution / refresh rate modes on
low-bandwidth cables, or if i want max resolution/refresh but some
lossy perceptual compression.

thanks,
-mario

>
> Thanks,
> pq
>
> >   * Connectors also have one standardized atomic property:
> >   *
> >   * CRTC_ID:
> > @@ -2150,6 +2158,39 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
> >  }
> >  EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
> >
> > +/**
> > + * drm_connector_attach_active_bpc_property - attach "active bpc" property
> > + * @connector: connector to attach active bpc property on.
> > + * @min: The minimum bit depth supported by the connector.
> > + * @max: The maximum bit depth supported by the connector.
> > + *
> > + * This is used to check the applied bit depth on a connector.
> > + *
> > + * Returns:
> > + * Zero on success, negative errno on failure.
> > + */
> > +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
> > +                                       int min, int max)
> > +{
> > +     struct drm_device *dev = connector->dev;
> > +     struct drm_property *prop;
> > +
> > +     prop = connector->active_bpc_property;
> > +     if (!prop) {
> > +             prop = drm_property_create_range(dev, 0, "active bpc", min, max);
> > +             if (!prop)
> > +                     return -ENOMEM;
> > +
> > +             connector->active_bpc_property = prop;
> > +     }
> > +
> > +     drm_object_attach_property(&connector->base, prop, 0);
> > +     connector->state->active_bpc = 0;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_connector_attach_active_bpc_property);
> > +
> >  /**
> >   * drm_connector_set_vrr_capable_property - sets the variable refresh rate
> >   * capable property for a connector
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 1922b278ffad..c58cba2b6afe 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -781,6 +781,13 @@ struct drm_connector_state {
> >        */
> >       u8 max_bpc;
> >
> > +     /**
> > +      * @active_bpc: Read only property set by the GPU driver to the actually
> > +      * applied bit depth of the pixels after evaluating all hardware
> > +      * limitations.
> > +      */
> > +     u8 active_bpc;
> > +
> >       /**
> >        * @hdr_output_metadata:
> >        * DRM blob property for HDR output metadata
> > @@ -1380,6 +1387,12 @@ struct drm_connector {
> >        */
> >       struct drm_property *max_bpc_property;
> >
> > +     /**
> > +      * @active_bpc_property: Default connector property for the active bpc
> > +      * to be driven out of the connector.
> > +      */
> > +     struct drm_property *active_bpc_property;
> > +
> >  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
> >  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
> >  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
> > @@ -1698,6 +1711,8 @@ int drm_connector_set_panel_orientation_with_quirk(
> >       int width, int height);
> >  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
> >                                         int min, int max);
> > +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
> > +                                       int min, int max);
> >
> >  /**
> >   * struct drm_tile_group - Tile group metadata
>
