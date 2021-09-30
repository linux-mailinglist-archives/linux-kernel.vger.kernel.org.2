Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4456941DAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350178AbhI3NOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349892AbhI3NOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:14:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7256761528
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633007556;
        bh=vHSfNPWmgwIIa9+j2tmKGBTEDiaUE/7eNtYnP7G/W4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGtqMo5E4xGTkHt1jJrxW8YHOcPFO6LUA7iPXBkoNrThnA0ffRV3HacMGjBlXi7AH
         RNHpE4lexIfAM7aq6K6LgijwPx/6A6p5Y5SrzoY8RO4nc3WV3U9+Do//3GcXknocn1
         wS7kEkFjzHqyOuluSTRw5D3ZZgG8uiokciZXS3uctswM3fwsUotYXHTKlp1i512dHM
         tdtjS4eJw2XqnTU27/hYsF7pp7cV5k8CswjDFvpdYwFaNYFkFJiBOdmwgF5KllrrHI
         JZ619kzb9PZiCVhV0p3CVsLaR8bB0IjAyylIqYloWAsSpF1ZMCv9JaviPjyRfkrNml
         tntDlL5n/8AbA==
Received: by mail-oi1-f172.google.com with SMTP id s24so7147426oij.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:12:36 -0700 (PDT)
X-Gm-Message-State: AOAM530Fq5hzv4ls2HuodYk0ZwAbKfc41/qlYDdvUt52s4ib4+MdrozP
        mcpWj1E0jsTfYhO8fq4NVEhE3IBORGvEajSIkMk=
X-Google-Smtp-Source: ABdhPJw8aCnwIHEA1Jv1HQMZO8zxfC4IOKBOuq+3Wj+bcPVnd8wKzwVnaZWqAwug1Q+dyXuyUb6l+3W1Ethn3DDUZGo=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr2628592oiu.33.1633007555710;
 Thu, 30 Sep 2021 06:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210930125813.197418-1-ardb@kernel.org> <20210930125813.197418-6-ardb@kernel.org>
 <427566ca-80c0-56eb-880b-908bd4a71e9a@csgroup.eu>
In-Reply-To: <427566ca-80c0-56eb-880b-908bd4a71e9a@csgroup.eu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Sep 2021 15:12:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF6NSy1WRrmHkg15ZD_myCa1gj7dN-CqPyz=bmRmoOdMQ@mail.gmail.com>
Message-ID: <CAMj1kXF6NSy1WRrmHkg15ZD_myCa1gj7dN-CqPyz=bmRmoOdMQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sept 2021 at 15:09, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 30/09/2021 =C3=A0 14:58, Ard Biesheuvel a =C3=A9crit :
> > THREAD_INFO_IN_TASK moved the CPU field out of thread_info, but this
> > causes some issues on architectures that define raw_smp_processor_id()
> > in terms of this field, due to the fact that #include'ing linux/sched.h
> > to get at struct task_struct is problematic in terms of circular
> > dependencies.
> >
> > Given that thread_info and task_struct are the same data structure
> > anyway when THREAD_INFO_IN_TASK=3Dy, let's move it back so that having
> > access to the type definition of struct thread_info is sufficient to
> > reference the CPU number of the current task.
> >
> > Note that this requires THREAD_INFO_IN_TASK's definition of the
> > task_thread_info() helper to be updated, as task_cpu() takes a
> > pointer-to-const, whereas task_thread_info() (which is used to generate
> > lvalues as well), needs a non-const pointer. So make it a macro instead=
.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >   arch/arm64/kernel/asm-offsets.c   |  1 -
> >   arch/arm64/kernel/head.S          |  2 +-
> >   arch/powerpc/kernel/asm-offsets.c |  2 +-
> >   arch/powerpc/kernel/smp.c         |  2 +-
> >   include/linux/sched.h             | 13 +------------
> >   kernel/sched/sched.h              |  4 ----
> >   6 files changed, 4 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-of=
fsets.c
> > index cee9f3e9f906..0bfc048221af 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -27,7 +27,6 @@
> >   int main(void)
> >   {
> >     DEFINE(TSK_ACTIVE_MM,             offsetof(struct task_struct, acti=
ve_mm));
> > -  DEFINE(TSK_CPU,            offsetof(struct task_struct, cpu));
> >     BLANK();
> >     DEFINE(TSK_TI_CPU,                offsetof(struct task_struct, thre=
ad_info.cpu));
> >     DEFINE(TSK_TI_FLAGS,              offsetof(struct task_struct, thre=
ad_info.flags));
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 17962452e31d..6a98f1a38c29 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -412,7 +412,7 @@ SYM_FUNC_END(__create_page_tables)
> >       scs_load \tsk
> >
> >       adr_l   \tmp1, __per_cpu_offset
> > -     ldr     w\tmp2, [\tsk, #TSK_CPU]
> > +     ldr     w\tmp2, [\tsk, #TSK_TI_CPU]
>
> Why do you need to change the name ?
>
> For powerpc64, you leave TASK_CPU.
>

Because arm64 has a clear idiom here, where TSK_TI_ is used for
thread_info fields accessed via a task_struct pointer. Also, it only
occurs once in the code.

Power does not seem to have this idiom, and TASK_CPU is used in many
more places, so I don't think it makes sense to change its name.


> >       ldr     \tmp1, [\tmp1, \tmp2, lsl #3]
> >       set_this_cpu_offset \tmp1
> >       .endm
> > diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/as=
m-offsets.c
> > index e563d3222d69..e37e4546034e 100644
> > --- a/arch/powerpc/kernel/asm-offsets.c
> > +++ b/arch/powerpc/kernel/asm-offsets.c
> > @@ -93,7 +93,7 @@ int main(void)
> >   #endif /* CONFIG_PPC64 */
> >       OFFSET(TASK_STACK, task_struct, stack);
> >   #ifdef CONFIG_SMP
> > -     OFFSET(TASK_CPU, task_struct, cpu);
> > +     OFFSET(TASK_CPU, task_struct, thread_info.cpu);
> >   #endif
> >
> >   #ifdef CONFIG_LIVEPATCH
>
> ...
