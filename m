Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7031AB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBMMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:39:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:50873 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBMMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:38:57 -0500
Received: by mail-io1-f71.google.com with SMTP id w15so2168970ioa.17
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 04:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C1gWOFZ3LUWUwfkgBVELlLLy2AUVbK2Ir0q3Ltv8MdA=;
        b=ECyCt/Wk+974LZS4qgg1em1ojMOjLJpVpdO8fKWigfHSx2i1T9ydfnMRlxIqAgVscp
         /4SJ6HnB+vGlfcww1r5qqQEb3PXlFov0W8pm1XugMcw9JlDTvhEsqQtF4sIPFlLmJwa3
         uQv0XMm9PEGt10+uoTUHLiw5DRVEtfD9Tu8Ne7C4gHnsuSEDj9yzwlNYGaqgvj8Z35kx
         kHoInkOOP/Aun9Jh+c5skQI/U838xsKn33imFjhHQO2cwUro8s7Uzp3AI9+XJVpA4ERn
         uv4C17uUEzDxtu1SY0M1kOtuIfChXgQzsHrpXG2gt7vvu0QzsOsznu+nMG0jKhy7bR9j
         TNzQ==
X-Gm-Message-State: AOAM532GEIN+yNsFWl316AtReLapls2MIyI58bWzSuuvxkaWCgMRsczF
        ArhKJaKS2HY3S2mhYhQBymed16o0UIZaFPqQT787b8zp+bw5
X-Google-Smtp-Source: ABdhPJzjhL7v/wXxVWMu4Eyzcb5wHVy/qPoiOgeakkANFHZ4YE8uYjzysG6Ea44vl6dVb5kRNSVzXw5gTXm7pBy4J+fG/MKCQeC0
MIME-Version: 1.0
X-Received: by 2002:a02:aa89:: with SMTP id u9mr7031391jai.38.1613219896097;
 Sat, 13 Feb 2021 04:38:16 -0800 (PST)
Date:   Sat, 13 Feb 2021 04:38:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9ff3a05bb37069e@google.com>
Subject: INFO: task hung in misc_open (4)
From:   syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e0756cfc Merge tag 'trace-v5.11-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147e449cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1106b4b91e8dfab8
dashboard link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e1dacd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af25e4d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com

INFO: task syz-executor487:8574 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor487 state:D stack:28112 pid: 8574 ppid:  8479 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5216
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_openat fs/open.c:1204 [inline]
 __se_sys_openat fs/open.c:1199 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4031a7
RSP: 002b:00007ffd77c5adc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00000000004031a7
RDX: 0000000000000002 RSI: 000000000048803b RDI: 00000000ffffff9c
RBP: 000000000048803b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd77c5ceec R14: 0000000000000076 R15: 00007ffd77c5cef0
INFO: task syz-executor487:8631 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor487 state:D stack:27912 pid: 8631 ppid:  8480 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5216
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_openat fs/open.c:1204 [inline]
 __se_sys_openat fs/open.c:1199 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4031a7
RSP: 002b:00007ffd77c5adc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00000000004031a7
RDX: 0000000000000002 RSI: 000000000048803b RDI: 00000000ffffff9c
RBP: 000000000048803b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd77c5ceec R14: 0000000000000076 R15: 00007ffd77c5cef0
INFO: task syz-executor487:8634 blocked for more than 143 seconds.
      Not tainted 5.11.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor487 state:D stack:28160 pid: 8634 ppid:  8475 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5216
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_openat fs/open.c:1204 [inline]
 __se_sys_openat fs/open.c:1199 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4031a7
RSP: 002b:00007ffd77c5adc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00000000004031a7
RDX: 0000000000000002 RSI: 000000000048803b RDI: 00000000ffffff9c
RBP: 000000000048803b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd77c5ceec R14: 0000000000000076 R15: 00007ffd77c5cef0
INFO: task syz-executor487:8668 blocked for more than 144 seconds.
      Not tainted 5.11.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor487 state:D stack:28160 pid: 8668 ppid:  8477 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5216
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_openat fs/open.c:1204 [inline]
 __se_sys_openat fs/open.c:1199 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4031a7
RSP: 002b:00007ffd77c5adc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00000000004031a7
RDX: 0000000000000002 RSI: 000000000048803b RDI: 00000000ffffff9c
RBP: 000000000048803b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd77c5ceec R14: 0000000000000076 R15: 00007ffd77c5cef0
INFO: task syz-executor487:8679 blocked for more than 144 seconds.
      Not tainted 5.11.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor487 state:D stack:28160 pid: 8679 ppid:  8478 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:5216
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x81a/0x1110 kernel/locking/mutex.c:1103
 misc_open+0x55/0x4a0 drivers/char/misc.c:107
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3254 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3371
 do_filp_open+0x17e/0x3c0 fs/namei.c:3398
 do_sys_openat2+0x16d/0x420 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_openat fs/open.c:1204 [inline]
 __se_sys_openat fs/open.c:1199 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4031a7
RSP: 002b:00007ffd77c5adc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000440 RCX: 00000000004031a7
RDX: 0000000000000002 RSI: 000000000048803b RDI: 00000000ffffff9c
RBP: 000000000048803b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffd77c5ceec R14: 0000000000000076 R15: 00007ffd77c5cef0

Showing all locks held in the system:
5 locks held by kworker/1:0/19:
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc90000d97da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff88801ccb9218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #2: ffff88801ccb9218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4320 drivers/usb/core/hub.c:5537
 #3: ffff8881441ce218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #3: ffff8881441ce218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
 #4: ffff8881418921a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #4: ffff8881418921a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
1 lock held by khungtaskd/1657:
 #0: ffffffff8bd73da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6259
5 locks held by kworker/0:2/3000:
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc90001887da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff88801cc79218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #2: ffff88801cc79218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4320 drivers/usb/core/hub.c:5537
 #3: ffff888147549218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #3: ffff888147549218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
 #4: ffff88814402f1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #4: ffff88814402f1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
5 locks held by kworker/0:4/4909:
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc900016d7da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff88801cd51218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #2: ffff88801cd51218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4320 drivers/usb/core/hub.c:5537
 #3: ffff88814745c218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #3: ffff88814745c218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
 #4: ffff888140e6d1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #4: ffff888140e6d1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
1 lock held by in:imklog/8184:
 #0: ffff888018fa34f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:947
5 locks held by kworker/1:1/8486:
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc9000175fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff888144669218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #2: ffff888144669218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4320 drivers/usb/core/hub.c:5537
 #3: ffff888019edc218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #3: ffff888019edc218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
 #4: ffff88814748c1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #4: ffff88814748c1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
5 locks held by kworker/1:2/8499:
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888015a52538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x871/0x15f0 kernel/workqueue.c:2246
 #1: ffffc90001a27da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x15f0 kernel/workqueue.c:2250
 #2: ffff888144611218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #2: ffff888144611218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4320 drivers/usb/core/hub.c:5537
 #3: ffff88814404a218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #3: ffff88814404a218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
 #4: ffff8881438b01a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:737 [inline]
 #4: ffff8881438b01a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0 drivers/base/dd.c:889
1 lock held by syz-executor487/8574:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor487/8631:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor487/8634:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor487/8668:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
1 lock held by syz-executor487/8679:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
2 locks held by syz-executor487/8683:
 #0: ffffffff8c752b48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x55/0x4a0 drivers/char/misc.c:107
 #1: ffffffff8bc45148 (system_transition_mutex){+.+.}-{3:3}, at: snapshot_open+0x3b/0x2a0 kernel/power/user.c:54

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1657 Comm: khungtaskd Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd43/0xfa0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:110 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_idle_do_entry+0x1c9/0x250 drivers/acpi/processor_idle.c:516


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
