Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBF342CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCTNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhCTNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 09:01:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE269C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 06:01:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so6209538pjv.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ON3r+aiJR5Q+UUgakEzAMuWKjcsi9+uuz4/fBWDEro=;
        b=QZgnK16rXyq85ehDyAiQXZvR70iLXG5F0ewNKUe8pvMEOjHRjNFx/ZCmcXpTkz6m2E
         o51J3PDpJFFIlxyJ/tPi7hx0MNf338zs7jhG42/ym/TcxPnnowQMIUsCr9U+6LLxXjDn
         7fcZJT1iFquSBRa24aLwPa1iXN+8Y+Ea668zFzLm6wWUJYF8JjGplr6MnerBT/b65cGu
         SNs/wRNJ7VGLoqwRHc0GPSNgQWmilhW+siP8nyr+A94M7oepd6rJ5lVgtitNPRpmwsdc
         rBQnZ0J+Vm7jtSK4gaNDhI2oKKOhszLw8dqHrxJUzDV4VmFHmTx8DO06GeaMhuqgiP8Q
         Pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ON3r+aiJR5Q+UUgakEzAMuWKjcsi9+uuz4/fBWDEro=;
        b=OVlqWxdDLgNSO5I+t0lriGax9RNmklCCIvsZzZ66lDtRnJ5j5GSBXnpn9NaSN0pcn/
         4ApRhB2Mi055Y41ZCEa2rfF01SJJlrsoyIwnueXqvKTRN/NzfZ1jlo246MH96QjfTcM2
         RDX43PV0TtflEB0Hwi7fb4LDtfENMyRb8joB4eTaYJ6yQn/ev2D1I+DnmNByvdSgmOD7
         IS/mTmVYPoxcdkW7WJDDMvU/YQpVn+N/Cb+y5rxRQJ6A/Skl8PUp0ZxtknTcRKOi8B8X
         8ssNstyLjtfe7a7DzZFZEIl7BM0bp1Nv/rrh2TQSrufHcRaSMBLPu2RSJO4ldwUS/yrM
         1r6w==
X-Gm-Message-State: AOAM530OaOtN2ZKhRptE2CjPRNHrMC3ZOMkzgC6I15k9e1G6MwfmTaX2
        VcRRRHaWMiAk5h9Ij1cQUVMmsNSPSia2R0Kd3vI=
X-Google-Smtp-Source: ABdhPJwu0PgawlU0aWRzBKCj1+2gsUvraBIaBwJWOXpTMjPRxKpSzNQ3z/8nQ5/HfHn5A1slZVncNDIhR+lGjrUS+Cg=
X-Received: by 2002:a17:90a:4104:: with SMTP id u4mr3445045pjf.81.1616245278293;
 Sat, 20 Mar 2021 06:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
 <20210206083552.24394-2-lecopzer.chen@mediatek.com> <20210319173758.GC6832@arm.com>
In-Reply-To: <20210319173758.GC6832@arm.com>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Sat, 20 Mar 2021 21:01:07 +0800
Message-ID: <CANr2M18q-EfmUvX=LbP2wLOX-=qJqPK9cH=EUKp3T9Nh6SLsGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        ardb@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        broonie@kernel.org, linux@roeck-us.net, rppt@kernel.org,
        tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 1:38 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Feb 06, 2021 at 04:35:48PM +0800, Lecopzer Chen wrote:
> > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> >
> > Like how the MODULES_VADDR does now, just not to early populate
> > the VMALLOC_START between VMALLOC_END.
> >
> > Before:
> >
> > MODULE_VADDR: no mapping, no zoreo shadow at init
> > VMALLOC_VADDR: backed with zero shadow at init
> >
> > After:
> >
> > MODULE_VADDR: no mapping, no zoreo shadow at init
> > VMALLOC_VADDR: no mapping, no zoreo shadow at init
>
> s/zoreo/zero/
>

thanks!

> > Thus the mapping will get allocated on demand by the core function
> > of KASAN_VMALLOC.
> >
> >   -----------  vmalloc_shadow_start
> >  |           |
> >  |           |
> >  |           | <= non-mapping
> >  |           |
> >  |           |
> >  |-----------|
> >  |///////////|<- kimage shadow with page table mapping.
> >  |-----------|
> >  |           |
> >  |           | <= non-mapping
> >  |           |
> >  ------------- vmalloc_shadow_end
> >  |00000000000|
> >  |00000000000| <= Zero shadow
> >  |00000000000|
> >  ------------- KASAN_SHADOW_END
> >
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/kasan_init.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index d8e66c78440e..20d06008785f 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> >  {
> >       u64 kimg_shadow_start, kimg_shadow_end;
> >       u64 mod_shadow_start, mod_shadow_end;
> > +     u64 vmalloc_shadow_end;
> >       phys_addr_t pa_start, pa_end;
> >       u64 i;
> >
> > @@ -223,6 +224,8 @@ static void __init kasan_init_shadow(void)
> >       mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> >       mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> >
> > +     vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> > +
> >       /*
> >        * We are going to perform proper setup of shadow memory.
> >        * At first we should unmap early shadow (clear_pgds() call below).
> > @@ -241,12 +244,17 @@ static void __init kasan_init_shadow(void)
> >
> >       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
> >                                  (void *)mod_shadow_start);
> > -     kasan_populate_early_shadow((void *)kimg_shadow_end,
> > -                                (void *)KASAN_SHADOW_END);
> >
> > -     if (kimg_shadow_start > mod_shadow_end)
> > -             kasan_populate_early_shadow((void *)mod_shadow_end,
> > -                                         (void *)kimg_shadow_start);
>
> Not something introduced by this patch but what happens if this
> condition is false? It means that kimg_shadow_end < mod_shadow_start and
> the above kasan_populate_early_shadow(PAGE_END, mod_shadow_start)
> overlaps with the earlier kasan_map_populate(kimg_shadow_start,
> kimg_shadow_end).

In this case, the area between mod_shadow_start and kimg_shadow_end
was mapping when kasan init.

Thus the corner case is that module_alloc() allocates that range
(the area between mod_shadow_start and kimg_shadow_end) again.


With VMALLOC_KASAN,
module_alloc() ->
    ... ->
        kasan_populate_vmalloc ->
            apply_to_page_range()
will check the mapping exists or not and bypass allocating new mapping
if it exists.
So it should be fine in the second allocation.

Without VMALLOC_KASAN,
module_alloc() ->
    kasan_module_alloc()
will allocate the range twice, first time is kasan_map_populate() and
second time is vmalloc(),
and this should have some problems(?).

Now the only possibility that the module area can overlap with kimage
should be KASLR on.
I'm not sure if this is the case that really happens in KASLR, it depends on
how __relocate_kernel() calculates kimage and how kaslr_earlt_init()
decides module_alloc_base.


> > +     if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> > +             kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> > +                                         (void *)KASAN_SHADOW_END);
> > +     else {
> > +             kasan_populate_early_shadow((void *)kimg_shadow_end,
> > +                                         (void *)KASAN_SHADOW_END);
> > +             if (kimg_shadow_start > mod_shadow_end)
> > +                     kasan_populate_early_shadow((void *)mod_shadow_end,
> > +                                                 (void *)kimg_shadow_start);
> > +     }
> >
> >       for_each_mem_range(i, &pa_start, &pa_end) {
> >               void *start = (void *)__phys_to_virt(pa_start);
> > --
> > 2.25.1
> >
