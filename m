Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA54198DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhI0Q3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0Q3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:29:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBF8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:27:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so12130400plh.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=um3iNRUFxtYdqd3cUEmAxCvliDJEGtIKGyJeeX1iTG8=;
        b=jpZ3iM5HS1bIwrnJr0YbTUtJQwYitB7nwgRCe1hlOvwqRhCkWbwgXu/qvzmI8S4BpR
         vMdiN0Yy3lQMuowKvFAJ3okKyA4260Zq4QeJ41Wi357M8B+TnfkN5NqM0s/pH0CW55Js
         HxBUKFBixkid6VXm4xKXdXnRLHnqI72nRIr+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=um3iNRUFxtYdqd3cUEmAxCvliDJEGtIKGyJeeX1iTG8=;
        b=ockjHIESZPXN2BGHNDFA5VduKDqzx4WGluzZ+yMH27rvSy47rE4HiuBfu5/GwWqd9x
         wB4+6GXGaNiUzQoWOLJ81ni2tlbeks9hxzYlHIU936aURhiXE+y6t2K+n4cBAOjeZtYV
         gkX8SvDAf7iTgKEoLhZdmB8sKzicjqPBi3MtV5we2SZSgbDJv6/qOIzZyY8oNcRzixLv
         R1u7yDVYJHd0Aj9bTXcOgyIZf9o8PEnvGR7TzeyajHvi3cvLKxwyv92H/MESkYcDcZEW
         Mdel89ner1QkJRoJSE1LKcHfj+R1kQjT45qgGxCxbnfOzoT2jS7FARl0o16WbCLJG6k7
         b+/A==
X-Gm-Message-State: AOAM530UZ5h5PitczTafknESt8YcT2j7ctrZnLJM1N5z6xZPgqhI8qCE
        IkxfsHvv4ZgwDgC6LQXLBx/xpQ==
X-Google-Smtp-Source: ABdhPJxw9Ceg1Xi9WnFq3SXtx4w1Ji7R7bh7LdxT2T4nwWpssZi+JtSWAux6hnV/broX7pUiV7gClg==
X-Received: by 2002:a17:902:6804:b0:13e:38d2:cdd8 with SMTP id h4-20020a170902680400b0013e38d2cdd8mr409736plk.54.1632760063737;
        Mon, 27 Sep 2021 09:27:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm17443419pfw.143.2021.09.27.09.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:27:43 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:27:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, x86@kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        viro@zeniv.linux.org.uk, nivedita@alum.mit.edu,
        adobriyan@gmail.com, oleg@redhat.com, sblbir@amazon.com,
        axboe@kernel.dk, laijs@linux.alibaba.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        akpm@linux-foundation.org, arnd@arndb.de, davem@davemloft.net,
        kim.phillips@amd.com, yazen.ghannam@amd.com, dave@stgolabs.net,
        metze@samba.org, elver@google.com, ebiederm@xmission.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/2] x86/mm: Randomize va with generic
 arch_pick_mmap_layout()
Message-ID: <202109270924.D0BC211B4@keescook>
References: <20210921143414.70723-1-sxwjean@me.com>
 <20210921143414.70723-3-sxwjean@me.com>
 <CAEVVKH-kvxDz80bz9c3zsd27sFHiz9N7T2rTQX+5G7J-xyHnsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH-kvxDz80bz9c3zsd27sFHiz9N7T2rTQX+5G7J-xyHnsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:37:28PM +0800, Xiongwei Song wrote:
> Hi Experts,
> 
> Any other objections on this patch?
> 
> Is it worth doing so? If yes, I will update the patch based on Peter's comments.
> 
> Regards,
> Xiongwei
> 
> On Tue, Sep 21, 2021 at 10:35 PM <sxwjean@me.com> wrote:
> >
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The code logic of arch_pick_mmap_layout() of x86 is basiclly same as
> > arch_pick_mmap_layout() in mm/util.c. Let's delete the function and
> > the related assistant functions in x86.
> >
> > There are some differences between x86 and geneirc code:
> > - mmap_is_legacy(), there is no check for stack limit of 32 bits process
> >   in x86, while generic code does, which is suitable for x86 too.
> > - arch_randomize_brk(), it only randomized the brk with SZ_32M range
> >   for 32 bits and 64 bits processes, while the generic code randomizes brk
> >   with SZ_1G range for 64 bits process, which is suitable for x86 too.
> > - Implement is_compat_task(), which means 32 bits process in 64 bits
> >   kernel, to adapt generic implementation.
> > - The special implementation of x86 is the code with
> >   CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES enabled. I assume other archs will
> >   enable CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES in the future, so move the
> >   implementation to the generic part.

Would it be possible to break this patch up into the separate pieces you
outline above? This code is pretty twisty, and keeping isolated changes
in separate patches can help with review.

Also, can you verify that the before/after entropy remains the same?
(There are a bunch of tools that measure various aspects of the layout
randomization, etc.)

Other than that, I'm all for consolidating this code. I've taking a few
passes at it in the past, so I welcome improvements here. There's a lot
of arch-specific stuff that doesn't need to be arch-specific. :)

Thanks for digging into this!

-Kees

> >
> > Hence select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT in x86 to use
> > generic arch_pick_mmap_layout(). Meanwhile, the ARCH_HAS_ELF_RANDOMIZE
> > can be enabled automatically, remove select for it.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  arch/x86/Kconfig                 |   2 +-
> >  arch/x86/include/asm/compat.h    |   7 +-
> >  arch/x86/include/asm/processor.h |   4 +-
> >  arch/x86/kernel/process.c        |   5 --
> >  arch/x86/mm/mmap.c               | 112 -------------------------------
> >  include/linux/compat.h           |   4 ++
> >  mm/util.c                        |  18 ++++-
> >  7 files changed, 29 insertions(+), 123 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index dad7f85dcdea..c081e6ff7f11 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -72,7 +72,6 @@ config X86
> >         select ARCH_HAS_DEBUG_VM_PGTABLE        if !X86_PAE
> >         select ARCH_HAS_DEVMEM_IS_ALLOWED
> >         select ARCH_HAS_EARLY_DEBUG             if KGDB
> > -       select ARCH_HAS_ELF_RANDOMIZE
> >         select ARCH_HAS_FAST_MULTIPLIER
> >         select ARCH_HAS_FILTER_PGPROT
> >         select ARCH_HAS_FORTIFY_SOURCE
> > @@ -114,6 +113,7 @@ config X86
> >         select ARCH_USE_SYM_ANNOTATIONS
> >         select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> >         select ARCH_WANT_DEFAULT_BPF_JIT        if X86_64
> > +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >         select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >         select ARCH_WANTS_NO_INSTR
> >         select ARCH_WANT_HUGE_PMD_SHARE
> > diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> > index 7516e4199b3c..c697e377644d 100644
> > --- a/arch/x86/include/asm/compat.h
> > +++ b/arch/x86/include/asm/compat.h
> > @@ -151,6 +151,11 @@ struct compat_shmid64_ds {
> >         compat_ulong_t __unused5;
> >  };
> >
> > +static inline int is_compat_task(void)
> > +{
> > +       return IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT);
> > +}
> > +
> >  #ifdef CONFIG_X86_X32_ABI
> >  #define COMPAT_USE_64BIT_TIME \
> >         (!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
> > @@ -165,12 +170,12 @@ static inline bool in_x32_syscall(void)
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_COMPAT
> >  static inline bool in_32bit_syscall(void)
> >  {
> >         return in_ia32_syscall() || in_x32_syscall();
> >  }
> >
> > -#ifdef CONFIG_COMPAT
> >  static inline bool in_compat_syscall(void)
> >  {
> >         return in_32bit_syscall();
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 9ad2acaaae9b..c28a36ee6eb0 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -708,7 +708,6 @@ extern int                  bootloader_version;
> >
> >  extern char                    ignore_fpu_irq;
> >
> > -#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
> >  #define ARCH_HAS_PREFETCHW
> >  #define ARCH_HAS_SPINLOCK_PREFETCH
> >
> > @@ -785,6 +784,9 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
> >   */
> >  #define __TASK_UNMAPPED_BASE(task_size)        (PAGE_ALIGN(task_size / 3))
> >  #define TASK_UNMAPPED_BASE             __TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
> > +#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> > +#define TASK_UNMAPPED_COMPAT_BASE __TASK_UNMAPPED_BASE(task_size_32bit())
> > +#endif
> >
> >  #define KSTK_EIP(task)         (task_pt_regs(task)->ip)
> >
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index 1d9463e3096b..1e747d34c18d 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -931,11 +931,6 @@ unsigned long arch_align_stack(unsigned long sp)
> >         return sp & ~0xf;
> >  }
> >
> > -unsigned long arch_randomize_brk(struct mm_struct *mm)
> > -{
> > -       return randomize_page(mm->brk, 0x02000000);
> > -}
> > -
> >  /*
> >   * Called from fs/proc with a reference on @p to find the function
> >   * which called into schedule(). This needs to be done carefully
> > diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> > index c90c20904a60..daf65cc5e5b1 100644
> > --- a/arch/x86/mm/mmap.c
> > +++ b/arch/x86/mm/mmap.c
> > @@ -38,118 +38,6 @@ unsigned long task_size_64bit(int full_addr_space)
> >         return full_addr_space ? TASK_SIZE_MAX : DEFAULT_MAP_WINDOW;
> >  }
> >
> > -static unsigned long stack_maxrandom_size(unsigned long task_size)
> > -{
> > -       unsigned long max = 0;
> > -       if (current->flags & PF_RANDOMIZE) {
> > -               max = (-1UL) & __STACK_RND_MASK(task_size == task_size_32bit());
> > -               max <<= PAGE_SHIFT;
> > -       }
> > -
> > -       return max;
> > -}
> > -
> > -#ifdef CONFIG_COMPAT
> > -# define mmap32_rnd_bits  mmap_rnd_compat_bits
> > -# define mmap64_rnd_bits  mmap_rnd_bits
> > -#else
> > -# define mmap32_rnd_bits  mmap_rnd_bits
> > -# define mmap64_rnd_bits  mmap_rnd_bits
> > -#endif
> > -
> > -#define SIZE_128M    (128 * 1024 * 1024UL)
> > -
> > -static int mmap_is_legacy(void)
> > -{
> > -       if (current->personality & ADDR_COMPAT_LAYOUT)
> > -               return 1;
> > -
> > -       return sysctl_legacy_va_layout;
> > -}
> > -
> > -static unsigned long arch_rnd(unsigned int rndbits)
> > -{
> > -       if (!(current->flags & PF_RANDOMIZE))
> > -               return 0;
> > -       return (get_random_long() & ((1UL << rndbits) - 1)) << PAGE_SHIFT;
> > -}
> > -
> > -unsigned long arch_mmap_rnd(void)
> > -{
> > -       return arch_rnd(mmap_is_ia32() ? mmap32_rnd_bits : mmap64_rnd_bits);
> > -}
> > -
> > -static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
> > -                              struct rlimit *rlim_stack)
> > -{
> > -       unsigned long gap = rlim_stack->rlim_cur;
> > -       unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
> > -       unsigned long gap_min, gap_max;
> > -
> > -       /* Values close to RLIM_INFINITY can overflow. */
> > -       if (gap + pad > gap)
> > -               gap += pad;
> > -
> > -       /*
> > -        * Top of mmap area (just below the process stack).
> > -        * Leave an at least ~128 MB hole with possible stack randomization.
> > -        */
> > -       gap_min = SIZE_128M;
> > -       gap_max = (task_size / 6) * 5;
> > -
> > -       if (gap < gap_min)
> > -               gap = gap_min;
> > -       else if (gap > gap_max)
> > -               gap = gap_max;
> > -
> > -       return PAGE_ALIGN(task_size - gap - rnd);
> > -}
> > -
> > -static unsigned long mmap_legacy_base(unsigned long rnd,
> > -                                     unsigned long task_size)
> > -{
> > -       return __TASK_UNMAPPED_BASE(task_size) + rnd;
> > -}
> > -
> > -/*
> > - * This function, called very early during the creation of a new
> > - * process VM image, sets up which VM layout function to use:
> > - */
> > -static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
> > -               unsigned long random_factor, unsigned long task_size,
> > -               struct rlimit *rlim_stack)
> > -{
> > -       *legacy_base = mmap_legacy_base(random_factor, task_size);
> > -       if (mmap_is_legacy())
> > -               *base = *legacy_base;
> > -       else
> > -               *base = mmap_base(random_factor, task_size, rlim_stack);
> > -}
> > -
> > -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> > -{
> > -       if (mmap_is_legacy())
> > -               mm->get_unmapped_area = arch_get_unmapped_area;
> > -       else
> > -               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> > -
> > -       arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
> > -                       arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
> > -                       rlim_stack);
> > -
> > -#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> > -       /*
> > -        * The mmap syscall mapping base decision depends solely on the
> > -        * syscall type (64-bit or compat). This applies for 64bit
> > -        * applications and 32bit applications. The 64bit syscall uses
> > -        * mmap_base, the compat syscall uses mmap_compat_base.
> > -        */
> > -       arch_pick_mmap_base(&mm->mmap_compat_base, &mm->mmap_compat_legacy_base,
> > -                       arch_rnd(mmap32_rnd_bits), task_size_32bit(),
> > -                       rlim_stack);
> > -#endif
> > -}
> > -
> >  unsigned long get_mmap_base(int is_legacy)
> >  {
> >         struct mm_struct *mm = current->mm;
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index 1c758b0e0359..0f7cc94f9b3f 100644
> > --- a/include/linux/compat.h
> > +++ b/include/linux/compat.h
> > @@ -946,6 +946,10 @@ static inline bool in_compat_syscall(void) { return false; }
> >
> >  #endif /* CONFIG_COMPAT */
> >
> > +#ifndef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> > +static inline bool in_32bit_syscall(void) { return false; }
> > +#endif
> > +
> >  #define BITS_PER_COMPAT_LONG    (8*sizeof(compat_long_t))
> >
> >  #define BITS_TO_COMPAT_LONGS(bits) DIV_ROUND_UP(bits, BITS_PER_COMPAT_LONG)
> > diff --git a/mm/util.c b/mm/util.c
> > index 4ac87f1b30f1..8932388c96a3 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -357,8 +357,9 @@ unsigned long arch_mmap_rnd(void)
> >  {
> >         unsigned long rnd;
> >
> > -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> > -       if (is_compat_task())
> > +#if defined(CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS) \
> > +       || defined(CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES)
> > +       if (is_compat_task() || in_32bit_syscall())
> >                 rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
> >         else
> >  #endif /* CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS */
> > @@ -413,13 +414,24 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> >         if (current->flags & PF_RANDOMIZE)
> >                 random_factor = arch_mmap_rnd();
> >
> > +       mm->mmap_legacy_base = TASK_UNMAPPED_BASE + random_factor;
> >         if (mmap_is_legacy(rlim_stack)) {
> > -               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> > +               mm->mmap_base = mm->mmap_legacy_base;
> >                 mm->get_unmapped_area = arch_get_unmapped_area;
> >         } else {
> >                 mm->mmap_base = mmap_base(random_factor, rlim_stack);
> >                 mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> >         }
> > +
> > +#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> > +       if (mmap_is_legacy(rlim_stack)) {
> > +               mm->mmap_compat_legacy_base =
> > +                       TASK_UNMAPPED_COMPAT_BASE + random_factor;
> > +               mm->mmap_compat_base = mm->mmap_compat_legacy_base;
> > +       } else {
> > +               mm->mmap_compat_base = mmap_base(random_factor, rlim_stack);
> > +       }
> > +#endif
> >  }
> >  #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
> >  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> > --
> > 2.30.2
> >

-- 
Kees Cook
