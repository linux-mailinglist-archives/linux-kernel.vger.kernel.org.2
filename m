Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293443A5F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhFNJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:51:09 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:38436 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232579AbhFNJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:51:07 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 70D56BAB01
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:49:04 +0100 (IST)
Received: (qmail 20755 invoked from network); 14 Jun 2021 09:49:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jun 2021 09:49:04 -0000
Date:   Mon, 14 Jun 2021 10:49:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210614094902.GF30378@techsingularity.net>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:38:29PM +0200, Vlastimil Babka wrote:
> Changes since RFC v1 [1]:
> * Addressed feedback from Christoph and Mel, added their acks.
> * Finished RT conversion, including adopting 2 patches from the RT tree.
> * The optional local_lock conversion has to sacrifice lockless fathpaths on RT
> * Added some more cleanup patches to the front.
> 
> This series was initially inspired by Mel's pcplist local_lock rewrite, and
> also by interest to better understand SLUB's locking and the new locking
> primitives and their RT variants and implications. It should make SLUB more
> preemption-friendly and fully RT compatible, hopefully without noticeable
> regressions on !RT kernels, as the fast paths are not affected there.
> 
> Series is based on 5.13-rc5 and also available as a git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r1
> 

This failed to boot for me inside KVM.

[    0.273576] SRBDS: Unknown: Dependent on hypervisor status
[    0.273576] MDS: Mitigation: Clear CPU buffers
[    0.273576] Freeing SMP alternatives memory: 36K
[    0.273576] bad: scheduling from the idle thread!
[    0.273576] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc5-unspecified+ #1
[    0.273576] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.273576] Call Trace:
[    0.273576]  dump_stack+0x76/0x94
[    0.273576]  dequeue_task_idle+0x28/0x40
[    0.273576]  __do_set_cpus_allowed+0xe0/0x1a0
[    0.273576]  __schedule+0x7f7/0x8f0
[    0.273576]  __cond_resched+0x22/0x40
[    0.273576]  alloc_vmap_area+0x72/0x8b0
[    0.273576]  ? kmem_cache_alloc_node_trace+0x189/0x300
[    0.273576]  ? __get_vm_area_node+0x76/0x150
[    0.273576]  __get_vm_area_node+0xab/0x150
[    0.273576]  __vmalloc_node_range+0x6d/0x2c0
[    0.273576]  ? kernel_clone+0x9b/0x3e0
[    0.273576]  ? kmem_cache_alloc_node+0x18d/0x2f0
[    0.273576]  ? copy_process+0x218/0x1c40
[    0.273576]  copy_process+0x2c1/0x1c40
[    0.273576]  ? kernel_clone+0x9b/0x3e0
[    0.273576]  ? enqueue_task_fair+0xa1/0x590
[    0.273576]  kernel_clone+0x9b/0x3e0
[    0.273576]  ? acpi_hw_register_read+0x146/0x166
[    0.273576]  kernel_thread+0x55/0x70
[    0.273576]  ? kthread_is_per_cpu+0x30/0x30
[    0.273576]  rest_init+0x75/0xc0
[    0.273576]  start_kernel+0x7fb/0x822
[    0.273576]  secondary_startup_64_no_verify+0xc2/0xcb
[    0.273576] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    0.273576] #PF: supervisor instruction fetch in kernel mode
[    0.273576] #PF: error_code(0x0010) - not-present page
[    0.273576] PGD 0 P4D 0
[    0.273576] Oops: 0010 [#1] SMP PTI
[    0.273576] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc5-unspecified+ #1
[    0.273576] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.273576] RIP: 0010:0x0
[    0.273576] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[    0.273576] RSP: 0000:ffffffffbb803bb0 EFLAGS: 00010002
[    0.273576] RAX: 0000000000000000 RBX: ffff9fa64ea2ecc0 RCX: ffffffffb9e00101
[    0.273576] RDX: 000000000000000a RSI: ffffffffbb81a940 RDI: ffff9fa64ea2ecc0
[    0.273576] RBP: ffffffffbb803c08 R08: 0000000000000000 R09: ffffffffbbaa699c
[    0.273576] R10: 0000000000000000 R11: ffffffffbb803888 R12: ffffffffbb81a940
[    0.273576] R13: ffff9f9a80245f40 R14: ffffffffbb1f0060 R15: 0000000000003fff
[    0.273576] FS:  0000000000000000(0000) GS:ffff9fa64ea00000(0000) knlGS:0000000000000000
[    0.273576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.273576] CR2: ffffffffffffffd6 CR3: 0000000a60e10001 CR4: 0000000000170ef0
[    0.273576] Call Trace:
[    0.273576]  __schedule+0x7f7/0x8f0
[    0.273576]  __cond_resched+0x22/0x40
[    0.273576]  alloc_vmap_area+0x72/0x8b0
[    0.273576]  ? kmem_cache_alloc_node_trace+0x189/0x300
[    0.273576]  ? __get_vm_area_node+0x76/0x150
[    0.273576]  __get_vm_area_node+0xab/0x150
[    0.273576]  __vmalloc_node_range+0x6d/0x2c0
[    0.273576]  ? kernel_clone+0x9b/0x3e0
[    0.273576]  ? kmem_cache_alloc_node+0x18d/0x2f0
[    0.273576]  ? copy_process+0x218/0x1c40
[    0.273576]  copy_process+0x2c1/0x1c40
[    0.273576]  ? kernel_clone+0x9b/0x3e0
[    0.273576]  ? enqueue_task_fair+0xa1/0x590
[    0.273576]  kernel_clone+0x9b/0x3e0
[    0.273576]  ? acpi_hw_register_read+0x146/0x166
[    0.273576]  kernel_thread+0x55/0x70
[    0.273576]  ? kthread_is_per_cpu+0x30/0x30
[    0.273576]  rest_init+0x75/0xc0
[    0.273576]  start_kernel+0x7fb/0x822
[    0.273576]  secondary_startup_64_no_verify+0xc2/0xcb
[    0.273576] Modules linked in:
[    0.273576] CR2: 0000000000000000
[    0.273576] ---[ end trace 7199d6fbb50b4cf7 ]---
[    0.273576] RIP: 0010:0x0
[    0.273576] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[    0.273576] RSP: 0000:ffffffffbb803bb0 EFLAGS: 00010002
[    0.273576] RAX: 0000000000000000 RBX: ffff9fa64ea2ecc0 RCX: ffffffffb9e00101
[    0.273576] RDX: 000000000000000a RSI: ffffffffbb81a940 RDI: ffff9fa64ea2ecc0
[    0.273576] RBP: ffffffffbb803c08 R08: 0000000000000000 R09: ffffffffbbaa699c
[    0.273576] R10: 0000000000000000 R11: ffffffffbb803888 R12: ffffffffbb81a940
[    0.273576] R13: ffff9f9a80245f40 R14: ffffffffbb1f0060 R15: 0000000000003fff
[    0.273576] FS:  0000000000000000(0000) GS:ffff9fa64ea00000(0000) knlGS:0000000000000000
[    0.273576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.273576] CR2: ffffffffffffffd6 CR3: 0000000a60e10001 CR4: 0000000000170ef0
[    0.273576] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.273576] Rebooting in 90 seconds..
