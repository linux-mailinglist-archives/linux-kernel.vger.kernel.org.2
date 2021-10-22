Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901C54379A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhJVPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:12:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233350AbhJVPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FE21FB;
        Fri, 22 Oct 2021 08:10:15 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5C83F694;
        Fri, 22 Oct 2021 08:10:10 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:10:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 00/15] irq: remove handle_domain_{irq,nmi}()
Message-ID: <20211022151007.GD86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <87k0i5b91c.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0i5b91c.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:20:31PM +0100, Marc Zyngier wrote:
> Hi Mark,
> 
> On Thu, 21 Oct 2021 19:02:21 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > The handle_domain_{irq,nmi}() functions were oringally intended as a
> > convenience, but recent rework to entry code across the kernel tree has
> > demonstrated that they cause more pain than they're worth and prevent
> > architectures from being able to write robust entry code.
> > 
> > This series reworks the irq code to remove them, handling the necessary
> > entry work consistently in entry code (be it architectural or generic).
> 
> [...]
> 
> Thanks for going through the pain of putting this together. The
> couple of nits I mentioned notwithstanding:
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>

Thanks!

I've pushed out an updated version to my irq/handle-domain-irq branch
on kernel.org:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

That has two new patches you suggested:

* irq: mips: simplify bcm6345_l1_irq_handle()
* irq: unexport handle_irq_desc()

... which I did not add your Reviewed-by to in case the commit messages
are garbage or something like that.

> It'd be good to work out a merging strategy once this has seen a bit
> of testing.

Conflict-wise, this merges near perfectly against next-20212022 aside
from a trivial conflict against arch/riscv/Kconfig:

| [mark@lakrids:~/src/linux]% git merge irq/handle-domain-irq
| Auto-merging arch/riscv/kernel/entry.S
| Auto-merging arch/riscv/Kconfig
| CONFLICT (content): Merge conflict in arch/riscv/Kconfig
| Auto-merging arch/nds32/Kconfig
| Auto-merging arch/mips/Kconfig
| Auto-merging arch/csky/Kconfig
| Auto-merging arch/arm64/Kconfig
| Auto-merging arch/arm/mach-s3c/irq-s3c24xx.c
| Auto-merging arch/arm/kernel/entry-armv.S
| Auto-merging arch/arm/Kconfig
| Auto-merging arch/arc/Kconfig
| Automatic merge failed; fix conflicts and then commit the result.
| [mark@lakrids:~/src/linux]% git diff
| diff --cc arch/riscv/Kconfig
| index 77a088d0a7e9,353e28f5f849..000000000000
| --- a/arch/riscv/Kconfig
| +++ b/arch/riscv/Kconfig
| @@@ -62,8 -62,6 +62,11 @@@ config RISC
|         select GENERIC_SCHED_CLOCK
|         select GENERIC_SMP_IDLE_THREAD
|         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
| ++<<<<<<< HEAD
|  +      select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
|  +      select HANDLE_DOMAIN_IRQ
| ++=======
| ++>>>>>>> irq/handle-domain-irq
|         select HAVE_ARCH_AUDITSYSCALL
|         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
|         select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL

... where the resolution is:

| diff --cc arch/riscv/Kconfig
| index 77a088d0a7e9,353e28f5f849..000000000000
| --- a/arch/riscv/Kconfig
| +++ b/arch/riscv/Kconfig
| @@@ -62,8 -62,6 +62,7 @@@ config RISC
|         select GENERIC_SCHED_CLOCK
|         select GENERIC_SMP_IDLE_THREAD
|         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
|  +      select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
| -       select HANDLE_DOMAIN_IRQ
|         select HAVE_ARCH_AUDITSYSCALL
|         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
|         select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL

... so I reckon we're not set for major pain there unless something new
appears in arch code in the next few days.

If we can get this onto a branch for linux-next ASAP, and if Linus is
happy with this having come together a little late, maybe we could queue
this in tip for v5.16, perhaps after -rc1 to let this soak, or waiting
to apply the final patch to make it easier to revert the arch changes if
needed?

I'd like to avoid sitting on this for an entire cycle if possible.

Thanks,
Mark.
