Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9009C35D629
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbhDMDvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241937AbhDMDvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:51:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:51:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f12so14990581wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLcMyvS4Bfbab4x/HInf8ARMVrCM5mdnxbt3TSzvKyM=;
        b=T2LwnjxDOzLRWHPqcEq8PIec2G8icasDBBoP+sJTv22LbBtNyIv1RYDig7zggkOmYO
         0YptXjHiN2a7Sea3XjbJHspj4yH960AJsGIV01R8FeSG5L8dDg0FPM5K2EEpgHh2ZQdl
         Lzy5nqU3WyKkg6fFTVJljPWl+sx+rek+0LGApDSDYnQou0noSRBoOpstYv3/naBV1tPs
         UWtxwfTkay9xgrMEkHC48mWsZxyw3aahU4N+5b0sLMpN8Ewft9znY53Vchz4O+b5nudH
         keKGlbYQ4eMVEEvf3gwnE4+CiKN7rzfevkbubWd86Zkqjxp7zByQPiVeCNsbq9uFDmIg
         3p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLcMyvS4Bfbab4x/HInf8ARMVrCM5mdnxbt3TSzvKyM=;
        b=tiI4iMHXUIuLJNiVnRWCwmbSpNYMOfIwyYJ7FsIwuu0haLB1YYOuSj6v0GNZizI2z6
         5PZl3KBWRZ9+M9Zcz9zt8jezmq390uqumW+DzhK9hfAzMXVAuqZdJazxzsPKIHyhn/6F
         8Yg7Sm9nbQmYtfW/EGCxEwLraYbFm3Nkh5J/MUfuwGbOznwf+FnZaYP3mN0j4ZaRgMXf
         6/cKPOgS69dMWra1ow8bS2jcGmeEzXp06tDOnP7wblnN9X7z3Qy/hMYR4lnM5tjzBIn8
         oU2jhQvcWMUXvuRa8sAZj2gDUGsL8bSdS4tz10gXG39lqoAL+Pognp6nD42a6uKHTAC+
         Ts8A==
X-Gm-Message-State: AOAM533hlniehfWjparhjxN1J+/WVAlxx00w1+EZZKrJ/FwKZjfyu+rr
        3iZGBcjk1AHxs7kEiLVb63hTsFahrDBiAw7yczyOAw==
X-Google-Smtp-Source: ABdhPJwaFz7sHwMzirdAqwGgVbeq4VCvAZR7WDx7zIjFmE5+OpMtCk+N1dnzc4HFSO+FyUpM3HMyU0+eRzBnK9bSGYI=
X-Received: by 2002:a5d:424f:: with SMTP id s15mr22570167wrr.356.1618285880927;
 Mon, 12 Apr 2021 20:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210413001110.7209bae6@xhacker> <20210413001228.663f9bc3@xhacker>
In-Reply-To: <20210413001228.663f9bc3@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 13 Apr 2021 09:21:09 +0530
Message-ID: <CAAhSdy0q43HqmJ_-NJBdhBi0P2jn7YMctkH5mFwE52SD2at03w@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] riscv: add __init section marker to some functions
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:47 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> They are not needed after booting, so mark them as __init to move them
> to the __init section.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  arch/riscv/kernel/traps.c      | 2 +-
>  arch/riscv/mm/init.c           | 4 ++--
>  arch/riscv/mm/kasan_init.c     | 6 +++---
>  arch/riscv/mm/ptdump.c         | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index ac202f44a670..e4741e1f0add 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -59,7 +59,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>
> -void riscv_fill_hwcap(void)
> +void __init riscv_fill_hwcap(void)
>  {
>         struct device_node *node;
>         const char *isa;
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 0879b5df11b9..041f4b44262e 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -196,6 +196,6 @@ int is_valid_bugaddr(unsigned long pc)
>  #endif /* CONFIG_GENERIC_BUG */
>
>  /* stvec & scratch is already set from head.S */
> -void trap_init(void)
> +void __init trap_init(void)
>  {
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index dbeaa4144e4d..ecd485662b07 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -70,7 +70,7 @@ static inline void print_mlm(char *name, unsigned long b, unsigned long t)
>                   (((t) - (b)) >> 20));
>  }
>
> -static void print_vm_layout(void)
> +static void __init print_vm_layout(void)
>  {
>         pr_notice("Virtual kernel memory layout:\n");
>         print_mlk("fixmap", (unsigned long)FIXADDR_START,
> @@ -553,7 +553,7 @@ static inline void setup_vm_final(void)
>  #endif /* CONFIG_MMU */
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void protect_kernel_text_data(void)
> +void __init protect_kernel_text_data(void)
>  {
>         unsigned long text_start = (unsigned long)_start;
>         unsigned long init_text_start = (unsigned long)__init_text_begin;
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index ec0029097251..e459290d2629 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -48,7 +48,7 @@ asmlinkage void __init kasan_early_init(void)
>         local_flush_tlb_all();
>  }
>
> -static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pte_t *ptep, *base_pte;
> @@ -70,7 +70,7 @@ static void kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long en
>         set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(base_pte)), PAGE_TABLE));
>  }
>
> -static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pmd_t *pmdp, *base_pmd;
> @@ -105,7 +105,7 @@ static void kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long en
>         set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
>  }
>
> -static void kasan_populate_pgd(unsigned long vaddr, unsigned long end)
> +static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
>  {
>         phys_addr_t phys_addr;
>         pgd_t *pgdp = pgd_offset_k(vaddr);
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index ace74dec7492..3b7b6e4d025e 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -331,7 +331,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>
>  DEFINE_SHOW_ATTRIBUTE(ptdump);
>
> -static int ptdump_init(void)
> +static int __init ptdump_init(void)
>  {
>         unsigned int i, j;
>
> --
> 2.31.0
>
>
