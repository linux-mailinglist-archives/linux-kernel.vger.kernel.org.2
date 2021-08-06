Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2833E2237
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhHFDjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:39:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54006 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhHFDjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:39:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:43532)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBqh5-000wbJ-64; Thu, 05 Aug 2021 21:38:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57952 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mBqh3-00DcAB-F7; Thu, 05 Aug 2021 21:38:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
Date:   Thu, 05 Aug 2021 22:38:05 -0500
In-Reply-To: <20210806021052.3013-1-hdanton@sina.com> (Hillf Danton's message
        of "Fri, 6 Aug 2021 10:10:52 +0800")
Message-ID: <87r1f7450i.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mBqh3-00DcAB-F7;;;mid=<87r1f7450i.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/c4isPmQq2ieYjHOxiuYJvm0ixUt1COaE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Hillf Danton <hdanton@sina.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1076 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (1.2%), b_tie_ro: 11 (1.0%), parse: 2.2 (0.2%),
         extract_message_metadata: 37 (3.4%), get_uri_detail_list: 14 (1.3%),
        tests_pri_-1000: 43 (4.0%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 126 (11.7%), check_bayes:
        123 (11.4%), b_tokenize: 30 (2.8%), b_tok_get_all: 22 (2.0%),
        b_comp_prob: 6 (0.5%), b_tok_touch_all: 60 (5.6%), b_finish: 1.23
        (0.1%), tests_pri_0: 831 (77.2%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 8 (0.7%), poll_dns_idle: 0.76 (0.1%), tests_pri_10:
        3.7 (0.3%), tests_pri_500: 12 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> writes:

> On Thu, 05 Aug 2021 12:15:24 -0500 Eric W. Biederman wrote:
>>
>>Please pull the for-v5.14 branch from the git tree:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14
>>
>>  HEAD: 345daff2e994ee844d6a609c37f085695fbb4c4d ucounts: Fix race condition between alloc_ucounts and put_ucounts
>>
>>This is just one patch on top of v5.14-rc3 that fixes a subtle locking
>>versus reference counting bug in the ucount changes, found by syzbot
>>after you merged this code.
>>
>>The ucount sysctls have a issue on big endian architectures that I hope
>>to get in before v5.14 is released but a patch is not ready yet.
>>
>>Eric
>>
>>
>>>From 345daff2e994ee844d6a609c37f085695fbb4c4d Mon Sep 17 00:00:00 2001
>>From: Alexey Gladkov <legion@kernel.org>
>>Date: Tue, 27 Jul 2021 17:24:18 +0200
>>Subject: [PATCH] ucounts: Fix race condition between alloc_ucounts and put_ucounts
>>
>>The race happens because put_ucounts() doesn't use spinlock and
>>get_ucounts is not under spinlock:
>>
>>CPU0                    CPU1
>>----                    ----
>>alloc_ucounts()         put_ucounts()
>>
>>spin_lock_irq(&ucounts_lock);
>>ucounts = find_ucounts(ns, uid, hashent);
>>
>>                        atomic_dec_and_test(&ucounts->count))
>>
>>spin_unlock_irq(&ucounts_lock);
>>
>>                        spin_lock_irqsave(&ucounts_lock, flags);
>>                        hlist_del_init(&ucounts->node);
>>                        spin_unlock_irqrestore(&ucounts_lock, flags);
>>                        kfree(ucounts);
>>
>>ucounts = get_ucounts(ucounts);
>>
>>==================================================================
>>BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>>BUG: KASAN: use-after-free in atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
>>BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:152 [inline]
>>BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:150 [inline]
>>BUG: KASAN: use-after-free in alloc_ucounts+0x19b/0x5b0 kernel/ucount.c:188
>>Write of size 4 at addr ffff88802821e41c by task syz-executor.4/16785
>>
>>CPU: 1 PID: 16785 Comm: syz-executor.4 Not tainted 5.14.0-rc1-next-20210712-syzkaller #0
>>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>Call Trace:
>> __dump_stack lib/dump_stack.c:88 [inline]
>> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>> print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
>> __kasan_report mm/kasan/report.c:419 [inline]
>> kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
>> check_region_inline mm/kasan/generic.c:183 [inline]
>> kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>> instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>> atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
>> get_ucounts kernel/ucount.c:152 [inline]
>> get_ucounts kernel/ucount.c:150 [inline]
>> alloc_ucounts+0x19b/0x5b0 kernel/ucount.c:188
>> set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
>> __sys_setuid+0x285/0x400 kernel/sys.c:623
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>RIP: 0033:0x4665d9
>>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>>RSP: 002b:00007fde54097188 EFLAGS: 00000246 ORIG_RAX: 0000000000000069
>>RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
>>RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000ff
>>RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
>>R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
>>R13: 00007ffc8655740f R14: 00007fde54097300 R15: 0000000000022000
>>
>>Allocated by task 16784:
>> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>> kasan_set_track mm/kasan/common.c:46 [inline]
>> set_alloc_info mm/kasan/common.c:434 [inline]
>> ____kasan_kmalloc mm/kasan/common.c:513 [inline]
>> ____kasan_kmalloc mm/kasan/common.c:472 [inline]
>> __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
>> kmalloc include/linux/slab.h:591 [inline]
>> kzalloc include/linux/slab.h:721 [inline]
>> alloc_ucounts+0x23d/0x5b0 kernel/ucount.c:169
>> set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
>> __sys_setuid+0x285/0x400 kernel/sys.c:623
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>>Freed by task 16785:
>> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>> kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>> kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
>> ____kasan_slab_free mm/kasan/common.c:366 [inline]
>> ____kasan_slab_free mm/kasan/common.c:328 [inline]
>> __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
>> kasan_slab_free include/linux/kasan.h:229 [inline]
>> slab_free_hook mm/slub.c:1650 [inline]
>> slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1675
>> slab_free mm/slub.c:3235 [inline]
>> kfree+0xeb/0x650 mm/slub.c:4295
>> put_ucounts kernel/ucount.c:200 [inline]
>> put_ucounts+0x117/0x150 kernel/ucount.c:192
>> put_cred_rcu+0x27a/0x520 kernel/cred.c:124
>> rcu_do_batch kernel/rcu/tree.c:2550 [inline]
>> rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2785
>> __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>>
>>Last potentially related work creation:
>> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>> kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
>> insert_work+0x48/0x370 kernel/workqueue.c:1332
>> __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
>> queue_work_on+0xee/0x110 kernel/workqueue.c:1525
>> queue_work include/linux/workqueue.h:507 [inline]
>> call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
>> kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
>> netdev_queue_add_kobject net/core/net-sysfs.c:1621 [inline]
>> netdev_queue_update_kobjects+0x374/0x450 net/core/net-sysfs.c:1655
>> register_queue_kobjects net/core/net-sysfs.c:1716 [inline]
>> netdev_register_kobject+0x35a/0x430 net/core/net-sysfs.c:1959
>> register_netdevice+0xd33/0x1500 net/core/dev.c:10331
>> nsim_init_netdevsim drivers/net/netdevsim/netdev.c:317 [inline]
>> nsim_create+0x381/0x4d0 drivers/net/netdevsim/netdev.c:364
>> __nsim_dev_port_add+0x32e/0x830 drivers/net/netdevsim/dev.c:1295
>> nsim_dev_port_add_all+0x53/0x150 drivers/net/netdevsim/dev.c:1355
>> nsim_dev_probe+0xcb5/0x1190 drivers/net/netdevsim/dev.c:1496
>> call_driver_probe drivers/base/dd.c:517 [inline]
>> really_probe+0x23c/0xcd0 drivers/base/dd.c:595
>> __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
>> driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
>> __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
>> bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
>> __device_attach+0x228/0x4a0 drivers/base/dd.c:965
>> bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
>> device_add+0xc2f/0x2180 drivers/base/core.c:3356
>> nsim_bus_dev_new drivers/net/netdevsim/bus.c:431 [inline]
>> new_device_store+0x436/0x710 drivers/net/netdevsim/bus.c:298
>> bus_attr_store+0x72/0xa0 drivers/base/bus.c:122
>> sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>> kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>> call_write_iter include/linux/fs.h:2152 [inline]
>> new_sync_write+0x426/0x650 fs/read_write.c:518
>> vfs_write+0x75a/0xa40 fs/read_write.c:605
>> ksys_write+0x12d/0x250 fs/read_write.c:658
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>>Second to last potentially related work creation:
>> kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>> kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
>> insert_work+0x48/0x370 kernel/workqueue.c:1332
>> __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
>> queue_work_on+0xee/0x110 kernel/workqueue.c:1525
>> queue_work include/linux/workqueue.h:507 [inline]
>> call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
>> kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
>> kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
>> uevent_store+0x20/0x50 drivers/base/core.c:2371
>> dev_attr_store+0x50/0x80 drivers/base/core.c:2072
>> sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
>> kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
>> call_write_iter include/linux/fs.h:2152 [inline]
>> new_sync_write+0x426/0x650 fs/read_write.c:518
>> vfs_write+0x75a/0xa40 fs/read_write.c:605
>> ksys_write+0x12d/0x250 fs/read_write.c:658
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>>The buggy address belongs to the object at ffff88802821e400
>> which belongs to the cache kmalloc-192 of size 192
>>The buggy address is located 28 bytes inside of
>> 192-byte region [ffff88802821e400, ffff88802821e4c0)
>>The buggy address belongs to the page:
>>page:ffffea0000a08780 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2821e
>>flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
>>raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010841a00
>>raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
>>page dumped because: kasan: bad access detected
>>page_owner tracks the page as allocated
>>page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 12874702440, free_ts 12637793385
>> prep_new_page mm/page_alloc.c:2433 [inline]
>> get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4166
>> __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5374
>> alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2119
>> alloc_pages+0x238/0x2a0 mm/mempolicy.c:2242
>> alloc_slab_page mm/slub.c:1713 [inline]
>> allocate_slab+0x32b/0x4c0 mm/slub.c:1853
>> new_slab mm/slub.c:1916 [inline]
>> new_slab_objects mm/slub.c:2662 [inline]
>> ___slab_alloc+0x4ba/0x820 mm/slub.c:2825
>> __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2865
>> slab_alloc_node mm/slub.c:2947 [inline]
>> slab_alloc mm/slub.c:2989 [inline]
>> __kmalloc+0x312/0x330 mm/slub.c:4133
>> kmalloc include/linux/slab.h:596 [inline]
>> kzalloc include/linux/slab.h:721 [inline]
>> __register_sysctl_table+0x112/0x1090 fs/proc/proc_sysctl.c:1318
>> rds_tcp_init_net+0x1db/0x4f0 net/rds/tcp.c:551
>> ops_init+0xaf/0x470 net/core/net_namespace.c:140
>> __register_pernet_operations net/core/net_namespace.c:1137 [inline]
>> register_pernet_operations+0x35a/0x850 net/core/net_namespace.c:1214
>> register_pernet_device+0x26/0x70 net/core/net_namespace.c:1301
>> rds_tcp_init+0x77/0xe0 net/rds/tcp.c:717
>> do_one_initcall+0x103/0x650 init/main.c:1285
>> do_initcall_level init/main.c:1360 [inline]
>> do_initcalls init/main.c:1376 [inline]
>> do_basic_setup init/main.c:1396 [inline]
>> kernel_init_freeable+0x6b8/0x741 init/main.c:1598
>>page last free stack trace:
>> reset_page_owner include/linux/page_owner.h:24 [inline]
>> free_pages_prepare mm/page_alloc.c:1343 [inline]
>> free_pcp_prepare+0x312/0x7d0 mm/page_alloc.c:1394
>> free_unref_page_prepare mm/page_alloc.c:3329 [inline]
>> free_unref_page+0x19/0x690 mm/page_alloc.c:3408
>> __vunmap+0x783/0xb70 mm/vmalloc.c:2587
>> free_work+0x58/0x70 mm/vmalloc.c:82
>> process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
>> worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
>> kthread+0x3e5/0x4d0 kernel/kthread.c:319
>> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>
>>Memory state around the buggy address:
>> ffff88802821e300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff88802821e380: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>>>ffff88802821e400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                            ^
>> ffff88802821e480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> ffff88802821e500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>==================================================================
>>
>>- The race fix has two parts.
>>  * Changing the code to guarantee that ucounts->count is only decremented
>>    when ucounts_lock is held.  This guarantees that find_ucounts
>>    will never find a structure with a zero reference count.
>>  * Changing alloc_ucounts to increment ucounts->count while
>>    ucounts_lock is held.  This guarantees the reference count on the
>>    found data structure will not be decremented to zero (and the data
>>    structure freed) before the reference count is incremented.
>>  -- Eric Biederman
>>
>>Reported-by: syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com
>>Reported-by: syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com
>>Reported-by: syzbot+6cd79f45bb8fa1c9eeae@syzkaller.appspotmail.com
>>Reported-by: syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com
>>Fixes: b6c336528926 ("Use atomic_t for ucounts reference counting")
>>Cc: Hillf Danton <hdanton@sina.com>
>>Signed-off-by: Alexey Gladkov <legion@kernel.org>
>>Link: https://lkml.kernel.org/r/7b2ace1759b281cdd2d66101d6b305deef722efb.1627397820.git.legion@kernel.org
>>Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>>---
>> kernel/ucount.c | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>
>>diff --git a/kernel/ucount.c b/kernel/ucount.c
>>index 87799e2379bd..77be3bbe3cc4 100644
>>--- a/kernel/ucount.c
>>+++ b/kernel/ucount.c
>>@@ -160,6 +160,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>> {
>> 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
>> 	struct ucounts *ucounts, *new;
>>+	long overflow;
>> 
>> 	spin_lock_irq(&ucounts_lock);
>> 	ucounts = find_ucounts(ns, uid, hashent);
>>@@ -184,8 +185,12 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
>> 			return new;
>> 		}
>> 	}
>>+	overflow = atomic_add_negative(1, &ucounts->count);
>> 	spin_unlock_irq(&ucounts_lock);
>>-	ucounts = get_ucounts(ucounts);
>>+	if (overflow) {
>>+		put_ucounts(ucounts);
>>+		return NULL;
>>+	}
>> 	return ucounts;
>> }
>> 
>>@@ -193,8 +198,7 @@ void put_ucounts(struct ucounts *ucounts)
>> {
>> 	unsigned long flags;
>> 
>>-	if (atomic_dec_and_test(&ucounts->count)) {
>>-		spin_lock_irqsave(&ucounts_lock, flags);
>>+	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
>
> If get_ucounts() runs on another CPU after locking ucounts_lock on the
> current CPU,
>
> 	if (ucounts && atomic_add_negative(1, &ucounts->count))
> 		return ucounts;
>
> UAF will happen again.

I think you are saying if someone calls get_ucounts without knowing the
reference count is at least one a user after free will happen.  It is a
bug to call get_ucounts unless it is known the reference count is at
least one.

> Is it too late to update the fix, Eric?

It would require a separate fix.  Probably that fix needs to be finding
fixing the logic where something calls get_ucounts when the reference
count is zero.

Eric
