Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35F4560EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhKRQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233699AbhKRQut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:50:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E132261266;
        Thu, 18 Nov 2021 16:47:47 +0000 (UTC)
Date:   Thu, 18 Nov 2021 11:47:46 -0500
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
Message-ID: <20211118114746.3329bd33@gandalf.local.home>
In-Reply-To: <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
        <20211012145540.343541e9@gandalf.local.home>
        <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
        <20211022083845.08fe5754@gandalf.local.home>
        <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 09:34:15 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 22, 2021 at 2:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > It finally triggered again. And this time with this patch applied. But I
> > don't see the added printks anywhere in the dmesg.  
> 
> That's strange. Those printk's were added in the only places that do a
> "return 0".
> 
> Ok, there's also the dummy pud_set_huge() inline function that
> unconditionally returns zero, but that's only if you don't have
> CONFIG_HAVE_ARCH_HUGE_VMAP enabled. And then the testing code is
> disabled too.
> 
> > [  178.714431] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> > [  178.723726] ------------[ cut here ]------------
> > [  178.728389] WARNING: CPU: 2 PID: 1 at mm/debug_vm_pgtable.c:492 pud_huge_tests+0x42/0x68  
> 
> That's literally that
> 
>     WARN_ON(!pud_set_huge(..));
> 
> and pud_set_huge() has two 'return 0' (and one 'return 1') and that
> patch added debug-printing to both of them.
> 
> Oh, it shouldn't have been a pr_debug() that gets suppressed. It
> should have been a pr_warn() or something.

Triggered it again with the new update:

[   24.751779] IPI shorthand broadcast: enabled
[   24.761177] sched_clock: Marking stable (23431856262, 1329270511)->(28163092341, -3401965568)
[   24.770495] device: 'cpu_dma_latency': device_add
[   24.775232] PM: Adding info for No Bus:cpu_dma_latency
[   24.780929] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[   24.799490] mtrr_type_lookup() returned 0 (0)
[   24.803892] ------------[ cut here ]------------
[   24.808517] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:492 debug_vm_pgtable+0x1315/0x1696
[   24.817131] Modules linked in:
[   24.820193] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1-test+ #17
[   24.827069] Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
[   24.834724] RIP: 0010:debug_vm_pgtable+0x1315/0x1696
[   24.839692] Code: 38 ff ff ff 48 c7 00 00 00 00 00 48 8b 75 b8 48 8b 95 78 ff ff ff 48 8b bd 38 ff ff ff 48 c1 e6 0c e8 d3 f4 61 fe 85 c0 75 02 <0f> 0b 48 8b bd 38 ff ff ff e8 61 f7 61 fe 85 c0 75 02 0f 0b 48 8b
[   24.858438] RSP: 0000:ffffb59e80033da8 EFLAGS: 00010246
[   24.863677] RAX: 0000000000000000 RBX: bffffffffffffff7 RCX: 00000000ffffefff
[   24.870815] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000001
[   24.877947] RBP: ffffb59e80033e98 R08: ffffffff9b6d3b68 R09: 0000000000004ffb
[   24.885078] R10: 00000000fffff000 R11: 3fffffffffffffff R12: ffff9abe83684078
[   24.892211] R13: 000038b500000000 R14: 000fffffffe00000 R15: 0000000000000027
[   24.899346] FS:  0000000000000000(0000) GS:ffff9abf9dc00000(0000) knlGS:0000000000000000
[   24.907430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.913175] CR2: ffff9abf97a01000 CR3: 0000000216612001 CR4: 00000000001706f0
[   24.920309] Call Trace:
[   24.922763]  <TASK>
[   24.924880]  ? destroy_args+0x281/0x281
[   24.928727]  do_one_initcall+0x68/0x310
[   24.932574]  ? rcu_read_lock_sched_held+0x46/0x80
[   24.937290]  kernel_init_freeable+0x1a5/0x1f4
[   24.941654]  ? rest_init+0x270/0x270
[   24.945236]  kernel_init+0x1a/0x120
[   24.948736]  ret_from_fork+0x22/0x30
[   24.952323]  </TASK>
[   24.954517] irq event stamp: 902445
[   24.958008] hardirqs last  enabled at (902455): [<ffffffff9a10c33f>] __up_console_sem+0x6f/0x80
[   24.966700] hardirqs last disabled at (902464): [<ffffffff9a10c324>] __up_console_sem+0x54/0x80
[   24.975395] softirqs last  enabled at (902372): [<ffffffff9ae00276>] __do_softirq+0x276/0x43d
[   24.983912] softirqs last disabled at (902367): [<ffffffff9a098dd2>] irq_exit_rcu+0xa2/0xd0
[   24.992262] ---[ end trace 385def99126fe75e ]---
[   24.996891] ------------[ cut here ]------------

Full dmesg is here:  https://rostedt.org/private/dmesg-20211118.txt
config is here: https://rostedt.org/private/config-20211118

-- Steve

