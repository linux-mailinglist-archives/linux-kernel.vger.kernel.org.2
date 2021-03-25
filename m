Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEEF34941E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCYOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:32:37 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60574 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhCYOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:32:18 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 12PEW5AR027167
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:32:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 12PEW5AR027167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616682726;
        bh=e8CUIyp+DoDPV+a+5TXzS00RUKDqRYfcFU2/cbf5mGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lIiDkCfaJCY6EMsiim5UIblpgG1SbGMbZmA/+bqY1bnuYrtrPVUOa6S9NMWWZ5iKm
         /6fx9rwZRyNDsgdSnCipakWMmgyel1DWWucRpKVdwjEQNFhTFFSWapqBLblUMah/B3
         Nodqv+ED3sjEh7g/jypWwNoQ2t6ZHkgN+s+830pCvOr6eQOwXR07fP0xnHXYe38/gC
         b6vn0XhLOcKkgHjapKJg/LOBx5Rvcrmr8MkTCeNIxhfEu7DUqsr3GlNPVUBF3qBf2A
         H+bkPm7mm8YA3Vw0SZYJhCbTQ9Oey684lAC4lmLidXbPdjO2+wjaY4aREv5e9/AOwa
         6v4sDi97Ie81w==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1024211pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:32:05 -0700 (PDT)
X-Gm-Message-State: AOAM533lY6G6TgJwxbqla1NS/zEg/0E6FNzb6lRnG+x95s49hShYK3Gq
        oaz4CYMbh8/Lbi9x/laNzH1ZnAIYJ1awNs3pFag=
X-Google-Smtp-Source: ABdhPJwc4gT8lT4sVTar/fALKNMpa9IVRwhl3jMyCmU69BLFe8NIHjmVvceXNtWyzPFvcoNpwSe5SVQpy7R3Tddw+0s=
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr9303713pjc.198.1616682725034;
 Thu, 25 Mar 2021 07:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210301131533.64671-1-masahiroy@kernel.org> <20210301131533.64671-2-masahiroy@kernel.org>
 <a47312ad-8d62-b740-49cd-d1065bb76d76@digikod.net>
In-Reply-To: <a47312ad-8d62-b740-49cd-d1065bb76d76@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Mar 2021 23:31:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQyyi0bOTLdmyhCwFg2PWPWq234ypVZnNkwLamoCAAmw@mail.gmail.com>
Message-ID: <CAK7LNASQyyi0bOTLdmyhCwFg2PWPWq234ypVZnNkwLamoCAAmw@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/syscalls: fix -Wmissing-prototypes warnings from COND_SYSCALL()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:48 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Hi Masahiro,
>
> What is the status of this patch? Could you please push it to -next?
> This would avoid emails from lkp:
> https://lore.kernel.org/linux-security-module/202103191423.Jl0jVzfL-lkp@i=
ntel.com/


Hmm, I also want to know the answer.
This is the *third* time that I resent this patch
to the x86 ML.

This is a territory of the x86 subsystem
because it is only touching
arch/x86/include/asm/syscall_wrapper.h
It is preferred to get this in via the x86 tree.

x86 Maintainers,
could you take a look please?





> Thanks,
>  Micka=C3=ABl
>
> On 01/03/2021 14:15, Masahiro Yamada wrote:
> > Building kernel/sys_ni.c with W=3D1 emits tons of -Wmissing-prototypes
> > warnings.
> >
> > $ make W=3D1 kernel/sys_ni.o
> >   [ snip ]
> >   CC      kernel/sys_ni.o
> > In file included from kernel/sys_ni.c:10:
> > ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous pr=
ototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
> >    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
> >       |              ^~
> > ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of m=
acro '__COND_SYSCALL'
> >   100 |  __COND_SYSCALL(x64, sys_##name)
> >       |  ^~~~~~~~~~~~~~
> > ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of m=
acro '__X64_COND_SYSCALL'
> >   256 |  __X64_COND_SYSCALL(name)     \
> >       |  ^~~~~~~~~~~~~~~~~~
> > kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
> >    39 | COND_SYSCALL(io_setup);
> >       | ^~~~~~~~~~~~
> > ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous pr=
ototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
> >    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
> >       |              ^~
> > ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of m=
acro '__COND_SYSCALL'
> >   120 |  __COND_SYSCALL(ia32, sys_##name)
> >       |  ^~~~~~~~~~~~~~
> > ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of m=
acro '__IA32_COND_SYSCALL'
> >   257 |  __IA32_COND_SYSCALL(name)
> >       |  ^~~~~~~~~~~~~~~~~~~
> > kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
> >    39 | COND_SYSCALL(io_setup);
> >       | ^~~~~~~~~~~~
> >   ...
> >
> > __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
> > declarations. Let's do likewise for __COND_SYSCALL() to fix the
> > warnings.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Tested-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> > ---
> >
> >  arch/x86/include/asm/syscall_wrapper.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/=
asm/syscall_wrapper.h
> > index a84333adeef2..80c08c7d5e72 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_reg=
s *regs);
> >       }
> >
> >  #define __COND_SYSCALL(abi, name)                                    \
> > +     __weak long __##abi##_##name(const struct pt_regs *__unused);   \
> >       __weak long __##abi##_##name(const struct pt_regs *__unused)    \
> >       {                                                               \
> >               return sys_ni_syscall();                                \
> >



--
Best Regards
Masahiro Yamada
