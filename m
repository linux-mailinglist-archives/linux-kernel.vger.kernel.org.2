Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF136D84F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhD1NbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhD1NbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:31:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92378613F7;
        Wed, 28 Apr 2021 13:30:20 +0000 (UTC)
Date:   Wed, 28 Apr 2021 09:30:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [syzbot] possible deadlock in vm_mmap_pgoff
Message-ID: <20210428093018.70c3888b@gandalf.local.home>
In-Reply-To: <20210428061522.1841-1-hdanton@sina.com>
References: <000000000000217d7005c0f5c6b1@google.com>
        <20210428061522.1841-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 14:15:22 +0800
Hillf Danton <hdanton@sina.com> wrote:

> On Tue, 27 Apr 2021 08:18:27 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    7af08140 Revert "gcov: clang: fix clang-11+ build"
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17d57dfed00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=76c0382ceab56d34
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f619f7c0a2a5f87694e6
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.12.0-rc8-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.1/16055 is trying to acquire lock:
> > ffffffff8bfe2bc8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x23/0xf0 kernel/trace/trace_event_perf.c:241
> > 
> > but task is already holding lock:
> > ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
> > ffff88801b887258 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0x15c/0x290 mm/util.c:517
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> >   
> > -> #3 (&mm->mmap_lock#2){++++}-{3:3}:  
> >        down_write_killable+0x95/0x170 kernel/locking/rwsem.c:1417
> >        mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
> >        dup_mmap kernel/fork.c:480 [inline]
> >        dup_mm+0x12e/0x1380 kernel/fork.c:1368
> >        copy_mm kernel/fork.c:1424 [inline]
> >        copy_process+0x2bc8/0x71a0 kernel/fork.c:2113
> >        kernel_clone+0xe7/0xab0 kernel/fork.c:2500
> >        __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   
> > -> #2 (dup_mmap_sem){++++}-{0:0}:  
> >        percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
> >        register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
> >        __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
> >        trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
> >        probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
> >        trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
> >        perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
> >        perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
> >        perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
> >        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
> >        perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
> >        perf_init_event kernel/events/core.c:11123 [inline]
> >        perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
> >        perf_event_alloc kernel/events/core.c:11785 [inline]
> >        __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   
> > -> #1 (&uprobe->register_rwsem){+.+.}-{3:3}:  
> >        down_write+0x92/0x150 kernel/locking/rwsem.c:1406
> >        __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177
> >        trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
> >        probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
> >        trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
> >        perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
> >        perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
> >        perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
> >        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
> >        perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
> >        perf_init_event kernel/events/core.c:11123 [inline]
> >        perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
> >        perf_event_alloc kernel/events/core.c:11785 [inline]
> >        __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   
> > -> #0 (event_mutex){+.+.}-{3:3}:  
> >        check_prev_add kernel/locking/lockdep.c:2937 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3060 [inline]
> >        validate_chain kernel/locking/lockdep.c:3675 [inline]
> >        __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4901
> >        lock_acquire kernel/locking/lockdep.c:5511 [inline]
> >        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
> >        __mutex_lock_common kernel/locking/mutex.c:949 [inline]
> >        __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
> >        perf_trace_destroy+0x23/0xf0 kernel/trace/trace_event_perf.c:241
> >        _free_event+0x2ee/0x1380 kernel/events/core.c:4863
> >        put_event kernel/events/core.c:4957 [inline]
> >        perf_mmap_close+0x572/0xe10 kernel/events/core.c:6002
> >        remove_vma+0xae/0x170 mm/mmap.c:180
> >        remove_vma_list mm/mmap.c:2653 [inline]
> >        __do_munmap+0x74f/0x11a0 mm/mmap.c:2909
> >        do_munmap mm/mmap.c:2917 [inline]
> >        munmap_vma_range mm/mmap.c:598 [inline]
> >        mmap_region+0x85a/0x1730 mm/mmap.c:1750
> >        do_mmap+0xcff/0x11d0 mm/mmap.c:1581
> >        vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
> >        ksys_mmap_pgoff+0x49c/0x620 mm/mmap.c:1632
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >   event_mutex --> dup_mmap_sem --> &mm->mmap_lock#2
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&mm->mmap_lock#2);
> >                                lock(dup_mmap_sem);
> >                                lock(&mm->mmap_lock#2);
> >   lock(event_mutex);
> > 
> >  *** DEADLOCK ***  
> 
> Break the lock chain by asking kworker to destroy perf event.
> Thoughts other than workqueue are appreciated.

I think this could cause a problem with the delay.

This is called from event->destroy()


	if (event->destroy)
		event->destroy(event);
	module_put(pmu->module);

What if this event is in that module, and we just unloaded it?

Then the workqueue would try to modify the module text that no longer
exists. Right?

I Cc'd some people that understand this code better.

-- Steve


> 
> +++ x/kernel/trace/trace_event_perf.c
> @@ -236,14 +236,22 @@ int perf_trace_init(struct perf_event *p
>  	return ret;
>  }
>  
> -void perf_trace_destroy(struct perf_event *p_event)
> +static void perf_trace_destroy_work_fn(struct work_struct *w)
>  {
> +	struct perf_event *p_event = container_of(w, struct perf_event,
> +							destroy_work);
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
>  	mutex_unlock(&event_mutex);
>  }
>  
> +void perf_trace_destroy(struct perf_event *p_event)
> +{
> +	INIT_WORK(&p_event->destroy_work, perf_trace_destroy_work_fn);
> +	queue_work(system_unbound_wq, &p_event->destroy_work);
> +}
> +
>  #ifdef CONFIG_KPROBE_EVENTS
>  int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>  {

