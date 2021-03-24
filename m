Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60423477BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCXLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:52:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCXLwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACD9F31B;
        Wed, 24 Mar 2021 04:51:59 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 440A43F718;
        Wed, 24 Mar 2021 04:51:57 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:51:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        amit.kachhap@arm.com, james.morse@arm.com,
        vincenzo.frascino@arm.com, nsaenzjulienne@suse.de,
        keescook@chromium.org, samitolvanen@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 2/2] arm64: print alloc free paths for address in
 registers
Message-ID: <20210324115113.GA19135@C02TD0UTHF1T.local>
References: <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
 <CGME20210324065516epcas5p450958011b69f5941e8f2bc993b82b904@epcas5p4.samsung.com>
 <1616568899-986-2-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616568899-986-2-git-send-email-maninder1.s@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 12:24:59PM +0530, Maninder Singh wrote:
> In case of a use after free kernel OOPs, freed path of the object is
> required to debug futher. In most of cases the object address is present
> in one of the registers.
> 
> Thus check the register's address and if it belongs to slab, print its
> alloc and free path.

This path is used for a number of failures that might have nothing to do
with a use-after-free, and from the trimmed example below it looks like
this could significantly bloat the panic and potentially cause important
information to be lost from the log, especially given the large number
of GPRs arm64 has.

Given that, I suspect this is not something we want enabled by default.

When is this logging enabled? I assume the kernel doesn't always record
the alloc/free paths. Is there a boot-time option to control this?

How many lines does this produce on average?

> commit a02a25709155 ("mm/slub: add support for free path information of an object")
> provides free path along with alloc path of object in mem_dump_obj().
> 
> Thus call it with register values same as in ARM with
> commit 14c0508adcdb ("arm: print alloc free paths for address in registers")
> 
> e.g.  in the below issue register x20 belongs to slab, and a use after free
> issue occurred on one of its dereferenced values:
> 
> [   19.516507] Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b73
> ..
> ..
> [   19.528784] Register x10 information: 0-page vmalloc region starting at 0xffff800011bb0000 allocated at paging_init+0x1d8/0x544
> [   19.529143] Register x11 information: 0-page vmalloc region starting at 0xffff800011bb0000 allocated at paging_init+0x1d8/0x544
> [   19.529513] Register x12 information: non-paged memory
> ..
> [   19.544953] Register x20 information: slab kmalloc-128 start ffff0000c3a34280 data offset 128 pointer offset 0 size 128 allocated at meminfo_proc_show+0x44/0x588
> [   19.545432]     ___slab_alloc+0x638/0x658
> [   19.545576]     __slab_alloc.isra.0+0x2c/0x58
> [   19.545728]     kmem_cache_alloc+0x584/0x598
> [   19.545877]     meminfo_proc_show+0x44/0x588
> [   19.546022]     seq_read_iter+0x258/0x460
> [   19.546160]     proc_reg_read_iter+0x90/0xd0
> [   19.546308]     generic_file_splice_read+0xd0/0x188
> [   19.546474]     do_splice_to+0x90/0xe0
> [   19.546609]     splice_direct_to_actor+0xbc/0x240
> [   19.546768]     do_splice_direct+0x8c/0xe8
> [   19.546911]     do_sendfile+0x2c4/0x500
> [   19.547048]     __arm64_sys_sendfile64+0x160/0x168
> [   19.547205]     el0_svc_common.constprop.0+0x60/0x120
> [   19.547377]     do_el0_svc_compat+0x1c/0x40
> [   19.547524]     el0_svc_compat+0x24/0x38
> [   19.547660]     el0_sync_compat_handler+0x90/0x158
> [   19.547821]  Free path:
> [   19.547906]     __slab_free+0x3dc/0x538
> [   19.548051]     kfree+0x2d8/0x310
> [   19.548176]     meminfo_proc_show+0x60/0x588
> [   19.548322]     seq_read_iter+0x258/0x460
> [   19.548459]     proc_reg_read_iter+0x90/0xd0
> [   19.548602]     generic_file_splice_read+0xd0/0x188
> [   19.548761]     do_splice_to+0x90/0xe0
> [   19.548889]     splice_direct_to_actor+0xbc/0x240
> [   19.549040]     do_splice_direct+0x8c/0xe8
> [   19.549183]     do_sendfile+0x2c4/0x500
> [   19.549319]     __arm64_sys_sendfile64+0x160/0x168
> [   19.549477]     el0_svc_common.constprop.0+0x60/0x120
> [   19.549646]     do_el0_svc_compat+0x1c/0x40
> [   19.549782]     el0_svc_compat+0x24/0x38
> [   19.549913]     el0_sync_compat_handler+0x90/0x158
> [   19.550067]     el0_sync_compat+0x174/0x180
> ..
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/arm64/include/asm/system_misc.h |  1 +
>  arch/arm64/kernel/process.c          | 11 +++++++++++
>  arch/arm64/kernel/traps.c            |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index 673be2d1263c..84d5204cdb80 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -31,6 +31,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
>  
>  struct mm_struct;
>  extern void __show_regs(struct pt_regs *);
> +extern void __show_regs_alloc_free(struct pt_regs *regs);
>  
>  extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6e60aa3b5ea9..d0d0ada332c3 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -306,6 +306,17 @@ void __show_regs(struct pt_regs *regs)
>  	}
>  }
>  
> +void __show_regs_alloc_free(struct pt_regs *regs)
> +{
> +	int i;
> +
> +	/* check for x0 - x29 only */

Why x29? The AAPCS says that's the frame pointer, so much like the SP it
shouldn't point to a heap object.

> +	for (i = 0; i <= 29; i++) {
> +		pr_alert("Register x%d information:", i);
> +		mem_dump_obj((void *)regs->regs[i]);
> +	}
> +}

The pr_alert() is unconditional -- can mem_dumpo_obj() never be
disabled?

What loglevel does mem_dump_obj() use? Generally we try to keep that
matched, so I'm surprised it isn't taken as a parameter.

> +
>  void show_regs(struct pt_regs *regs)
>  {
>  	__show_regs(regs);
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index a05d34f0e82a..cb4858c6e57b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -104,6 +104,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>  
>  	print_modules();
>  	show_regs(regs);
> +	__show_regs_alloc_free(regs);

As above, I'm not sure this is the right place to put this. We can get
here for reasons other than UAF, and I'm sure we can trigger panics via
UAF without going via this.

THanks,
Mark.
