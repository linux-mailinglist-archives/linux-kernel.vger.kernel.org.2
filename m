Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF13E46D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhHINmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:42:13 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:65401 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233726AbhHINmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628516511; x=1660052511;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MG6I+NFt2tJ8NYVFdFhNvN1qBYIbBrG4san1MjVsUHk=;
  b=KyQlwdXa/UnaUNCkng+7p0Rhc9X/j6JvZG69V2E9HpMUSpGhQgsgZOgP
   9mRmiW1sWFOVvBvVboqiL5904xy/VwRTjtYWwKEm1wOJovIrGcabHOEqm
   RQIc+2efVIrUHeXpf8c4i0LMo/d7Cp7E8YDSpTha2RVUXFVK23OVhpPcJ
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Aug 2021 06:41:51 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Aug 2021 06:41:51 -0700
Received: from [10.111.167.17] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 9 Aug
 2021 06:41:49 -0700
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
Date:   Mon, 9 Aug 2021 09:41:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805152000.12817-30-vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2021 11:19 AM, Vlastimil Babka wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> flush_all() flushes a specific SLAB cache on each CPU (where the cache
> is present). The deactivate_slab()/__free_slab() invocation happens
> within IPI handler and is problematic for PREEMPT_RT.
> 
> The flush operation is not a frequent operation or a hot path. The
> per-CPU flush operation can be moved to within a workqueue.
> 
> [vbabka@suse.cz: adapt to new SLUB changes]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index dceb289cb052..da48ada3d17f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2513,33 +2513,73 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
>  	unfreeze_partials_cpu(s, c);
>  }
>  
> +struct slub_flush_work {
> +	struct work_struct work;
> +	struct kmem_cache *s;
> +	bool skip;
> +};
> +
>  /*
>   * Flush cpu slab.
>   *
> - * Called from IPI handler with interrupts disabled.
> + * Called from CPU work handler with migration disabled.
>   */
> -static void flush_cpu_slab(void *d)
> +static void flush_cpu_slab(struct work_struct *w)
>  {
> -	struct kmem_cache *s = d;
> -	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
> +	struct kmem_cache *s;
> +	struct kmem_cache_cpu *c;
> +	struct slub_flush_work *sfw;
> +
> +	sfw = container_of(w, struct slub_flush_work, work);
> +
> +	s = sfw->s;
> +	c = this_cpu_ptr(s->cpu_slab);
>  
>  	if (c->page)
> -		flush_slab(s, c, false);
> +		flush_slab(s, c, true);
>  
>  	unfreeze_partials(s);
>  }
>  
> -static bool has_cpu_slab(int cpu, void *info)
> +static bool has_cpu_slab(int cpu, struct kmem_cache *s)
>  {
> -	struct kmem_cache *s = info;
>  	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
>  
>  	return c->page || slub_percpu_partial(c);
>  }
>  
> +static DEFINE_MUTEX(flush_lock);
> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
> +
>  static void flush_all(struct kmem_cache *s)
>  {
> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
> +	struct slub_flush_work *sfw;
> +	unsigned int cpu;
> +
> +	mutex_lock(&flush_lock);

Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:

slab_mutex -> flush_lock

[   91.374541] WARNING: possible circular locking dependency detected
[   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
[   91.387149] ------------------------------------------------------
[   91.394016] lsbug/1523 is trying to acquire lock:
[   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
[   91.407425] 
               but task is already holding lock:
[   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
[   91.423603] 
               which lock already depends on the new lock.

[   91.433854] 
               the existing dependency chain (in reverse order) is:
[   91.442715] 
               -> #4 (slab_mutex){+.+.}-{3:3}:
[   91.449766]        __lock_acquire+0xb0c/0x1aa8
[   91.454901]        lock_acquire+0x34c/0xb20
[   91.459773]        __mutex_lock+0x194/0x1470
[   91.464732]        mutex_lock_nested+0x6c/0xc0
[   91.469864]        slab_memory_callback+0x44/0x280
[   91.475344]        blocking_notifier_call_chain+0xd0/0x138
[   91.481519]        memory_notify+0x28/0x38
[   91.486304]        offline_pages+0x2cc/0xce4
[   91.491262]        memory_subsys_offline+0xd8/0x280
[   91.496827]        device_offline+0x154/0x1e0
[   91.501872]        online_store+0xa4/0x118
[   91.506656]        dev_attr_store+0x44/0x78
[   91.511527]        sysfs_kf_write+0xe8/0x138
[   91.516485]        kernfs_fop_write_iter+0x26c/0x3d0
[   91.522138]        new_sync_write+0x2bc/0x4f8
[   91.527185]        vfs_write+0x718/0xc88
[   91.531795]        ksys_write+0xf8/0x1e0
[   91.536404]        __arm64_sys_write+0x74/0xa8
[   91.541535]        invoke_syscall.constprop.0+0xdc/0x1d8
[   91.547536]        do_el0_svc+0xe4/0x2a8
[   91.552146]        el0_svc+0x64/0x130
[   91.556498]        el0t_64_sync_handler+0xb0/0xb8
[   91.561889]        el0t_64_sync+0x180/0x184
[   91.566760] 
               -> #3 ((memory_chain).rwsem){++++}-{3:3}:
[   91.574680]        __lock_acquire+0xb0c/0x1aa8
[   91.579814]        lock_acquire+0x34c/0xb20
[   91.584685]        down_read+0xf0/0x488
[   91.589210]        blocking_notifier_call_chain+0x58/0x138
[   91.595383]        memory_notify+0x28/0x38
[   91.600167]        offline_pages+0x2cc/0xce4
[   91.605124]        memory_subsys_offline+0xd8/0x280
[   91.610689]        device_offline+0x154/0x1e0
[   91.615734]        online_store+0xa4/0x118
[   91.620518]        dev_attr_store+0x44/0x78
[   91.625388]        sysfs_kf_write+0xe8/0x138
[   91.630346]        kernfs_fop_write_iter+0x26c/0x3d0
[   91.635997]        new_sync_write+0x2bc/0x4f8
[   91.641043]        vfs_write+0x718/0xc88
[   91.645652]        ksys_write+0xf8/0x1e0
[   91.650262]        __arm64_sys_write+0x74/0xa8
[   91.655393]        invoke_syscall.constprop.0+0xdc/0x1d8
[   91.661394]        do_el0_svc+0xe4/0x2a8
[   91.666004]        el0_svc+0x64/0x130
[   91.670355]        el0t_64_sync_handler+0xb0/0xb8
[   91.675747]        el0t_64_sync+0x180/0x184
[   91.680617] 
               -> #2 (pcp_batch_high_lock){+.+.}-{3:3}:
[   91.688449]        __lock_acquire+0xb0c/0x1aa8
[   91.693582]        lock_acquire+0x34c/0xb20
[   91.698452]        __mutex_lock+0x194/0x1470
[   91.703410]        mutex_lock_nested+0x6c/0xc0
[   91.708541]        zone_pcp_update+0x3c/0x68
[   91.713500]        page_alloc_cpu_online+0x64/0x90
[   91.718978]        cpuhp_invoke_callback+0x588/0x2ba8
[   91.724718]        cpuhp_invoke_callback_range+0xa4/0x108
[   91.730804]        cpu_up+0x598/0xb78
[   91.735154]        bringup_nonboot_cpus+0x110/0x168
[   91.740719]        smp_init+0x4c/0xe0
[   91.745070]        kernel_init_freeable+0x554/0x7c8
[   91.750637]        kernel_init+0x2c/0x140
[   91.755334]        ret_from_fork+0x10/0x20
[   91.760118] 
               -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[   91.767688]        __lock_acquire+0xb0c/0x1aa8
[   91.772820]        lock_acquire+0x34c/0xb20
[   91.777691]        cpus_read_lock+0x98/0x308
[   91.782649]        flush_all+0x54/0x1c8
[   91.787173]        __kmem_cache_shrink+0x38/0x2f0
[   91.792566]        kmem_cache_shrink+0x28/0x38
[   91.797699]        acpi_os_purge_cache+0x18/0x28
[   91.803006]        acpi_purge_cached_objects+0x44/0xdc
[   91.808832]        acpi_initialize_objects+0x24/0x88
[   91.814487]        acpi_bus_init+0xe0/0x47c
[   91.819357]        acpi_init+0x130/0x27c
[   91.823967]        do_one_initcall+0x180/0xbe8
[   91.829098]        kernel_init_freeable+0x710/0x7c8
[   91.834663]        kernel_init+0x2c/0x140
[   91.839360]        ret_from_fork+0x10/0x20
[   91.844143] 
               -> #0 (flush_lock){+.+.}-{3:3}:
[   91.851193]        check_prev_add+0x194/0x1170
[   91.856326]        validate_chain+0xfe8/0x1c20
[   91.861458]        __lock_acquire+0xb0c/0x1aa8
[   91.866589]        lock_acquire+0x34c/0xb20
[   91.871460]        __mutex_lock+0x194/0x1470
[   91.876418]        mutex_lock_nested+0x6c/0xc0
[   91.881549]        flush_all+0x50/0x1c8
[   91.886072]        __kmem_cache_shrink+0x38/0x2f0
[   91.891465]        slab_memory_callback+0x68/0x280
[   91.896943]        blocking_notifier_call_chain+0xd0/0x138
[   91.903117]        memory_notify+0x28/0x38
[   91.907901]        offline_pages+0x2cc/0xce4
[   91.912859]        memory_subsys_offline+0xd8/0x280
[   91.918424]        device_offline+0x154/0x1e0
[   91.923470]        online_store+0xa4/0x118
[   91.928254]        dev_attr_store+0x44/0x78
[   91.933125]        sysfs_kf_write+0xe8/0x138
[   91.938083]        kernfs_fop_write_iter+0x26c/0x3d0
[   91.943735]        new_sync_write+0x2bc/0x4f8
[   91.948781]        vfs_write+0x718/0xc88
[   91.953391]        ksys_write+0xf8/0x1e0
[   91.958000]        __arm64_sys_write+0x74/0xa8
[   91.963130]        invoke_syscall.constprop.0+0xdc/0x1d8
[   91.969131]        do_el0_svc+0xe4/0x2a8
[   91.973741]        el0_svc+0x64/0x130
[   91.978093]        el0t_64_sync_handler+0xb0/0xb8
[   91.983484]        el0t_64_sync+0x180/0x184
[   91.988354] 
               other info that might help us debug this:

[   91.998431] Chain exists of:
                 flush_lock --> (memory_chain).rwsem --> slab_mutex

[   92.010867]  Possible unsafe locking scenario:

[   92.018166]        CPU0                    CPU1
[   92.023380]        ----                    ----
[   92.028595]   lock(slab_mutex);
[   92.032425]                                lock((memory_chain).rwsem);
[   92.039641]                                lock(slab_mutex);
[   92.045989]   lock(flush_lock);
[   92.049819] 
                *** DEADLOCK ***

[   92.057811] 10 locks held by lsbug/1523:
[   92.062420]  #0: ffff0000505a8430 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0xf8/0x1e0
[   92.071128]  #1: ffff000870f99e88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1dc/0x3d0
[   92.080701]  #2: ffff0000145b2ab8 (kn->active#175){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f8/0x3d0
[   92.090623]  #3: ffff800018f84f08 (device_hotplug_lock){+.+.}-{3:3}, at: lock_device_hotplug_sysfs+0x24/0x88
[   92.101151]  #4: ffff0000145e9190 (&dev->mutex){....}-{3:3}, at: device_offline+0xa0/0x1e0
[   92.110115]  #5: ffff800011d26450 (cpu_hotplug_lock){++++}-{0:0}, at: offline_pages+0x10c/0xce4
[   92.119514]  #6: ffff800018e60570 (mem_hotplug_lock){++++}-{0:0}, at: offline_pages+0x11c/0xce4
[   92.128919]  #7: ffff800018e5bb68 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x30/0x60
[   92.138668]  #8: ffff800018fa0610 ((memory_chain).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x58/0x138
[   92.149633]  #9: ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
[   92.159033] 
               stack backtrace:
[   92.164772] CPU: 29 PID: 1523 Comm: lsbug Not tainted 5.14.0-rc5-next-20210809+ #84
[   92.173116] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[   92.181631] Call trace:
[   92.184763]  dump_backtrace+0x0/0x3b8
[   92.189115]  show_stack+0x20/0x30
[   92.193118]  dump_stack_lvl+0x8c/0xb8
[   92.197469]  dump_stack+0x1c/0x38
[   92.201472]  print_circular_bug.isra.0+0x530/0x540
[   92.206953]  check_noncircular+0x27c/0x2f0
[   92.211738]  check_prev_add+0x194/0x1170
[   92.216349]  validate_chain+0xfe8/0x1c20
[   92.220961]  __lock_acquire+0xb0c/0x1aa8
[   92.225571]  lock_acquire+0x34c/0xb20
[   92.229921]  __mutex_lock+0x194/0x1470
[   92.234358]  mutex_lock_nested+0x6c/0xc0
[   92.238968]  flush_all+0x50/0x1c8
flush_all at /usr/src/linux-next/mm/slub.c:2649
[   92.242971]  __kmem_cache_shrink+0x38/0x2f0
[   92.247842]  slab_memory_callback+0x68/0x280
slab_mem_going_offline_callback at /usr/src/linux-next/mm/slub.c:4586
(inlined by) slab_memory_callback at /usr/src/linux-next/mm/slub.c:4678
[   92.252800]  blocking_notifier_call_chain+0xd0/0x138
notifier_call_chain at /usr/src/linux-next/kernel/notifier.c:83
(inlined by) blocking_notifier_call_chain at /usr/src/linux-next/kernel/notifier.c:337
(inlined by) blocking_notifier_call_chain at /usr/src/linux-next/kernel/notifier.c:325
[   92.258453]  memory_notify+0x28/0x38
[   92.262717]  offline_pages+0x2cc/0xce4
[   92.267153]  memory_subsys_offline+0xd8/0x280
[   92.272198]  device_offline+0x154/0x1e0
[   92.276723]  online_store+0xa4/0x118
[   92.280986]  dev_attr_store+0x44/0x78
[   92.285336]  sysfs_kf_write+0xe8/0x138
[   92.289774]  kernfs_fop_write_iter+0x26c/0x3d0
[   92.294906]  new_sync_write+0x2bc/0x4f8
[   92.299431]  vfs_write+0x718/0xc88
[   92.303520]  ksys_write+0xf8/0x1e0
[   92.307608]  __arm64_sys_write+0x74/0xa8
[   92.312219]  invoke_syscall.constprop.0+0xdc/0x1d8
[   92.317698]  do_el0_svc+0xe4/0x2a8
[   92.321789]  el0_svc+0x64/0x130
[   92.325619]  el0t_64_sync_handler+0xb0/0xb8
[   92.330489]  el0t_64_sync+0x180/0x184

> +	cpus_read_lock();
> +
> +	for_each_online_cpu(cpu) {
> +		sfw = &per_cpu(slub_flush, cpu);
> +		if (!has_cpu_slab(cpu, s)) {
> +			sfw->skip = true;
> +			continue;
> +		}
> +		INIT_WORK(&sfw->work, flush_cpu_slab);
> +		sfw->skip = false;
> +		sfw->s = s;
> +		schedule_work_on(cpu, &sfw->work);
> +	}
> +
> +	for_each_online_cpu(cpu) {
> +		sfw = &per_cpu(slub_flush, cpu);
> +		if (sfw->skip)
> +			continue;
> +		flush_work(&sfw->work);
> +	}
> +
> +	cpus_read_unlock();
> +	mutex_unlock(&flush_lock);
>  }
>  
>  /*
> 
