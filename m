Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2B39C6BB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFEIWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:22:11 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:65165 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:22:11 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1558K7UX019363
        for <linux-kernel@vger.kernel.org>; Sat, 5 Jun 2021 17:20:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1558K7UX019363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622881208;
        bh=2KZ2DFnGUmOMndKjn2vFbyLrqHO/6wYppNTe8El71NE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+4rBi1GwCisVa/pn1SRdRnOUm1+t8eBj3/hfrvV0Lk+zUk/3EPPfHXV4/G3uS8gk
         JDTzjfyypwUJ4zgtT/pnlDYdIjdB/zXY1erulJsncagaA6kWwi3PcYkaNjcXqEMIu2
         PlSsDO4r9SdPYCwt6RnWGnd+/vIuSctuAbHpZmBVflAW1LVjR8OP7e/mSZfUns8ez0
         /uN8tpb4iCzw87fqlQ7/oOdDlr3AdefhWgVGjA3HedLJMTWQlIfaC4gN7xQrl6v4Sq
         ejLEAnWUFba6EZ7RKTfBgy2lhcv/b1TvIo8k8N1eFuwHGhoJpbeVcEhmQCAL/se2kb
         fPTxxJfjVpTBg==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id d5-20020a17090ab305b02901675357c371so8402373pjr.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 01:20:07 -0700 (PDT)
X-Gm-Message-State: AOAM531qDQgTYG6fdivJrmSJWWd8ipruYSSjXipgh/fU3BOUyhkySU/h
        WkJYzSvRWe/p6GFh1EHL9HtShvO7jKrZ+TbiiPw=
X-Google-Smtp-Source: ABdhPJwMG3wQHbH00oQt2XpiPhbdxbaysohG+k5TpjtqDONw/NlCoX604Pvmwmf2sPzcQ5EFjOonm2ik/pao68haDUo=
X-Received: by 2002:a17:90a:c485:: with SMTP id j5mr6221392pjt.87.1622881207266;
 Sat, 05 Jun 2021 01:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <454425.1622838810@turing-police>
In-Reply-To: <454425.1622838810@turing-police>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 5 Jun 2021 17:19:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbWnduSfqehJ7yMjxCbkrM87aojDCdQ79J+kXiTaZ-fQ@mail.gmail.com>
Message-ID: <CAK7LNATbWnduSfqehJ7yMjxCbkrM87aojDCdQ79J+kXiTaZ-fQ@mail.gmail.com>
Subject: Re: x86 - weird cross-compile build problem with try-run next-20210602
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 5:33 AM Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.e=
du> wrote:
>
> I built a gcc 11.1 cross-compiler targeting x86_64, and builds
> were throwing an error message:
>
> Makefile:149: CONFIG_X86_X32 enabled but no binutils support
>
> so I added some debugging to arch/x86/Makefile:
>
> ifdef CONFIG_X86_X32
>         x32_ld_ok :=3D $(call try-run,\
>                         /bin/echo -e '1: .quad 1b' | \
>                         $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP"=
 - && \
>                         $(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMP.o" && \
>                         $(LD) -m elf32_x86_64 "$$TMP.o" -o "$$TMP",y,n)
>  $(warning x32_ld_ok is +$(x32_ld_ok)+ with CC=3D$(CC) $(KBUILD_AFLAGS) O=
BJ=3D$(OBJCOPY) LD=3D$(LD) )
>         ifeq ($(x32_ld_ok),y)
>                 CONFIG_X86_X32_ABI :=3D y
>
> and that throws:
>
> arch/x86/Makefile:143: x32_ld_ok is ++ with CC=3Dx86_64-unknown-linux-gnu=
-gcc -D__ASSEMBLY__ -fno-PIE -m64 OBJ=3Dx86_64-unknown-linux-gnu-objcopy LD=
=3Dx86_64-unknown-linux-gnu-ld
>
> Anybody have a clue why $(x32_ld_ok)  is null rather than 'y' or 'n'?


What command did you run?

I see this warning message for 'make install' for example.

$ make install
arch/x86/Makefile:148: CONFIG_X86_X32 enabled but no binutils support



Please add one more debug line:
  $(warning need-compiler is +$(need-compiler)+)
and what will you get?



One quick fix is to change

    ifeq ($(x32_ld_ok),y)

to

   ifneq ($(x32_ld_ok),n)

But, I think moving this check to Kconfig
is a more proper fix.







> (It's totally possible that my cross-compiler is broken, but I still don'=
t see how
> try-run would return null rather than 'n' in that case...  I built a shel=
l script that did the
> test and that ended with $? =3D=3D 0, but had a warning msg:
>
> + /bin/echo -e '1: .quad 1b'
> + x86_64-unknown-linux-gnu-gcc -D__ASSEMBLY__ -fno-PIE -m64 -c -x assembl=
er -o /tmp/z97 -
> + x86_64-unknown-linux-gnu-objcopy -O elf32-x86-64 /tmp/z97 /tmp/z99.o
> + x86_64-unknown-linux-gnu-ld -m elf32_x86_64 /tmp/z99.o -o /tmp/z98
> x86_64-unknown-linux-gnu-ld: warning: cannot find entry symbol _start; de=
faulting to 0000000000401000
> echo $?
> + echo 0
> 0
>
>
>


--=20
Best Regards
Masahiro Yamada
