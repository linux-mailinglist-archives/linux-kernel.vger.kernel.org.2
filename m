Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720D341C59A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbhI2N3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbhI2N3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:29:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448CAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 06:28:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x9so1410069qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f6BdMjzeoGTqAzDDPAaupjh/bE+SDzeh13jh3Dn+w5I=;
        b=2TeQe5kiF66RUO71fRRiclDq6MMklHM1DmXmbdkxrpZaEhOg05MFMpq4xsXni6SFgt
         TcLwLy601p8lRH+E8vf/tgjZInmeGFOq6JesCuYrDQWoeTXkUMHYfwEoQbFVI0xjY5jU
         +b4NQsoM3ksCm/J4A2PZwxBcheXDKRAdGSvz3peBuaCnYDqkV2PNUpwLqvDsNi138a3M
         DXrxEkygMv+l47kGXCfQgvkWK0GAgENqhiBkkYH10D2W09vwSDGmWI/ooIFTa8xkEnTt
         o51tODU4HhA+NA5fpJYPOM5AYxLwLHXaqaFzwgQZkyW9UQ/POJWb0Hi2BNd7ILcwQ2g5
         0YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f6BdMjzeoGTqAzDDPAaupjh/bE+SDzeh13jh3Dn+w5I=;
        b=m22tzUkYmeV9KwTpUmkwUeg2vwhgEaVyHkc3bUXWX67pYR4pijc5JX5kChnD4Ze75S
         LQu7EukE1uTH+z6pzxwImMFjk3twMPOYxaaLXdl/ezzuefUH2o2TvG4f1IlxMhNA96I9
         6+Y+Bk6pYKlYrFvqaghCs0N6SeTsPkvvEay4iCKUPF9OYxbRznox0EoajY0l8uxqL92A
         8AMOmwb7pEEXgYkumeqA+yiZyyaxJk2A37Nq9ngBuwouKiRcJ/K2S1LoSo1X2G8dQ6ko
         dtU4Zt4CtwtFm+H5Erm9mq6+ZItBPlvAqTsgOdDSaAKnAIBdu+eAGRNxG4C2YDG/rHG8
         d1bQ==
X-Gm-Message-State: AOAM532psL5Y5XRA8U20JsGO1UU8rXKHtwg6M17oWkYUODDxgFM7aoQm
        dMA3smoTtSGL3jRgLegOTE7h
X-Google-Smtp-Source: ABdhPJy8kLCFcwrIge09SfjGt5hFuhVErOxF2SpViBB6/aQy+5aVmv/rsD1Jpc4EzM2FDj6jS9AJHg==
X-Received: by 2002:a0c:e44b:: with SMTP id d11mr11138867qvm.27.1632922088395;
        Wed, 29 Sep 2021 06:28:08 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id o13sm1594263qtk.37.2021.09.29.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:28:07 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:28:06 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YVRp5uWFGQrwBpgf@bruce.bluespec.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
 <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> >
> > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > This patch adds task switch support for vector. It supports partial lazy
> > > save and restore mechanism. It also supports all lengths of vlen.
> > >
> > > [guoren@linux.alibaba.com: First available porting to support vector
> > > context switching]
> > > [nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen and
> > > code refine]
> > > [vincent.chen@sifive.co: Fix the might_sleep issue in vstate_save,
> > > vstate_restore]
> > > Co-developed-by: Nick Knight <nick.knight@sifive.com>
> > > Signed-off-by: Nick Knight <nick.knight@sifive.com>
> > > Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > ---
> > >   arch/riscv/include/asm/switch_to.h | 66 +++++++++++++++++++++++
> > >   arch/riscv/kernel/Makefile         |  1 +
> > >   arch/riscv/kernel/process.c        | 38 ++++++++++++++
> > >   arch/riscv/kernel/vector.S         | 84 ++++++++++++++++++++++++++++++
> > >   4 files changed, 189 insertions(+)
> > >   create mode 100644 arch/riscv/kernel/vector.S
> > >
> > > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > > index ec83770b3d98..de0573dad78f 100644
> > > --- a/arch/riscv/include/asm/switch_to.h
> > > +++ b/arch/riscv/include/asm/switch_to.h
> > > @@ -7,10 +7,12 @@
> > >   #define _ASM_RISCV_SWITCH_TO_H
> > >
> > >   #include <linux/jump_label.h>
> > > +#include <linux/slab.h>
> > >   #include <linux/sched/task_stack.h>
> > >   #include <asm/processor.h>
> > >   #include <asm/ptrace.h>
> > >   #include <asm/csr.h>
> > > +#include <asm/asm-offsets.h>
> > >
> > >   #ifdef CONFIG_FPU
> > >   extern void __fstate_save(struct task_struct *save_to);
> > > @@ -68,6 +70,68 @@ static __always_inline bool has_fpu(void) { return false; }
> > >   #define __switch_to_fpu(__prev, __next) do { } while (0)
> > >   #endif
> > >
> > > +#ifdef CONFIG_VECTOR
> > > +extern bool has_vector;
> > > +extern unsigned long riscv_vsize;
> > > +extern void __vstate_save(struct __riscv_v_state *save_to, void *datap);
> > > +extern void __vstate_restore(struct __riscv_v_state *restore_from, void *datap);
> > > +
> > > +static inline void __vstate_clean(struct pt_regs *regs)
> > > +{
> > > +     regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> > > +}
> > > +
> > > +static inline void vstate_off(struct task_struct *task,
> > > +                           struct pt_regs *regs)
> > > +{
> > > +     regs->status = (regs->status & ~SR_VS) | SR_VS_OFF;
> > > +}
> > > +
> > > +static inline void vstate_save(struct task_struct *task,
> > > +                            struct pt_regs *regs)
> > > +{
> > > +     if ((regs->status & SR_VS) == SR_VS_DIRTY) {
> > > +             struct __riscv_v_state *vstate = &(task->thread.vstate);
> > > +
> > > +             __vstate_save(vstate, vstate->datap);
> > > +             __vstate_clean(regs);
> > > +     }
> > > +}
> > > +
> > > +static inline void vstate_restore(struct task_struct *task,
> > > +                               struct pt_regs *regs)
> > > +{
> > > +     if ((regs->status & SR_VS) != SR_VS_OFF) {
> > > +             struct __riscv_v_state *vstate = &(task->thread.vstate);
> > > +
> > > +             /* Allocate space for vector registers. */
> > > +             if (!vstate->datap) {
> > > +                     vstate->datap = kzalloc(riscv_vsize, GFP_ATOMIC);
> > > +                     vstate->size = riscv_vsize;
> > > +             }
> > > +             __vstate_restore(vstate, vstate->datap);
> > > +             __vstate_clean(regs);
> > > +     }
> > > +}
> > > +
> > > +static inline void __switch_to_vector(struct task_struct *prev,
> > > +                                struct task_struct *next)
> > > +{
> > > +     struct pt_regs *regs;
> > > +
> > > +     regs = task_pt_regs(prev);
> > > +     if (unlikely(regs->status & SR_SD))
> > > +             vstate_save(prev, regs);
> > > +     vstate_restore(next, task_pt_regs(next));
> > > +}
> > > +
> > > +#else
> > > +#define has_vector false
> > > +#define vstate_save(task, regs) do { } while (0)
> > > +#define vstate_restore(task, regs) do { } while (0)
> > > +#define __switch_to_vector(__prev, __next) do { } while (0)
> > > +#endif
> > > +
> > >   extern struct task_struct *__switch_to(struct task_struct *,
> > >                                      struct task_struct *);
> > >
> > > @@ -77,6 +141,8 @@ do {                                                       \
> > >       struct task_struct *__next = (next);            \
> > >       if (has_fpu())                                  \
> > >               __switch_to_fpu(__prev, __next);        \
> > > +     if (has_vector)                                 \
> > > +             __switch_to_vector(__prev, __next);     \
> > >       ((last) = __switch_to(__prev, __next));         \
> > >   } while (0)
> > >
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 3397ddac1a30..344078080839 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -40,6 +40,7 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
> > >
> > >   obj-$(CONFIG_RISCV_M_MODE)  += traps_misaligned.o
> > >   obj-$(CONFIG_FPU)           += fpu.o
> > > +obj-$(CONFIG_VECTOR)         += vector.o
> > >   obj-$(CONFIG_SMP)           += smpboot.o
> > >   obj-$(CONFIG_SMP)           += smp.o
> > >   obj-$(CONFIG_SMP)           += cpu_ops.o
> > > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > > index 03ac3aa611f5..0b86e9e531c9 100644
> > > --- a/arch/riscv/kernel/process.c
> > > +++ b/arch/riscv/kernel/process.c
> > > @@ -95,6 +95,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
> > >                */
> > >               fstate_restore(current, regs);
> > >       }
> > > +
> > > +     if (has_vector) {
> > > +             regs->status |= SR_VS_INITIAL;
> > > +             /*
> > > +              * Restore the initial value to the vector register
> > > +              * before starting the user program.
> > > +              */
> > > +             vstate_restore(current, regs);
> > > +     }
> > > +
> >
> > So this will unconditionally enable vector instructions, and allocate
> > memory for vector state, for all processes, regardless of whether vector
> > instructions are used?
> >
> 
> Hi Darius,
> 
> Yes, it will enable vector if has_vector() is true. The reason that we
> choose to enable and allocate memory for user space program is because
> we also implement some common functions in the glibc such as memcpy
> vector version and it is called very often by every process. So that
> we assume if the user program is running in a CPU with vector ISA
> would like to use vector by default. If we disable it by default and
> make it trigger the illegal instruction, that might be a burden since
> almost every process will use vector glibc memcpy or something like
> that.

Do you have any evidence to support the assertion that almost every process
would use vector operations?  One could easily argue that the converse is
true: no existing software uses the vector extension now, so most likely a
process will not be using it.

> 
> > Given the size of the vector state and potential power and performance
> > implications of enabling the vector engine, it seems like this should
> > treated similarly to Intel AMX on x86.  The full discussion of that is
> > here:
> >
> > https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> >
> > The cover letter for recent Intel AMX patches has a summary of the x86
> > implementation:
> >
> > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@intel.com/
> >
> > If RISC-V were to adopt a similar approach, I think the significant
> > points are:
> >
> >   1. A process (or thread) must specifically request the desire to use
> > vector extensions (perhaps with some new arch_prctl() API),
> >
> >   2. The kernel is free to deny permission, perhaps based on
> > administrative rules or for other reasons, and
> >
> >   3. If a process attempts to use vector extensions before doing the
> > above, the process will die due to an illegal instruction.
> 
> Thank you for sharing this, but I am not sure if we should treat
> vector like AMX on x86. IMHO, compiler might generate code with vector
> instructions automatically someday, maybe we should treat vector
> extensions like other extensions.
> If user knows the vector extension is supported in this CPU and he
> would like to use it, it seems we should let user use it directly just
> like other extensions.
> If user don't know it exists or not, user should use the library API
> transparently and let glibc or other library deal with it. The glibc
> ifunc feature or multi-lib should be able to choose the correct
> implementation.

What makes me think that the vector extension should be treated like AMX is
that they both (1) have a significant amount of architectural state, and
(2) likely have a significant power and/or area impact on (non-emulated)
designs.

For example, I think it is possible, maybe even likely, that vector
implementations will have one or more of the following behaviors:

  1. A single vector unit shared among two or more harts,

  2. Additional power consumption when the vector unit is enabled and idle
versus not being enabled at all,

  3. For a system which supports variable operating frequency, a reduction
in the maximum frequency when the vector unit is enabled, and/or

  4. The inability to enter low power states and/or delays to low power
states transitions when the vector unit is enabled.

None of the above constraints apply to more ordinary extensions like
compressed or the various bit manipulation extensions.

The discussion I linked to has some well reasoned arguments on why
substantial extensions should have a mechanism to request using them by
user space.  The discussion was in the context of Intel AMX, but applies to
further x86 extensions, and I think should also apply to similar extensions
on RISC-V, like vector here.

