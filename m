Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD33DDB8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhHBOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhHBOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:52:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7379C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:52:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z26so24371725oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQf/6EbtvsFGXCpLIeLMXCBjoYqQyEQy3L/J+5U6bGc=;
        b=NsJ515G2xH2144H0Y7aiHXlcN+J2IBvttrOnBkUxVrB6xDWp5kUbnIOhXXb+17dGbu
         BDdoRX9qk83R5vlZecP9wDwT8/+ah5dgvnefF54sHUMoi0x17oN8nPBcK8lnokl2Bjc9
         B3995Vb/3zXuqSUEJLj2sf7CFk6vvNNH9SG1p7p4LdyTEeEMDJ9yIHBLiX9daY5mi6IF
         YgRt+mPS9eA8b9a1rtNzUwcw8ywZWzhsZUogBk+RsXN6U71+2TSfw9t7cVhrKF1nB8sa
         C54WGnucXCEq2tNwTH2AsWbzrytXemrqUvKCP7YpF1TzEov44UG58J7nJ/3hPMXw8aIb
         AQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQf/6EbtvsFGXCpLIeLMXCBjoYqQyEQy3L/J+5U6bGc=;
        b=g+OlpWM71W5Y8G99GI+T7EUCZ2KQg73waO8gYj0G/qF6xWp8n+ndVDZ67kcOVVGhrE
         tcGEiCYB1cXvEdgH/EW4AOJZDG9DSekn8iI73/V4NC0TWppUu9vwjd4ph6dx/vg384Yr
         xjPBKSbnhiM1R8gnWKFCZPC2TffdxKQQtT1B3DNEpzyBD+BfprkCHkt2SnQ5b+o/VBxm
         pGNYa6kkLMXedgBPt5qrJh2OVJmaU+QToCycYHgUSSwz6H9K4x2pBuwZhk7AOPCdo5Lj
         sQ+VT1c4dw9POZiDUPm+s1sFVM/o9Y/zDg04A53KEQqZdE9oYYPO6W8vIyvurDBHFe9Y
         4ofg==
X-Gm-Message-State: AOAM531i45e2N8Fnp8wZjCGPkVxiipnQ+r/qMDX7zU4EDuWxHl6TTffm
        C2NRGwzsojCFHfxFmHVUlN4pzz/3QtypJ3L8Kfg=
X-Google-Smtp-Source: ABdhPJz5IBWEW1dGeE849/a2wNhSLuvgD7PQqTJoLLxdHUvh3aZXEK9puzLMtALjmRICYK+gSEVvSck2D24CEM71fLo=
X-Received: by 2002:a05:6808:6d2:: with SMTP id m18mr10578519oih.120.1627915922243;
 Mon, 02 Aug 2021 07:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com> <YQetXMaASz/F2EyS@phenom.ffwll.local>
In-Reply-To: <YQetXMaASz/F2EyS@phenom.ffwll.local>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Aug 2021 10:51:51 -0400
Message-ID: <CADnq5_PDtEn1y5HJBRHXw8o11LVwSRDKNtQgZtN5u0CW5ZspnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 4:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian K=C3=B6nig wrote:
> > Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> > > When primary bo is updated, crtc's pitch may
> > > have not been updated, this will lead to show
> > > disorder content when user changes display mode,
> > > we update crtc's pitch in page flip to avoid
> > > this bug.
> > > This refers to amdgpu's pageflip.
> >
> > Alex is the expert to ask about that code, but I'm not sure if that is
> > really correct for the old hardware.
> >
> > As far as I know the crtc's pitch should not change during a page flip,=
 but
> > only during a full mode set.
> >
> > So could you elaborate a bit more how you trigger this?
>
> legacy page_flip ioctl only verifies that the fb->format stays the same.
> It doesn't check anything else (afair never has), this is all up to
> drivers to verify.
>
> Personally I'd say add a check to reject this, since testing this and
> making sure it really works everywhere is probably a bit much on this old
> hw.

If just the pitch changed, that probably wouldn't be much of a
problem, but if the pitch is changing, that probably implies other
stuff has changed as well and we'll just be chasing changes.  I agree
it would be best to just reject anything other than updating the
scanout address.

Alex

> -Daniel
>
> >
> > Thanks,
> > Christian.
> >
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> > > ---
> > >   drivers/gpu/drm/radeon/evergreen.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/rad=
eon/evergreen.c
> > > index 36a888e1b179..eeb590d2dec2 100644
> > > --- a/drivers/gpu/drm/radeon/evergreen.c
> > > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > > @@ -28,6 +28,7 @@
> > >   #include <drm/drm_vblank.h>
> > >   #include <drm/radeon_drm.h>
> > > +#include <drm/drm_fourcc.h>
> > >   #include "atom.h"
> > >   #include "avivod.h"
> > > @@ -1414,10 +1415,15 @@ void evergreen_page_flip(struct radeon_device=
 *rdev, int crtc_id, u64 crtc_base,
> > >                      bool async)
> > >   {
> > >     struct radeon_crtc *radeon_crtc =3D rdev->mode_info.crtcs[crtc_id=
];
> > > +   struct drm_framebuffer *fb =3D radeon_crtc->base.primary->fb;
> > > -   /* update the scanout addresses */
> > > +   /* flip at hsync for async, default is vsync */
> > >     WREG32(EVERGREEN_GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
> > >            async ? EVERGREEN_GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
> > > +   /* update pitch */
> > > +   WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset,
> > > +          fb->pitches[0] / fb->format->cpp[0]);
> > > +   /* update the scanout addresses */
> > >     WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH + radeon_crtc-=
>crtc_offset,
> > >            upper_32_bits(crtc_base));
> > >     WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc=
_offset,
> > >
> > > No virus found
> > >             Checked by Hillstone Network AntiVirus
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
