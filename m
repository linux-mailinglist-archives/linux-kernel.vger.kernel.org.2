Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F43156D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhBIT30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhBIRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:54:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F680C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:52:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j11so4054128wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qurygo4Yly3E1f1TWQ/u0Ebw8nzovdEmMUxw2+PKiCo=;
        b=K35gV+8NMJSWwwxDrkLuHwrWWuHpkmJkmG4mvkTBKjTAaGngMJCLk5NZ/hTQ4U4LL6
         qRMkICzaKw/y171PpJTFQqr9T+a6vhtnGWfCTQ6hB1maXAS6vSw8jm5q57LQmusLAEtq
         h2EjKTzOaINuT+DiBTluDESqMOm8eMPz7EQW65rFigeH8Fqgtro1IEtFjrEyigKBDx7J
         intSDB7+hXaetanspdaqRq5Gm5JRn1H/Gb0dDZi29GSZSIBkJHZV1XeFiT2tkv+gIthJ
         0tLJ87YnrUp1AwZlT1YgHVI2+ompMTtfyCg51ddCb2p3S35Mt19EqT2m0IwMtaUhaJI7
         AFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qurygo4Yly3E1f1TWQ/u0Ebw8nzovdEmMUxw2+PKiCo=;
        b=sWrn9iJYA90xhqfUVpiV79hNk8zaoQP32kV0iGXSCkXdiRFPPyFHKuPzJeqz+yThh/
         d1jVAAnr6XLYatXXEQNJevj3KrAkNieY2hTEMq7PR5pGfuqsx/sDAOdoL7TY0HQJ+cA8
         gM+GsQzLbeQbYJuVmgzqDbY3zK73aY00nCTPvYUSzuoqHiLUIm4A9D8M/3NAW3/qYGP8
         HeINfSROJS+9po9Oi8AsGebX6dTyyw/kJx8MY/KdFhi7ty0L1pXal6iH4K9OYOsyfVvg
         KTDKsWuiY/l8jOFkJ13fZIoXy084XLbxOrICls5WCg+xSgnXLkd0UW91EOrJbPfYzX1a
         6tMQ==
X-Gm-Message-State: AOAM532+Gw/jV1WjkKJ2Ieo57sdRidt+cHs7I2E+anManFDoGHVltWeL
        Zb4594a0h11dYdtUTbfpHdylZsMQggowQrrtheK7+TGYyRls5Q==
X-Google-Smtp-Source: ABdhPJw/ZzytWg5CW789jXtqWr/Y1tuEN+eZ9OSIglt0n9y2jznG7vlnoXKyR+aJ+kNl/OAcTgGKefXnuLeCi6HOwfU=
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr4467411wmq.126.1612893166675;
 Tue, 09 Feb 2021 09:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20210205080621.3102035-1-john.stultz@linaro.org>
 <20210205080621.3102035-2-john.stultz@linaro.org> <4471b3b0-603e-6dbb-8064-ff4a95afbba9@amd.com>
 <CALAqxLWZkUFvJX5r2OU2erW4tU3j=+u==VTyzYkt+95LwwVCUA@mail.gmail.com>
 <48225879-2fe1-22ac-daae-c61d52465aea@amd.com> <a9dd7f8a-ef30-9eb4-4834-37801d43b96f@amd.com>
 <CAJuCfpE-T4Cs_h6LfrgHE+T_iOVywU2oNzLquYETudOaBMauMQ@mail.gmail.com> <c7df099f-27f7-adc6-4e87-9903ac00cbea@amd.com>
In-Reply-To: <c7df099f-27f7-adc6-4e87-9903ac00cbea@amd.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 9 Feb 2021 09:52:35 -0800
Message-ID: <CAJuCfpHrvv8PAWdSMPK-=mtrgje9LrrNC-NC81=T5S+4YOw63w@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 1/7] drm: Add a sharable drm page-pool implementation
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 9:46 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
>
>
> Am 09.02.21 um 18:33 schrieb Suren Baghdasaryan:
> > On Tue, Feb 9, 2021 at 4:57 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Am 09.02.21 um 13:11 schrieb Christian K=C3=B6nig:
> >>> [SNIP]
> >>>>>> +void drm_page_pool_add(struct drm_page_pool *pool, struct page *p=
age)
> >>>>>> +{
> >>>>>> +     spin_lock(&pool->lock);
> >>>>>> +     list_add_tail(&page->lru, &pool->items);
> >>>>>> +     pool->count++;
> >>>>>> +     atomic_long_add(1 << pool->order, &total_pages);
> >>>>>> +     spin_unlock(&pool->lock);
> >>>>>> +
> >>>>>> +     mod_node_page_state(page_pgdat(page),
> >>>>>> NR_KERNEL_MISC_RECLAIMABLE,
> >>>>>> +                         1 << pool->order);
> >>>>> Hui what? What should that be good for?
> >>>> This is a carryover from the ION page pool implementation:
> >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
git.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2F=
tree%2Fdrivers%2Fstaging%2Fandroid%2Fion%2Fion_page_pool.c%3Fh%3Dv5.10%23n2=
8&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7Cdccccff8edcd4d147a5b08d=
8cd20cff2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637484888114923580%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C1000&amp;sdata=3D9%2BIBC0tezSV6Ci4S3kWfW%2BQvJm4mdunn3dF6C=
0kyfCw%3D&amp;reserved=3D0
> >>>>
> >>>>
> >>>> My sense is it helps with the vmstat/meminfo accounting so folks can
> >>>> see the cached pages are shrinkable/freeable. This maybe falls under
> >>>> other dmabuf accounting/stats discussions, so I'm happy to remove it
> >>>> for now, or let the drivers using the shared page pool logic handle
> >>>> the accounting themselves?
> >> Intentionally separated the discussion for that here.
> >>
> >> As far as I can see this is just bluntly incorrect.
> >>
> >> Either the page is reclaimable or it is part of our pool and freeable
> >> through the shrinker, but never ever both.
> > IIRC the original motivation for counting ION pooled pages as
> > reclaimable was to include them into /proc/meminfo's MemAvailable
> > calculations. NR_KERNEL_MISC_RECLAIMABLE defined as "reclaimable
> > non-slab kernel pages" seems like a good place to account for them but
> > I might be wrong.
>
> Yeah, that's what I see here as well. But exactly that is utterly nonsens=
e.
>
> Those pages are not "free" in the sense that get_free_page could return
> them directly.

Any ideas where these pages would fit better? We do want to know that
under memory pressure these pages can be made available (which is I
think what MemAvailable means).

>
> Regards,
> Christian.
>
> >
> >> In the best case this just messes up the accounting, in the worst case
> >> it can cause memory corruption.
> >>
> >> Christian.
>
