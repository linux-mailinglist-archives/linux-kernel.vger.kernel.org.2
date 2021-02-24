Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855483239E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhBXJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhBXJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:51:13 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA92C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:50:32 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id n195so1248136ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bm8OUtTjcP/3TkU7F1PFj1hpkFAw65wsKNu4InM5dSA=;
        b=ghwVW9pCKdDCdJ2w+KuW98xcoDHpSu8mKT7O8puj6+BGRaaTOLu50cNN6NHfJKU8+M
         gymvKlPEtKqpOYsOIN8Gku2i3S6XqsEWAZLiacVeSFr4UY/Su+KZIor7hmHRR8Yw7Q/0
         Fc1CEWh/oU8WEFJfcWUBQtZr4KhuUXlbmwdsIfqxzvkSWmzm/zTOlRLA0yOiiN8nqyGE
         9XpajQ+xfVqUThQ0o4IyDRlQraZvXBX0J3+VR3rZLBVpBjHcIeCUlUQgmllYBEY+hmXH
         a7YH0pyLrfj6xoWBPuGmnW8AI64pljl5ckhBbqZH69diz2v3NSBGi+RKf4ACGgu7iE5m
         qhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bm8OUtTjcP/3TkU7F1PFj1hpkFAw65wsKNu4InM5dSA=;
        b=rqV7q8Xx74YrqqBVM5kitRg7Q2HnMK6ArAz2fszh296KcCHkT0+yDuQ7h6JhuT9m5c
         mdUhIdu8hJQ/HE8qQIeJ5NwEGtAfqf4jnDeDx7Mj5wIUsJWf6icLO2XYTJlhN04cTRzN
         vSl/eB7xKZZBiwLn5ANOZ5GGCCvGehspl64fBS6gt0akxCHTnV1KZOM+Xbns5yMcD0Xr
         8yJZDe1yPnDeQQo/FfJXSeyT6kKgh2m4NGKwtAEUeO2/M5G2r2kwTGoX0DP1ZTiPfsj1
         7lpcQJdBE4yuSpK68DghKGaBVqscTCKd2CocK2JaIzPoi0uS1C5MK3ijcSWyZQA0bXmc
         EoPA==
X-Gm-Message-State: AOAM530vHr7LrErNbZEtPiuFAgFdOIdFTzjFpeqFekO7xcl9QrROifP+
        u0vscSHM60IO49ZBx2/rX7b25DrJhdZemdJmc52SDXKsb9gCQw==
X-Google-Smtp-Source: ABdhPJzmW7yuMW6jXgJWPEx5Uh7ezt0D71mmBkwTAAytvOkuI+mVWOE04yNfIK2XycFgQMot+cLd0uIH4JzUwIP/Jlo=
X-Received: by 2002:a25:e68c:: with SMTP id d134mr49378328ybh.94.1614160232205;
 Wed, 24 Feb 2021 01:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20210216161924.1687-1-diego.viola@gmail.com> <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
In-Reply-To: <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 24 Feb 2021 19:50:21 +1000
Message-ID: <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/pmu: fix timeout on GP108
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Diego Viola <diego.viola@gmail.com>,
        Roy Spliet <nouveau@spliet.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 at 13:30, Alexandre Courbot <gnurou@gmail.com> wrote:
>
> On Wed, Feb 17, 2021 at 1:20 AM Diego Viola <diego.viola@gmail.com> wrote:
> >
> > This code times out on GP108, probably because the BIOS puts it into a
> > bad state.
> >
> > Since we reset the PMU on driver load anyway, we are at no risk from
> > missing a response from it since we are not waiting for one to begin
> > with.
>
> This looks safe to me, provided indeed that the PMU's reset is not
> called outside of initialization (which for GP108 is shouldn't be
> IIRC?).
ISTR that the PMU FW we use prior to GM200 might depend on that being there.

I've posted a proposed alternate fix here[1], as we probably shouldn't
have been touching PMU there anyway on those GPUs.

Ben.

[1] https://github.com/skeggsb/linux/commit/90224a17437b1f39dbecbb385567c1fce958f992

>
> >
> > Signed-off-by: Diego Viola <diego.viola@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > index a0fe607c9c07..5c802f2d00cb 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > @@ -102,12 +102,8 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
> >         if (!pmu->func->enabled(pmu))
> >                 return 0;
> >
> > -       /* Inhibit interrupts, and wait for idle. */
> > +       /* Inhibit interrupts. */
> >         nvkm_wr32(device, 0x10a014, 0x0000ffff);
> > -       nvkm_msec(device, 2000,
> > -               if (!nvkm_rd32(device, 0x10a04c))
> > -                       break;
> > -       );
> >
> >         /* Reset. */
> >         if (pmu->func->reset)
> > --
> > 2.30.1
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
