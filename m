Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB9324A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 06:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhBYFil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 00:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhBYFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 00:38:32 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:37:52 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d5so3915622iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5d9tiVZiSmpYw9Kzo6OPD2MnxpXtmVp9YVqjAIMjME=;
        b=N4/1dq8IxosfqqcyRqFUKzf0LEF+uEbdtBPMjcXviAg8s3TEjBbtQPKgXjcEsC2zFw
         63MzRx2oMJeSEBepMA/RhLLvF4VDJvL3cuMoZIoDbP4Rdk9UUXYBh0v8N5RQK2qCZ+yN
         yedIew1DWaEoPXcTa47tEmILM4wUMo1aq1+gJWZcWroXQR664VLei5soaSN6YkR9OWsS
         11hatA1aJOEu1d5OEdBMfmCvkJSHJaQGRmc8zffpHOZTPLGr+0XGq5rxQqy0pf0h6PNN
         jXgJLv0NU8CiERAQVL4gsFu7KClcmg1MnqiiLdmQWOnn0KEWM0CBRoj8i1d3aR/STm4O
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5d9tiVZiSmpYw9Kzo6OPD2MnxpXtmVp9YVqjAIMjME=;
        b=H9zmKimUZ4OCHnPha+oAY7/dWlx0wi0EarHPJbp5yefBqLauNjq4h7j+41GeO6ttyy
         W1mh9h5p5i/A6CxxM5PKyxN9HfmjBsibsGGuJgAVDX6oWNtDFXH0k8JUcSFgbHYbX+B8
         NEt+/DFEHQXg6yqZ+Ab4P4srLEZCP1vzXCLaLztQAHzpZYMeMcZ/tkIp49Xqc6dLCl32
         RI4E3nUB4MF9EYqpbNS4mJ2tVaeIm7UM6f8QCxRN3q8Tnk4wNMADvlC2bMGEMb+7UNyD
         pNybqwk9l0tqglp9SE/rTn+P4SmTlw5bbP9WDmDmcjxQy6KBqo+wltzXRLltvFTd/fle
         cUhg==
X-Gm-Message-State: AOAM533hR0REO5XlUNg4EKSZpoed7B2Yk2Fq7qmtD2jHI9jMQyrKAYdB
        bITXMSEMgm6IHCXJ9Xq5lkf9K++2MPrByuTlNb4=
X-Google-Smtp-Source: ABdhPJwOX4LdSs88ZQuWV3zM9JR/5lpinl1Y/17aNQwTMSnOrxFgeHzdFQlA0MjmlzuQve8I48uu2pf2cv/QB520s3o=
X-Received: by 2002:a05:6e02:12e2:: with SMTP id l2mr1158655iln.91.1614231471697;
 Wed, 24 Feb 2021 21:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20210216161924.1687-1-diego.viola@gmail.com> <CAAVeFuLLw+pb-vvxPbbgDGGLo4Vi-ReJAh_YH-3xUZEDyhDb-Q@mail.gmail.com>
 <CACAvsv43MhF2JUUhLbxk+aaMkforpF1bvggyfJR=MOnv3wMCfA@mail.gmail.com> <CA+ToGPHOb46YRJmKbEUXv9hqo0fjeGxPQEoQiWniX7WUuVJypA@mail.gmail.com>
In-Reply-To: <CA+ToGPHOb46YRJmKbEUXv9hqo0fjeGxPQEoQiWniX7WUuVJypA@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 25 Feb 2021 02:37:40 -0300
Message-ID: <CA+ToGPH+afKCW=e_Z5a=WmzpUbg9JaJh0pCGujXx+D6US0SypQ@mail.gmail.com>
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

On Thu, Feb 25, 2021 at 2:22 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> Hi Ben,
>
> I can confirm that your last two patches[0][1] fix the timeout issues
> (those from a normal boot and from suspend/resume).
>
> [0] https://github.com/skeggsb/linux/commit/90224a17437b1f39dbecbb385567c1fce958f992
> [1] https://github.com/skeggsb/linux/commit/0ee6dc49601359042fd254bbd8ba6b4685b4d0d7
>
> Tested-by: Diego Viola <diego.viola@gmail.com>
>
> on both patches.
>
> Thanks, I appreciate it a lot.
>
> Diego
>
> On Wed, Feb 24, 2021 at 6:50 AM Ben Skeggs <skeggsb@gmail.com> wrote:
> >
> > On Wed, 17 Feb 2021 at 13:30, Alexandre Courbot <gnurou@gmail.com> wrote:
> > >
> > > On Wed, Feb 17, 2021 at 1:20 AM Diego Viola <diego.viola@gmail.com> wrote:
> > > >
> > > > This code times out on GP108, probably because the BIOS puts it into a
> > > > bad state.
> > > >
> > > > Since we reset the PMU on driver load anyway, we are at no risk from
> > > > missing a response from it since we are not waiting for one to begin
> > > > with.
> > >
> > > This looks safe to me, provided indeed that the PMU's reset is not
> > > called outside of initialization (which for GP108 is shouldn't be
> > > IIRC?).
> > ISTR that the PMU FW we use prior to GM200 might depend on that being there.
> >
> > I've posted a proposed alternate fix here[1], as we probably shouldn't
> > have been touching PMU there anyway on those GPUs.
> >
> > Ben.
> >
> > [1] https://github.com/skeggsb/linux/commit/90224a17437b1f39dbecbb385567c1fce958f992
> >
> > >
> > > >
> > > > Signed-off-by: Diego Viola <diego.viola@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 6 +-----
> > > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > > index a0fe607c9c07..5c802f2d00cb 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
> > > > @@ -102,12 +102,8 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
> > > >         if (!pmu->func->enabled(pmu))
> > > >                 return 0;
> > > >
> > > > -       /* Inhibit interrupts, and wait for idle. */
> > > > +       /* Inhibit interrupts. */
> > > >         nvkm_wr32(device, 0x10a014, 0x0000ffff);
> > > > -       nvkm_msec(device, 2000,
> > > > -               if (!nvkm_rd32(device, 0x10a04c))
> > > > -                       break;
> > > > -       );
> > > >
> > > >         /* Reset. */
> > > >         if (pmu->func->reset)
> > > > --
> > > > 2.30.1
> > > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel

Ugh, sorry for breaking the regular email flow/order. Damn you gmail!

Regards,
Diego
