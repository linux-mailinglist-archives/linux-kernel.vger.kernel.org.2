Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67C441B270
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhI1O6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbhI1O6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:58:43 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C55C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:57:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p4so41038009qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8VNpdtkEoliOS37FEyslZhSPnjXEDK9SRfQU3PFcQB0=;
        b=JxpFtg04G6WsZ8CatyXdC/AEE9tDd/WhcEn1sxEoIfSD0ZBxynl28sdyZfFqlJ0kaZ
         BWemzKpzqiShOgdmsVNP/Lc72WvkpORW2VWw0KXmlAaphr9Y23dRzuRyWn2mVxlyn1EV
         aQrZ80hjVeCQC0e/dnQTFZ3f0MZrmA4Zv9ZxT+81qNZ9QzzKRLZ1TiwHCkKNXD4JxPJr
         nzluZtPJ0J9cxQgErO9/zrUNreSkDBq02PV/auHW4Judbe3egL80gxUe0CUhpJ01S+UQ
         Wos3tZ4V36yyq2gJ3jNcvC2wwG5sCa2+ABBQg2P8cj2NWu2luT2cRCl+zh0sXVTsqFJF
         FozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8VNpdtkEoliOS37FEyslZhSPnjXEDK9SRfQU3PFcQB0=;
        b=Phl7cvgrdrH5mZi6HIGNNizSZv1Al1aEyeuqFpC6EQQ3sWD3bpUSoZC9GTuK/S4IbA
         eKcCzEDZIEZs5DYmW7USq+CKcIjfvviCpZS7JQBUYfmncD6zA3oqUUBDPg8m6dk6bzvL
         m0pVYz57sYUF7FCTJ7Q7+p3u9UQ5BAfjcMiy4A58DnTo6LZSgWGq3e8/5NwMNIiD3Fsl
         VInnsFBxroMzXnFf8S481LBJPtBFPZqSHxhKjJ8kL6y9tHJGNTcLASxmfLeqW1VDfVRA
         D0IlpxaT14M/rh+R6asDVCdrQqL4EzMSQovOcwBmBCd6Gl/nd+RiQg1D79aax7stOJ5O
         OWGg==
X-Gm-Message-State: AOAM533RKLRcAeoS9yov9cIaZSieAxj7eFQg1UlSzd80R8hmMlhhJq2v
        KeVOFhczyLXCbhzoDvpUjv5hTfH74PPokVB1+C6eSR1kJoY=
X-Google-Smtp-Source: ABdhPJzRIR3eUGDCn24vX/m9Evu6LSJjz+X5qiwmwDYnTBZPfiTgsjhcleKtjLSovmUT+88SmlfXrrklLkV2+AWEO4M=
X-Received: by 2002:a37:a548:: with SMTP id o69mr404970qke.9.1632841023020;
 Tue, 28 Sep 2021 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
In-Reply-To: <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 28 Sep 2021 22:56:52 +0800
Message-ID: <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Darius Rad <darius@bluespec.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 9/8/21 1:45 PM, Greentime Hu wrote:
> > This patch adds task switch support for vector. It supports partial laz=
y
> > save and restore mechanism. It also supports all lengths of vlen.
> >
> > [guoren@linux.alibaba.com: First available porting to support vector
> > context switching]
> > [nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen, xlen=
 and
> > code refine]
> > [vincent.chen@sifive.co: Fix the might_sleep issue in vstate_save,
> > vstate_restore]
> > Co-developed-by: Nick Knight <nick.knight@sifive.com>
> > Signed-off-by: Nick Knight <nick.knight@sifive.com>
> > Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >   arch/riscv/include/asm/switch_to.h | 66 +++++++++++++++++++++++
> >   arch/riscv/kernel/Makefile         |  1 +
> >   arch/riscv/kernel/process.c        | 38 ++++++++++++++
> >   arch/riscv/kernel/vector.S         | 84 +++++++++++++++++++++++++++++=
+
> >   4 files changed, 189 insertions(+)
> >   create mode 100644 arch/riscv/kernel/vector.S
> >
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/as=
m/switch_to.h
> > index ec83770b3d98..de0573dad78f 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -7,10 +7,12 @@
> >   #define _ASM_RISCV_SWITCH_TO_H
> >
> >   #include <linux/jump_label.h>
> > +#include <linux/slab.h>
> >   #include <linux/sched/task_stack.h>
> >   #include <asm/processor.h>
> >   #include <asm/ptrace.h>
> >   #include <asm/csr.h>
> > +#include <asm/asm-offsets.h>
> >
> >   #ifdef CONFIG_FPU
> >   extern void __fstate_save(struct task_struct *save_to);
> > @@ -68,6 +70,68 @@ static __always_inline bool has_fpu(void) { return f=
alse; }
> >   #define __switch_to_fpu(__prev, __next) do { } while (0)
> >   #endif
> >
> > +#ifdef CONFIG_VECTOR
> > +extern bool has_vector;
> > +extern unsigned long riscv_vsize;
> > +extern void __vstate_save(struct __riscv_v_state *save_to, void *datap=
);
> > +extern void __vstate_restore(struct __riscv_v_state *restore_from, voi=
d *datap);
> > +
> > +static inline void __vstate_clean(struct pt_regs *regs)
> > +{
> > +     regs->status =3D (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> > +}
> > +
> > +static inline void vstate_off(struct task_struct *task,
> > +                           struct pt_regs *regs)
> > +{
> > +     regs->status =3D (regs->status & ~SR_VS) | SR_VS_OFF;
> > +}
> > +
> > +static inline void vstate_save(struct task_struct *task,
> > +                            struct pt_regs *regs)
> > +{
> > +     if ((regs->status & SR_VS) =3D=3D SR_VS_DIRTY) {
> > +             struct __riscv_v_state *vstate =3D &(task->thread.vstate)=
;
> > +
> > +             __vstate_save(vstate, vstate->datap);
> > +             __vstate_clean(regs);
> > +     }
> > +}
> > +
> > +static inline void vstate_restore(struct task_struct *task,
> > +                               struct pt_regs *regs)
> > +{
> > +     if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> > +             struct __riscv_v_state *vstate =3D &(task->thread.vstate)=
;
> > +
> > +             /* Allocate space for vector registers. */
> > +             if (!vstate->datap) {
> > +                     vstate->datap =3D kzalloc(riscv_vsize, GFP_ATOMIC=
);
> > +                     vstate->size =3D riscv_vsize;
> > +             }
> > +             __vstate_restore(vstate, vstate->datap);
> > +             __vstate_clean(regs);
> > +     }
> > +}
> > +
> > +static inline void __switch_to_vector(struct task_struct *prev,
> > +                                struct task_struct *next)
> > +{
> > +     struct pt_regs *regs;
> > +
> > +     regs =3D task_pt_regs(prev);
> > +     if (unlikely(regs->status & SR_SD))
> > +             vstate_save(prev, regs);
> > +     vstate_restore(next, task_pt_regs(next));
> > +}
> > +
> > +#else
> > +#define has_vector false
> > +#define vstate_save(task, regs) do { } while (0)
> > +#define vstate_restore(task, regs) do { } while (0)
> > +#define __switch_to_vector(__prev, __next) do { } while (0)
> > +#endif
> > +
> >   extern struct task_struct *__switch_to(struct task_struct *,
> >                                      struct task_struct *);
> >
> > @@ -77,6 +141,8 @@ do {                                                =
       \
> >       struct task_struct *__next =3D (next);            \
> >       if (has_fpu())                                  \
> >               __switch_to_fpu(__prev, __next);        \
> > +     if (has_vector)                                 \
> > +             __switch_to_vector(__prev, __next);     \
> >       ((last) =3D __switch_to(__prev, __next));         \
> >   } while (0)
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 3397ddac1a30..344078080839 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -40,6 +40,7 @@ obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> >
> >   obj-$(CONFIG_RISCV_M_MODE)  +=3D traps_misaligned.o
> >   obj-$(CONFIG_FPU)           +=3D fpu.o
> > +obj-$(CONFIG_VECTOR)         +=3D vector.o
> >   obj-$(CONFIG_SMP)           +=3D smpboot.o
> >   obj-$(CONFIG_SMP)           +=3D smp.o
> >   obj-$(CONFIG_SMP)           +=3D cpu_ops.o
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 03ac3aa611f5..0b86e9e531c9 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -95,6 +95,16 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
> >                */
> >               fstate_restore(current, regs);
> >       }
> > +
> > +     if (has_vector) {
> > +             regs->status |=3D SR_VS_INITIAL;
> > +             /*
> > +              * Restore the initial value to the vector register
> > +              * before starting the user program.
> > +              */
> > +             vstate_restore(current, regs);
> > +     }
> > +
>
> So this will unconditionally enable vector instructions, and allocate
> memory for vector state, for all processes, regardless of whether vector
> instructions are used?
>

Hi Darius,

Yes, it will enable vector if has_vector() is true. The reason that we
choose to enable and allocate memory for user space program is because
we also implement some common functions in the glibc such as memcpy
vector version and it is called very often by every process. So that
we assume if the user program is running in a CPU with vector ISA
would like to use vector by default. If we disable it by default and
make it trigger the illegal instruction, that might be a burden since
almost every process will use vector glibc memcpy or something like
that.

> Given the size of the vector state and potential power and performance
> implications of enabling the vector engine, it seems like this should
> treated similarly to Intel AMX on x86.  The full discussion of that is
> here:
>
> https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG=
8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
>
> The cover letter for recent Intel AMX patches has a summary of the x86
> implementation:
>
> https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@intel.=
com/
>
> If RISC-V were to adopt a similar approach, I think the significant
> points are:
>
>   1. A process (or thread) must specifically request the desire to use
> vector extensions (perhaps with some new arch_prctl() API),
>
>   2. The kernel is free to deny permission, perhaps based on
> administrative rules or for other reasons, and
>
>   3. If a process attempts to use vector extensions before doing the
> above, the process will die due to an illegal instruction.

Thank you for sharing this, but I am not sure if we should treat
vector like AMX on x86. IMHO, compiler might generate code with vector
instructions automatically someday, maybe we should treat vector
extensions like other extensions.
If user knows the vector extension is supported in this CPU and he
would like to use it, it seems we should let user use it directly just
like other extensions.
If user don't know it exists or not, user should use the library API
transparently and let glibc or other library deal with it. The glibc
ifunc feature or multi-lib should be able to choose the correct
implementation.
