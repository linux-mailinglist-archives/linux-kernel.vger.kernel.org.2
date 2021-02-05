Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2773112D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBETLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhBETJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:09:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D0C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:51:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so4503367pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZLU4c8CFtN82E3juz+QcV9FF1JDMzfdyAO1GFaD3hY=;
        b=J97dVjLjNvVby8Zj4bXfcz649DPZ5fll8CrBpuA3qsFXESA71JYiLLqk+X5dDf8a0j
         ikNvcC0IAmPZP9XrKnHt9U/nl8zMeP6sp8swP1r7kG6gSV9cg3XGj6Ko1sTUpE2/sCAh
         eE5GKW8Q1KkIwGB4vAgreo8VVLF94i+b6AaR8nGGUcM0Qiyhwr/yR+/nPeNRCVugL96m
         epq0XpBdpwKhuGLuMCPlSb14MqbXvZ7SHT5a9B+S9itLinpXDAKG82KEXd0IK8yR48Qk
         LzdU3dMG8eMMwLoIGGQ+g9EqSwy3OuwJjyGscGtU9rzazozWwYDT2eo/U9O0DLq374qW
         H9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZLU4c8CFtN82E3juz+QcV9FF1JDMzfdyAO1GFaD3hY=;
        b=pvidmVGwJsDN3lDQ+MFvz6Cw3sglx1jxEaY8WKJYmyalyGntPwRYDHEcxDNu0Jbj+b
         I06yCpFT1PuqdUwHcVIS/wqIPEPwuSS+TIGMI2TykV58TNTNJyaWECQgMKoQI26Ug1TD
         7drtv9Xy0oSSxdwpkbdDTzcbcTHIsPReiesPf6eTiYJxufPdfz2QTeKhLskD/Ep85F55
         4KXOX/2ye6QxD1/pcXiuHMl53IGxikl2OgzEb4ZBFhbgfXMA54sKQEdtrz89MmUvIiTm
         akQk72Fff3CLJJCi4rbhbtdYKnPP/ShFOKth7muvPiv5xnGt3/p8wlI01mRTVdW8654V
         2tsA==
X-Gm-Message-State: AOAM531hZXUfYkrm3A6YkBPxzPSe8/iT0eomk5ivBxCxy74zzavmXc9Y
        pL+q2rt/VdJH0wgD503Z8M24QXOyEgnuW7c+3OOJ6g==
X-Google-Smtp-Source: ABdhPJyapOvhRRqZ+bQIBXS8rWxLcpUPYbQDSO/D7VDIaq2PS0n8HmEJl5SVaOYTt6EAsXuZBRAOpQBkCOHcYirmJBs=
X-Received: by 2002:a17:90b:3756:: with SMTP id ne22mr5531867pjb.41.1612558266710;
 Fri, 05 Feb 2021 12:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20210204150100.GE20815@willie-the-truck> <20210204163721.91295-1-lecopzer@gmail.com>
 <20210205171859.GE22665@willie-the-truck> <CAAeHK+zppv6P+PqAuZqAfd7++QxhA1rPX6vdY5MyYK_v6YdXSA@mail.gmail.com>
 <20210205174301.GF22665@willie-the-truck>
In-Reply-To: <20210205174301.GF22665@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Feb 2021 21:50:55 +0100
Message-ID: <CAAeHK+ysNmkxEZqQ_rEsa7bh_ZZEtOHaMstXumtzWJLu1LdDyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
To:     Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>, rppt@kernel.org,
        tyhicks@linux.microsoft.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:43 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 06:30:44PM +0100, Andrey Konovalov wrote:
> > On Fri, Feb 5, 2021 at 6:19 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, Feb 05, 2021 at 12:37:21AM +0800, Lecopzer Chen wrote:
> > > >
> > > > > On Thu, Feb 04, 2021 at 10:46:12PM +0800, Lecopzer Chen wrote:
> > > > > > > On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> > > > > > > > Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > > > > > > ("kasan: support backing vmalloc space with real shadow memory")
> > > > > > > >
> > > > > > > > Like how the MODULES_VADDR does now, just not to early populate
> > > > > > > > the VMALLOC_START between VMALLOC_END.
> > > > > > > > similarly, the kernel code mapping is now in the VMALLOC area and
> > > > > > > > should keep these area populated.
> > > > > > > >
> > > > > > > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > > > > > > ---
> > > > > > > >  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
> > > > > > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > > > > > > > index d8e66c78440e..39b218a64279 100644
> > > > > > > > --- a/arch/arm64/mm/kasan_init.c
> > > > > > > > +++ b/arch/arm64/mm/kasan_init.c
> > > > > > > > @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
> > > > > > > >  {
> > > > > > > >   u64 kimg_shadow_start, kimg_shadow_end;
> > > > > > > >   u64 mod_shadow_start, mod_shadow_end;
> > > > > > > > + u64 vmalloc_shadow_start, vmalloc_shadow_end;
> > > > > > > >   phys_addr_t pa_start, pa_end;
> > > > > > > >   u64 i;
> > > > > > > >
> > > > > > > > @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
> > > > > > > >   mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
> > > > > > > >   mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > > > > > > >
> > > > > > > > + vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> > > > > > > > + vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> > > > > > > > +
> > > > > > > >   /*
> > > > > > > >    * We are going to perform proper setup of shadow memory.
> > > > > > > >    * At first we should unmap early shadow (clear_pgds() call below).
> > > > > > > > @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
> > > > > > > >
> > > > > > > >   kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
> > > > > > > >                              (void *)mod_shadow_start);
> > > > > > > > - kasan_populate_early_shadow((void *)kimg_shadow_end,
> > > > > > > > -                            (void *)KASAN_SHADOW_END);
> > > > > > > > + if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> > > > > > >
> > > > > > > Do we really need yet another CONFIG option for KASAN? What's the use-case
> > > > > > > for *not* enabling this if you're already enabling one of the KASAN
> > > > > > > backends?
> > > > > >
> > > > > > As I know, KASAN_VMALLOC now only supports KASAN_GENERIC and also
> > > > > > KASAN_VMALLOC uses more memory to map real shadow memory (1/8 of vmalloc va).
> > > > >
> > > > > The shadow is allocated dynamically though, isn't it?
> > > >
> > > > Yes, but It's still a cost.
> > > >
> > > > > > There should be someone can enable KASAN_GENERIC but can't use VMALLOC
> > > > > > due to memory issue.
> > > > >
> > > > > That doesn't sound particularly realistic to me. The reason I'm pushing here
> > > > > is because I would _really_ like to move to VMAP stack unconditionally, and
> > > > > that would effectively force KASAN_VMALLOC to be set if KASAN is in use.
> > > > >
> > > > > So unless there's a really good reason not to do that, please can we make
> > > > > this unconditional for arm64? Pretty please?
> > > >
> > > > I think it's fine since we have a good reason.
> > > > Also if someone have memory issue in KASAN_VMALLOC,
> > > > they can use SW_TAG, right?
> > > >
> > > > However the SW_TAG/HW_TAG is not supported VMALLOC yet.
> > > > So the code would be like
> > > >
> > > >       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> > >
> > > Just make this CONFIG_KASAN_VMALLOC, since that depends on KASAN_GENERIC.
> > >
> > > >               /* explain the relationship between
> > > >                * KASAN_GENERIC and KASAN_VMALLOC in arm64
> > > >                * XXX: because we want VMAP stack....
> > > >                */
> > >
> > > I don't understand the relation with SW_TAGS. The VMAP_STACK dependency is:
> > >
> > >         depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
> >
> > This means that VMAP_STACK can be only enabled if KASAN_HW_TAGS=y or
> > if KASAN_VMALLOC=y for other modes.
> >
> > >
> > > which doesn't mention SW_TAGS at all. So that seems to imply that SW_TAGS
> > > and VMAP_STACK are mutually exclusive :(
> >
> > SW_TAGS doesn't yet have vmalloc support, so it's not compatible with
> > VMAP_STACK. Once vmalloc support is added to SW_TAGS, KASAN_VMALLOC
> > should be allowed to be enabled with SW_TAGS. This series is a step
> > towards having that support, but doesn't implement it. That will be a
> > separate effort.
>
> Ok, thanks. Then I think we should try to invert the dependency here, if
> possible, so that the KASAN backends depend on !VMAP_STACK if they don't
> support it, rather than silently disabling VMAP_STACK when they are
> selected.

SGTM. Not sure if I will get to this in the nearest future, so I filed
a bug: https://bugzilla.kernel.org/show_bug.cgi?id=211581
