Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C895C3E8445
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhHJUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhHJUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FDE960F55;
        Tue, 10 Aug 2021 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628627114;
        bh=m/XOuvss0wg/hS6PzlWSyo704Novc2tyFkeTu4pQ96A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QaE/EKOp5HLiyf2Gb66o6nHP+rRUwDL+sfrO9an+jh6OXSoLbiv7wkJlSpgVa+hVk
         4uIGJGuEBjL44ZDMtjYLfGSoAN4aWVyW7hJhaZcW0ewgu5eSS50XnqQ+9Lb7idre3N
         T0UdFQIz0hymRifbc2EUJggoM7+Ebt9m5XzWvqFHFWmldrrVxAGWKk/xeyP3kuNUYE
         O0J9UqQBaPyD15Nd5tVuIJEEqpGyKjczSHD82rxZn5lG+eruEIXzeQ+Mn0uq/G7pkP
         yIzjk46olv/c9OOsyJGb+VUc+FgjUBTIvywCJNVQqy0LE0UX7gu6G74m4lsNjz1q2n
         SjJ9gkICJOikw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2DB1A5C048D; Tue, 10 Aug 2021 13:25:14 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:25:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
Message-ID: <20210810202514.GA190765@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf59e73-8b27-56a8-d863-cfe40457f4df@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:03:02AM +0200, Vlastimil Babka wrote:
> On 8/9/21 3:41 PM, Qian Cai wrote:
> >>  
> >> +static DEFINE_MUTEX(flush_lock);
> >> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> >> +
> >>  static void flush_all(struct kmem_cache *s)
> >>  {
> >> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
> >> +	struct slub_flush_work *sfw;
> >> +	unsigned int cpu;
> >> +
> >> +	mutex_lock(&flush_lock);
> > 
> > Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:
> > 
> > slab_mutex -> flush_lock
> > 
> > [   91.374541] WARNING: possible circular locking dependency detected
> > [   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
> > [   91.387149] ------------------------------------------------------
> > [   91.394016] lsbug/1523 is trying to acquire lock:
> > [   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
> > [   91.407425] 
> >                but task is already holding lock:
> > [   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
> > [   91.423603] 
> >                which lock already depends on the new lock.

From the series in -next, I got a three-way deadlock similar to what
Qian Cai got.

> OK, managed to reproduce in qemu and this fixes it for me on top of
> next-20210809. Could you test as well, as your testing might be more
> comprehensive? I will format is as a fixup for the proper patch in the series then.
> 
> ----8<----
> >From 7ce71c7f9455e8b96dc1b728ea566b6ef5e424e4 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 10 Aug 2021 10:58:07 +0200
> Subject: [PATCH] mm, slub: fix memory offline lockdep splat
> 
> Reverse order of flush_lock and cpus_read_lock() to prevent lockdep splat.
> In slab_mem_going_offline_callback() we already have cpus_read_lock()
> held so make sure it's not taken again.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

With this patch, it reduces to a two-way deadlock as shown at the end
of this message.

My reproducer is the following on a two-socket system:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10m --configs RUDE01 --trust-make

This likely needs the RCU commits in -next to reproduce quickly, though
you never know.

							Thanx, Paul

> ---
>  mm/slub.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 88a6c3ed2751..073cdd4b020f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2640,13 +2640,13 @@ static bool has_cpu_slab(int cpu, struct kmem_cache *s)
>  static DEFINE_MUTEX(flush_lock);
>  static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>  
> -static void flush_all(struct kmem_cache *s)
> +static void flush_all_cpus_locked(struct kmem_cache *s)
>  {
>  	struct slub_flush_work *sfw;
>  	unsigned int cpu;
>  
> +	lockdep_assert_cpus_held();
>  	mutex_lock(&flush_lock);
> -	cpus_read_lock();
>  
>  	for_each_online_cpu(cpu) {
>  		sfw = &per_cpu(slub_flush, cpu);
> @@ -2667,10 +2667,16 @@ static void flush_all(struct kmem_cache *s)
>  		flush_work(&sfw->work);
>  	}
>  
> -	cpus_read_unlock();
>  	mutex_unlock(&flush_lock);
>  }
>  
> +static void flush_all(struct kmem_cache *s)
> +{
> +	cpus_read_lock();
> +	flush_all_cpus_locked(s);
> +	cpus_read_unlock();
> +}
> +
>  /*
>   * Use the cpu notifier to insure that the cpu slabs are flushed when
>   * necessary.
> @@ -4516,7 +4522,7 @@ EXPORT_SYMBOL(kfree);
>   * being allocated from last increasing the chance that the last objects
>   * are freed in them.
>   */
> -int __kmem_cache_shrink(struct kmem_cache *s)
> +int __kmem_cache_do_shrink(struct kmem_cache *s)
>  {
>  	int node;
>  	int i;
> @@ -4528,7 +4534,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	flush_all(s);
>  	for_each_kmem_cache_node(s, node, n) {
>  		INIT_LIST_HEAD(&discard);
>  		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
> @@ -4578,13 +4583,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
>  	return ret;
>  }
>  
> +int __kmem_cache_shrink(struct kmem_cache *s)
> +{
> +	flush_all(s);
> +	return __kmem_cache_do_shrink(s);
> +}
> +
>  static int slab_mem_going_offline_callback(void *arg)
>  {
>  	struct kmem_cache *s;
>  
>  	mutex_lock(&slab_mutex);
> -	list_for_each_entry(s, &slab_caches, list)
> -		__kmem_cache_shrink(s);
> +	list_for_each_entry(s, &slab_caches, list) {
> +		flush_all_cpus_locked(s);
> +		__kmem_cache_do_shrink(s);
> +	}
>  	mutex_unlock(&slab_mutex);
>  
>  	return 0;
> -- 
> 2.32.0

[  602.668050] ========================================================
[  602.668924] WARNING: possible circular locking dependency detected
[  602.669796] 5.14.0-rc5-next-20210809+ #3298 Not tainted
[  602.670537] ------------------------------------------------------
[  602.671408] torture_shutdow/88 is trying to acquire lock:
[  602.672169] ffffffffb00686b0 (cpu_hotplug_lock){++++}-{0:0}, at: __kmem_=
cache_shutdown+0x26/0x210
[  602.673416]
[  602.673416] but task is already holding lock:
[  602.674240] ffffffffb0178368 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_de=
stroy+0x1c/0x110
[  602.675379]
[  602.675379] which lock already depends on the new lock.
[  602.675379]
[  602.676525]
[  602.676525] the existing dependency chain (in reverse order) is:
[  602.677576]
[  602.677576] -> #1 (slab_mutex){+.+.}-{3:3}:
[  602.678377]        __mutex_lock+0x81/0x9a0
[  602.678964]        slub_cpu_dead+0x17/0xb0
[  602.679547]        cpuhp_invoke_callback+0x180/0x890
[  602.680255]        cpuhp_invoke_callback_range+0x3b/0x80
[  602.681009]        _cpu_down+0xe4/0x2b0
[  602.681556]        cpu_down+0x29/0x50
[  602.682082]        device_offline+0x7e/0xb0
[  602.682677]        remove_cpu+0x17/0x30
[  602.683225]        torture_offline+0x7d/0x140
[  602.683844]        torture_onoff+0x14f/0x260
[  602.684455]        kthread+0x132/0x160
[  602.684994]        ret_from_fork+0x22/0x30
[  602.685574]
[  602.685574] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[  602.686460]        __lock_acquire+0x13d2/0x2470
[  602.687107]        lock_acquire+0xc9/0x2e0
[  602.687686]        cpus_read_lock+0x26/0xb0
[  602.688284]        __kmem_cache_shutdown+0x26/0x210
[  602.688973]        kmem_cache_destroy+0x38/0x110
[  602.689625]        rcu_torture_cleanup.cold.36+0x192/0x421
[  602.690399]        torture_shutdown+0xdd/0x1c0
[  602.691032]        kthread+0x132/0x160
[  602.691563]        ret_from_fork+0x22/0x30
[  602.692147]
[  602.692147] other info that might help us debug this:
[  602.692147]
[  602.693268]  Possible unsafe locking scenario:
[  602.693268]
[  602.694128]        CPU0                    CPU1
[  602.694766]        ----                    ----
[  602.695409]   lock(slab_mutex);
[  602.695858]                                lock(cpu_hotplug_lock);
[  602.696731]                                lock(slab_mutex);
[  602.697531]   lock(cpu_hotplug_lock);
[  602.698057]
[  602.698057]  *** DEADLOCK ***
[  602.698057]
[  602.698884] 1 lock held by torture_shutdow/88:
[  602.699517]  #0: ffffffffb0178368 (slab_mutex){+.+.}-{3:3}, at: kmem_cac=
he_destroy+0x1c/0x110
[  602.700716]
[  602.700716] stack backtrace:
[  602.701334] CPU: 3 PID: 88 Comm: torture_shutdow Not tainted 5.14.0-rc5-=
next-20210809+ #3298
[  602.702518] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module_el8=
.5.0+746+bbd5d70c 04/01/2014
[  602.703799] Call Trace:
[  602.704160]  dump_stack_lvl+0x44/0x57
[  602.704686]  check_noncircular+0xfe/0x110
[  602.705264]  __lock_acquire+0x13d2/0x2470
[  602.705836]  lock_acquire+0xc9/0x2e0
[  602.706389]  ? __kmem_cache_shutdown+0x26/0x210
[  602.707059]  cpus_read_lock+0x26/0xb0
[  602.707582]  ? __kmem_cache_shutdown+0x26/0x210
[  602.708226]  __kmem_cache_shutdown+0x26/0x210
[  602.708843]  ? lock_is_held_type+0xd6/0x130
[  602.709442]  ? torture_onoff+0x260/0x260
[  602.710007]  kmem_cache_destroy+0x38/0x110
[  602.710590]  rcu_torture_cleanup.cold.36+0x192/0x421
[  602.711298]  ? wait_woken+0x60/0x60
[  602.711796]  ? torture_onoff+0x260/0x260
[  602.712359]  torture_shutdown+0xdd/0x1c0
[  602.712918]  kthread+0x132/0x160
[  602.713386]  ? set_kthread_struct+0x40/0x40
[  602.713985]  ret_from_fork+0x22/0x30
