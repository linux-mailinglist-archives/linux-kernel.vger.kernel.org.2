Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEB381B27
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhEOVKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:10:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:40842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhEOVKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2433AD09;
        Sat, 15 May 2021 21:09:31 +0000 (UTC)
Subject: Re: [BUG] Shudown-time lockdep splat in next-20210514
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, ming.lei@redhat.com, riel@fb.com,
        jweiner@fb.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, glittao@gmail.com
References: <20210515204622.GA2672367@paulmck-ThinkPad-P17-Gen-1>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a9e5c5c4-08db-47bf-cb0a-2a90bd747c77@suse.cz>
Date:   Sat, 15 May 2021 23:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210515204622.GA2672367@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/21 10:46 PM, Paul E. McKenney wrote:
> Hello!
> 
> I am seeing the following lockdep splat in next-20210514.  It happens
> at shutdown time in all rcutorture scenarios that enable lockdep.  It
> happens consistently on 2-hour runs, and I am trying it on shorter runs.
> If it reproduces nicely, I will try bisection.
> 
> In the meantime, does this ring a bell for anyone?

Hm, I think it will be
ad36bafb3bcdf mm/slub: use stackdepot to save stack trace in objects

can you try this please?

diff --git a/mm/slub.c b/mm/slub.c
index 6b896b8c36f0..04824dae2e32 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -623,7 +623,7 @@ static void set_track(struct kmem_cache *s, void *object,
 
 	if (addr) {
 #ifdef CONFIG_STACKDEPOT
-		p->handle = save_stack_depot_trace(GFP_KERNEL);
+		p->handle = save_stack_depot_trace(GFP_NOWAIT);
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
 
> 							Thanx, Paul
> 
> 
> =====================================================
> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 5.13.0-rc1-next-20210514 #1587 Not tainted
> -----------------------------------------------------
> torture_shutdow/112 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> ffffffffaad7ac20 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire+0x7f/0xd0
> 
> and this task is already holding:
> ffffa37a02ab4098 (&n->list_lock){-.-.}-{2:2}, at: free_debug_processing+0x3a/0x230
> which would create a new lock dependency:
>  (&n->list_lock){-.-.}-{2:2} -> (fs_reclaim){+.+.}-{0:0}
> 
> but this new dependency connects a HARDIRQ-irq-safe lock:
>  (&n->list_lock){-.-.}-{2:2}
> 
> ... which became HARDIRQ-irq-safe at:
>   lock_acquire+0xb5/0x3a0
>   _raw_spin_lock+0x27/0x40
>   deactivate_slab.isra.90+0x3c2/0x5d0
>   flush_cpu_slab+0x31/0x50
>   flush_smp_call_function_queue+0x132/0x1d0
>   __sysvec_call_function_single+0x3e/0x190
>   sysvec_call_function_single+0x61/0x80
>   asm_sysvec_call_function_single+0x12/0x20
>   default_idle+0xb/0x10
>   default_idle_call+0x66/0x1e0
>   do_idle+0x204/0x2a0
>   cpu_startup_entry+0x14/0x20
>   secondary_startup_64_no_verify+0xc2/0xcb
> 
> to a HARDIRQ-irq-unsafe lock:
>  (fs_reclaim){+.+.}-{0:0}
> 
> ... which became HARDIRQ-irq-unsafe at:
> ...
>   lock_acquire+0xb5/0x3a0
>   fs_reclaim_acquire+0x9f/0xd0
>   kmem_cache_alloc_node_trace+0x2f/0x230
>   alloc_worker+0x18/0x50
>   init_rescuer.part.33+0xf/0x90
>   workqueue_init+0x1fb/0x2db
>   kernel_init_freeable+0x10c/0x26f
>   kernel_init+0x5/0xfe
>   ret_from_fork+0x22/0x30
> 
> other info that might help us debug this:
> 
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                local_irq_disable();
>                                lock(&n->list_lock);
>                                lock(fs_reclaim);
>   <Interrupt>
>     lock(&n->list_lock);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by torture_shutdow/112:
>  #0: ffffa37a02ab4098 (&n->list_lock){-.-.}-{2:2}, at: free_debug_processing+0x3a/0x230
> 
> the dependencies between HARDIRQ-irq-safe lock and the holding lock:
> -> (&n->list_lock){-.-.}-{2:2} {
>    IN-HARDIRQ-W at:
>                     lock_acquire+0xb5/0x3a0
>                     _raw_spin_lock+0x27/0x40
>                     deactivate_slab.isra.90+0x3c2/0x5d0
>                     flush_cpu_slab+0x31/0x50
>                     flush_smp_call_function_queue+0x132/0x1d0
>                     __sysvec_call_function_single+0x3e/0x190
>                     sysvec_call_function_single+0x61/0x80
>                     asm_sysvec_call_function_single+0x12/0x20
>                     default_idle+0xb/0x10
>                     default_idle_call+0x66/0x1e0
>                     do_idle+0x204/0x2a0
>                     cpu_startup_entry+0x14/0x20
>                     secondary_startup_64_no_verify+0xc2/0xcb
>    IN-SOFTIRQ-W at:
>                     lock_acquire+0xb5/0x3a0
>                     _raw_spin_lock_irqsave+0x30/0x50
>                     __slab_free+0xc8/0x4a0
>                     kmem_cache_free+0x2a8/0x310
>                     rcu_do_batch+0x18e/0x4d0
>                     rcu_core+0x2c7/0x470
>                     __do_softirq+0xca/0x409
>                     irq_exit_rcu+0xa9/0xb0
>                     sysvec_apic_timer_interrupt+0x66/0x80
>                     asm_sysvec_apic_timer_interrupt+0x12/0x20
>                     default_idle+0xb/0x10
>                     default_idle_call+0x66/0x1e0
>                     do_idle+0x204/0x2a0
>                     cpu_startup_entry+0x14/0x20
>                     start_kernel+0x6ab/0x6d2
>                     secondary_startup_64_no_verify+0xc2/0xcb
>    INITIAL USE at:
>                    lock_acquire+0xb5/0x3a0
>                    _raw_spin_lock+0x27/0x40
>                    get_partial_node.isra.92.part.93+0x47/0x300
>                    ___slab_alloc+0x2a1/0x6e0
>                    kmem_cache_alloc_node+0x1bc/0x230
>                    __kmem_cache_create+0x1b3/0x430
>                    create_boot_cache+0x70/0x93
>                    kmem_cache_init+0xd9/0x15f
>                    start_kernel+0x3e6/0x6d2
>                    secondary_startup_64_no_verify+0xc2/0xcb
>  }
>  ... key      at: [<ffffffffabfa6370>] __key.50785+0x0/0x10
>  ... acquired at:
>    lock_acquire+0xb5/0x3a0
>    fs_reclaim_acquire+0x9f/0xd0
>    __alloc_pages+0xed/0x330
>    stack_depot_save+0x3a1/0x470
>    save_stack_depot_trace.constprop.100+0x3b/0x60
>    set_track+0x27/0x80
>    free_debug_processing+0x169/0x230
>    __slab_free+0x262/0x4a0
>    kmem_cache_free+0x2a8/0x310
>    rcu_torture_cleanup.cold.34+0x186/0x41d
>    torture_shutdown+0x101/0x1f0
>    kthread+0x122/0x140
>    ret_from_fork+0x22/0x30
> 
> 
> the dependencies between the lock to be acquired
>  and HARDIRQ-irq-unsafe lock:
> -> (fs_reclaim){+.+.}-{0:0} {
>    HARDIRQ-ON-W at:
>                     lock_acquire+0xb5/0x3a0
>                     fs_reclaim_acquire+0x9f/0xd0
>                     kmem_cache_alloc_node_trace+0x2f/0x230
>                     alloc_worker+0x18/0x50
>                     init_rescuer.part.33+0xf/0x90
>                     workqueue_init+0x1fb/0x2db
>                     kernel_init_freeable+0x10c/0x26f
>                     kernel_init+0x5/0xfe
>                     ret_from_fork+0x22/0x30
>    SOFTIRQ-ON-W at:
>                     lock_acquire+0xb5/0x3a0
>                     fs_reclaim_acquire+0x9f/0xd0
>                     kmem_cache_alloc_node_trace+0x2f/0x230
>                     alloc_worker+0x18/0x50
>                     init_rescuer.part.33+0xf/0x90
>                     workqueue_init+0x1fb/0x2db
>                     kernel_init_freeable+0x10c/0x26f
>                     kernel_init+0x5/0xfe
>                     ret_from_fork+0x22/0x30
>    INITIAL USE at:
>                    lock_acquire+0xb5/0x3a0
>                    fs_reclaim_acquire+0x9f/0xd0
>                    kmem_cache_alloc_node_trace+0x2f/0x230
>                    alloc_worker+0x18/0x50
>                    init_rescuer.part.33+0xf/0x90
>                    workqueue_init+0x1fb/0x2db
>                    kernel_init_freeable+0x10c/0x26f
>                    kernel_init+0x5/0xfe
>                    ret_from_fork+0x22/0x30
>  }
>  ... key      at: [<ffffffffaad7ac20>] __fs_reclaim_map+0x0/0x28
>  ... acquired at:
>    lock_acquire+0xb5/0x3a0
>    fs_reclaim_acquire+0x9f/0xd0
>    __alloc_pages+0xed/0x330
>    stack_depot_save+0x3a1/0x470
>    save_stack_depot_trace.constprop.100+0x3b/0x60
>    set_track+0x27/0x80
>    free_debug_processing+0x169/0x230
>    __slab_free+0x262/0x4a0
>    kmem_cache_free+0x2a8/0x310
>    rcu_torture_cleanup.cold.34+0x186/0x41d
>    torture_shutdown+0x101/0x1f0
>    kthread+0x122/0x140
>    ret_from_fork+0x22/0x30
> 
> 
> stack backtrace:
> CPU: 0 PID: 112 Comm: torture_shutdow Not tainted 5.13.0-rc1-next-20210514 #1587
> Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8.4.0+547+a85d02ba 04/01/2014
> Call Trace:
>  dump_stack_lvl+0x6a/0x88
>  check_irq_usage.cold.80+0x2cd/0x2d2
>  ? trace_event_raw_event_lock+0xf0/0xf0
>  ? check_path.constprop.61+0x24/0x40
>  ? check_noncircular+0x7e/0x110
>  ? __lock_acquire+0x13a0/0x23c0
>  __lock_acquire+0x13a0/0x23c0
>  lock_acquire+0xb5/0x3a0
>  ? fs_reclaim_acquire+0x7f/0xd0
>  ? __lock_acquire+0xa8e/0x23c0
>  ? get_stack_info_noinstr+0x12/0xe0
>  ? unwind_next_frame+0x4a3/0x6a0
>  fs_reclaim_acquire+0x9f/0xd0
>  ? fs_reclaim_acquire+0x7f/0xd0
>  __alloc_pages+0xed/0x330
>  stack_depot_save+0x3a1/0x470
>  ? rcu_torture_cleanup.cold.34+0x186/0x41d
>  save_stack_depot_trace.constprop.100+0x3b/0x60
>  ? kmem_cache_free+0x2a8/0x310
>  ? rcu_torture_cleanup.cold.34+0x186/0x41d
>  ? torture_shutdown+0x101/0x1f0
>  ? kthread+0x122/0x140
>  ? ret_from_fork+0x22/0x30
>  set_track+0x27/0x80
>  free_debug_processing+0x169/0x230
>  ? rcu_torture_cleanup.cold.34+0x186/0x41d
>  ? rcu_torture_cleanup.cold.34+0x186/0x41d
>  __slab_free+0x262/0x4a0
>  ? vprintk_emit+0x89/0x270
>  ? torture_onoff+0x260/0x260
>  ? rcu_torture_cleanup.cold.34+0x186/0x41d
>  kmem_cache_free+0x2a8/0x310
>  ? torture_onoff+0x260/0x260
>  rcu_torture_cleanup.cold.34+0x186/0x41d
>  ? wait_woken+0x80/0x80
>  ? torture_onoff+0x260/0x260
>  torture_shutdown+0x101/0x1f0
>  kthread+0x122/0x140
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x22/0x30
> 

