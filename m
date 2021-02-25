Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992BB3249A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhBYEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhBYEFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:05:49 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03040C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:05:08 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y202so4499096iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XD17gQa9AzXjPB2+GwY8mzC45sraIQo5gpXDP4ure1o=;
        b=bPb6mNiXnQc/cPMp9kwbrwkLzyQHc606ZvE4kAzY3fqBNnKzWdh2eoI/6JO3Q7H1mr
         dWFjQTo23H3mLPbhxV0YC1GqpUAM13cfIQ5j9h0mjwjSFtylke6BtT8fAA4MsRwwg7qm
         joaFjTJUJp2mi/x0JFuiTrIaDQhGJUtO6jHGpufvQfyxD7bLQQYY1ju1cfn/W8tUQ/lJ
         5YOg1pW6UVaG1+N/+40KDOyUWtmD9/dEX8n+4csH2s9dh2AlZ82n2QxObfoNPYcQfzd8
         BQWHuMYDRVjh5zOGmRDZbD14hTH8GbtKyW1e5k2X0a7R6P+8Q7deEZbnGe7lzffm1fPN
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XD17gQa9AzXjPB2+GwY8mzC45sraIQo5gpXDP4ure1o=;
        b=Rmjk80KCglGaYhZXuIivUQHXEFQDDNFElhGDe58Pdw7J86KyIWErH3d4VhmXwqzgOQ
         PdoGumQFaAUmjGEX3xXuWj0Xt2l/BQ5b8R9EHq1+iLZDjAco1KpJPqUHnoWbUIGpgapW
         wq7AtLaMNU/84B5fWZQ3ahN9hz2b/gncodbtXTl6f+aQUC0O//0LJZ3KRkMEn9+TgYiX
         +YlbhpAEglySY/MDR3X/4k9JstQiE4MiigiXxLcIlga6KlQfHe5jiOaFD935Zuqj7wr1
         H2XOS/fHljLH0s8Z31bBU5/PSENYUQVR+5A2KVSrFdOU7yHimX7zZc6o/6FrE7ykyMbf
         8DAA==
X-Gm-Message-State: AOAM532cv1/OtUJbvuUR/QFc11wiUENyEC5qBvmP7S58XegsXgbd9/ln
        eT1b+j2PsoI256PP5Nv4oIWayfvjcbj8Go6ELiM=
X-Google-Smtp-Source: ABdhPJxMw5BHpEmnhuE/5xT/Q0PWhkJj1c6h9DIQ2pkBnQBM5DiitsjnA+siDqMH3cEe40ib+U+JwvYOdG2wbS350PM=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr1064581iop.50.1614225908176;
 Wed, 24 Feb 2021 20:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20210216161924.1687-1-diego.viola@gmail.com> <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
 <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com>
In-Reply-To: <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 25 Feb 2021 01:04:57 -0300
Message-ID: <CA+ToGPErqo46Eu_ryzBb9nOAw4FKyhUD5sd9xciBqn231n=9Mw@mail.gmail.com>
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

I tested your patch and can confirm that the timeout is gone after
booting my system, but unfortunately it's back after doing a
suspend/resume.

Any ideas about that?

Thanks,
Diego
