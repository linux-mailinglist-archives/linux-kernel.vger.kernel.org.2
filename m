Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F28452805
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhKPCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:52:42 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54000 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355579AbhKPCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:50:20 -0500
Received: by mail-io1-f71.google.com with SMTP id a12-20020a056602148c00b005e7052734adso11901698iow.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ggSrbpqYB0zj9SsUZyI9NLNsrHfPk1tg1OoLy6oiLjQ=;
        b=o5FPfH2z21SkxXlHKsg6GBu5BuTu7b1TD00VMOraFFpPa7KzO9j/AgvysrHHQ9rlPZ
         LQsj+lwg/tW4LKiPysHOLBLzo3AwP9rj767vnTRZEzonX5R7wClGS+1XXviks7w+hX1Q
         e1JBn1iBmUOrtWNZfIPF2RwitLvjuoWxCqicyBTREgGp3F6YbwlidhMJJS+/mAI4BXLz
         Wu3swSIci/tkejdrEZX7nw3hXa1GabitsTkW1pyr5v1161utS/emoOfeMb+rJ6n3/gSH
         fFmvmYK/KjbSD7uyq1vyn8hPhnh50I+iodmkBcTsHQ6FFkjJErc/DWv8nHvKqyoSJDPx
         qptg==
X-Gm-Message-State: AOAM531oDueVuGy4ai3votalWzifxnIlTVs6RzFSO/zdkFdSFc3M6zrX
        7tlHeYS2Jt+AFaJ94vRQ7GYpcwov04PaDNF6iFc9+ydzk39E
X-Google-Smtp-Source: ABdhPJympZ0L4qPdufA9Cnv87splhzoX0/33xFJfHNMKipVFUaXZGWxc3kTvHsHd2nLRUMqqzIB/ji0SCT1h9PUB42wM+4vsAEGP
MIME-Version: 1.0
X-Received: by 2002:a6b:fc11:: with SMTP id r17mr2552701ioh.59.1637030842371;
 Mon, 15 Nov 2021 18:47:22 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d893d805d0def1a0@google.com>
Subject: [syzbot] INFO: task hung in hub_port_init (2)
From:   syzbot <syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ab774587903 Merge tag 'trace-v5.16-5' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6b6d1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com

INFO: task kworker/1:4:7960 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:23576 pid: 7960 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326
 usb_kill_urb+0x1d5/0x310 drivers/usb/core/urb.c:720
 usb_start_wait_urb+0x265/0x530 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2a5/0x4b0 drivers/usb/core/message.c:153
 hub_port_init+0x9f1/0x2df0 drivers/usb/core/hub.c:4829
 hub_port_connect+0xcf8/0x27d0 drivers/usb/core/hub.c:5280
 hub_port_connect_change+0x5f9/0xc20 drivers/usb/core/hub.c:5488
 port_event+0xb67/0x1220 drivers/usb/core/hub.c:5634
 hub_event+0x4ed/0xe40 drivers/usb/core/hub.c:5716
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u4:0/8:
1 lock held by khungtaskd/27:
 #0: ffffffff8cd1da80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6200:
 #0: ffff8880715914f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:990
2 locks held by agetty/6229:
 #0: ffff888024550098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc900028dc2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
5 locks held by kworker/1:4/7960:
 #0: ffff888016717538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x7ca/0x1140
 #1: ffffc9000c1bfd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x808/0x1140 kernel/workqueue.c:2273
 #2: ffff888147758220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888147758220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1b2/0xe40 drivers/usb/core/hub.c:5662
 #3: ffff88814775c5c0 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #3: ffff88814775c5c0 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect+0xce1/0x27d0 drivers/usb/core/hub.c:5279
 #4: ffff888147701168 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_init+0x1ef/0x2df0 drivers/usb/core/hub.c:4703
1 lock held by syz-executor.0/16819:
2 locks held by syz-executor.4/16820:
1 lock held by syz-executor.1/16824:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc82/0xcd0 kernel/hung_task.c:295
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 16715 Comm: kworker/u4:4 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy8 ieee80211_iface_work
RIP: 0010:unwind_done arch/x86/include/asm/unwind.h:50 [inline]
RIP: 0010:__unwind_start+0x61a/0x750 arch/x86/kernel/unwind_orc.c:709
Code: e8 5b 79 95 00 48 8b 44 24 10 48 39 03 0f 83 d4 fa ff ff 4c 89 f7 e8 35 da ff ff 48 b8 00 00 00 00 00 fc ff df 0f b6 44 05 00 <84> c0 75 2d 41 83 3e 00 0f 85 38 ff ff ff e9 aa fa ff ff 44 89 f1
RSP: 0018:ffffc90001b3f3b8 EFLAGS: 00000292
RAX: 0000000000000000 RBX: ffffc90001b3f458 RCX: 0000000080000000
RDX: ffffc90001b3f3b8 RSI: 0000000000000001 RDI: 0000000000000001
RBP: 1ffff92000367e84 R08: dffffc0000000000 R09: ffffc90001b3f470
R10: fffff52000367e90 R11: 0000000000000000 R12: 1ffff92000367e86
R13: ffffc90001b38000 R14: ffffc90001b3f420 R15: ffffc90001b3f428
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd4386b03a4 CR3: 000000003a2bd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xdc/0x140 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x11b/0x1e0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 kmem_cache_alloc_trace+0x9d/0x330 mm/slub.c:3261
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 ieee802_11_parse_elems_crc+0xc7/0x1040 net/mac80211/util.c:1471
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2208 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1605 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x389/0x2b30 net/mac80211/ibss.c:1639
 ieee80211_iface_process_skb net/mac80211/iface.c:1466 [inline]
 ieee80211_iface_work+0x709/0xc90 net/mac80211/iface.c:1520
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0:	e8 5b 79 95 00       	callq  0x957960
   5:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   a:	48 39 03             	cmp    %rax,(%rbx)
   d:	0f 83 d4 fa ff ff    	jae    0xfffffae7
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 35 da ff ff       	callq  0xffffda50
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
  25:	0f b6 44 05 00       	movzbl 0x0(%rbp,%rax,1),%eax
* 2a:	84 c0                	test   %al,%al <-- trapping instruction
  2c:	75 2d                	jne    0x5b
  2e:	41 83 3e 00          	cmpl   $0x0,(%r14)
  32:	0f 85 38 ff ff ff    	jne    0xffffff70
  38:	e9 aa fa ff ff       	jmpq   0xfffffae7
  3d:	44 89 f1             	mov    %r14d,%ecx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
