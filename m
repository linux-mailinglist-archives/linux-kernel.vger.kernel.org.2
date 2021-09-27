Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5007419016
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhI0Hjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhI0Hje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:39:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A1C061570
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:37:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so73355244lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMQmGZaiEHoDNR4igoBQB3WFc628sYhdAxQvFXLVp3Q=;
        b=MjqrrmsUu2gJkpzQJpO519HCleViEu8pbKAMnCd++JyvlW6FlHIkLlAVCfUBZG6gGh
         s+bkHh3szT0gHAPUbaIJ26Jt/NaMv4fdZO7JxL8hbXSp+ThgtdDhJ/8u2JsrESEs0Cef
         abi1oKG9i4faeViBJzJkVU5U4pZUyG0Rwu8up0uP1jEYjNYmJN7nD/TROyyvJoHAmWwV
         OwyIGn6yqGSeF3ZjZgrjf4z+oontyq/4edpLAm59LsXUBsVNwdWET1vrnHaqoCKFCePX
         BFTj7foa3TzXRABEGmc6NYciNnYB6MjtcZoJl5JXCNWqoL2hqEm77T8XtyZASl2CY+uq
         Xo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMQmGZaiEHoDNR4igoBQB3WFc628sYhdAxQvFXLVp3Q=;
        b=lnI217FNaOUYIiBJofJS+xqHLyRPvLLeqElT5V9tQarVwUR/O1In88Oj6iE5kwYlwy
         NY4OWUbM9OLDyGp5wQYTvC2cM4QSDw1JLDNTHorQbq6Me+onIyLW2JXN4qja4eCMa0ka
         VMCuuXNiVVhkZbDzZQl9pKI9y1BIMDffLB5UtPHKHmz+RBpFVFJahX9fKRsIn/Rh+Vfj
         czj8dPjBm1l+Jg6kBQ2inP0qPXVgth0pAquZRSJHqIxY9TH/ed1K4qh1/rGfIrcPh7wJ
         JdkV9QfuGp7+tp4NfzwpG30FRsjU8Lb9pQr16u1a0A2cKxyHtvcYp7g22D2FBxg9pGBR
         yp0g==
X-Gm-Message-State: AOAM532kcKGMz6Orl0gmOUI7LrBaT/5j2yv1eDMgkypDJ9EtRDevhaxN
        nH1vrqVya0aeEgulGRssK6eo6iXODt3Ywvnkins=
X-Google-Smtp-Source: ABdhPJyVAuQEkj1grZuJPOO+3UCs4vPesphwkUm+oiM9DLzCOiU6e3P8bwuSWKnu9ebwb8Y6zH6vZH8KYuEBGb/NmHo=
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr22758167lfd.246.1632728274840;
 Mon, 27 Sep 2021 00:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210921143414.70723-1-sxwjean@me.com> <20210921143414.70723-3-sxwjean@me.com>
In-Reply-To: <20210921143414.70723-3-sxwjean@me.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Mon, 27 Sep 2021 15:37:28 +0800
Message-ID: <CAEVVKH-kvxDz80bz9c3zsd27sFHiz9N7T2rTQX+5G7J-xyHnsw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] x86/mm: Randomize va with generic arch_pick_mmap_layout()
To:     Xiongwei Song <sxwjean@me.com>
Cc:     x86@kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@kernel.org,
        krisman@collabora.com, chang.seok.bae@intel.com,
        viro@zeniv.linux.org.uk, nivedita@alum.mit.edu,
        adobriyan@gmail.com, oleg@redhat.com, sblbir@amazon.com,
        axboe@kernel.dk, laijs@linux.alibaba.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        akpm@linux-foundation.org, arnd@arndb.de, davem@davemloft.net,
        keescook@chromium.org, kim.phillips@amd.com, yazen.ghannam@amd.com,
        dave@stgolabs.net, metze@samba.org, elver@google.com,
        ebiederm@xmission.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Experts,

Any other objections on this patch?

Is it worth doing so? If yes, I will update the patch based on Peter's comments.

Regards,
Xiongwei

On Tue, Sep 21, 2021 at 10:35 PM <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <sxwjean@gmail.com>
>
> The code logic of arch_pick_mmap_layout() of x86 is basiclly same as
> arch_pick_mmap_layout() in mm/util.c. Let's delete the function and
> the related assistant functions in x86.
>
> There are some differences between x86 and geneirc code:
> - mmap_is_legacy(), there is no check for stack limit of 32 bits process
>   in x86, while generic code does, which is suitable for x86 too.
> - arch_randomize_brk(), it only randomized the brk with SZ_32M range
>   for 32 bits and 64 bits processes, while the generic code randomizes brk
>   with SZ_1G range for 64 bits process, which is suitable for x86 too.
> - Implement is_compat_task(), which means 32 bits process in 64 bits
>   kernel, to adapt generic implementation.
> - The special implementation of x86 is the code with
>   CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES enabled. I assume other archs will
>   enable CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES in the future, so move the
>   implementation to the generic part.
>
> Hence select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT in x86 to use
> generic arch_pick_mmap_layout(). Meanwhile, the ARCH_HAS_ELF_RANDOMIZE
> can be enabled automatically, remove select for it.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  arch/x86/Kconfig                 |   2 +-
>  arch/x86/include/asm/compat.h    |   7 +-
>  arch/x86/include/asm/processor.h |   4 +-
>  arch/x86/kernel/process.c        |   5 --
>  arch/x86/mm/mmap.c               | 112 -------------------------------
>  include/linux/compat.h           |   4 ++
>  mm/util.c                        |  18 ++++-
>  7 files changed, 29 insertions(+), 123 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index dad7f85dcdea..c081e6ff7f11 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -72,7 +72,6 @@ config X86
>         select ARCH_HAS_DEBUG_VM_PGTABLE        if !X86_PAE
>         select ARCH_HAS_DEVMEM_IS_ALLOWED
>         select ARCH_HAS_EARLY_DEBUG             if KGDB
> -       select ARCH_HAS_ELF_RANDOMIZE
>         select ARCH_HAS_FAST_MULTIPLIER
>         select ARCH_HAS_FILTER_PGPROT
>         select ARCH_HAS_FORTIFY_SOURCE
> @@ -114,6 +113,7 @@ config X86
>         select ARCH_USE_SYM_ANNOTATIONS
>         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>         select ARCH_WANT_DEFAULT_BPF_JIT        if X86_64
> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>         select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANT_HUGE_PMD_SHARE
> diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> index 7516e4199b3c..c697e377644d 100644
> --- a/arch/x86/include/asm/compat.h
> +++ b/arch/x86/include/asm/compat.h
> @@ -151,6 +151,11 @@ struct compat_shmid64_ds {
>         compat_ulong_t __unused5;
>  };
>
> +static inline int is_compat_task(void)
> +{
> +       return IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT);
> +}
> +
>  #ifdef CONFIG_X86_X32_ABI
>  #define COMPAT_USE_64BIT_TIME \
>         (!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
> @@ -165,12 +170,12 @@ static inline bool in_x32_syscall(void)
>         return false;
>  }
>
> +#ifdef CONFIG_COMPAT
>  static inline bool in_32bit_syscall(void)
>  {
>         return in_ia32_syscall() || in_x32_syscall();
>  }
>
> -#ifdef CONFIG_COMPAT
>  static inline bool in_compat_syscall(void)
>  {
>         return in_32bit_syscall();
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 9ad2acaaae9b..c28a36ee6eb0 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -708,7 +708,6 @@ extern int                  bootloader_version;
>
>  extern char                    ignore_fpu_irq;
>
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
>  #define ARCH_HAS_PREFETCHW
>  #define ARCH_HAS_SPINLOCK_PREFETCH
>
> @@ -785,6 +784,9 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
>   */
>  #define __TASK_UNMAPPED_BASE(task_size)        (PAGE_ALIGN(task_size / 3))
>  #define TASK_UNMAPPED_BASE             __TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
> +#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> +#define TASK_UNMAPPED_COMPAT_BASE __TASK_UNMAPPED_BASE(task_size_32bit())
> +#endif
>
>  #define KSTK_EIP(task)         (task_pt_regs(task)->ip)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1d9463e3096b..1e747d34c18d 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -931,11 +931,6 @@ unsigned long arch_align_stack(unsigned long sp)
>         return sp & ~0xf;
>  }
>
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -       return randomize_page(mm->brk, 0x02000000);
> -}
> -
>  /*
>   * Called from fs/proc with a reference on @p to find the function
>   * which called into schedule(). This needs to be done carefully
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index c90c20904a60..daf65cc5e5b1 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -38,118 +38,6 @@ unsigned long task_size_64bit(int full_addr_space)
>         return full_addr_space ? TASK_SIZE_MAX : DEFAULT_MAP_WINDOW;
>  }
>
> -static unsigned long stack_maxrandom_size(unsigned long task_size)
> -{
> -       unsigned long max = 0;
> -       if (current->flags & PF_RANDOMIZE) {
> -               max = (-1UL) & __STACK_RND_MASK(task_size == task_size_32bit());
> -               max <<= PAGE_SHIFT;
> -       }
> -
> -       return max;
> -}
> -
> -#ifdef CONFIG_COMPAT
> -# define mmap32_rnd_bits  mmap_rnd_compat_bits
> -# define mmap64_rnd_bits  mmap_rnd_bits
> -#else
> -# define mmap32_rnd_bits  mmap_rnd_bits
> -# define mmap64_rnd_bits  mmap_rnd_bits
> -#endif
> -
> -#define SIZE_128M    (128 * 1024 * 1024UL)
> -
> -static int mmap_is_legacy(void)
> -{
> -       if (current->personality & ADDR_COMPAT_LAYOUT)
> -               return 1;
> -
> -       return sysctl_legacy_va_layout;
> -}
> -
> -static unsigned long arch_rnd(unsigned int rndbits)
> -{
> -       if (!(current->flags & PF_RANDOMIZE))
> -               return 0;
> -       return (get_random_long() & ((1UL << rndbits) - 1)) << PAGE_SHIFT;
> -}
> -
> -unsigned long arch_mmap_rnd(void)
> -{
> -       return arch_rnd(mmap_is_ia32() ? mmap32_rnd_bits : mmap64_rnd_bits);
> -}
> -
> -static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
> -                              struct rlimit *rlim_stack)
> -{
> -       unsigned long gap = rlim_stack->rlim_cur;
> -       unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
> -       unsigned long gap_min, gap_max;
> -
> -       /* Values close to RLIM_INFINITY can overflow. */
> -       if (gap + pad > gap)
> -               gap += pad;
> -
> -       /*
> -        * Top of mmap area (just below the process stack).
> -        * Leave an at least ~128 MB hole with possible stack randomization.
> -        */
> -       gap_min = SIZE_128M;
> -       gap_max = (task_size / 6) * 5;
> -
> -       if (gap < gap_min)
> -               gap = gap_min;
> -       else if (gap > gap_max)
> -               gap = gap_max;
> -
> -       return PAGE_ALIGN(task_size - gap - rnd);
> -}
> -
> -static unsigned long mmap_legacy_base(unsigned long rnd,
> -                                     unsigned long task_size)
> -{
> -       return __TASK_UNMAPPED_BASE(task_size) + rnd;
> -}
> -
> -/*
> - * This function, called very early during the creation of a new
> - * process VM image, sets up which VM layout function to use:
> - */
> -static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
> -               unsigned long random_factor, unsigned long task_size,
> -               struct rlimit *rlim_stack)
> -{
> -       *legacy_base = mmap_legacy_base(random_factor, task_size);
> -       if (mmap_is_legacy())
> -               *base = *legacy_base;
> -       else
> -               *base = mmap_base(random_factor, task_size, rlim_stack);
> -}
> -
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> -{
> -       if (mmap_is_legacy())
> -               mm->get_unmapped_area = arch_get_unmapped_area;
> -       else
> -               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> -
> -       arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
> -                       arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
> -                       rlim_stack);
> -
> -#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> -       /*
> -        * The mmap syscall mapping base decision depends solely on the
> -        * syscall type (64-bit or compat). This applies for 64bit
> -        * applications and 32bit applications. The 64bit syscall uses
> -        * mmap_base, the compat syscall uses mmap_compat_base.
> -        */
> -       arch_pick_mmap_base(&mm->mmap_compat_base, &mm->mmap_compat_legacy_base,
> -                       arch_rnd(mmap32_rnd_bits), task_size_32bit(),
> -                       rlim_stack);
> -#endif
> -}
> -
>  unsigned long get_mmap_base(int is_legacy)
>  {
>         struct mm_struct *mm = current->mm;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 1c758b0e0359..0f7cc94f9b3f 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -946,6 +946,10 @@ static inline bool in_compat_syscall(void) { return false; }
>
>  #endif /* CONFIG_COMPAT */
>
> +#ifndef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> +static inline bool in_32bit_syscall(void) { return false; }
> +#endif
> +
>  #define BITS_PER_COMPAT_LONG    (8*sizeof(compat_long_t))
>
>  #define BITS_TO_COMPAT_LONGS(bits) DIV_ROUND_UP(bits, BITS_PER_COMPAT_LONG)
> diff --git a/mm/util.c b/mm/util.c
> index 4ac87f1b30f1..8932388c96a3 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -357,8 +357,9 @@ unsigned long arch_mmap_rnd(void)
>  {
>         unsigned long rnd;
>
> -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> -       if (is_compat_task())
> +#if defined(CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS) \
> +       || defined(CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES)
> +       if (is_compat_task() || in_32bit_syscall())
>                 rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
>         else
>  #endif /* CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS */
> @@ -413,13 +414,24 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>         if (current->flags & PF_RANDOMIZE)
>                 random_factor = arch_mmap_rnd();
>
> +       mm->mmap_legacy_base = TASK_UNMAPPED_BASE + random_factor;
>         if (mmap_is_legacy(rlim_stack)) {
> -               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> +               mm->mmap_base = mm->mmap_legacy_base;
>                 mm->get_unmapped_area = arch_get_unmapped_area;
>         } else {
>                 mm->mmap_base = mmap_base(random_factor, rlim_stack);
>                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>         }
> +
> +#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> +       if (mmap_is_legacy(rlim_stack)) {
> +               mm->mmap_compat_legacy_base =
> +                       TASK_UNMAPPED_COMPAT_BASE + random_factor;
> +               mm->mmap_compat_base = mm->mmap_compat_legacy_base;
> +       } else {
> +               mm->mmap_compat_base = mmap_base(random_factor, rlim_stack);
> +       }
> +#endif
>  }
>  #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> --
> 2.30.2
>
