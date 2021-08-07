Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B63E32CE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhHGCsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhHGCsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628304476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ai1Cqx3EQ+OXVB6dtvE8BYwUCnqNAh4hHG802BZFcg=;
        b=dDm4g3Y/3ByDBmzAN4j9QMH1q27xqXHNT2Vph4q7DZIfn2dx/pwusuQp7ecJfMtb/0cSOU
        a9nN14ABI8wIiDRgFuhhEPdU3UZhvqmbPV93rutN1Blk5F/HO3dLf+/sfPQqiaOmqMMDW5
        kjCUCijLIvnWAh1A/65x3UoW2K90dNs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-AJ5uD4vcPm-jKPm_7MGLlg-1; Fri, 06 Aug 2021 22:47:54 -0400
X-MC-Unique: AJ5uD4vcPm-jKPm_7MGLlg-1
Received: by mail-lf1-f72.google.com with SMTP id x186-20020a19c7c30000b02903b69bdbaa03so4603635lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 19:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ai1Cqx3EQ+OXVB6dtvE8BYwUCnqNAh4hHG802BZFcg=;
        b=kVKzaBwO2mCLY+Dta05Tlxua2MMOGc9VZG6u22x3+AnbePT5YfCulyOyfTQGAuRKNh
         ysrQfR14jTuh3BcwL8QkS3q572LyEViEGAn1aEv74RUoO5u6CzQjXaJuZpfqJgvtbf6D
         J1VY2SVyZVrswzuAOaF3ri8GxXdsJkAXPSTq4RK3FJ39jOWqFY3Wso/gXXR5AeXEmKdW
         Mr/rPURrp8EdpKQ/ggcRIdtqBnOQ5qG06hmSpT+/JLUvzl8gu1cUGKyga3pXl74i6wLh
         u8WlheH0sHQ0YyNVOSQJMrN+pPm5695nBo6rYWUW41e4tDT7Q3VKR8UlWGIhzNyCC07M
         9i7w==
X-Gm-Message-State: AOAM533ZxCDMsyDOsdh0pzaxNX4qoWTkyWbVIVgQ+K9f6ymxCjD2ZMe0
        r4o3lPz6dHLR8sjeJE1iX77U6VposHo3yimydFRv/jzWrCSti8NKTQ1deLWGRDpDq/yrCAOUc8D
        yIfyba68riVxGKjLJBRxIYyhqYbMyovPDqPmNuoNB
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr1328279ljj.30.1628304473315;
        Fri, 06 Aug 2021 19:47:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE051IqFrQxhbm/fZG6Gp/CTPcdKQgWRqoHIdZfhaGsvaRmoI92b3x+Hi85YocqVAEsWPARSv3rWyvuo6ByCk=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr1328277ljj.30.1628304473106;
 Fri, 06 Aug 2021 19:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210730201827.269106165@fuller.cnet> <20210730202010.331065257@fuller.cnet>
In-Reply-To: <20210730202010.331065257@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 6 Aug 2021 22:47:40 -0400
Message-ID: <CAFki+L==9YGLS-qk0RgPCmO_-9+Ea1mJ0LTEN0cKF1OURpWdyg@mail.gmail.com>
Subject: Re: [patch 4/4] mm: vmstat_refresh: avoid queueing work item if cpu
 stats are clean
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Fri, Jul 30, 2021 at 4:21 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> It is not necessary to queue work item to run refresh_vm_stats
> on a remote CPU if that CPU has no dirty stats and no per-CPU
> allocations for remote nodes.

[...]

>         /*
>          * The regular update, every sysctl_stat_interval, may come later
> @@ -1850,9 +1875,15 @@ int vmstat_refresh(struct ctl_table *tab
>          * transiently negative values, report an error here if any of
>          * the stats is negative, so we know to go looking for imbalance.
>          */
> -       err = schedule_on_each_cpu(refresh_vm_stats);
> -       if (err)
> -               return err;
> +       get_online_cpus();
> +       for_each_online_cpu(cpu) {
> +               if (need_update(cpu) || need_drain_remote_zones(cpu))
> +                       work_on_cpu(cpu, refresh_vm_stats, NULL);
> +
> +               cond_resched();
> +       }
> +       put_online_cpus();

While testing this patch-set by enabling the debug config options, I
ran into the following splat:

[  945.149209] ======================================================
[  945.156111] WARNING: possible circular locking dependency detected
[  945.163013] 5.14.0-rc3+ #2 Tainted: G S
[  945.168754] ------------------------------------------------------
[  945.175655] sysctl/6820 is trying to acquire lock:
[  945.181006] ffff8881679efb00
((work_completion)(&wfc.work)){+.+.}-{0:0}, at:
__flush_work+0x5c2/0x8c0
[  945.191332]
[  945.191332] but task is already holding lock:
[  945.197846] ffffffff93b43660 (cpu_hotplug_lock){++++}-{0:0}, at:
vmstat_refresh+0x4a/0x450
[  945.207098]
[  945.207098] which lock already depends on the new lock.
[  945.207098]
[  945.216228]
[  945.216228] the existing dependency chain (in reverse order) is:
[  945.224574]
[  945.224574] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[  945.231488]        lock_acquire+0x1d7/0x540
[  945.236157]        cpus_read_lock+0x3b/0xc0
[  945.240834]        alloc_workqueue+0x884/0xd00
[  945.245800]        scsi_host_alloc+0xbdb/0xf60
[  945.250769]        megasas_probe_one+0x164/0x800 [megaraid_sas]
[  945.257402]        local_pci_probe+0xd8/0x170
[  945.262270]        work_for_cpu_fn+0x51/0xa0
[  945.267041]        process_one_work+0x960/0x16a0
[  945.272200]        worker_thread+0x55e/0xbf0
[  945.276970]        kthread+0x371/0x440
[  945.281158]        ret_from_fork+0x22/0x30
[  945.285737]
[  945.285737] -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[  945.293813]        check_prevs_add+0x3fd/0x2470
[  945.298874]        __lock_acquire+0x23f7/0x2f80
[  945.303934]        lock_acquire+0x1d7/0x540
[  945.308605]        __flush_work+0x5e2/0x8c0
[  945.313278]        work_on_cpu+0xee/0x140
[  945.317753]        vmstat_refresh+0x12f/0x450
[  945.322622]        proc_sys_call_handler+0x389/0x500
[  945.328170]        new_sync_read+0x3af/0x610
[  945.332942]        vfs_read+0x268/0x490
[  945.337225]        ksys_read+0xf1/0x1c0
[  945.341511]        do_syscall_64+0x42/0x90
[  945.346091]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  945.352318]
[  945.352318] other info that might help us debug this:
[  945.352318]
[  945.361254]  Possible unsafe locking scenario:
[  945.361254]
[  945.367863]        CPU0                    CPU1
[  945.372920]        ----                    ----
[  945.377976]   lock(cpu_hotplug_lock);
[  945.382072]
lock((work_completion)(&wfc.work));
[  945.390140]                                lock(cpu_hotplug_lock);
[  945.397046]   lock((work_completion)(&wfc.work));
[  945.402301]
[  945.402301]  *** DEADLOCK ***
[  945.402301]
[  945.408909] 1 lock held by sysctl/6820:
[  945.413194]  #0: ffffffff93b43660 (cpu_hotplug_lock){++++}-{0:0},
at: vmstat_refresh+0x4a/0x450
[  945.422929]
[  945.422929] stack backtrace:
[  945.427793] CPU: 25 PID: 6820 Comm: sysctl Tainted: G S
   5.14.0-rc3+ #2
[  945.436540] Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS
2.6.0 10/31/2017
[  945.444886] Call Trace:
[  945.447623]  dump_stack_lvl+0x44/0x57
[  945.451720]  check_noncircular+0x280/0x320
[  945.456299]  ? print_circular_bug.isra.49+0x440/0x440
[  945.461943]  ? mark_lock.part.54+0x107/0x1370
[  945.466813]  ? mark_lock.part.54+0x107/0x1370
[  945.471683]  ? native_sched_clock+0x32/0x130
[  945.476449]  ? lock_chain_count+0x20/0x20
[  945.480929]  ? sched_clock_cpu+0x151/0x1d0
[  945.485512]  check_prevs_add+0x3fd/0x2470
[  945.489999]  ? native_sched_clock+0x32/0x130
[  945.494770]  ? sched_clock_cpu+0x151/0x1d0
[  945.499347]  ? find_held_lock+0x3a/0x1c0
[  945.503731]  ? check_irq_usage+0xe10/0xe10
[  945.508306]  ? lockdep_lock+0xbf/0x1b0
[  945.512495]  ? static_obj+0xc0/0xc0
[  945.516392]  ? sched_clock_cpu+0x151/0x1d0
[  945.520975]  __lock_acquire+0x23f7/0x2f80
[  945.525461]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  945.530430]  lock_acquire+0x1d7/0x540
[  945.534523]  ? __flush_work+0x5c2/0x8c0
[  945.538811]  ? rcu_read_unlock+0x50/0x50
[  945.543196]  ? native_sched_clock+0x32/0x130
[  945.547969]  ? __queue_work+0x4a3/0xfd0
[  945.552256]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  945.557514]  __flush_work+0x5e2/0x8c0
[  945.561604]  ? __flush_work+0x5c2/0x8c0
[  945.565894]  ? queue_delayed_work_on+0x80/0x80
[  945.570853]  ? lock_downgrade+0x700/0x700
[  945.575339]  ? mark_held_locks+0xb7/0x120
[  945.579829]  ? lockdep_hardirqs_on_prepare+0x28f/0x3e0
[  945.585572]  ? queue_work_on+0x48/0x80
[  945.589763]  ? trace_hardirqs_on+0x32/0x170
[  945.594436]  work_on_cpu+0xee/0x140
[  945.598327]  ? flush_delayed_work+0xc0/0xc0
[  945.603004]  ? work_debug_hint+0x40/0x40
[  945.607388]  ? refresh_cpu_vm_stats+0x530/0x530
[  945.612452]  ? need_update+0x162/0x210
[  945.616646]  vmstat_refresh+0x12f/0x450
[  945.620938]  proc_sys_call_handler+0x389/0x500
[  945.625905]  ? proc_sys_permission+0x120/0x120
[  945.630872]  ? native_sched_clock+0x32/0x130
[  945.635644]  new_sync_read+0x3af/0x610
[  945.639838]  ? __x64_sys_llseek+0x2e0/0x2e0
[  945.644505]  ? native_sched_clock+0x32/0x130
[  945.649290]  ? fsnotify+0xf10/0xf10
[  945.653199]  vfs_read+0x268/0x490
[  945.656913]  ksys_read+0xf1/0x1c0
[  945.660619]  ? vfs_write+0x910/0x910
[  945.664615]  ? syscall_trace_enter.isra.17+0x18c/0x260
[  945.670369]  do_syscall_64+0x42/0x90
[  945.674371]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Maybe we should replace get/put_online_cpus() with cpu_hotplug/enable_disable()?

-- 
Thanks
Nitesh

