Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDD42ACAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhJLS5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhJLS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:57:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D9960F23;
        Tue, 12 Oct 2021 18:55:43 +0000 (UTC)
Date:   Tue, 12 Oct 2021 14:55:40 -0400
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
Message-ID: <20211012145540.343541e9@gandalf.local.home>
In-Reply-To: <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
References: <20211012141131.3c9a2eb1@gandalf.local.home>
        <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 11:34:19 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That warning seems to be due to pud_set_huge() failing (the "line 438"
> one I don't know what it is - there's no warning on that line in my
> tree, so I worry a bit that Steven has other things in his tree).

I saved off that warning from a different branch, and looking at the dmesg,
it is:

  Linux version 5.14.0-rc2-test+

Which shows this happened on 5.14 as well (and explains why the line
numbers are different).

Here's the full splat:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1 at mm/debug_vm_pgtable.c:438 pud_huge_tests+0x2f/0x50
 Modules linked in:
 CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc2-test+ #16
 Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
 RIP: 0010:pud_huge_tests+0x2f/0x50
 Code: 48 8b 05 c4 93 da ff 48 0f ba e0 3a 73 3c 55 48 c1 e6 0c 48 89 e5 53 48 89 fb 48 c7 07 00 00 00 00 e8 47 3d f5 fd 85 c0 75 02 <0f> 0b 48 89 df e8 0c 3e f5 fd 85 c0 75 02 0f 0b 48 8b 03 48 a9 9f
 RSP: 0000:ffffb728c0033dd0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff8d5648f44570 RCX: 6421c8b694c43a00
 RDX: 00ffffffaf11c9ec RSI: ffffb728c0033d58 RDI: ffffb728c0033d59
 RBP: ffffb728c0033dd8 R08: 000000021f000000 R09: 0000000000040000
 R10: 0000000000000001 R11: 0000000000000000 R12: ffff8d5648f44570
 R13: ffff8d5640a808c0 R14: 000000000020713a R15: ffff8d5640a80938
 FS:  0000000000000000(0000) GS:ffff8d5756800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000206c2a001 CR4: 00000000001706e0
 Call Trace:
  debug_vm_pgtable+0x533/0x6f0
  ? pgd_clear_tests.isra.0+0x50/0x50
  do_one_initcall+0xe8/0x25c
  ? lock_is_held+0xc/0xe
  ? rcu_read_lock_sched_held+0x3b/0x72
  do_initcalls+0xcd/0xed
  kernel_init_freeable+0x18a/0x1c1
  ? rest_init+0x155/0x155
  kernel_init+0x1a/0x11a
  ret_from_fork+0x22/0x30
 irq event stamp: 28613811
 hardirqs last  enabled at (28613821): [<ffffffffaf12caf1>] console_unlock+0x323/0x36e
 hardirqs last disabled at (28613830): [<ffffffffaf12ca36>] console_unlock+0x268/0x36e
 softirqs last  enabled at (28613546): [<ffffffffb0200328>] __do_softirq+0x328/0x363
 softirqs last disabled at (28613475): [<ffffffffaf0cfea2>] __irq_exit_rcu+0x5f/0x9b
 ---[ end trace 216b0cab27d4c431 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1 at mm/debug_vm_pgtable.c:439 pud_huge_tests+0x3d/0x50
 Modules linked in:
 CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         5.14.0-rc2-test+ #16
 Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
 RIP: 0010:pud_huge_tests+0x3d/0x50
 Code: 55 48 c1 e6 0c 48 89 e5 53 48 89 fb 48 c7 07 00 00 00 00 e8 47 3d f5 fd 85 c0 75 02 0f 0b 48 89 df e8 0c 3e f5 fd 85 c0 75 02 <0f> 0b 48 8b 03 48 a9 9f ff ff ff 74 02 0f 0b 5b 5d c3 c3 0f 1f 44
 RSP: 0000:ffffb728c0033dd0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff8d5648f44570 RCX: 6421c8b694c43a00
 RDX: 0000000000000000 RSI: ffffb728c0033d58 RDI: ffff8d5648f44570
 RBP: ffffb728c0033dd8 R08: 000000021f000000 R09: 0000000000040000
 R10: 0000000000000001 R11: 0000000000000000 R12: ffff8d5648f44570
 R13: ffff8d5640a808c0 R14: 000000000020713a R15: ffff8d5640a80938
 FS:  0000000000000000(0000) GS:ffff8d5756800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000206c2a001 CR4: 00000000001706e0
 Call Trace:
  debug_vm_pgtable+0x533/0x6f0
  ? pgd_clear_tests.isra.0+0x50/0x50
  do_one_initcall+0xe8/0x25c
  ? lock_is_held+0xc/0xe
  ? rcu_read_lock_sched_held+0x3b/0x72
  do_initcalls+0xcd/0xed
  kernel_init_freeable+0x18a/0x1c1
  ? rest_init+0x155/0x155
  kernel_init+0x1a/0x11a
  ret_from_fork+0x22/0x30
 irq event stamp: 28614155
 hardirqs last  enabled at (28614165): [<ffffffffaf12caf1>] console_unlock+0x323/0x36e
 hardirqs last disabled at (28614174): [<ffffffffaf12ca36>] console_unlock+0x268/0x36e
 softirqs last  enabled at (28613546): [<ffffffffb0200328>] __do_softirq+0x328/0x363
 softirqs last disabled at (28613475): [<ffffffffaf0cfea2>] __irq_exit_rcu+0x5f/0x9b
 ---[ end trace 216b0cab27d4c432 ]---


May be just the same bug at a different line number for 5.14-rc2?

-- Steve
