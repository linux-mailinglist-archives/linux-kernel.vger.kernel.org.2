Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C277B437739
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhJVMlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhJVMlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:41:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5855C610FF;
        Fri, 22 Oct 2021 12:38:47 +0000 (UTC)
Date:   Fri, 22 Oct 2021 08:38:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
Message-ID: <20211022083845.08fe5754@gandalf.local.home>
In-Reply-To: <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
        <20211012145540.343541e9@gandalf.local.home>
        <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 12:15:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -706,12 +706,16 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>  
>  	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
>  	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> -	    (mtrr != MTRR_TYPE_WRBACK))
> +	    (mtrr != MTRR_TYPE_WRBACK)) {
> +		pr_debug("mtrr_type_lookup() returned %d (%d)\n", mtrr, uniform);
>  		return 0;
> +	}
>  
>  	/* Bail out if we are we on a populated non-leaf entry: */
> -	if (pud_present(*pud) && !pud_huge(*pud))
> +	if (pud_present(*pud) && !pud_huge(*pud)) {
> +		pr_debug("pud is already present (%lx)\n", (unsigned long)pud_val(*pud));
>  		return 0;
> +	}
>  

It finally triggered again. And this time with this patch applied. But I
don't see the added printks anywhere in the dmesg.

Full dmesg is here:

  https://rostedt.org/private/dmesg-debug_vm_pgtable-20211022

Unfortunately I lost the config, but can recreated it when my tests finish.
(I kicked it off again so that I can post these patches to linux-next)
But I did share a config that triggered this in the past:

  https://lore.kernel.org/all/20211012141131.3c9a2eb1@gandalf.local.home/

The tree I'm testing is:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  branch: ftrace/core

But this is something that has been triggering since 5.14.

Now there's a lot of debugging that is happening.

Here's the first splat:

[  178.714431] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[  178.723726] ------------[ cut here ]------------
[  178.728389] WARNING: CPU: 2 PID: 1 at mm/debug_vm_pgtable.c:492 pud_huge_tests+0x42/0x68
[  178.736494] Modules linked in:
[  178.739565] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3-test+ #79
[  178.746452] Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
[  178.754112] RIP: 0010:pud_huge_tests+0x42/0x68
[  178.758567] Code: 48 8b 47 20 48 89 fb 48 c7 00 00 00 00 00 48 8b b7 a0 00 00 00 48 8b 57 60 48 8b 7f 20 48 c1 e6 0c e8 ca 2b d5 fd 85 c0 75 02 <0f> 0b 48 8b 7b 20 e8 92 2d d5 fd 85 c0 75 02 0f 0b 48 8b 43 20 48
[  178.777323] RSP: 0000:ffffaadf40033d70 EFLAGS: 00010246
[  178.782566] RAX: 0000000000000000 RBX: ffffaadf40033d88 RCX: 6fd4a5ea5b1e4400
[  178.789706] RDX: 00ffffff8411f9a3 RSI: ffffaadf40033cf8 RDI: ffffaadf40033cf9
[  178.796846] RBP: ffffaadf40033d78 R08: 00000000dc000000 R09: 0000000000040000
[  178.803992] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[  178.811129] R13: ffff947400a48938 R14: ffff9474009afde8 R15: 0000000000000000
[  178.818273] FS:  0000000000000000(0000) GS:ffff947516800000(0000) knlGS:0000000000000000
[  178.826367] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  178.832121] CR2: 0000000000000000 CR3: 00000000cae2a002 CR4: 00000000001706e0
[  178.839261] Call Trace:
[  178.841725]  debug_vm_pgtable+0x3a2/0x50b
[  178.845765]  ? pgd_clear_tests+0x61/0x61
[  178.849700]  do_one_initcall+0xe8/0x25c
[  178.853556]  ? lock_is_held+0xc/0xe
[  178.857055]  ? rcu_read_lock_sched_held+0x3b/0x72
[  178.861775]  do_initcalls+0xcd/0xed
[  178.865282]  kernel_init_freeable+0x183/0x1ba
[  178.869653]  ? rest_init+0x155/0x155
[  178.873248]  kernel_init+0x1a/0x11a
[  178.876754]  ret_from_fork+0x22/0x30
[  178.880360] irq event stamp: 29103539
[  178.884035] hardirqs last  enabled at (29103549): [<ffffffff8412e491>] __up_console_sem+0x4b/0x4f
[  178.892910] hardirqs last disabled at (29103558): [<ffffffff8412e471>] __up_console_sem+0x2b/0x4f
[  178.901782] softirqs last  enabled at (29103506): [<ffffffff85400328>] __do_softirq+0x328/0x363
[  178.910485] softirqs last disabled at (29103501): [<ffffffff840d211e>] __irq_exit_rcu+0x60/0x9c
[  178.919187] ---[ end trace 328fd4bcdb7a033d ]---

It did trigger right after the kprobe test. Could be a hint. As it does seem
to only happen on configs with a lot of debugging enabled. But it doesn't
always happen there. I remember it happening usually around testing the
tracers.

Maybe it's a race between the initcall debug_vm_pgtable happens while some
internal tests are going on?

The tests do trigger "text_poke" which will muck with the page tables. Not
sure if that has anything to do with this.

I need to update my tests to just save off all failures and configs, so I
can go back to them. Just that my tests fail so often I'd fill up my hard
drive ;-)

-- Steve
