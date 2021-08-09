Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC03E4AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhHIRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233819AbhHIRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628530495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rb4QDnk0ojrnKDB8uBewr/Jrr1VfLLECRcpvoFY5drw=;
        b=K1v3ENm5bK64xEur4sbrXd85y3ySab4W2PpVjeER9g2Ok/fOrmGnnH7+lBexbYZZgz/oyJ
        uOWF8jRsMcfSwBo5kBOiifY45vUAVp0e37/P16zqfZRHDpjhYaAkDercoWlW3cZfz4X0j+
        VowVxU4Ry1lAxPYvFz98LYfVPO6rfjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-N5dse8S9OaWEpH2Fl-SoVw-1; Mon, 09 Aug 2021 13:34:52 -0400
X-MC-Unique: N5dse8S9OaWEpH2Fl-SoVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D64871814;
        Mon,  9 Aug 2021 17:34:51 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36010136F5;
        Mon,  9 Aug 2021 17:34:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 024844175292; Mon,  9 Aug 2021 14:34:39 -0300 (-03)
Date:   Mon, 9 Aug 2021 14:34:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 4/4] mm: vmstat_refresh: avoid queueing work item if cpu
 stats are clean
Message-ID: <20210809173439.GA17223@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
 <20210730202010.331065257@fuller.cnet>
 <CAFki+L==9YGLS-qk0RgPCmO_-9+Ea1mJ0LTEN0cKF1OURpWdyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+L==9YGLS-qk0RgPCmO_-9+Ea1mJ0LTEN0cKF1OURpWdyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:47:40PM -0400, Nitesh Lal wrote:
> Hi Marcelo,
> 
> On Fri, Jul 30, 2021 at 4:21 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > It is not necessary to queue work item to run refresh_vm_stats
> > on a remote CPU if that CPU has no dirty stats and no per-CPU
> > allocations for remote nodes.
> 
> [...]
> 
> >         /*
> >          * The regular update, every sysctl_stat_interval, may come later
> > @@ -1850,9 +1875,15 @@ int vmstat_refresh(struct ctl_table *tab
> >          * transiently negative values, report an error here if any of
> >          * the stats is negative, so we know to go looking for imbalance.
> >          */
> > -       err = schedule_on_each_cpu(refresh_vm_stats);
> > -       if (err)
> > -               return err;
> > +       get_online_cpus();
> > +       for_each_online_cpu(cpu) {
> > +               if (need_update(cpu) || need_drain_remote_zones(cpu))
> > +                       work_on_cpu(cpu, refresh_vm_stats, NULL);
> > +
> > +               cond_resched();
> > +       }
> > +       put_online_cpus();
> 
> While testing this patch-set by enabling the debug config options, I
> ran into the following splat:
> 
> [  945.149209] ======================================================
> [  945.156111] WARNING: possible circular locking dependency detected
> [  945.163013] 5.14.0-rc3+ #2 Tainted: G S
> [  945.168754] ------------------------------------------------------
> [  945.175655] sysctl/6820 is trying to acquire lock:
> [  945.181006] ffff8881679efb00
> ((work_completion)(&wfc.work)){+.+.}-{0:0}, at:
> __flush_work+0x5c2/0x8c0
> [  945.191332]
> [  945.191332] but task is already holding lock:
> [  945.197846] ffffffff93b43660 (cpu_hotplug_lock){++++}-{0:0}, at:
> vmstat_refresh+0x4a/0x450
> [  945.207098]
> [  945.207098] which lock already depends on the new lock.
> [  945.207098]
> [  945.216228]
> [  945.216228] the existing dependency chain (in reverse order) is:
> [  945.224574]
> [  945.224574] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
> [  945.231488]        lock_acquire+0x1d7/0x540
> [  945.236157]        cpus_read_lock+0x3b/0xc0
> [  945.240834]        alloc_workqueue+0x884/0xd00
> [  945.245800]        scsi_host_alloc+0xbdb/0xf60
> [  945.250769]        megasas_probe_one+0x164/0x800 [megaraid_sas]
> [  945.257402]        local_pci_probe+0xd8/0x170
> [  945.262270]        work_for_cpu_fn+0x51/0xa0
> [  945.267041]        process_one_work+0x960/0x16a0
> [  945.272200]        worker_thread+0x55e/0xbf0
> [  945.276970]        kthread+0x371/0x440
> [  945.281158]        ret_from_fork+0x22/0x30
> [  945.285737]
> [  945.285737] -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
> [  945.293813]        check_prevs_add+0x3fd/0x2470
> [  945.298874]        __lock_acquire+0x23f7/0x2f80
> [  945.303934]        lock_acquire+0x1d7/0x540
> [  945.308605]        __flush_work+0x5e2/0x8c0
> [  945.313278]        work_on_cpu+0xee/0x140
> [  945.317753]        vmstat_refresh+0x12f/0x450
> [  945.322622]        proc_sys_call_handler+0x389/0x500
> [  945.328170]        new_sync_read+0x3af/0x610
> [  945.332942]        vfs_read+0x268/0x490
> [  945.337225]        ksys_read+0xf1/0x1c0
> [  945.341511]        do_syscall_64+0x42/0x90
> [  945.346091]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  945.352318]
> [  945.352318] other info that might help us debug this:
> [  945.352318]
> [  945.361254]  Possible unsafe locking scenario:
> [  945.361254]
> [  945.367863]        CPU0                    CPU1
> [  945.372920]        ----                    ----
> [  945.377976]   lock(cpu_hotplug_lock);
> [  945.382072]
> lock((work_completion)(&wfc.work));
> [  945.390140]                                lock(cpu_hotplug_lock);
> [  945.397046]   lock((work_completion)(&wfc.work));
> [  945.402301]
> [  945.402301]  *** DEADLOCK ***
> [  945.402301]
> [  945.408909] 1 lock held by sysctl/6820:
> [  945.413194]  #0: ffffffff93b43660 (cpu_hotplug_lock){++++}-{0:0},
> at: vmstat_refresh+0x4a/0x450
> [  945.422929]
> [  945.422929] stack backtrace:
> [  945.427793] CPU: 25 PID: 6820 Comm: sysctl Tainted: G S
>    5.14.0-rc3+ #2
> [  945.436540] Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS
> 2.6.0 10/31/2017
> [  945.444886] Call Trace:
> [  945.447623]  dump_stack_lvl+0x44/0x57
> [  945.451720]  check_noncircular+0x280/0x320
> [  945.456299]  ? print_circular_bug.isra.49+0x440/0x440
> [  945.461943]  ? mark_lock.part.54+0x107/0x1370
> [  945.466813]  ? mark_lock.part.54+0x107/0x1370
> [  945.471683]  ? native_sched_clock+0x32/0x130
> [  945.476449]  ? lock_chain_count+0x20/0x20
> [  945.480929]  ? sched_clock_cpu+0x151/0x1d0
> [  945.485512]  check_prevs_add+0x3fd/0x2470
> [  945.489999]  ? native_sched_clock+0x32/0x130
> [  945.494770]  ? sched_clock_cpu+0x151/0x1d0
> [  945.499347]  ? find_held_lock+0x3a/0x1c0
> [  945.503731]  ? check_irq_usage+0xe10/0xe10
> [  945.508306]  ? lockdep_lock+0xbf/0x1b0
> [  945.512495]  ? static_obj+0xc0/0xc0
> [  945.516392]  ? sched_clock_cpu+0x151/0x1d0
> [  945.520975]  __lock_acquire+0x23f7/0x2f80
> [  945.525461]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  945.530430]  lock_acquire+0x1d7/0x540
> [  945.534523]  ? __flush_work+0x5c2/0x8c0
> [  945.538811]  ? rcu_read_unlock+0x50/0x50
> [  945.543196]  ? native_sched_clock+0x32/0x130
> [  945.547969]  ? __queue_work+0x4a3/0xfd0
> [  945.552256]  ? rcu_read_lock_sched_held+0xaf/0xe0
> [  945.557514]  __flush_work+0x5e2/0x8c0
> [  945.561604]  ? __flush_work+0x5c2/0x8c0
> [  945.565894]  ? queue_delayed_work_on+0x80/0x80
> [  945.570853]  ? lock_downgrade+0x700/0x700
> [  945.575339]  ? mark_held_locks+0xb7/0x120
> [  945.579829]  ? lockdep_hardirqs_on_prepare+0x28f/0x3e0
> [  945.585572]  ? queue_work_on+0x48/0x80
> [  945.589763]  ? trace_hardirqs_on+0x32/0x170
> [  945.594436]  work_on_cpu+0xee/0x140
> [  945.598327]  ? flush_delayed_work+0xc0/0xc0
> [  945.603004]  ? work_debug_hint+0x40/0x40
> [  945.607388]  ? refresh_cpu_vm_stats+0x530/0x530
> [  945.612452]  ? need_update+0x162/0x210
> [  945.616646]  vmstat_refresh+0x12f/0x450
> [  945.620938]  proc_sys_call_handler+0x389/0x500
> [  945.625905]  ? proc_sys_permission+0x120/0x120
> [  945.630872]  ? native_sched_clock+0x32/0x130
> [  945.635644]  new_sync_read+0x3af/0x610
> [  945.639838]  ? __x64_sys_llseek+0x2e0/0x2e0
> [  945.644505]  ? native_sched_clock+0x32/0x130
> [  945.649290]  ? fsnotify+0xf10/0xf10
> [  945.653199]  vfs_read+0x268/0x490
> [  945.656913]  ksys_read+0xf1/0x1c0
> [  945.660619]  ? vfs_write+0x910/0x910
> [  945.664615]  ? syscall_trace_enter.isra.17+0x18c/0x260
> [  945.670369]  do_syscall_64+0x42/0x90
> [  945.674371]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Maybe we should replace get/put_online_cpus() with cpu_hotplug/enable_disable()?

schedule_on_each_cpu has a similar pattern and should exhibit
the same problem.

So perhaps this problem already existed... 
Don't see the warning on a VM.

Can you revert the last patch and confirm that it introduces this
issue?

Thanks for testing!

