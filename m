Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F553400BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCRITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCRISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:18:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:18:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z7so3167323lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O/WY2Bl4bEwXZZzzpuZUOllqUEJ+Z8Y/vfnp2iRL83U=;
        b=fDR0gy+9vrvudTQpd8ALd/Pi3bgro8qTAxQigVBuyYE5fefSUqrOPfNC94xzZedzqr
         hnq76OVGUfFwS258l8rVenrcSCgFjRhCa9YaAX7TnzAedyGfbM4+1uA/hycOT4YqveQS
         w0KJxg7X+yNYRMnow3I6GRXKOe3FCCuVG7vrk0qhV2jbEdiihLNndkQwV+e12UDRKlUO
         8HjL65l0MSrkY6pxpacWr5oD9JEIMF+jlWPlG7m53Y7Cm3EzOAGg52AHLRFVgQtPzWaY
         xHLP67ZuQ/DwGsmOM5ClC8/ngx/FaQSBvqSgeZhrmZ2se0TDayHUrvL8apgqXECSMHFJ
         nLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O/WY2Bl4bEwXZZzzpuZUOllqUEJ+Z8Y/vfnp2iRL83U=;
        b=jOS6f83lbPI4lHYBLibxE0YmLZ1WIOfEdLsUiGdRDVpZ3CM7MtDERTzNZP23QjkXv2
         Si1DMLbrOyKu4gerMDEp/MBs8vY6Dw9MNm5hCzDnw68cR5YCq8mNkwSIUSxdz1IfOkLE
         +xo1DKE93ewwp7pEhyEnsAl7HxsMLsqY/ukQBzRwZ7QmVi0w0DCV/sEdt/ZMgm7Wl4n1
         peknsuxlPoQjt8LdDbJWmojIKOcAgccbytJcefrVAXjv9hd75ySs243iMEIz+g8nMJUW
         shUrWKm4bkNaHBLuIRZIGyOxvkl3Cjm6cLzNr3VJpXLWyqAt7VwxU8vwEjr4McNtl94S
         wAng==
X-Gm-Message-State: AOAM530HPN6bzmhMZsPn8VsbFcg3HQIjfykaKJeNdTLrVyT1Jn0GeCUg
        fVPuZ06wutrTT9CAh+ky+f5xkb/Z+3aLDI859Fu+xA==
X-Google-Smtp-Source: ABdhPJxeSEGQ5VxzxzzuKMz+JRZK3Y8C7XkLNiducFb7gkrMCDzzC+lAffXBLb1HjWZ0YQ0AsfAJEhTXxhi/sUbQYT4=
X-Received: by 2002:a19:791e:: with SMTP id u30mr4703038lfc.621.1616055509025;
 Thu, 18 Mar 2021 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210317160840.36019-1-daniel@qtec.com> <bb94b582-a720-9c4f-3d37-d1f7fd29da44@amd.com>
In-Reply-To: <bb94b582-a720-9c4f-3d37-d1f7fd29da44@amd.com>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Thu, 18 Mar 2021 09:18:17 +0100
Message-ID: <CAH1Ww+SBgw6-HikPBpE1_yLG-X75LfSBbNerzzqBzyCArgm1-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 08:49, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 17.03.21 um 17:08 schrieb Daniel Gomez:
> > If userptr pages have been pinned but not bounded,
> > they remain uncleared.
> >
> > Signed-off-by: Daniel Gomez <daniel@qtec.com>
>
> Good catch, not sure if that can ever happen in practice but better save
> than sorry.
Thanks! We actually had a case with clEnqueueWriteBuffer where the
driver was leaking.
I can see the problem also affects to the radeon driver so, I'll send
a patch for that one as
well.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 9fd2157b133a..50c2b4827c13 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1162,13 +1162,13 @@ static void amdgpu_ttm_backend_unbind(struct tt=
m_bo_device *bdev,
> >       struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
> >       int r;
> >
> > -     if (!gtt->bound)
> > -             return;
> > -
> >       /* if the pages have userptr pinning then clear that first */
> >       if (gtt->userptr)
> >               amdgpu_ttm_tt_unpin_userptr(bdev, ttm);
> >
> > +     if (!gtt->bound)
> > +             return;
> > +
> >       if (gtt->offset =3D=3D AMDGPU_BO_INVALID_OFFSET)
> >               return;
> >
>
