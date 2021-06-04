Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9039B63F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFDJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:55:38 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:42956 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:55:37 -0400
Received: by mail-yb1-f171.google.com with SMTP id x6so12846263ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dHxjx5YL69TG257xYMSlRK9DeSKTQjJUGuYuF182ZkA=;
        b=ZjNrkxUTZGVEOoJt3tb3BRIbJS+FLoZFrMhc6MX/H92/nvb6aCc3J/4G1fgy3QycmF
         wI/D/zKJ5ReMigNMp1Yruu+AfWR9GYZFfjznAioLnLSJQieXrGVOO6VX0V7ya22FKgQi
         l4R+FvRvFa0eHm/hoSZ3YM1MqKW1pwFIOSlqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHxjx5YL69TG257xYMSlRK9DeSKTQjJUGuYuF182ZkA=;
        b=tRSN+kjvBzt4fgYR7P+RcUEFGGDSOVFgoJtAaD+NcKDHQ8tztyN+hn2mj6s36qCohe
         3MYr8OxFginuqUd02USeL+yzQOFzGJNfqhUdmcYVNotKpiF84mx6npjCzBGpd7A96Mf/
         b1FbrCjyVLCsuwgnedngVduxGxc6vw3f3C4Ecq8GDHGRs6vtgLfF0emnRz3Cjif2RfHJ
         VbKdrkyk6XcsY1aun902Okvyppeq8zOI6aJijXkCu4CsB53RWfYh+mMJxf3KBdu/ONeX
         hUynxTunG8GNbcZA0sJsTbASIAODTxlrQUqMe2POrGNd/vc6ine4dFBD3ExjXq778Ob2
         F8sw==
X-Gm-Message-State: AOAM5325HK4Xfu1N2oDNZdM1j72fjgOxEfzQZN4fVCgJ0rk3MK77xVR+
        /n0ohDHtWbcwLVuqyRMl3SM8C6MLNSfOszoB+4eIyQ==
X-Google-Smtp-Source: ABdhPJyS9cYbCFKGsztRDfF6yaEQmGAAoAeRCo6x/1tvJKc15N9ceuS5HGdAbrtrzPPK25UBZxg8Mk36jlthwCVCiaE=
X-Received: by 2002:a05:6902:4b2:: with SMTP id r18mr3959329ybs.446.1622800371649;
 Fri, 04 Jun 2021 02:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210531085342.17494-1-vitaly.wool@konsulko.com>
 <62961217-1733-eaa3-b072-cbb252620c9a@ghiti.fr> <2fb64dce-779a-c6f2-53b7-088cd38813a4@ghiti.fr>
In-Reply-To: <2fb64dce-779a-c6f2-53b7-088cd38813a4@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Fri, 4 Jun 2021 11:52:40 +0200
Message-ID: <CAM4kBBKL0D0cvHaNTt2DobbUROp1eGAfmNkakOqzgakEZDLYbA@mail.gmail.com>
Subject: Re: [PATCH] riscv: xip: support runtime trap patching
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Jun 4, 2021 at 11:35 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Le 31/05/2021 =C3=A0 17:17, Alex Ghiti a =C3=A9crit :
> > Hi Vitaly,
> >
> > Le 31/05/2021 =C3=A0 10:53, Vitaly Wool a =C3=A9crit :
> >> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is currently
> >> not possible when the kernel is executed from the flash in XIP mode.
> >> Since runtime patching concerns only traps at the moment, let's just
> >> have all the traps reside in RAM anyway if RISCV_ERRATA_ALTERNATIVE
> >> is set. Thus, these functions will be patch-able even when the .text
> >> section is in flash.
> >>
> >
> > This sounds like a good fix for sifive platforms to work with XIP kerne=
l
> > in 5.13: did you test that it actually works on HW?
> >
> >> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> >> ---
> >>   arch/riscv/kernel/traps.c           | 13 +++++++++----
> >>   arch/riscv/kernel/vmlinux-xip.lds.S | 15 ++++++++++++++-
> >>   2 files changed, 23 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index 0721b9798595..7bc88d8aab97 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -86,8 +86,13 @@ static void do_trap_error(struct pt_regs *regs, int
> >> signo, int code,
> >>       }
> >>   }
> >> +#if defined (CONFIG_XIP_KERNEL) && defined
> >> (CONFIG_RISCV_ERRATA_ALTERNATIVE)
> >> +#define __trap_section        __section(".xip.traps")
> >> +#else
> >> +#define __trap_section
> >> +#endif
> >
> > Maybe we could do something more generic. At the moment, only traps are
> > subject to alternatives but that will likely expand: what about rather
> > defining a section called __alternative_section?
>
> Any thoughts about that?

Oh sorry, I have overlooked this. I do agree this is the way to go
long term, I just wanted to do a reasonably good quick fix since the
default SiFive configuration won't even build with CONFIG_XIP enabled.
So I would probably just suggest to take the existing solution and
then think over the details (e. g. should we just use one "alternative
section" for both the functions and the table or have separate ones?)
for the generic solution.

Best regards,
   Vitaly

> Thanks,
>
> Alex
>
> >
> >>   #define DO_ERROR_INFO(name, signo, code, str)                \
> >> -asmlinkage __visible void name(struct pt_regs *regs)            \
> >> +asmlinkage __visible __trap_section void name(struct pt_regs *regs)  =
  \
> >>   {                                    \
> >>       do_trap_error(regs, signo, code, regs->epc, "Oops - " str);    \
> >>   }
> >> @@ -111,7 +116,7 @@ DO_ERROR_INFO(do_trap_store_misaligned,
> >>   int handle_misaligned_load(struct pt_regs *regs);
> >>   int handle_misaligned_store(struct pt_regs *regs);
> >> -asmlinkage void do_trap_load_misaligned(struct pt_regs *regs)
> >> +asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs
> >> *regs)
> >>   {
> >>       if (!handle_misaligned_load(regs))
> >>           return;
> >> @@ -119,7 +124,7 @@ asmlinkage void do_trap_load_misaligned(struct
> >> pt_regs *regs)
> >>                 "Oops - load address misaligned");
> >>   }
> >> -asmlinkage void do_trap_store_misaligned(struct pt_regs *regs)
> >> +asmlinkage void __trap_section do_trap_store_misaligned(struct
> >> pt_regs *regs)
> >>   {
> >>       if (!handle_misaligned_store(regs))
> >>           return;
> >> @@ -146,7 +151,7 @@ static inline unsigned long
> >> get_break_insn_length(unsigned long pc)
> >>       return GET_INSN_LENGTH(insn);
> >>   }
> >> -asmlinkage __visible void do_trap_break(struct pt_regs *regs)
> >> +asmlinkage __visible __trap_section void do_trap_break(struct pt_regs
> >> *regs)
> >>   {
> >>   #ifdef CONFIG_KPROBES
> >>       if (kprobe_single_step_handler(regs))
> >> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S
> >> b/arch/riscv/kernel/vmlinux-xip.lds.S
> >> index 4b29b9917f99..a3ff09c4c3f9 100644
> >> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> >> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> >> @@ -99,9 +99,22 @@ SECTIONS
> >>       }
> >>       PERCPU_SECTION(L1_CACHE_BYTES)
> >> -    . =3D ALIGN(PAGE_SIZE);
> >> +    . =3D ALIGN(8);
> >> +    .alternative : {
> >> +        __alt_start =3D .;
> >> +        *(.alternative)
> >> +        __alt_end =3D .;
> >> +    }
> >>       __init_end =3D .;
> >> +    . =3D ALIGN(16);
> >
> > Why 16 here?
> >
> >> +    .xip.traps : {
> >> +        __xip_traps_start =3D .;
> >> +        *(.xip.traps)
> >> +        __xip_traps_end =3D .;
> >> +    }
> >> +
> >> +    . =3D ALIGN(PAGE_SIZE);
> >>       .sdata : {
> >>           __global_pointer$ =3D . + 0x800;
> >>           *(.sdata*)
> >>
> >
> > Thanks,
> >
> > Alex
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
