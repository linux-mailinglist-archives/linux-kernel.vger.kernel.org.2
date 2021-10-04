Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9066420B04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhJDMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJDMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:43:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36546C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:41:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id f15so15668239qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zg7eS5WxLlp9Bw3rR/b/rK4LHqfpDnHoumtWV2YKtJY=;
        b=StDYvXNCIIAPQkgdrMd9qYxJadComOe1oTdHpZ6U4Lc4jFW4LQwp0wHBHPtDrJg/I8
         izai3BOmiYCdSvvaYU4ukvDVdQ6StdS4A/Wd7UxmFnpj6AI5iyJmY27kIKxmieiQl/mP
         8G9SVDjMysKAe73z5zWd9vz7TMZtAQEaOtQOeUe207f2BL0qcOJJZMLPJpJozJVBA0my
         DdX1gQs2RhqrxAEBoKiv1oVjsElYVxMrQl98yOa+6HWgVXPxaVRqV2+cTno+vXopON/Z
         UmT6ZEyLgkxXmbbvpTdIoKacq/onON3gDxBaxmgVEC0KCMEcpqo9SSuWxv3K83hrAz9B
         +1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zg7eS5WxLlp9Bw3rR/b/rK4LHqfpDnHoumtWV2YKtJY=;
        b=RfyreOgxlALQUw8rCsw6Wq2avOMZOsk5D+JebkvaLV5698vfwY87j0aO/mRmZhQIFk
         dSxtAKnShiMOyz1aR8TryTuO8CEnoSH8ZROFE2UJck53+OGJCSxePv7Y4mHKxs5Mi5dT
         +oGVniPJkjWJQ6dkiBGfEGWaaijuYrxZcV9S68ny6VZKSpFNDOaAJGBc/F+LdDnOjaF3
         RLh1wrBn5y9fwCTXJHTsYjc6lzcP14VYWhbO5SEsAgA75zt8mClHYgKfR1QR6uwT+CtQ
         Y1xQTM7CymP0JZCaymavI1A4YpY1aUgNkVcEUCC9Wxh+cElQfZ9hvtPUrU5KYp0GjX2V
         hKeQ==
X-Gm-Message-State: AOAM533qLbPXfbQrbtm/Qe4SIqvFSCiDpebBeKZALb/74QFkHSsPs4t+
        k9EpgCEuMaFNXSwNOcZxUGkvd/QEXBEJqjRP5u/wRZmPdiZ84g==
X-Google-Smtp-Source: ABdhPJxSZ+KEYMXp9Wqc0KvAFXWOfYUI5U2b529iRSdvaFF+WCR8SRbZAn/YejfsE8Cr044NpduoR4lHuuGRG3ySFeY=
X-Received: by 2002:ac8:5617:: with SMTP id 23mr13142791qtr.257.1633351312274;
 Mon, 04 Oct 2021 05:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAFiDJ5_eoUNjQbCcwgHtXHfykeD7MiSw3xJzx83+bXOFHv-dQQ@mail.gmail.com>
In-Reply-To: <CAFiDJ5_eoUNjQbCcwgHtXHfykeD7MiSw3xJzx83+bXOFHv-dQQ@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 4 Oct 2021 20:41:41 +0800
Message-ID: <CAHCEeh+yXwAyc=G+JEfNx5tk6XXuVgZSF74yuEanBiz7JCiApQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Ley Foon Tan <lftan.linux@gmail.com>
Cc:     Darius Rad <darius@bluespec.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

Ley Foon Tan <lftan.linux@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=881=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:46=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Sep 29, 2021 at 11:54 PM Darius Rad <darius@bluespec.com> wrote:
> >
> > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > This patch adds task switch support for vector. It supports parti=
al lazy
> > > > > save and restore mechanism. It also supports all lengths of vlen.
> > > > >
> > > > > [guoren@linux.alibaba.com: First available porting to support vec=
tor
> > > > > context switching]
> > > > > [nick.knight@sifive.com: Rewrite vector.S to support dynamic vlen=
, xlen and
> > > > > code refine]
> > > > > [vincent.chen@sifive.co: Fix the might_sleep issue in vstate_save=
,
> > > > > vstate_restore]
> > > > > Co-developed-by: Nick Knight <nick.knight@sifive.com>
> > > > > Signed-off-by: Nick Knight <nick.knight@sifive.com>
> > > > > Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > > > > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > > > > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > > > > ---
> > > > >   arch/riscv/include/asm/switch_to.h | 66 +++++++++++++++++++++++
> > > > >   arch/riscv/kernel/Makefile         |  1 +
> > > > >   arch/riscv/kernel/process.c        | 38 ++++++++++++++
> > > > >   arch/riscv/kernel/vector.S         | 84 +++++++++++++++++++++++=
+++++++
> > > > >   4 files changed, 189 insertions(+)
> > > > >   create mode 100644 arch/riscv/kernel/vector.S
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/incl=
ude/asm/switch_to.h
> > > > > index ec83770b3d98..de0573dad78f 100644
> > > > > --- a/arch/riscv/include/asm/switch_to.h
> > > > > +++ b/arch/riscv/include/asm/switch_to.h
> > > > > @@ -7,10 +7,12 @@
> > > > >   #define _ASM_RISCV_SWITCH_TO_H
> > > > >
> > > > >   #include <linux/jump_label.h>
> > > > > +#include <linux/slab.h>
> > > > >   #include <linux/sched/task_stack.h>
> > > > >   #include <asm/processor.h>
> > > > >   #include <asm/ptrace.h>
> > > > >   #include <asm/csr.h>
> > > > > +#include <asm/asm-offsets.h>
> > > > >
> > > > >   #ifdef CONFIG_FPU
> > > > >   extern void __fstate_save(struct task_struct *save_to);
> > > > > @@ -68,6 +70,68 @@ static __always_inline bool has_fpu(void) { re=
turn false; }
> > > > >   #define __switch_to_fpu(__prev, __next) do { } while (0)
> > > > >   #endif
> > > > >
> > > > > +#ifdef CONFIG_VECTOR
> > > > > +extern bool has_vector;
> > > > > +extern unsigned long riscv_vsize;
> > > > > +extern void __vstate_save(struct __riscv_v_state *save_to, void =
*datap);
> > > > > +extern void __vstate_restore(struct __riscv_v_state *restore_fro=
m, void *datap);
> > > > > +
> > > > > +static inline void __vstate_clean(struct pt_regs *regs)
> > > > > +{
> > > > > +     regs->status =3D (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> > > > > +}
> > > > > +
> > > > > +static inline void vstate_off(struct task_struct *task,
> > > > > +                           struct pt_regs *regs)
> > > > > +{
> > > > > +     regs->status =3D (regs->status & ~SR_VS) | SR_VS_OFF;
> > > > > +}
> > > > > +
> > > > > +static inline void vstate_save(struct task_struct *task,
> > > > > +                            struct pt_regs *regs)
> > > > > +{
> > > > > +     if ((regs->status & SR_VS) =3D=3D SR_VS_DIRTY) {
> > > > > +             struct __riscv_v_state *vstate =3D &(task->thread.v=
state);
> > > > > +
> > > > > +             __vstate_save(vstate, vstate->datap);
> > > > > +             __vstate_clean(regs);
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static inline void vstate_restore(struct task_struct *task,
> > > > > +                               struct pt_regs *regs)
> > > > > +{
> > > > > +     if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> > > > > +             struct __riscv_v_state *vstate =3D &(task->thread.v=
state);
> > > > > +
> > > > > +             /* Allocate space for vector registers. */
> > > > > +             if (!vstate->datap) {
> > > > > +                     vstate->datap =3D kzalloc(riscv_vsize, GFP_=
ATOMIC);
> > > > > +                     vstate->size =3D riscv_vsize;
> > > > > +             }
> > > > > +             __vstate_restore(vstate, vstate->datap);
> > > > > +             __vstate_clean(regs);
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static inline void __switch_to_vector(struct task_struct *prev,
> > > > > +                                struct task_struct *next)
> > > > > +{
> > > > > +     struct pt_regs *regs;
> > > > > +
> > > > > +     regs =3D task_pt_regs(prev);
> > > > > +     if (unlikely(regs->status & SR_SD))
> > > > > +             vstate_save(prev, regs);
> > > > > +     vstate_restore(next, task_pt_regs(next));
> > > > > +}
> > > > > +
> > > > > +#else
> > > > > +#define has_vector false
> > > > > +#define vstate_save(task, regs) do { } while (0)
> > > > > +#define vstate_restore(task, regs) do { } while (0)
> > > > > +#define __switch_to_vector(__prev, __next) do { } while (0)
> > > > > +#endif
> > > > > +
> > > > >   extern struct task_struct *__switch_to(struct task_struct *,
> > > > >                                      struct task_struct *);
> > > > >
> > > > > @@ -77,6 +141,8 @@ do {                                          =
             \
> > > > >       struct task_struct *__next =3D (next);            \
> > > > >       if (has_fpu())                                  \
> > > > >               __switch_to_fpu(__prev, __next);        \
> > > > > +     if (has_vector)                                 \
> > > > > +             __switch_to_vector(__prev, __next);     \
> > > > >       ((last) =3D __switch_to(__prev, __next));         \
> > > > >   } while (0)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makef=
ile
> > > > > index 3397ddac1a30..344078080839 100644
> > > > > --- a/arch/riscv/kernel/Makefile
> > > > > +++ b/arch/riscv/kernel/Makefile
> > > > > @@ -40,6 +40,7 @@ obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> > > > >
> > > > >   obj-$(CONFIG_RISCV_M_MODE)  +=3D traps_misaligned.o
> > > > >   obj-$(CONFIG_FPU)           +=3D fpu.o
> > > > > +obj-$(CONFIG_VECTOR)         +=3D vector.o
> > > > >   obj-$(CONFIG_SMP)           +=3D smpboot.o
> > > > >   obj-$(CONFIG_SMP)           +=3D smp.o
> > > > >   obj-$(CONFIG_SMP)           +=3D cpu_ops.o
> > > > > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/proc=
ess.c
> > > > > index 03ac3aa611f5..0b86e9e531c9 100644
> > > > > --- a/arch/riscv/kernel/process.c
> > > > > +++ b/arch/riscv/kernel/process.c
> > > > > @@ -95,6 +95,16 @@ void start_thread(struct pt_regs *regs, unsign=
ed long pc,
> > > > >                */
> > > > >               fstate_restore(current, regs);
> > > > >       }
> > > > > +
> > > > > +     if (has_vector) {
> > > > > +             regs->status |=3D SR_VS_INITIAL;
> > > > > +             /*
> > > > > +              * Restore the initial value to the vector register
> > > > > +              * before starting the user program.
> > > > > +              */
> > > > > +             vstate_restore(current, regs);
> > > > > +     }
> > > > > +
> > > >
> > > > So this will unconditionally enable vector instructions, and alloca=
te
> > > > memory for vector state, for all processes, regardless of whether v=
ector
> > > > instructions are used?
> > > >
> > >
> > > Hi Darius,
> > >
> > > Yes, it will enable vector if has_vector() is true. The reason that w=
e
> > > choose to enable and allocate memory for user space program is becaus=
e
> > > we also implement some common functions in the glibc such as memcpy
> > > vector version and it is called very often by every process. So that
> > > we assume if the user program is running in a CPU with vector ISA
> > > would like to use vector by default. If we disable it by default and
> > > make it trigger the illegal instruction, that might be a burden since
> > > almost every process will use vector glibc memcpy or something like
> > > that.
> >
> > Do you have any evidence to support the assertion that almost every pro=
cess
> > would use vector operations?  One could easily argue that the converse =
is
> > true: no existing software uses the vector extension now, so most likel=
y a
> > process will not be using it.
> >
> > >
> > > > Given the size of the vector state and potential power and performa=
nce
> > > > implications of enabling the vector engine, it seems like this shou=
ld
> > > > treated similarly to Intel AMX on x86.  The full discussion of that=
 is
> > > > here:
> > > >
> > > > https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtD=
SAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
> > > >
> > > > The cover letter for recent Intel AMX patches has a summary of the =
x86
> > > > implementation:
> > > >
> > > > https://lore.kernel.org/lkml/20210825155413.19673-1-chang.seok.bae@=
intel.com/
> > > >
> > > > If RISC-V were to adopt a similar approach, I think the significant
> > > > points are:
> > > >
> > > >   1. A process (or thread) must specifically request the desire to =
use
> > > > vector extensions (perhaps with some new arch_prctl() API),
> > > >
> > > >   2. The kernel is free to deny permission, perhaps based on
> > > > administrative rules or for other reasons, and
> > > >
> > > >   3. If a process attempts to use vector extensions before doing th=
e
> > > > above, the process will die due to an illegal instruction.
> > >
> > > Thank you for sharing this, but I am not sure if we should treat
> > > vector like AMX on x86. IMHO, compiler might generate code with vecto=
r
> > > instructions automatically someday, maybe we should treat vector
> > > extensions like other extensions.
> > > If user knows the vector extension is supported in this CPU and he
> > > would like to use it, it seems we should let user use it directly jus=
t
> > > like other extensions.
> > > If user don't know it exists or not, user should use the library API
> > > transparently and let glibc or other library deal with it. The glibc
> > > ifunc feature or multi-lib should be able to choose the correct
> > > implementation.
> >
> > What makes me think that the vector extension should be treated like AM=
X is
> > that they both (1) have a significant amount of architectural state, an=
d
> > (2) likely have a significant power and/or area impact on (non-emulated=
)
> > designs.
> >
> > For example, I think it is possible, maybe even likely, that vector
> > implementations will have one or more of the following behaviors:
> >
> >   1. A single vector unit shared among two or more harts,
> >
> >   2. Additional power consumption when the vector unit is enabled and i=
dle
> > versus not being enabled at all,
> >
> >   3. For a system which supports variable operating frequency, a reduct=
ion
> > in the maximum frequency when the vector unit is enabled, and/or
> >
> >   4. The inability to enter low power states and/or delays to low power
> > states transitions when the vector unit is enabled.
> >
> > None of the above constraints apply to more ordinary extensions like
> > compressed or the various bit manipulation extensions.
> >
> > The discussion I linked to has some well reasoned arguments on why
> > substantial extensions should have a mechanism to request using them by
> > user space.  The discussion was in the context of Intel AMX, but applie=
s to
> > further x86 extensions, and I think should also apply to similar extens=
ions
> > on RISC-V, like vector here.
> >
> There is possible use case where not all cores support vector
> extension due to size, area and power.
> Perhaps can have the mechanism or flow to determine the
> application/thread require vector extension or it specifically request
> the desire to use
> vector extensions. Then this app/thread run on cpu with vector
> extension capability only.
>

IIRC, we assume all harts has the same ability in Linux because of SMP
assumption.
If we have more information of hw capability and we may use this
information for scheduler to switch the correct process to the correct
CPU.
Do you have any idea how to implement it in Linux kernel? Maybe we can
list in the TODO list.
