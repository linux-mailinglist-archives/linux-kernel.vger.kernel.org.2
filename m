Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5742123A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhJDPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJDPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:06:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB919C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 08:04:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d8so5946880qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=coeA+NJ+izjdDdd3bJyei8jkmsDrSZ3n52RhOCmFatw=;
        b=mdeGGc+U+UEijbCYGQMc8WuuyUDDP9kt8ceaq5dxbO1tt68ocWyCzi2k5cGv05MN30
         LP7qSfynDVrh0uS+JZ4xP4nqPtXIuH6xowvGHNdVdI+5r/C6ktJF9L4YWabqiVBDvUhG
         9fSVBHzv4lkabH9OEQX/NqHA6tJuBmTwn8t5jbYINI6oZjgxk9A894jD9B1hYTMrtzZa
         WdEft//oQVfRjFs6qcq10s/DPuk5UbO0Qx2wcmgysGUKNO+nlUbG5L3K8NGvNCLzz4Dy
         vDDmuHl7JUcLKu7mbVvJqgbOjXastbdM6KnV9nJucdnjALwMmBdxj4czge8RjTKIpEGE
         TNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=coeA+NJ+izjdDdd3bJyei8jkmsDrSZ3n52RhOCmFatw=;
        b=mjechr2FOxIxR7d+moB7vHeSWBgwtU+/8KfJibK0ccep9wpQkE0R24ht368be4+sh8
         KGyFaXlUbSuvaBsVSoxTYT+Aa+dDSUGcLRG7Np4jlB2jFp3dWofWyQNhxtXyRKynqasC
         sCgXOqCpMaixHebGIpdfqdzX949KMDeBqJec3tPgJjpW4yekLY1qolpvBSTpv2umJ4ro
         Opx/aGtb6Pb50pGjIsp0SPRhhsAcx3JNeCKwKLIlotUZWqYsd29xrnYsy+8jCUj32Aow
         AM8Xuz85Yigzng/goKBPYFtNy2RVr8oXCAEmhI9MGCe+LUNGq1wywYKqLr5VnxU6ZXW1
         OilQ==
X-Gm-Message-State: AOAM533M88ej6c6Q5WO0IpY4OnP6D8P1lWyra/jFVLPS+G02AaOtSZki
        /y2+bWOdxTq1zWo/tSf4pqGGAl60BOF7c/1luQt/ug==
X-Google-Smtp-Source: ABdhPJxOfbWjjd8CVL7rNz6roUeC3GWYDDYV8AHX+b4DFK5d8Ckh3KNr3zeUy5Hp+Z5N0sqGW/MYG/nPU2vqSK7SRRQ=
X-Received: by 2002:ac8:5d91:: with SMTP id d17mr14248372qtx.18.1633359861733;
 Mon, 04 Oct 2021 08:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <56e2328d133045c79b420ecbcaf37cf9d0b2248c.1631121222.git.greentime.hu@sifive.com>
 <20210915222456.1de541df@xhacker>
In-Reply-To: <20210915222456.1de541df@xhacker>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 4 Oct 2021 23:04:11 +0800
Message-ID: <CAHCEehKGTA0ygyf4KNVovc5nAo_UZUus7QBQLeJHt1Py3Xb-mw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 21/21] riscv: Turn has_vector into a static key if VECTOR=y
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
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

Jisheng Zhang <jszhang3@mail.ustc.edu.cn> =E6=96=BC 2021=E5=B9=B49=E6=9C=88=
15=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:31=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu,  9 Sep 2021 01:45:33 +0800
> Greentime Hu <greentime.hu@sifive.com> wrote:
>
> > Just like fpu, we can use static key for has_vector.
> > The has_vector check sits at hot code path: switch_to(). Currently,
> > has_vector is a bool variable if VECTOR=3Dy, switch_to() checks it each=
 time,
> > we can optimize out this check by turning the has_vector into a static =
key.
> >
>
> has_vector is newly introduced in this patch set so I believe this patch =
can
> be folded into has_vector introducing patch, I.E patch 6
>
ok, I'll split this patch and merge these codes into its related patches.

>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/switch_to.h     | 10 +++++++---
> >  arch/riscv/kernel/cpufeature.c         |  4 ++--
> >  arch/riscv/kernel/kernel_mode_vector.c |  4 ++--
> >  arch/riscv/kernel/process.c            |  8 ++++----
> >  arch/riscv/kernel/signal.c             |  6 +++---
> >  5 files changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/as=
m/switch_to.h
> > index b48c9c974564..576204217e0f 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -71,7 +71,11 @@ static __always_inline bool has_fpu(void) { return f=
alse; }
> >  #endif
> >
> >  #ifdef CONFIG_VECTOR
> > -extern bool has_vector;
> > +extern struct static_key_false cpu_hwcap_vector;
> > +static __always_inline bool has_vector(void)
> > +{
> > +     return static_branch_likely(&cpu_hwcap_vector);
> > +}
> >  extern unsigned long riscv_vsize;
> >  extern void __vstate_save(struct __riscv_v_state *save_to, void *datap=
);
> >  extern void __vstate_restore(struct __riscv_v_state *restore_from, voi=
d *datap);
> > @@ -120,7 +124,7 @@ static inline void __switch_to_vector(struct task_s=
truct *prev,
> >  }
> >
> >  #else
> > -#define has_vector false
> > +static __always_inline bool has_vector(void) { return false; }
> >  #define riscv_vsize (0)
> >  #define vstate_save(task, regs) do { } while (0)
> >  #define vstate_restore(task, regs) do { } while (0)
> > @@ -136,7 +140,7 @@ do {                                               =
       \
> >       struct task_struct *__next =3D (next);            \
> >       if (has_fpu())                                  \
> >               __switch_to_fpu(__prev, __next);        \
> > -     if (has_vector)                                 \
> > +     if (has_vector())                                       \
> >               __switch_to_vector(__prev, __next);     \
> >       ((last) =3D __switch_to(__prev, __next));         \
> >  } while (0)
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index af984f875f60..0139ec20adce 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -23,7 +23,7 @@ __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu=
);
> >  #endif
> >  #ifdef CONFIG_VECTOR
> >  #include <asm/vector.h>
> > -bool has_vector __read_mostly;
> > +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
> >  unsigned long riscv_vsize __read_mostly;
> >  #endif
> >
> > @@ -157,7 +157,7 @@ void __init riscv_fill_hwcap(void)
> >
> >  #ifdef CONFIG_VECTOR
> >       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> > -             has_vector =3D true;
> > +             static_branch_enable(&cpu_hwcap_vector);
> >               /* There are 32 vector registers with vlenb length. */
> >               rvv_enable();
> >               riscv_vsize =3D csr_read(CSR_VLENB) * 32;
> > diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel=
/kernel_mode_vector.c
> > index 0d990bd8b8dd..0d08954c30af 100644
> > --- a/arch/riscv/kernel/kernel_mode_vector.c
> > +++ b/arch/riscv/kernel/kernel_mode_vector.c
> > @@ -110,7 +110,7 @@ static void vector_flush_cpu_state(void)
> >   */
> >  void kernel_rvv_begin(void)
> >  {
> > -     if (WARN_ON(!has_vector))
> > +     if (WARN_ON(!has_vector()))
> >               return;
> >
> >       WARN_ON(!may_use_vector());
> > @@ -140,7 +140,7 @@ EXPORT_SYMBOL(kernel_rvv_begin);
> >   */
> >  void kernel_rvv_end(void)
> >  {
> > -     if (WARN_ON(!has_vector))
> > +     if (WARN_ON(!has_vector()))
> >               return;
> >
> >       /* Invalidate vector regs */
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 05ff5f934e7e..62540815ba1c 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -96,7 +96,7 @@ void start_thread(struct pt_regs *regs, unsigned long=
 pc,
> >               fstate_restore(current, regs);
> >       }
> >
> > -     if (has_vector) {
> > +     if (has_vector()) {
> >               struct __riscv_v_state *vstate =3D &(current->thread.vsta=
te);
> >
> >               /* Enable vector and allocate memory for vector registers=
. */
> > @@ -141,11 +141,11 @@ void flush_thread(void)
> >  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *=
src)
> >  {
> >       fstate_save(src, task_pt_regs(src));
> > -     if (has_vector)
> > +     if (has_vector())
> >               /* To make sure every dirty vector context is saved. */
> >               vstate_save(src, task_pt_regs(src));
> >       *dst =3D *src;
> > -     if (has_vector) {
> > +     if (has_vector()) {
> >               /* Copy vector context to the forked task from parent. */
> >               if ((task_pt_regs(src)->status & SR_VS) !=3D SR_VS_OFF) {
> >                       dst->thread.vstate.datap =3D kzalloc(riscv_vsize,=
 GFP_KERNEL);
> > @@ -164,7 +164,7 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct task_struct *src)
> >  void arch_release_task_struct(struct task_struct *tsk)
> >  {
> >       /* Free the vector context of datap. */
> > -     if (has_vector)
> > +     if (has_vector())
> >               kfree(tsk->thread.vstate.datap);
> >  }
> >
> > diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> > index d30a3b588156..6a19b4b7b206 100644
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -192,7 +192,7 @@ static long restore_sigcontext(struct pt_regs *regs=
,
> >                               goto invalid;
> >                       goto done;
> >               case RVV_MAGIC:
> > -                     if (!has_vector)
> > +                     if (!has_vector())
> >                               goto invalid;
> >                       if (size !=3D rvv_sc_size)
> >                               goto invalid;
> > @@ -221,7 +221,7 @@ static size_t cal_rt_frame_size(void)
> >
> >       frame_size =3D sizeof(*frame);
> >
> > -     if (has_vector)
> > +     if (has_vector())
> >               total_context_size +=3D rvv_sc_size;
> >       /* Preserved a __riscv_ctx_hdr for END signal context header. */
> >       total_context_size +=3D sizeof(struct __riscv_ctx_hdr);
> > @@ -288,7 +288,7 @@ static long setup_sigcontext(struct rt_sigframe __u=
ser *frame,
> >       if (has_fpu())
> >               err |=3D save_fp_state(regs, &sc->sc_fpregs);
> >       /* Save the vector state. */
> > -     if (has_vector)
> > +     if (has_vector())
> >               err |=3D save_v_state(regs, &sc_reserved_free_ptr);
> >
> >       /* Put END __riscv_ctx_hdr at the end. */
>
>
