Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414CE30E2A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhBCSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhBCSiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:38:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA79364F6C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612377450;
        bh=3giaFRH1j9PVmzyZwv3HjY0DTQs3tZkZzQ8m1nc4mNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UKpOsqrXPhh2J4MabEYv9pDGdajv4XjOL7hpTw2yiP+4kYP4oJo8FVd0iHO6eLA+d
         uUxt+1U0/Y7RFnuzOGAQigFDWYuTKbC5dVhZk71coTGV5MT/IX8PoN+8XQMsXlEuy/
         DSEFwVrLUmKKZtoy3KCaPhjNzA2hdantHnAHWC91GpHYfiYKawj/Hw/xGFrWs3qwSb
         buJ0AhEwkX3UXUOmaxEF+DNxV2KP7lfRUNJbTCxWYNp8/PqOoJJ3DZ0Gucefn8UIQl
         2vNbkpA8mw7Z+kmelm61kFgflvIjghJU/9bNHmQ3YZZabrpJNCdv4T6b1Tuf/XUaJO
         fuCqWe4BgPnWg==
Received: by mail-oi1-f176.google.com with SMTP id a77so926347oii.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:37:30 -0800 (PST)
X-Gm-Message-State: AOAM530C54iL9b33pQ6pRm68Cnz9aIy4WGFHl+bzIF96DqC+sZhuGBx9
        umYnUb+GSQfoYvUp8r1lvO8V+FkD0eUViTAyCRw=
X-Google-Smtp-Source: ABdhPJwTcKGhhrhcSXeU83MadiHuFOevZ5EXyyScTqYjD6/o+QLIP4TAi8X/UM98hvguCOQr900onLCBTaId+ZK8RP4=
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr2899751oih.33.1612377449888;
 Wed, 03 Feb 2021 10:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20210109103252.812517-1-lecopzer@gmail.com> <20210109103252.812517-2-lecopzer@gmail.com>
In-Reply-To: <20210109103252.812517-2-lecopzer@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Feb 2021 19:37:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEMOeCZTvNqPPk-uL5iA7hx7SFPwkq3Oz3yYefn=tVnPQ@mail.gmail.com>
Message-ID: <CAMj1kXEMOeCZTvNqPPk-uL5iA7hx7SFPwkq3Oz3yYefn=tVnPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 at 11:33, Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
>
> Like how the MODULES_VADDR does now, just not to early populate
> the VMALLOC_START between VMALLOC_END.
> similarly, the kernel code mapping is now in the VMALLOC area and
> should keep these area populated.
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>


This commit log text is a bit hard to follow. You are saying that the
vmalloc region is *not* backed with zero shadow or any default mapping
at all, right, and everything gets allocated on demand, just like is
the case for modules?

> ---
>  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index d8e66c78440e..39b218a64279 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
>  {
>         u64 kimg_shadow_start, kimg_shadow_end;
>         u64 mod_shadow_start, mod_shadow_end;
> +       u64 vmalloc_shadow_start, vmalloc_shadow_end;
>         phys_addr_t pa_start, pa_end;
>         u64 i;
>
> @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
>         mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
>         mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
>
> +       vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> +       vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> +


This and the below seems overly complicated, given that VMALLOC_START
== MODULES_END. Can we simplify this?

>         /*
>          * We are going to perform proper setup of shadow memory.
>          * At first we should unmap early shadow (clear_pgds() call below).
> @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
>
>         kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
>                                    (void *)mod_shadow_start);
> -       kasan_populate_early_shadow((void *)kimg_shadow_end,
> -                                  (void *)KASAN_SHADOW_END);
> +       if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> +               kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> +                                           (void *)KASAN_SHADOW_END);
> +               if (vmalloc_shadow_start > mod_shadow_end)
> +                       kasan_populate_early_shadow((void *)mod_shadow_end,
> +                                                   (void *)vmalloc_shadow_start);
> +
> +       } else {
> +               kasan_populate_early_shadow((void *)kimg_shadow_end,
> +                                           (void *)KASAN_SHADOW_END);
> +               if (kimg_shadow_start > mod_shadow_end)
> +                       kasan_populate_early_shadow((void *)mod_shadow_end,
> +                                                   (void *)kimg_shadow_start);
> +       }
>
> -       if (kimg_shadow_start > mod_shadow_end)
> -               kasan_populate_early_shadow((void *)mod_shadow_end,
> -                                           (void *)kimg_shadow_start);
>
>         for_each_mem_range(i, &pa_start, &pa_end) {
>                 void *start = (void *)__phys_to_virt(pa_start);
> --
> 2.25.1
>
