Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD75F4379A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhJVPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:12:49 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50965 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhJVPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:36 -0400
Received: by mail-il1-f197.google.com with SMTP id o6-20020a92a806000000b002590430fa32so2659948ilh.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dzMScCJzD8KNQMG+U1s3cz7LwmN1H60cRSP1WR9DSAU=;
        b=W3fmC+OExGRE9LlEMkT1Eza31rB4YSuJiXrs41D4puQN5FE2/H8Bf7ZFHXHYbLQx2W
         ZM/35rqkNkOOH+0hllztA4NNQ/Yxn0lPFCyZnEZS+jgGH4iAFeZqXqIrrCLGOeN39KIC
         zLHoazU3ur8c3wd1FcBeoJ5I4ZNrFu6sc9K1zunwR2WHEJtloeLICmVK0O6gPMeJVYQh
         oGeFclVHnXqn2TerfOyBJ/hu2VWKdeFxQ01Sp5WNPtbU0BnL53w1Exayk5XYgnubeX+S
         wIo1ljEqrPW8e3C7oKNhWUVuWkkBJ/8jdYJxrk1nWoHbeGksCecL9Oc7UsDlpyhVUcY9
         +S0Q==
X-Gm-Message-State: AOAM533Xbi77FJknL14okx0cWLGu29YMAZ1I1wq/2W5fKwarzGxs7Ovu
        ovTn0YoP2hALhOem97Y75/osBwUP6u7oNt5LPVHRQLDfiKlx
X-Google-Smtp-Source: ABdhPJz3Xga2wvOl2nVtIgBjjNOfnOQnOXgr7pfe+eaoU1FckeXno8M/38tGxDKHo6lh8RNtbdirz2M3W09PU6R3z0e0wuN7+ZG1
MIME-Version: 1.0
X-Received: by 2002:a6b:6d06:: with SMTP id a6mr108155iod.25.1634915418929;
 Fri, 22 Oct 2021 08:10:18 -0700 (PDT)
Date:   Fri, 22 Oct 2021 08:10:18 -0700
In-Reply-To: <0000000000003cc03505a9c771ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c87fc005cef26865@google.com>
Subject: Re: [syzbot] INFO: task hung in sisusb_open
From:   syzbot <syzbot+fd9d03311cdce9a9ec36@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, thomas@winischhofer.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a3aaf0b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61f4d9af07d3bbdf
dashboard link: https://syzkaller.appspot.com/bug?extid=fd9d03311cdce9a9ec36
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d4e9fcb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1444ada4b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd9d03311cdce9a9ec36@syzkaller.appspotmail.com

INFO: task syz-executor620:7119 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor620 state:D stack:28152 pid: 7119 ppid:  6567 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6c225333c7
RSP: 002b:00007fffa0f54860 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6c225333c7
RDX: 0000000000000002 RSI: 00007fffa0f548e0 RDI: 00000000ffffff9c
RBP: 00007fffa0f548e0 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffa0f5497c R14: 00007fffa0f54990 R15: 00007fffa0f54980
INFO: task syz-executor620:7122 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor620 state:D stack:28152 pid: 7122 ppid:  6568 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6c225333c7
RSP: 002b:00007fffa0f54860 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6c225333c7
RDX: 0000000000000002 RSI: 00007fffa0f548e0 RDI: 00000000ffffff9c
RBP: 00007fffa0f548e0 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffa0f5497c R14: 00007fffa0f54990 R15: 00007fffa0f54980
INFO: task syz-executor620:7125 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor620 state:D stack:27872 pid: 7125 ppid:  6566 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6c225333c7
RSP: 002b:00007fffa0f54860 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6c225333c7
RDX: 0000000000000002 RSI: 00007fffa0f548e0 RDI: 00000000ffffff9c
RBP: 00007fffa0f548e0 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffa0f5497c R14: 00007fffa0f54990 R15: 00007fffa0f54980
INFO: task syz-executor620:7128 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor620 state:D stack:28016 pid: 7128 ppid:  6562 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
 usb_open+0x204/0x2e0 drivers/usb/core/file.c:48
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6c225333c7
RSP: 002b:00007fffa0f54860 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6c225333c7
RDX: 0000000000000002 RSI: 00007fffa0f548e0 RDI: 00000000ffffff9c
RBP: 00007fffa0f548e0 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffa0f5497c R14: 00007fffa0f54990 R15: 00007fffa0f54980

Showing all locks held in the system:
6 locks held by kworker/0:0/5:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90000ca7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff8881462ac220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff8881462ac220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88801213b220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88801213b220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88801cec41a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88801cec41a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/1:1/25:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90000dffdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff88814663e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88814663e220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff888019b39220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff888019b39220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff8881477ae1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8881477ae1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
1 lock held by khungtaskd/27:
 #0: ffffffff8b981b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
6 locks held by kworker/0:2/1266:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc900051efdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff8881462a4220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff8881462a4220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88801213a220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88801213a220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff88801bc171a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff88801bc171a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/1:3/2951:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc9000c74fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff888146672220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888146672220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88801258d220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88801258d220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff8880121921a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8880121921a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/1:0/6579:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90002cefdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff888146675220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888146675220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88801258e220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88801258e220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff8880121911a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff8880121911a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
6 locks held by kworker/1:2/6583:
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:634 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8880143e4138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x8a3/0x16b0 kernel/workqueue.c:2268
 #1: ffffc90002c97db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff88801eb01220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88801eb01220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4330 drivers/usb/core/hub.c:5662
 #3: ffff88801258f220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88801258f220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #4: ffff888025ad01a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #4: ffff888025ad01a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:944
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x7e0 drivers/usb/core/file.c:156
2 locks held by syz-executor620/7116:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88801be198d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor620/7119:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88801be198d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor620/7122:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88801be198d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor620/7125:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88801be198d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
2 locks held by syz-executor620/7128:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39
 #1: ffff88801be198d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
1 lock held by syz-executor620/7150:
 #0: ffffffff8c81f970 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x24/0x2e0 drivers/usb/core/file.c:39

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 2960 Comm: systemd-journal Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:84 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xc8/0x180 mm/kasan/generic.c:189
Code: 38 00 74 ed 48 8d 50 08 eb 09 48 83 c0 01 48 39 d0 74 7a 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 <48> 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 80 38 00
RSP: 0018:ffffc90002b9faa0 EFLAGS: 00000083
RAX: fffffbfff1f9ff42 RBX: fffffbfff1f9ff43 RCX: ffffffff815bcd56
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8fcffa10
RBP: fffffbfff1f9ff42 R08: 0000000000000000 R09: ffffffff8fcffa17
R10: fffffbfff1f9ff42 R11: 0000000000000000 R12: ffff88807b585fa0
R13: ffff88807b585580 R14: 0000000000050000 R15: 00000000000501a1
FS:  00007f57954e18c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57928e0000 CR3: 000000002507b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 hlock_class kernel/locking/lockdep.c:199 [inline]
 check_wait_context kernel/locking/lockdep.c:4688 [inline]
 __lock_acquire+0x3e6/0x54a0 kernel/locking/lockdep.c:4965
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __might_fault mm/memory.c:5262 [inline]
 __might_fault+0x106/0x180 mm/memory.c:5247
 strncpy_from_user+0x2f/0x3e0 lib/strncpy_from_user.c:117
 getname_flags.part.0+0x95/0x4f0 fs/namei.c:149
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x8e/0xd0 fs/namei.c:217
 do_sys_openat2+0xf5/0x4d0 fs/open.c:1194
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_open fs/open.c:1224 [inline]
 __se_sys_open fs/open.c:1220 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1220
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5794a70840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffd068716a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffd068719b0 RCX: 00007f5794a70840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 000055871d1a48d0
RBP: 000000000000000d R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000055871d197040 R14: 00007ffd06871970 R15: 000055871d1a46f0
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.187 msecs
----------------
Code disassembly (best guess):
   0:	38 00                	cmp    %al,(%rax)
   2:	74 ed                	je     0xfffffff1
   4:	48 8d 50 08          	lea    0x8(%rax),%rdx
   8:	eb 09                	jmp    0x13
   a:	48 83 c0 01          	add    $0x1,%rax
   e:	48 39 d0             	cmp    %rdx,%rax
  11:	74 7a                	je     0x8d
  13:	80 38 00             	cmpb   $0x0,(%rax)
  16:	74 f2                	je     0xa
  18:	48 89 c2             	mov    %rax,%rdx
  1b:	b8 01 00 00 00       	mov    $0x1,%eax
  20:	48 85 d2             	test   %rdx,%rdx
  23:	75 56                	jne    0x7b
  25:	5b                   	pop    %rbx
  26:	5d                   	pop    %rbp
  27:	41 5c                	pop    %r12
  29:	c3                   	retq
* 2a:	48 85 d2             	test   %rdx,%rdx <-- trapping instruction
  2d:	74 5e                	je     0x8d
  2f:	48 01 ea             	add    %rbp,%rdx
  32:	eb 09                	jmp    0x3d
  34:	48 83 c0 01          	add    $0x1,%rax
  38:	48 39 d0             	cmp    %rdx,%rax
  3b:	74 50                	je     0x8d
  3d:	80 38 00             	cmpb   $0x0,(%rax)

