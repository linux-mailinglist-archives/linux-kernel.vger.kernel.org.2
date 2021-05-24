Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6620938E3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhEXKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhEXKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:06:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:04:30 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so24700603otp.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LIVDxSTAx+v+3BlB7H3HwH9zYuBEuDEtS9LHuHrcO4=;
        b=rQkzdS5dztN31yOdw1eoDmv/6SnnGWs7N/EwYlHUkJUSqmG++CFUk6djblqQq1p1Hf
         w5ig1pZRrBrL+PjW0mdvPSshlnfyy/4gkY/UIFPp4vSTJJbqAofNYKdfPQDrbV1TLY/Q
         EWEs890k6LSIhThWNr+nPvCeDdLXK2iKIIXranfB8GXTqcxG9fB6RgcAirG3SkyDVp71
         +b2Op2vlfqOWOsUxCYHbNjtlPPWHidfpQv42OGIzyrdfM5DY1z7qihasF4w6LaObXi4w
         OtC6849vEPh10WPC/1ZgvsTQWFpEnlqCY2jSPSE3tZaGYPR1OCnCpMSoMZ7aEECFdo2L
         HUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LIVDxSTAx+v+3BlB7H3HwH9zYuBEuDEtS9LHuHrcO4=;
        b=nZG03vWTHCm8+QsEv1ezkAQwb3TkpqteD6MgC5dI5oul49MaWBQEbnZRPwGTVMtD/O
         e7fOPZ6UMFH0j06H8g0yaD0HAYTwUdaAhj5vwrnFVaL0La+nB9y/d1JOOxnFbAgVaIOU
         OH2gS5qAXM59pvWzCOux8Nl7GjZ3Fs2lkNcihqqQ327V/7Ka0v1hVlgddTR4zDqWyq7d
         kXXGYduIKcwzw00iQwIp+LF/abYY4+itlQnnRGq4bGp63B3Bpz+kRPxnRXewkhbUHdXb
         vhX/QAVFltqg3utEh+ep5Lk0Sfo4jTrOw5oAZrDEnUfbc5binuUwAldkH0qQuxNFYMsx
         Dnlg==
X-Gm-Message-State: AOAM533vz+lFNjUhn2UZQHNitOedv33mMKKMqvHmyuajkA/Wk4GsCGgE
        ymErGKIgQdB4huCIzN+AxRpIpV4gkBb8hBItIveMJw==
X-Google-Smtp-Source: ABdhPJyq8txa+iw2m92FjJqhBhzKDa7d/LMZI9ViqDJJaVaaD6CDDpVh1eFBYpew85q1Cy33X1Rxc3NOtLOnlTz7p5c=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr18932645otu.251.1621850669515;
 Mon, 24 May 2021 03:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210524172433.015b3b6b@xhacker.debian> <20210524172606.08dac28d@xhacker.debian>
In-Reply-To: <20210524172606.08dac28d@xhacker.debian>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 May 2021 12:04:18 +0200
Message-ID: <CANpmjNNuaYneLb3ScSwF=o0DnECBt4NRkBZJuwRqBrOKnTGPbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: remove page granularity limitation from KFENCE
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Mark

On Mon, 24 May 2021 at 11:26, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> KFENCE requires linear map to be mapped at page granularity, so that
> it is possible to protect/unprotect single pages in the KFENCE pool.
> Currently if KFENCE is enabled, arm64 maps all pages at page
> granularity, it seems overkilled. In fact, we only need to map the
> pages in KFENCE pool itself at page granularity. We acchieve this goal
> by allocating KFENCE pool before paging_init() so we know the KFENCE
> pool address, then we take care to map the pool at page granularity
> during map_mem().
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/arm64/kernel/setup.c |  3 +++
>  arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 61845c0821d9..51c0d6e8b67b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -18,6 +18,7 @@
>  #include <linux/screen_info.h>
>  #include <linux/init.h>
>  #include <linux/kexec.h>
> +#include <linux/kfence.h>
>  #include <linux/root_dev.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
> @@ -345,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>
>         arm64_memblock_init();
>
> +       kfence_alloc_pool();
> +
>         paging_init();
>
>         acpi_table_upgrade();
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 89b66ef43a0f..12712d31a054 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/kexec.h>
> +#include <linux/kfence.h>
>  #include <linux/libfdt.h>
>  #include <linux/mman.h>
>  #include <linux/nodemask.h>
> @@ -515,10 +516,16 @@ static void __init map_mem(pgd_t *pgdp)
>          */
>         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
>
> -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> -           IS_ENABLED(CONFIG_KFENCE))
> +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
>                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
> +       /*
> +        * KFENCE requires linear map to be mapped at page granularity, so
> +        * temporarily skip mapping for __kfence_pool in the following
> +        * for-loop
> +        */
> +       memblock_mark_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
> +

Did you build this with CONFIG_KFENCE unset? I don't think it builds.

>         /*
>          * Take care not to create a writable alias for the
>          * read-only text and rodata sections of the kernel image.
> @@ -553,6 +560,15 @@ static void __init map_mem(pgd_t *pgdp)
>         __map_memblock(pgdp, kernel_start, kernel_end,
>                        PAGE_KERNEL, NO_CONT_MAPPINGS);
>         memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> +
> +       /*
> +        * Map the __kfence_pool at page granularity now.
> +        */
> +       __map_memblock(pgdp, __pa(__kfence_pool),
> +                      __pa(__kfence_pool + KFENCE_POOL_SIZE),
> +                      pgprot_tagged(PAGE_KERNEL),
> +                      NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +       memblock_clear_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
>  }
>
>  void mark_rodata_ro(void)
> @@ -1480,12 +1496,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>
>         VM_BUG_ON(!mhp_range_allowed(start, size, true));
>
> -       /*
> -        * KFENCE requires linear map to be mapped at page granularity, so that
> -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> -        */
> -       if (rodata_full || debug_pagealloc_enabled() ||
> -           IS_ENABLED(CONFIG_KFENCE))
> +       if (rodata_full || debug_pagealloc_enabled())
>                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>
>         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> --
> 2.31.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210524172606.08dac28d%40xhacker.debian.
