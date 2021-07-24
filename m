Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C893D48FB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhGXRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhGXRQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:16:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC99860E8B;
        Sat, 24 Jul 2021 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627149447;
        bh=ON6IpEe5E41fsYVjufdCUZYUE6AD4bGNybxwb4ajXho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJEO3EjaXj40mtZg7SxsDTQDQ3EYBItZ+eVQmyQcQNW0y+w7OFRpbBj+57noMQG4P
         x62NJ2xHQtfKw4iiEfGN1HbveBGJYjENTN1UQ/uSTPI9lLoJYhL/ermtu32ADYk1qf
         uYt/P5too6ezDWTX6uwYdCDn39jeJjDw25ycu74/B4Br0RG9u+9RferotS1EQf/MUM
         f995nJZLdfUd0bWiHh86U+DcZnClef+T+GjUIg1pRVuWF+SNV/79CgQupn8xvwRYfi
         uZd7hvGAN+mMwqpIKhAgyBao0reG57vsUe5FUfZQbDcaoeOssxgrjC5S+yQCaoXphx
         S4GbP7+9G0Xbg==
Date:   Sat, 24 Jul 2021 19:57:24 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in put_ucounts
Message-ID: <20210724175724.6uijkfnxuenvfzu3@example.org>
References: <000000000000efe97f05c74bb995@google.com>
 <20210719094432.425-1-hdanton@sina.com>
 <87czretdwm.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czretdwm.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:24:41PM -0500, Eric W. Biederman wrote:
> Hillf Danton <hdanton@sina.com> writes:
> 
> > On Fri, 16 Jul 2021 23:22:19 -0700
> >>syzbot found the following issue on:
> >>
> >>HEAD commit:    3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
> >>git tree:       upstream
> >>console output: https://syzkaller.appspot.com/x/log.txt?x=1541de9c300000
> >>kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
> >>dashboard link: https://syzkaller.appspot.com/bug?extid=b6e65bd125a05f803d6b
> >>userspace arch: i386
> >>
> >>Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >>IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>Reported-by: syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com
> >>
> >>==================================================================
> >>BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >>BUG: KASAN: use-after-free in atomic_dec_and_test include/asm-generic/atomic-instrumented.h:542 [inline]
> >>BUG: KASAN: use-after-free in put_ucounts+0x1c/0x150 kernel/ucount.c:196
> >>Write of size 4 at addr ffff88801c86cc1c by task kworker/u4:3/166
> >>
> >>CPU: 0 PID: 166 Comm: kworker/u4:3 Not tainted 5.13.0-syzkaller #0
> >>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >>Workqueue: bat_events batadv_nc_worker
> >>Call Trace:
> >> <IRQ>
> >> __dump_stack lib/dump_stack.c:79 [inline]
> >> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
> >> print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
> >> __kasan_report mm/kasan/report.c:419 [inline]
> >> kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
> >> check_region_inline mm/kasan/generic.c:183 [inline]
> >> kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
> >> instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >> atomic_dec_and_test include/asm-generic/atomic-instrumented.h:542 [inline]
> >> put_ucounts+0x1c/0x150 kernel/ucount.c:196
> >> put_cred_rcu+0x27a/0x520 kernel/cred.c:124
> >> rcu_do_batch kernel/rcu/tree.c:2558 [inline]
> >> rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2793
> >> __do_softirq+0x29b/0x9bd kernel/softirq.c:558
> >> invoke_softirq kernel/softirq.c:432 [inline]
> >> __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
> >> irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
> >> sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
> >> </IRQ>
> >> asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> >>RIP: 0010:lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5593
> >>Code: e1 a6 7e 83 f8 01 0f 85 a6 02 00 00 9c 58 f6 c4 02 0f 85 91 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
> >>RSP: 0018:ffffc900010bfba8 EFLAGS: 00000206
> >>RAX: dffffc0000000000 RBX: 1ffff92000217f77 RCX: 3f6e7590f6a9846c
> >>RDX: 1ffff1100283613d RSI: 0000000000000000 RDI: 0000000000000000
> >>RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff9049d8a7
> >>R10: fffffbfff2093b14 R11: 0000000000000000 R12: 0000000000000002
> >>R13: 0000000000000000 R14: ffffffff8c17bb80 R15: 0000000000000000
> >> rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
> >> rcu_read_lock include/linux/rcupdate.h:671 [inline]
> >> batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:404 [inline]
> >> batadv_nc_worker+0x12d/0xe50 net/batman-adv/network-coding.c:715
> >> process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
> >> worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
> >> kthread+0x3e5/0x4d0 kernel/kthread.c:319
> >> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>
> >>Allocated by task 8622:
> >> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >> kasan_set_track mm/kasan/common.c:46 [inline]
> >> set_alloc_info mm/kasan/common.c:434 [inline]
> >> ____kasan_kmalloc mm/kasan/common.c:513 [inline]
> >> ____kasan_kmalloc mm/kasan/common.c:472 [inline]
> >> __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
> >> kmalloc include/linux/slab.h:591 [inline]
> >> kzalloc include/linux/slab.h:721 [inline]
> >> alloc_ucounts+0x23d/0x5b0 kernel/ucount.c:169
> >> set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
> >> copy_creds+0x853/0xb20 kernel/cred.c:375
> >> copy_process+0x1413/0x74c0 kernel/fork.c:1992
> >> kernel_clone+0xe7/0xab0 kernel/fork.c:2509
> >> __do_compat_sys_ia32_clone+0xac/0xe0 arch/x86/kernel/sys_ia32.c:254
> >> do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >> do_int80_syscall_32+0x46/0x90 arch/x86/entry/common.c:132
> >> entry_INT80_compat+0x71/0x76 arch/x86/entry/entry_64_compat.S:413
> >>
> >>Last potentially related work creation:
> >> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >> kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
> >> insert_work+0x48/0x370 kernel/workqueue.c:1332
> >> __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
> >> queue_work_on+0xee/0x110 kernel/workqueue.c:1525
> >> queue_work include/linux/workqueue.h:507 [inline]
> >> call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
> >> kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
> >> kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
> >> uevent_store+0x20/0x50 drivers/base/core.c:2370
> >> dev_attr_store+0x50/0x80 drivers/base/core.c:2071
> >> sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
> >> kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
> >> call_write_iter include/linux/fs.h:2114 [inline]
> >> new_sync_write+0x426/0x650 fs/read_write.c:518
> >> vfs_write+0x796/0xa30 fs/read_write.c:605
> >> ksys_write+0x12d/0x250 fs/read_write.c:658
> >> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >> entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >>Second to last potentially related work creation:
> >> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
> >> kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
> >> insert_work+0x48/0x370 kernel/workqueue.c:1332
> >> __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
> >> queue_work_on+0xee/0x110 kernel/workqueue.c:1525
> >> queue_work include/linux/workqueue.h:507 [inline]
> >> call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
> >> kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
> >> kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
> >> uevent_store+0x42/0x90 drivers/base/bus.c:585
> >> drv_attr_store+0x6d/0xa0 drivers/base/bus.c:77
> >> sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
> >> kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
> >> call_write_iter include/linux/fs.h:2114 [inline]
> >> new_sync_write+0x426/0x650 fs/read_write.c:518
> >> vfs_write+0x796/0xa30 fs/read_write.c:605
> >> ksys_write+0x12d/0x250 fs/read_write.c:658
> >> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >> entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >>The buggy address belongs to the object at ffff88801c86cc00
> >> which belongs to the cache kmalloc-192 of size 192
> >>The buggy address is located 28 bytes inside of
> >> 192-byte region [ffff88801c86cc00, ffff88801c86ccc0)
> >>The buggy address belongs to the page:
> >>page:ffffea0000721b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801c86cc00 pfn:0x1c86c
> >>flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> >>raw: 00fff00000000200 ffffea00009f0e48 ffffea00009cd188 ffff888011041a00
> >>raw: ffff88801c86cc00 000000000010000b 00000001ffffffff 0000000000000000
> >>page dumped because: kasan: bad access detected
> >>page_owner tracks the page as allocated
> >>page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 7975119940, free_ts 7474437105
> >> prep_new_page mm/page_alloc.c:2445 [inline]
> >> get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4178
> >> __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
> >> alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
> >> alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
> >> alloc_slab_page mm/slub.c:1702 [inline]
> >> allocate_slab+0x32b/0x4c0 mm/slub.c:1842
> >> new_slab mm/slub.c:1905 [inline]
> >> new_slab_objects mm/slub.c:2651 [inline]
> >> ___slab_alloc+0x4ba/0x820 mm/slub.c:2814
> >> __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2854
> >> slab_alloc_node mm/slub.c:2936 [inline]
> >> slab_alloc mm/slub.c:2978 [inline]
> >> kmem_cache_alloc_trace+0x325/0x3c0 mm/slub.c:2995
> >> kmalloc include/linux/slab.h:591 [inline]
> >> kzalloc include/linux/slab.h:721 [inline]
> >> call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
> >> kobject_uevent_env+0xf73/0x1650 lib/kobject_uevent.c:614
> >> device_add+0xb71/0x2100 drivers/base/core.c:3305
> >> register_virtio_device+0x1e1/0x2c0 drivers/virtio/virtio.c:363
> >> virtio_pci_probe+0x203/0x390 drivers/virtio/virtio_pci_common.c:552
> >> local_pci_probe+0xdb/0x190 drivers/pci/pci-driver.c:309
> >> pci_call_probe drivers/pci/pci-driver.c:366 [inline]
> >> __pci_device_probe drivers/pci/pci-driver.c:391 [inline]
> >> pci_device_probe+0x3dd/0x6f0 drivers/pci/pci-driver.c:434
> >> really_probe+0x291/0xf60 drivers/base/dd.c:576
> >>page last free stack trace:
> >> reset_page_owner include/linux/page_owner.h:24 [inline]
> >> free_pages_prepare mm/page_alloc.c:1355 [inline]
> >> free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1406
> >> free_unref_page_prepare mm/page_alloc.c:3341 [inline]
> >> free_unref_page+0x19/0x690 mm/page_alloc.c:3420
> >> __vunmap+0x783/0xb70 mm/vmalloc.c:2569
> >> free_work+0x58/0x70 mm/vmalloc.c:80
> >> process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
> >> worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
> >> kthread+0x3e5/0x4d0 kernel/kthread.c:319
> >> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>
> >>Memory state around the buggy address:
> >> ffff88801c86cb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> ffff88801c86cb80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
> >>>ffff88801c86cc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >>                            ^
> >> ffff88801c86cc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >> ffff88801c86cd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>==================================================================
> >
> > To fix the uaf, add a couple of changes. Now only for thoughts.
> 
> >
> > 1/ s/atomic_add_negative/atomic_inc_not_zero/ to correct the get
> > method.
> 
> I really don't think so.  The use of atomic_add_negative is very
> deliberate.  Changing that fundamentally changes the algorithm into used
> to keep track of things.  Definitely not something to lead with.
> 
> Before it even makes sense to talk about how to change the code,
> a plausible explanation for how a use after free happens is needed.
> 
> That explanation should account for the fact this code was in linux-next
> the since last -rc1 without any kind of issue with the test code.
> 
> Did something change in the test infrastructure?  Is there another
> bug that is stomping memory and making it look like this code is buggy?
> 
> I haven't had a chance to dig in in detail (everyone in my house is
> sick).  I am hoping that Alexey Gladkov will have that time soon.

It's better to look at another report. I think it illustrates
regression better:

https://syzkaller.appspot.com/bug?id=edc996c68de05701cbd709b1ee99344defb94334

Hillf Danton is right about race condition. The situation is rare because
most often alloc_ucounts() and put_ucounts() are executed under rcu lock.
I spent a few days but couldn't reproduce it.

I did this regression in the b6c336528926 ("Use atomic_t for ucounts
reference counting"). Before to this, the reference count check was under
spin_lock. Now spin_lock in alloc_ucounts() doesn't protect find_ucounts()
from parallel put_ucounts().

Atomically increasing the reference count solves the problem between
get_accounts() and put_accounts(), but find_ucounts() is not protected.

We need to either return spin_lock to the beginning of put_ucounts(), or
recycle alloc_ucounts().

> What I can say is that a solution that leads with your code is
> fundamentally misdesigned and everything needs to change, and there
> is no explanation for why it all needs to change is probably not a
> solution to the problem.

The proposed patch is incorrect because in case of an overflow of the
reference count in find_get_ucounts(), we will get a counter leak.

-- 
Rgrds, legion

