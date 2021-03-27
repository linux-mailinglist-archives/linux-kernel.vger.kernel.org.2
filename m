Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D136234B8A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhC0RxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230344AbhC0RxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616867597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuK5LSqkkGC/ZZ9eL0MJo3qzj56HGnSLKarGfZ3Dkz8=;
        b=YCvd8R3U7GhjxLIeZYStuc/C9iTmeaC/A4uRIXRazMTnBJdKC8UGp4y0/m1S7K+ddTEgmd
        wdXNrLKzlTGaFIn2TRLXLLTwRcoUimRK9f3Er2xlZP947VaNRjn94v+S1zNeuCwhhiquz/
        W7NtQ1H5ycqNPVnqvhvIzFf/FD0euHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Jia4pOo6PCyz6-OTgurjLA-1; Sat, 27 Mar 2021 13:53:13 -0400
X-MC-Unique: Jia4pOo6PCyz6-OTgurjLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BED9180FCA1;
        Sat, 27 Mar 2021 17:53:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5713F60C5C;
        Sat, 27 Mar 2021 17:53:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 27 Mar 2021 18:53:10 +0100 (CET)
Date:   Sat, 27 Mar 2021 18:53:08 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        peterz@infradead.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in register_for_each_vma
Message-ID: <20210327175307.GA12212@redhat.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327042150.7460-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

it seems that you already understand the problem ;) I don't.

Could you explain in details how double __register is possible ? and how
it connects to this lockdep report?

On 03/27, Hillf Danton wrote:
>
> On Fri, 26 Mar 2021 03:29:19
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0d02ec6b Linux 5.12-rc4
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1719e4aad00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5adab0bdee099d7a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b804f902bbb6bcf290cb
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.12.0-rc4-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.3/23522 is trying to acquire lock:
> > ffffffff8c03e530 (dup_mmap_sem){++++}-{0:0}, at: register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
> > 
> > but task is already holding lock:
> > ffff8880624a8c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #3 (&uprobe->register_rwsem){+.+.}-{3:3}:
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
> > -> #2 (event_mutex){+.+.}-{3:3}:
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
> > -> #1 (&mm->mmap_lock#2){++++}-{3:3}:
> >        down_write_killable+0x95/0x170 kernel/locking/rwsem.c:1417
> >        mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
> >        dup_mmap kernel/fork.c:480 [inline]
> >        dup_mm+0x12e/0x1380 kernel/fork.c:1368
> >        copy_mm kernel/fork.c:1424 [inline]
> >        copy_process+0x2b99/0x7150 kernel/fork.c:2107
> >        kernel_clone+0xe7/0xab0 kernel/fork.c:2500
> >        __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
> >        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > -> #0 (dup_mmap_sem){++++}-{0:0}:
> >        check_prev_add kernel/locking/lockdep.c:2936 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3059 [inline]
> >        validate_chain kernel/locking/lockdep.c:3674 [inline]
> >        __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
> >        lock_acquire kernel/locking/lockdep.c:5510 [inline]
> >        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
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
> > other info that might help us debug this:
> > 
> > Chain exists of:
> >   dup_mmap_sem --> event_mutex --> &uprobe->register_rwsem
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&uprobe->register_rwsem);
> >                                lock(event_mutex);
> >                                lock(&uprobe->register_rwsem);
> >   lock(dup_mmap_sem);
> > 
> >  *** DEADLOCK ***
> > 
> > 3 locks held by syz-executor.3/23522:
> >  #0: ffffffff8fe4fcd8 (&pmus_srcu){....}-{0:0}, at: perf_event_alloc.part.0+0xc8e/0x3960 kernel/events/core.c:11401
> >  #1: ffffffff8bfe5688 (event_mutex){+.+.}-{3:3}, at: perf_uprobe_init+0x164/0x210 kernel/trace/trace_event_perf.c:335
> >  #2: ffff8880624a8c90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: __uprobe_register+0x531/0x850 kernel/events/uprobes.c:1177
> > 
> > stack backtrace:
> > CPU: 0 PID: 23522 Comm: syz-executor.3 Not tainted 5.12.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> >  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
> >  check_prev_add kernel/locking/lockdep.c:2936 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3059 [inline]
> >  validate_chain kernel/locking/lockdep.c:3674 [inline]
> >  __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
> >  lock_acquire kernel/locking/lockdep.c:5510 [inline]
> >  lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
> >  percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
> >  register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
> >  __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
> >  trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
> >  probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
> >  trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
> >  perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
> >  perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:204
> >  perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
> >  perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
> >  perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
> >  perf_init_event kernel/events/core.c:11123 [inline]
> >  perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
> >  perf_event_alloc kernel/events/core.c:11785 [inline]
> >  __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Add a flag and check it to avoid double registering of uprobe.
> 
> --- x/kernel/events/uprobes.c
> +++ y/kernel/events/uprobes.c
> @@ -51,6 +51,7 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem)
>  
>  /* Have a copy of original instruction */
>  #define UPROBE_COPY_INSN	0
> +#define UPROBE_REGISTERING	1
>  
>  struct uprobe {
>  	struct rb_node		rb_node;	/* node in the rb tree */
> @@ -1170,6 +1171,9 @@ static int __uprobe_register(struct inod
>  	if (IS_ERR(uprobe))
>  		return PTR_ERR(uprobe);
>  
> +	/* no point to register twice at the cost of deadlock */
> +	if (test_and_set_bit(UPROBE_REGISTERING, &uprobe->flags))
> +		return 0;
>  	/*
>  	 * We can race with uprobe_unregister()->delete_uprobe().
>  	 * Check uprobe_is_active() and retry if it is false.
> @@ -1183,6 +1187,7 @@ static int __uprobe_register(struct inod
>  			__uprobe_unregister(uprobe, uc);
>  	}
>  	up_write(&uprobe->register_rwsem);
> +	clear_bit(UPROBE_REGISTERING, &uprobe->flags);
>  	put_uprobe(uprobe);
>  
>  	if (unlikely(ret == -EAGAIN))
> 

