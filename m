Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A03F2D65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhHTNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:49:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33112 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhHTNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:49:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:39506)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mH4tF-00HXA5-BX; Fri, 20 Aug 2021 07:48:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:49876 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mH4tD-00DuRv-T4; Fri, 20 Aug 2021 07:48:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     syzbot <syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com>,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000f2d84305c74bb986@google.com>
        <000000000000b1f4d305c9ef72ad@google.com>
        <20210820100916.oyjwyteskvbxwyvg@example.org>
Date:   Fri, 20 Aug 2021 08:44:32 -0500
In-Reply-To: <20210820100916.oyjwyteskvbxwyvg@example.org> (Alexey Gladkov's
        message of "Fri, 20 Aug 2021 12:09:16 +0200")
Message-ID: <878s0wtem7.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mH4tD-00DuRv-T4;;;mid=<878s0wtem7.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PfeqPpz/p0FjgpqZUTcp0z921uJDX5Ag=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 855 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.5%), b_tie_ro: 3.1 (0.4%), parse: 1.46
        (0.2%), extract_message_metadata: 18 (2.1%), get_uri_detail_list: 6
        (0.8%), tests_pri_-1000: 11 (1.3%), tests_pri_-950: 0.95 (0.1%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 118 (13.8%), check_bayes:
        115 (13.5%), b_tokenize: 19 (2.2%), b_tok_get_all: 16 (1.8%),
        b_comp_prob: 3.3 (0.4%), b_tok_touch_all: 74 (8.6%), b_finish: 0.67
        (0.1%), tests_pri_0: 689 (80.6%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.7 (0.3%), poll_dns_idle: 1.12 (0.1%), tests_pri_10:
        1.86 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] KASAN: use-after-free Write in dec_rlimit_ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Thu, Aug 19, 2021 at 01:32:22PM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    d6d09a694205 Merge tag 'for-5.14-rc6-tag' of git://git.ker..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16c8081e300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=01985d7909f9468f013c
>> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d0ec1e300000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1516c341300000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com
>> 
>> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000004ca4cc
>> RBP: 00000000004ca4c0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004ca4cc
>> R13: 00007fffffe0b62f R14: 00007f1054173400 R15: 0000000000022000
>> ==================================================================
>> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>> BUG: KASAN: use-after-free in atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
>> BUG: KASAN: use-after-free in atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
>> BUG: KASAN: use-after-free in dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:279
>> Write of size 8 at addr ffff888025b8ef80 by task syz-executor668/8707
>> 
>> CPU: 1 PID: 8707 Comm: syz-executor668 Not tainted 5.14.0-rc6-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
>>  print_address_description+0x66/0x3b0 mm/kasan/report.c:233
>>  __kasan_report mm/kasan/report.c:419 [inline]
>>  kasan_report+0x163/0x210 mm/kasan/report.c:436
>>  check_region_inline mm/kasan/generic.c:135 [inline]
>>  kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
>>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>>  atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
>>  atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
>>  dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:279
>>  release_task+0x2d3/0x1590 kernel/exit.c:191
>
> void release_task(struct task_struct *p)
> {
> ...
> 	/* don't need to get the RCU readlock here - the process is dead and
> 	 * can't be modifying its own credentials. But shut RCU-lockdep up */
> 	rcu_read_lock();
> 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
> 	rcu_read_unlock();
> ...
> }
>
> It looks like the ucounts have been released before this in the put_cred_rcu().

That should not be.

After that in release_task there is:

put_task_struct_rcu_user
  delayed_put_task_struct
     put_task_struct
        __put_task_struct
           exit_creds
              put_cred
                 __put_cred
                    put_cred_rcu
                       put_ucounts

So there very much should be a valid cred reference at that point.

>>  exit_notify kernel/exit.c:699 [inline]
>>  do_exit+0x1aa2/0x2510 kernel/exit.c:845
>>  do_group_exit+0x168/0x2d0 kernel/exit.c:922
>>  get_signal+0x16b0/0x2080 kernel/signal.c:2808
>>  arch_do_signal_or_restart+0x8e/0x6d0 arch/x86/kernel/signal.c:865
>>  handle_signal_work kernel/entry/common.c:148 [inline]
>>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>>  exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:209
>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>>  syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:302
>>  do_syscall_64+0x4c/0xb0 arch/x86/entry/common.c:86
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x445a69
>> Code: Unable to access opcode bytes at RIP 0x445a3f.
>> RSP: 002b:00007f1054173318 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
>> RAX: fffffffffffffff2 RBX: 00000000004ca4c8 RCX: 0000000000445a69
>> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000004ca4cc
>> RBP: 00000000004ca4c0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004ca4cc
>> R13: 00007fffffe0b62f R14: 00007f1054173400 R15: 0000000000022000
>> 
>> Allocated by task 8441:
>>  kasan_save_stack mm/kasan/common.c:38 [inline]
>>  kasan_set_track mm/kasan/common.c:46 [inline]
>>  set_alloc_info mm/kasan/common.c:434 [inline]
>>  ____kasan_kmalloc+0xc4/0xf0 mm/kasan/common.c:513
>>  kasan_kmalloc include/linux/kasan.h:264 [inline]
>>  kmem_cache_alloc_trace+0x96/0x340 mm/slub.c:2986
>>  kmalloc include/linux/slab.h:591 [inline]
>>  kzalloc include/linux/slab.h:721 [inline]
>>  alloc_ucounts+0x1b1/0x5d0 kernel/ucount.c:173
>>  set_cred_ucounts+0x220/0x2d0 kernel/cred.c:684
>>  __sys_setresuid+0x6d5/0x920 kernel/sys.c:702
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> 
>> Freed by task 13:
>>  kasan_save_stack mm/kasan/common.c:38 [inline]
>>  kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
>>  kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
>>  ____kasan_slab_free+0x109/0x150 mm/kasan/common.c:366
>>  kasan_slab_free include/linux/kasan.h:230 [inline]
>>  slab_free_hook mm/slub.c:1628 [inline]
>>  slab_free_freelist_hook+0x1d8/0x290 mm/slub.c:1653
>>  slab_free mm/slub.c:3213 [inline]
>>  kfree+0xcf/0x2e0 mm/slub.c:4267
>>  put_ucounts+0x15c/0x1a0 kernel/ucount.c:207
>>  put_cred_rcu+0x221/0x400 kernel/cred.c:124
>>  rcu_do_batch kernel/rcu/tree.c:2550 [inline]
>>  rcu_core+0x906/0x14b0 kernel/rcu/tree.c:2785
>>  __do_softirq+0x372/0x783 kernel/softirq.c:558
>> 
>> Last potentially related work creation:
>>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
>>  kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
>>  insert_work+0x54/0x400 kernel/workqueue.c:1332
>>  __queue_work+0x928/0xc60 kernel/workqueue.c:1498
>>  queue_work_on+0x111/0x200 kernel/workqueue.c:1525
>>  queue_work include/linux/workqueue.h:507 [inline]
>>  call_usermodehelper_exec+0x283/0x470 kernel/umh.c:435
>>  kobject_uevent_env+0x1337/0x1700 lib/kobject_uevent.c:618
>>  device_add+0x1073/0x1790 drivers/base/core.c:3336
>>  device_create_groups_vargs drivers/base/core.c:4014 [inline]
>>  device_create+0x241/0x2d0 drivers/base/core.c:4056
>>  vc_allocate+0x66a/0x780 drivers/tty/vt/vt.c:1157
>>  con_install+0x9f/0x880 drivers/tty/vt/vt.c:3342
>>  tty_driver_install_tty drivers/tty/tty_io.c:1315 [inline]
>>  tty_init_dev+0xc6/0x4c0 drivers/tty/tty_io.c:1429
>>  tty_open_by_driver drivers/tty/tty_io.c:2098 [inline]
>>  tty_open+0x89a/0xdd0 drivers/tty/tty_io.c:2146
>>  chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
>>  do_dentry_open+0x7cb/0x1020 fs/open.c:826
>>  do_open fs/namei.c:3374 [inline]
>>  path_openat+0x27e7/0x36b0 fs/namei.c:3507
>>  do_filp_open+0x253/0x4d0 fs/namei.c:3534
>>  do_sys_openat2+0x124/0x460 fs/open.c:1204
>>  do_sys_open fs/open.c:1220 [inline]
>>  __do_sys_open fs/open.c:1228 [inline]
>>  __se_sys_open fs/open.c:1224 [inline]
>>  __x64_sys_open+0x221/0x270 fs/open.c:1224
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> 
>> Second to last potentially related work creation:
>>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
>>  kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
>>  insert_work+0x54/0x400 kernel/workqueue.c:1332
>>  __queue_work+0x928/0xc60 kernel/workqueue.c:1498
>>  queue_work_on+0x111/0x200 kernel/workqueue.c:1525
>>  queue_work include/linux/workqueue.h:507 [inline]
>>  call_usermodehelper_exec+0x283/0x470 kernel/umh.c:435
>>  kobject_uevent_env+0x1337/0x1700 lib/kobject_uevent.c:618
>>  kobject_synth_uevent+0x3bf/0x900 lib/kobject_uevent.c:208
>>  uevent_store+0x20/0x60 drivers/base/core.c:2372
>>  kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
>>  call_write_iter include/linux/fs.h:2114 [inline]
>>  new_sync_write fs/read_write.c:518 [inline]
>>  vfs_write+0xa39/0xc90 fs/read_write.c:605
>>  ksys_write+0x171/0x2a0 fs/read_write.c:658
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> 
>> The buggy address belongs to the object at ffff888025b8ef00
>>  which belongs to the cache kmalloc-192 of size 192
>> The buggy address is located 128 bytes inside of
>>  192-byte region [ffff888025b8ef00, ffff888025b8efc0)
>> The buggy address belongs to the page:
>> page:ffffea000096e380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25b8e
>> flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
>> raw: 00fff00000000200 ffffea00005dac80 0000000c0000000c ffff888011041a00
>> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> page_owner tracks the page as allocated
>> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 9979944008, free_ts 0
>>  prep_new_page mm/page_alloc.c:2436 [inline]
>>  get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4169
>>  __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5391
>>  alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2119
>>  alloc_slab_page mm/slub.c:1691 [inline]
>>  allocate_slab+0xf1/0x540 mm/slub.c:1831
>>  new_slab mm/slub.c:1894 [inline]
>>  new_slab_objects mm/slub.c:2640 [inline]
>>  ___slab_alloc+0x1cf/0x350 mm/slub.c:2803
>>  __slab_alloc mm/slub.c:2843 [inline]
>>  slab_alloc_node mm/slub.c:2925 [inline]
>>  slab_alloc mm/slub.c:2967 [inline]
>>  kmem_cache_alloc_trace+0x29d/0x340 mm/slub.c:2984
>>  kmalloc include/linux/slab.h:591 [inline]
>>  kzalloc include/linux/slab.h:721 [inline]
>>  call_usermodehelper_setup+0x8a/0x260 kernel/umh.c:365
>>  kobject_uevent_env+0x1311/0x1700 lib/kobject_uevent.c:614
>>  device_add+0x1073/0x1790 drivers/base/core.c:3336
>>  __video_register_device+0x37fc/0x4580 drivers/media/v4l2-core/v4l2-dev.c:1036
>>  video_register_device include/media/v4l2-dev.h:384 [inline]
>>  vivid_create_devnodes drivers/media/test-drivers/vivid/vivid-core.c:1585 [inline]
>>  vivid_create_instance+0x85df/0xac90 drivers/media/test-drivers/vivid/vivid-core.c:1946
>>  vivid_probe+0x9a/0x140 drivers/media/test-drivers/vivid/vivid-core.c:2001
>>  platform_probe+0x130/0x1b0 drivers/base/platform.c:1427
>>  call_driver_probe+0x96/0x250 drivers/base/dd.c:517
>>  really_probe+0x223/0x9b0 drivers/base/dd.c:595
>>  __driver_probe_device+0x1f8/0x3e0 drivers/base/dd.c:747
>> page_owner free stack trace missing
>> 
>> Memory state around the buggy address:
>>  ffff888025b8ee80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>  ffff888025b8ef00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >ffff888025b8ef80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>                    ^
>>  ffff888025b8f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  ffff888025b8f080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
>> ==================================================================
>> 
