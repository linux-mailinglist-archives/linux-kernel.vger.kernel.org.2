Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B763D787A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhG0O2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhG0O2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:28:52 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:28:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u7so9008513ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Prx0Bs3bi2Iedu+a31xFuqWG2tgHJduHwRz4ZIFies=;
        b=iwg3INetBSvSrA2PFYqyLYPB7PI8YxE5YBgzSCjQ63DsueVurjkfTnHSKQEF6hucc3
         lFDNFSEZz98jxNKhV8ssutp8hNDO8ukVScHrxzMfINjJzxgaxtgKRX0AGiR0DvW78tMd
         OP2U76sZRXONyVQpFCrlDKn8QBC5427e/FOgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Prx0Bs3bi2Iedu+a31xFuqWG2tgHJduHwRz4ZIFies=;
        b=tLkfQRyGOPyxCIh8adYGMGYupYmrOewPD0vBZEXZYY4d32R1vvnaOuiZ1fvLoXrBtb
         5hPQoQgg4Y7prk+XaGG28kPpE2dVFCcQPA4nIdk6iC6DuFgS96hivlnwLRU/AZm/MA2A
         vP4gTEa3Ny5fUnfy6c5z2RWCcuBEKRZJ6omukIyQ/UDU65OsGGS80wiABjXVL5tPztn+
         AHFa+1Mr987yb+JGogZXtmCdLWsJnmKYeV2IlMmXcCweFooQbQm5yCix32wXK6V9jYR0
         nmcEIqWlZb1osQeNuqQQA7K7UHfwmbkWC6jTTTtFG5/vqY6S7Q0Gndxd6Xkf7AozUyXi
         XebA==
X-Gm-Message-State: AOAM530djPCcz8qiDY7aViFp61KI2T2KrLlh+hPpNBI+xIkyz6egSCoV
        gHypv7eiV/gZXbDyhEae9mC3H+mOIDB/Tj+uiwVoLg==
X-Google-Smtp-Source: ABdhPJybYxwYy18KLwUbJfyvL+fb6T2BlYafeEVAj/NR03+20aiC9dS9LWK4oQGWXgLiZRehkrarL9nMSfFaH1DpM90=
X-Received: by 2002:a92:3206:: with SMTP id z6mr16785042ile.201.1627396130923;
 Tue, 27 Jul 2021 07:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210726233854.2453899-1-robdclark@gmail.com> <20210726233854.2453899-4-robdclark@gmail.com>
 <db6cdec8-d44c-a09c-3fbd-60fb55c66efb@daenzer.net>
In-Reply-To: <db6cdec8-d44c-a09c-3fbd-60fb55c66efb@daenzer.net>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 27 Jul 2021 07:33:01 -0700
Message-ID: <CAJs_Fx6dmNcjAvAJASr-YOZSDPrPfb0iwxNTZwmn1AQXpQevYQ@mail.gmail.com>
Subject: Re: [RFC 3/4] drm/atomic-helper: Set fence deadline for vblank
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Rob Clark <robdclark@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 3:44 AM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2021-07-27 1:38 a.m., Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> > the next vblank time, and inform the fence(s) of that deadline.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index bc3487964fb5..f81b20775b15 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1406,6 +1406,40 @@ void drm_atomic_helper_commit_modeset_enables(st=
ruct drm_device *dev,
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> >
> > +/*
> > + * For atomic updates which touch just a single CRTC, calculate the ti=
me of the
> > + * next vblank, and inform all the fences of the of the deadline.
> > + */
> > +static void set_fence_deadline(struct drm_device *dev,
> > +                            struct drm_atomic_state *state)
> > +{
> > +     struct drm_crtc *crtc, *wait_crtc =3D NULL;
> > +     struct drm_crtc_state *new_crtc_state;
> > +     struct drm_plane *plane;
> > +     struct drm_plane_state *new_plane_state;
> > +     ktime_t vbltime;
> > +     int i;
> > +
> > +     for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> > +             if (!wait_crtc)
> > +                     return;
>
> Either this return or the next one below would always be taken, I doubt t=
his was intended.

oops, the condition here is mistakenly inverted, it was meant to bail
if there is more than a single CRTC

>
> > +             wait_crtc =3D crtc;
> > +     }
> > +
> > +     /* If no CRTCs updated, then nothing to do: */
> > +     if (!wait_crtc)
> > +             return;
> > +
> > +     if (drm_crtc_next_vblank_time(wait_crtc, &vbltime))
> > +             return;
> > +
> > +     for_each_new_plane_in_state (state, plane, new_plane_state, i) {
> > +             if (!new_plane_state->fence)
> > +                     continue;
> > +             dma_fence_set_deadline(new_plane_state->fence, vbltime);
> > +     }
>
> vblank timestamps correspond to the end of vertical blank, the deadline s=
hould be the start of vertical blank though.
>

hmm, I suppose this depends on whether the hw actually has separate
irq's for frame-done and vblank (and whether the driver
differentiates).. and if the display controller is doing some
buffering, the point at which it wants to flip could be a bit earlier
still.  Maybe we just want a kms driver provided offset for how early
it wants the deadline relative to vblank?

BR,
-R

>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
