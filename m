Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3893971CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFAKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFAKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:50:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC67C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:48:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f84so20513940ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vHWXwHdrf+SpAY1R+QQ9SLPMaJjOtheXZxEyrp2mlm4=;
        b=c3CkPxKUvLz7qLkj6z4StYTCRXk6JgZiglQ9JBDxksRoIbTXnanZpQHBRXczPVdNJI
         ED10qAJWnPVA9BvKVkcSUPP3KvETpPglxEixAA+EZ8M2MtVSyZ9jHWJevCcm4g02DYaI
         VtBR5s3/6nlOU6oxdch70N2bgTGt78mchF2V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vHWXwHdrf+SpAY1R+QQ9SLPMaJjOtheXZxEyrp2mlm4=;
        b=CxkTpnQPS6XdfuyCe+pdWNVmPn1e9rUABB4G6BFzopgSA9F9fL7YnPT21OR292Pt6a
         cngdzgq/SATCP75ONngfQcwInSrGIonAsV+8aLNoIbtPLkLshfszE2G9XREe6YqbtbH3
         ir7yGzfVkLZzQEJyEJIioX1ExYKa7swliFhf5iIhhbuGOSwI/rHV4afSWcPoRD5Ahc90
         dtobPJCxVFfC0qT6qL0eZ2wd+ilxSoyrTqU8VKEBx70rHQMvhkQNIMZs22fsXY+drS64
         vSmOq6t4A30in2yHs4FxvbS41ZUrJyNettI7tU+UBAod7WgrRIAGLlwkUT0nqGyaA9wX
         0qLA==
X-Gm-Message-State: AOAM532REZgKuJjINM7bhgtMQun6SB0ISCYD96v8QfPzeq1iCYytEAR0
        tqP4Oytq1CQw/uAyL9g42mutC1EjBBggnsk3obi52A==
X-Google-Smtp-Source: ABdhPJxZxCyk1Ss2osp7d7BP2Esx+7urpayxglIs6s80rFyyxyM14ZcbwDxkjnbrh3HDO++Xd7GzS0OATYSWG9BWdZU=
X-Received: by 2002:a5b:307:: with SMTP id j7mr34512850ybp.481.1622544518564;
 Tue, 01 Jun 2021 03:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210531085342.17494-1-vitaly.wool@konsulko.com> <62961217-1733-eaa3-b072-cbb252620c9a@ghiti.fr>
In-Reply-To: <62961217-1733-eaa3-b072-cbb252620c9a@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 1 Jun 2021 12:48:27 +0200
Message-ID: <CAM4kBBJ_3KF52UtC7LB=zwB_ohgv6wKWhN7kQuAG+4rCV4tQTA@mail.gmail.com>
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

On Mon, May 31, 2021 at 5:17 PM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi Vitaly,
>
> Le 31/05/2021 =C3=A0 10:53, Vitaly Wool a =C3=A9crit :
> > RISCV_ERRATA_ALTERNATIVE patches text at runtime which is currently
> > not possible when the kernel is executed from the flash in XIP mode.
> > Since runtime patching concerns only traps at the moment, let's just
> > have all the traps reside in RAM anyway if RISCV_ERRATA_ALTERNATIVE
> > is set. Thus, these functions will be patch-able even when the .text
> > section is in flash.
> >
>
> This sounds like a good fix for sifive platforms to work with XIP kernel
> in 5.13: did you test that it actually works on HW?

I don't have any SiFive HW so strictly speaking, not quite. However, I
created a test configuration for Polarfire with a basically no-op
runtime patching and it apparently worked. Traps end up in RAM and are
changeable.

> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > ---
> >   arch/riscv/kernel/traps.c           | 13 +++++++++----
> >   arch/riscv/kernel/vmlinux-xip.lds.S | 15 ++++++++++++++-
> >   2 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 0721b9798595..7bc88d8aab97 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -86,8 +86,13 @@ static void do_trap_error(struct pt_regs *regs, int =
signo, int code,
> >       }
> >   }
> >
> > +#if defined (CONFIG_XIP_KERNEL) && defined (CONFIG_RISCV_ERRATA_ALTERN=
ATIVE)
> > +#define __trap_section               __section(".xip.traps")
> > +#else
> > +#define __trap_section
> > +#endif
>
> Maybe we could do something more generic. At the moment, only traps are
> subject to alternatives but that will likely expand: what about rather
> defining a section called __alternative_section?
>
> >   #define DO_ERROR_INFO(name, signo, code, str)                        =
       \
> > -asmlinkage __visible void name(struct pt_regs *regs)                 \
> > +asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> >   {                                                                   \
> >       do_trap_error(regs, signo, code, regs->epc, "Oops - " str);     \
> >   }
> > @@ -111,7 +116,7 @@ DO_ERROR_INFO(do_trap_store_misaligned,
> >   int handle_misaligned_load(struct pt_regs *regs);
> >   int handle_misaligned_store(struct pt_regs *regs);
> >
> > -asmlinkage void do_trap_load_misaligned(struct pt_regs *regs)
> > +asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs =
*regs)
> >   {
> >       if (!handle_misaligned_load(regs))
> >               return;
> > @@ -119,7 +124,7 @@ asmlinkage void do_trap_load_misaligned(struct pt_r=
egs *regs)
> >                     "Oops - load address misaligned");
> >   }
> >
> > -asmlinkage void do_trap_store_misaligned(struct pt_regs *regs)
> > +asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs=
 *regs)
> >   {
> >       if (!handle_misaligned_store(regs))
> >               return;
> > @@ -146,7 +151,7 @@ static inline unsigned long get_break_insn_length(u=
nsigned long pc)
> >       return GET_INSN_LENGTH(insn);
> >   }
> >
> > -asmlinkage __visible void do_trap_break(struct pt_regs *regs)
> > +asmlinkage __visible __trap_section void do_trap_break(struct pt_regs =
*regs)
> >   {
> >   #ifdef CONFIG_KPROBES
> >       if (kprobe_single_step_handler(regs))
> > diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vm=
linux-xip.lds.S
> > index 4b29b9917f99..a3ff09c4c3f9 100644
> > --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> > +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> > @@ -99,9 +99,22 @@ SECTIONS
> >       }
> >       PERCPU_SECTION(L1_CACHE_BYTES)
> >
> > -     . =3D ALIGN(PAGE_SIZE);
> > +     . =3D ALIGN(8);
> > +     .alternative : {
> > +             __alt_start =3D .;
> > +             *(.alternative)
> > +             __alt_end =3D .;
> > +     }
> >       __init_end =3D .;
> >
> > +     . =3D ALIGN(16);
>
> Why 16 here?

Honestly, I don't remember. I believe it should have been 8 but didn't
bother to check, thought it was not a big deal anyway :)

Best regards,
   Vitaly

> > +     .xip.traps : {
> > +             __xip_traps_start =3D .;
> > +             *(.xip.traps)
> > +             __xip_traps_end =3D .;
> > +     }
> > +
> > +     . =3D ALIGN(PAGE_SIZE);
> >       .sdata : {
> >               __global_pointer$ =3D . + 0x800;
> >               *(.sdata*)
> >
>
> Thanks,
>
> Alex
