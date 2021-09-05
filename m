Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3638400E5F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 07:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbhIEFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 01:22:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38840 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhIEFWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 01:22:11 -0400
Received: by mail-il1-f200.google.com with SMTP id j6-20020a056e02014600b00224bde51e20so2029115ilr.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 22:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NWf+5xldcIKicXDKhgBMbUv+I42tUuA2/dCHxrGc6Cw=;
        b=LJXxhC0Tvk1k0X7OGTMnDyA81qxVYsJ9bddTw29T4PkCfdzEKeE/NfdvZeqgOMKe9F
         KkuC8s/8ojCKJ5jGGGOtQx44ikfU+jCSaADUsg44FLzmolT6BdENbZvlCpBSsn6iSqxC
         SSWXC6Rf3faw344O24+neD+4c7Bssb/g9b6OKPeTg9BHLvxuCniJwGc6ehhzC4LuLc81
         zH1JgYo+C4ALB9BhwyhV2scTWd1eJMNWIO9tcXHJJJxMoRbT60pI2GZWSFTSANxH5GQB
         S3Vh2EsDs5OqvLUqRDIvM+rcH8XK4iZfI0wnNf0Mc3Ulm8j2Ao61hxZ/EKQB6mXS9npM
         wqxA==
X-Gm-Message-State: AOAM530cvkIQkwZ6F6Ngc84BauZvXZ9OENxt/+7mvRfR/CDP19YEvBOK
        /BG+g87hshQMswJSYLlm8qmU3iO/dbHEIa7vjN2zAveKJaqK
X-Google-Smtp-Source: ABdhPJx3cp9BWRTXs+pqTa6EinJmcb9km/9IdHrDAA9mMmJr1u6sRcgdUyfecRIUYDg36U9ebRhdOdHd8TIjYx5ot+/8/01ZdJbz
MIME-Version: 1.0
X-Received: by 2002:a02:7f11:: with SMTP id r17mr5663701jac.94.1630819268783;
 Sat, 04 Sep 2021 22:21:08 -0700 (PDT)
Date:   Sat, 04 Sep 2021 22:21:08 -0700
In-Reply-To: <20210905022044.3176-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035730005cb38b3a5@google.com>
Subject: Re: [syzbot] INFO: task hung in __lru_add_drain_all
From:   syzbot <syzbot+a9b681dcbc06eb2bca04@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in synchronize_rcu

INFO: task kworker/u4:4:135 blocked for more than 143 seconds.
      Not tainted 5.14.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:26552 pid:  135 ppid:     2 flags:0x00004000
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __synchronize_srcu+0x1f4/0x290 kernel/rcu/srcutree.c:930
 fsnotify_connector_destroy_workfn+0x49/0xa0 fs/notify/mark.c:164
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 process_scheduled_works kernel/workqueue.c:2360 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2446
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task kworker/u4:6:852 blocked for more than 144 seconds.
      Not tainted 5.14.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:6    state:D stack:25784 pid:  852 ppid:     2 flags:0x00004000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __synchronize_srcu+0x1f4/0x290 kernel/rcu/srcutree.c:930
 fsnotify_mark_destroy_workfn+0xfd/0x340 fs/notify/mark.c:860
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 process_scheduled_works kernel/workqueue.c:2360 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2446
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 1634 Comm: khungtaskd Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: kworker/u4:2 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lock_acquire+0x33/0x510 kernel/locking/lockdep.c:5593
Code: df 41 57 41 89 f7 41 56 49 89 fe 41 55 41 89 d5 41 54 41 89 cc 55 44 89 c5 53 48 81 ec b0 00 00 00 48 8d 5c 24 10 4c 89 0c 24 <48> c7 44 24 10 b3 8a b5 41 48 c1 eb 03 48 c7 44 24 18 ca d8 14 8b
RSP: 0018:ffffc90000e2fba0 EFLAGS: 00000286
RAX: dffffc0000000000 RBX: ffffc90000e2fbb0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8b97f960
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff88d220e1 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8b97f960 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6d467a718 CR3: 000000002bece000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:410 [inline]
 batadv_nc_worker+0x12d/0xfa0 net/batman-adv/network-coding.c:721
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess):
   0:	df 41 57             	filds  0x57(%rcx)
   3:	41 89 f7             	mov    %esi,%r15d
   6:	41 56                	push   %r14
   8:	49 89 fe             	mov    %rdi,%r14
   b:	41 55                	push   %r13
   d:	41 89 d5             	mov    %edx,%r13d
  10:	41 54                	push   %r12
  12:	41 89 cc             	mov    %ecx,%r12d
  15:	55                   	push   %rbp
  16:	44 89 c5             	mov    %r8d,%ebp
  19:	53                   	push   %rbx
  1a:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
  21:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
  26:	4c 89 0c 24          	mov    %r9,(%rsp)
* 2a:	48 c7 44 24 10 b3 8a 	movq   $0x41b58ab3,0x10(%rsp) <-- trapping instruction
  31:	b5 41
  33:	48 c1 eb 03          	shr    $0x3,%rbx
  37:	48 c7 44 24 18 ca d8 	movq   $0xffffffff8b14d8ca,0x18(%rsp)
  3e:	14 8b


Tested on:

commit:         49624efa Merge tag 'denywrite-for-5.15' of git://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16810735300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=faed7df0f442c217
dashboard link: https://syzkaller.appspot.com/bug?extid=a9b681dcbc06eb2bca04
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d0a286300000

