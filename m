Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420CA341CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCSMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhCSMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DADC64F6E;
        Fri, 19 Mar 2021 12:25:11 +0000 (UTC)
Date:   Fri, 19 Mar 2021 12:25:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20210319122506.GA6832@arm.com>
References: <20210225112122.2198845-1-arnd@kernel.org>
 <20210317143757.GD12269@arm.com>
 <20210317161838.GF12269@arm.com>
 <CAK8P3a0FeuGLYhiPx=GLdewu2P=Hix7cpVsbF05i5WO5T2XPvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FeuGLYhiPx=GLdewu2P=Hix7cpVsbF05i5WO5T2XPvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:41:54AM +0100, Arnd Bergmann wrote:
> On Wed, Mar 17, 2021 at 5:18 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 02:37:57PM +0000, Catalin Marinas wrote:
> > > On Thu, Feb 25, 2021 at 12:20:56PM +0100, Arnd Bergmann wrote:
> > > > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > > > index bad2b9eaab22..926cdb597a45 100644
> > > > --- a/arch/arm64/kernel/vmlinux.lds.S
> > > > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > > > @@ -217,7 +217,7 @@ SECTIONS
> > > >             INIT_CALLS
> > > >             CON_INITCALL
> > > >             INIT_RAM_FS
> > > > -           *(.init.altinstructions .init.bss .init.bss.*)  /* from the EFI stub */
> > > > +           *(.init.altinstructions .init.data.* .init.bss .init.bss.*)     /* from the EFI stub */
> > >
> > > INIT_DATA already covers .init.data and .init.data.*, so I don't think
> > > we need this change.
> >
> > Ah, INIT_DATA only covers init.data.* (so no dot in front). The above
> > is needed for the EFI stub.
> 
> I wonder if that is just a typo in INIT_DATA. Nico introduced it as part of
> 266ff2a8f51f ("kbuild: Fix asm-generic/vmlinux.lds.h for
> LD_DEAD_CODE_DATA_ELIMINATION"), so perhaps that should have
> been .init.data.* instead.

I think it was the other Nicholas ;) (with an 'h'). The vmlinux.lds.h
change indeed looks like a typo (it's been around since 4.18).

> > However, I gave this a quick try and under Qemu with -cpu max and -smp 2
> > (or more) it fails as below. I haven't debugged but the lr points to
> > just after the switch_to() call. Maybe some section got discarded and we
> > patched in the wrong instructions. It is fine with -cpu host or -smp 1.
> 
> Ah, interesting.
> 
> > -------------------8<------------------------
> > smp: Bringing up secondary CPUs ...
> > Detected PIPT I-cache on CPU1
> > CPU1: Booted secondary processor 0x0000000001 [0x000f0510]
> > Unable to handle kernel paging request at virtual address eb91d81ad2971160
> > Mem abort info:
> >   ESR = 0x86000004
> >   EC = 0x21: IABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> > [eb91d81ad2971160] address between user and kernel address ranges
> > Internal error: Oops: 86000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 1 PID: 16 Comm: migration/1 Not tainted 5.12.0-rc3-00002-g128e977c1322 #1
> > Stopper: 0x0 <- 0x0
> > pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
> > pc : 0xeb91d81ad2971160
> > lr : __schedule+0x230/0x6b8
> > sp : ffff80001009bd60
> > x29: ffff80001009bd60 x28: 0000000000000000
> > x27: ffff0000000a6760 x26: ffff0000000b7540
> > x25: 0080000000000000 x24: ffffd81ad3969000
> > x23: ffff0000000a6200 x22: 6ee0d81ad2971658
> > x21: ffff0000000a6200 x20: ffff000000080000
> > x19: ffff00007fbc6bc0 x18: 0000000000000030
> > x17: 0000000000000000 x16: 0000000000000000
> > x15: 00008952b30a9a9e x14: 0000000000000366
> > x13: 0000000000000192 x12: 0000000000000000
> > x11: 0000000000000003 x10: 00000000000009b0
> > x9 : ffff80001009bd30 x8 : ffff0000000a6c10
> > x7 : ffff00007fbc6cc0 x6 : 00000000fffedb30
> > x5 : 00000000ffffffff x4 : 0000000000000000
> > x3 : 0000000000000008 x2 : 0000000000000000
> > x1 : ffff0000000a6200 x0 : ffff0000000a3800
> > Call trace:
> >  0xeb91d81ad2971160
> >  schedule+0x70/0x108
> >  schedule_preempt_disabled+0x24/0x40
> >  __kthread_parkme+0x68/0xd0
> >  kthread+0x138/0x170
> >  ret_from_fork+0x10/0x30
> > Code: bad PC value
> > ---[ end trace af3481062ecef3e7 ]---
> 
> This looks like it has just returned from __schedule() to schedule()
> and is trying to return from that as well, through code like this:
> 
> .L562:
> // /git/arm-soc/kernel/sched/core.c:5159: }
>         ldp     x19, x20, [sp, 16]      //,,
>         ldp     x29, x30, [sp], 32      //,,,
>         hint    29 // autiasp
>         ret
> 
> It looks like pointer authentication gone wrong, which ended up
> with dereferencing the broken pointer in x22, and it explains why
> it only happens with -cpu max. Presumably this also only happens
> on secondary CPUs, so maybe the bit that initializes PAC on
> secondary CPUs got discarded?

I seems that the whole alternative instructions section is gone, so any
run-time code patching that the kernel does won't work. The kernel boots
with the diff below but I'm not convinced we don't miss anything else.
In some cases you get a linker warning about gc sections but not in this
case. Maybe we need some more asserts to ensure that certain sections
are not empty.

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 11909782ee3e..036cc59033d3 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -203,7 +203,7 @@ SECTIONS
 	. = ALIGN(4);
 	.altinstructions : {
 		__alt_instructions = .;
-		*(.altinstructions)
+		KEEP(*(.altinstructions))
 		__alt_instructions_end = .;
 	}

Do we need a KEEP(.init.altinstructions) as well? 

BTW, the build fails with CONFIG_FUNCTION_TRACER enabled:

aarch64-linux-gnu-ld: init/main.o(__patchable_function_entries): error: need linked-to section for --gc-sections

-- 
Catalin
