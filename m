Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ACD324A02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 06:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBYFXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 00:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhBYFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 00:23:31 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:22:51 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h18so3892593ils.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBGLbUHfWX61SiPuGbVl+z4WV/5RdoCYOnTg8ALW4Zg=;
        b=DVAmSyuk+BaSYeGygm5m0R8sQPLdVwq/XOvT42QyATnyJ5AE2bLe8sVQkhInWYpMVi
         cxUKfMBwiHIEmztfiZ/3h8TJKddNEekmOm7GYYwuiwIaIuwnMUtjKsbbf0q5bNxK5d2k
         9C2G/EDOFR2Pnd+Hzr92cMjuy+1rrwZvgriKT/V1A2LxTSoy+BrndozazEO1we9OQTFT
         L1LD8lsG/Kqfc86TNHyh4iGNhhFL96QFkfPdvNqnAiDXzU+nFNQe9iXtxlQzKqwt32Bz
         6T2jB/7TCecIvKmuHUArNRm/1MmVohOaOzc0IKLkh51jCYd5H/r+AdOMkQW5Iob6gRkZ
         qQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBGLbUHfWX61SiPuGbVl+z4WV/5RdoCYOnTg8ALW4Zg=;
        b=UJFpEfetprqjHA3KmDlJKzl6HE6O4EvpCUTxjcvz2Dh+oKHE2/2ReCmWoZ3BcrJ89Z
         AV1Z35lnG3Id/EwvCe6ho4wVPSXwCDcYODO+9xM+TOIxCN73Nz8o8RiCkRrtcTM9bG1C
         23zX7R1Y4RuvMK1w+77VDpiKCqZ4/0L+ECMEs7c6qeGNPIeU1/EZdjijJ2H/K6b1FwyZ
         iXJKgz/6D6ISCkpbkOtNffZHUYzmr/1++YGnjDwH3GgO21xSfw3HycN5Jr9RfFmNl0Bo
         ZXHwd8nFbYk4XlcNAcToyZVGpEeJd0XLKjkmyHGg+J6vvlFcFM5piVvff0zvQpvEKSOR
         N3rw==
X-Gm-Message-State: AOAM532CUBORDlgSOnSeLCrugU3xMBFlzZUsHKHoQKQH+COwYB+Lx3pX
        eewFhhDrY4p7SEm5ctWe9/kdzFqa9Ok80r/mfI8=
X-Google-Smtp-Source: ABdhPJxcuyMPHuz3RT7RRJD234eggZ4GCOSwBDp7tCEvVpntXbijLoSuT8C44xvcJuxdkHusqs1wDwa5dBlSFQ6Tcb4=
X-Received: by 2002:a05:6e02:b46:: with SMTP id f6mr1015099ilu.230.1614230570310;
 Wed, 24 Feb 2021 21:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20210216161924.1687-1-diego.viola@gmail.com> <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
 <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com>
In-Reply-To: <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 25 Feb 2021 02:22:39 -0300
Message-ID: <CA+ToGPHOb46YRJmKbEUXv9hqo0fjeGxPQEoQiWniX7WUuVJypA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/pmu: fix timeout on GP108
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Roy Spliet <nouveau@spliet.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I can confirm that your last two patches[0][1] fix the timeout issues
(those from a normal boot and from suspend/resume).

[0] https://github.com/skeggsb/linux/commit/90224a17437b1f39dbecbb385567c1fce958f992
[1] https://github.com/skeggsb/linux/commit/0ee6dc49601359042fd254bbd8ba6b4685b4d0d7

Tested-by: Diego Viola <diego.viola@gmail.com>

on both patches.

Thanks, I appreciate it a lot.

Diego

On Wed, Feb 24, 2021 at 6:50 AM Ben Skeggs <skeggsb@gmail.com> wrote:
>
> On Wed, 17 Feb 2021 at 13:30, Alexandre Courbot <gnurou@gmail.com> wrote:
> >
> > On Wed, Feb 17, 2021 at 1:20 AM Diego Viola <diego.viola@gmail.com> wrote:
> > >
> > > This code times out on GP108, probably because the BIOS puts it into a
> > > bad state.
> > >
> > > Since we reset the PMU on driver load anyway, we are at no risk from
> > > missing a response from it since we are not waiting for one to begin
> > > with.
> >
> > This looks safe to me, provided indeed that the PMU's reset is not
> > called outside of initialization (which for GP108 is shouldn't be
> > IIRC?).
> ISTR that the PMU FW we use prior to GM200 might depend on that being there.
>
> I've posted a proposed alternate fix here[1], as we probably shouldn't
> have been touching PMU there anyway on those GPUs.
>
> Ben.
>
> [1] https://github.com/skeggsb/linux/commit/90224a17437b1f39dbecbb385567c1fce958f992
>
> >
> > >
> > > Signed-off-by: Diego Viola <diego.viola@gmail.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > index a0fe607c9c07..5c802f2d00cb 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > @@ -102,12 +102,8 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
> > >         if (!pmu->func->enabled(pmu))
> > >                 return 0;
> > >
> > > -       /* Inhibit interrupts, and wait for idle. */
> > > +       /* Inhibit interrupts. */
> > >         nvkm_wr32(device, 0x10a014, 0x0000ffff);
> > > -       nvkm_msec(device, 2000,
> > > -               if (!nvkm_rd32(device, 0x10a04c))
> > > -                       break;
> > > -       );
> > >
> > >         /* Reset. */
> > >         if (pmu->func->reset)
> > > --
> > > 2.30.1
> > >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
