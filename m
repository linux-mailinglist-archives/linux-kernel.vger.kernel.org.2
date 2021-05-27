Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2639297F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhE0I0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:26:01 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36604 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0IZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:25:57 -0400
Received: by mail-il1-f198.google.com with SMTP id w10-20020a056e021c8ab02901bb7c1adfa1so2731209ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s8GwG3dIVbArB28FmUQQibTN5cRvKFBSK38RO0GpilI=;
        b=EFpRIYwVzt2yE1k0gFjw/+u+dN7JM8K/Hx16gFRSxKzRTpaLiwg6kz6YBJ2pIf7X4h
         5VhJ+deRo7LzhftrA+9c/fIjZkYKolK5q5XRNFPZs5scXb23Fp6tDdqNg+vAr5SbXYCL
         obS2naFr2xWu16EZHw/meDti2nUNU6soxJiHOq3bflShuDbP1+ktJDmPZRGAq6eWOVI6
         vCmm9vaHMiXPbu5oEEyQS01H22E73g/SEBQiW9G8SHHaKS7l2Cc7x77d/H/A/GUCwL6k
         y6cSo4BjtIO+vesSw46QRIDjCBqZ8+ZCNHmbzPA5ZxuqxFDmNXLktnCRxWzS3rlU0/kb
         05Aw==
X-Gm-Message-State: AOAM531/7PYh1l0pjpix0XHiFntQbmnlkluZFDURKKdLFmtijs9J4xYV
        rIcN+77pnTHd+vYohIU/CF18/fDEiMHqOvdWy+c4gs73D/Hj
X-Google-Smtp-Source: ABdhPJyIWTDxmJQL/Mmg65zNIphk/UwUjrUCN3LDmy9R+Gnbs7j3ijv9rcZkCRxsc70XHV8hF+4m9smE2Av080u9sVzixlHQLRFK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:130f:: with SMTP id g15mr2096070ilr.73.1622103865048;
 Thu, 27 May 2021 01:24:25 -0700 (PDT)
Date:   Thu, 27 May 2021 01:24:25 -0700
In-Reply-To: <000000000000f32b3c05958ed0eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa42ce05c34b7c28@google.com>
Subject: Re: [syzbot] INFO: task hung in register_netdevice_notifier (2)
From:   syzbot <syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1660d517d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=355f8edb2ff45d5f95fa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cc630fd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com

INFO: task syz-executor.0:16395 blocked for more than 143 seconds.
      Not tainted 5.13.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:25952 pid:16395 ppid: 16156 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0x916/0x23e0 kernel/sched/core.c:5147
 schedule+0xcf/0x270 kernel/sched/core.c:5226
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 register_netdevice_notifier+0x1e/0x260 net/core/dev.c:1902
 bcm_init+0x1a3/0x210 net/can/bcm.c:1451
 can_create+0x27c/0x4d0 net/can/af_can.c:168
 __sock_create+0x3de/0x780 net/socket.c:1408
 sock_create net/socket.c:1459 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1501
 __do_sys_socket net/socket.c:1510 [inline]
 __se_sys_socket net/socket.c:1508 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1508
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
RSP: 002b:00007f7e1ffa7188 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 000000000000001d
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc744b4b1f R14: 00007f7e1ffa7300 R15: 0000000000022000
INFO: task syz-executor.0:16400 blocked for more than 143 seconds.
      Not tainted 5.13.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29408 pid:16400 ppid: 16156 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0x916/0x23e0 kernel/sched/core.c:5147
 schedule+0xcf/0x270 kernel/sched/core.c:5226
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 register_netdevice_notifier+0x1e/0x260 net/core/dev.c:1902
 bcm_init+0x1a3/0x210 net/can/bcm.c:1451
 can_create+0x27c/0x4d0 net/can/af_can.c:168
 __sock_create+0x3de/0x780 net/socket.c:1408
 sock_create net/socket.c:1459 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1501
 __do_sys_socket net/socket.c:1510 [inline]
 __se_sys_socket net/socket.c:1508 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1508
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
RSP: 002b:00007f7e1ff44188 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 000000000056c1a8 RCX: 00000000004665d9
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 000000000000001d
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c1a8
R13: 00007ffc744b4b1f R14: 00007f7e1ff44300 R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1627:
 #0: ffffffff8bf79320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6333
1 lock held by in:imklog/8277:
 #0: ffff888030e12870 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
3 locks held by kworker/u4:2/14373:
1 lock held by syz-executor.0/16395:
 #0: ffffffff8d691f10 (pernet_ops_rwsem){++++}-{3:3}, at: register_netdevice_notifier+0x1e/0x260 net/core/dev.c:1902
1 lock held by syz-executor.0/16400:
 #0: ffffffff8d691f10 (pernet_ops_rwsem){++++}-{3:3}, at: register_netdevice_notifier+0x1e/0x260 net/core/dev.c:1902

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1627 Comm: khungtaskd Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd48/0xfb0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 14373 Comm: kworker/u4:2 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 81 e1 00 01 00 00 65 48 8b 14 25 00 f0 01 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 3c 15 00 00 85 c0 74 2b 8b 82 18 15 00 00 <83> f8 02 75 20 48 8b 8a 20 15 00 00 8b 92 1c 15 00 00 48 8b 01 48
RSP: 0018:ffffc900019afb58 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff8880286d9c40 RSI: ffffffff8145d523 RDI: 0000000000000003
RBP: ffffffff874d2c23 R08: 0000000000000000 R09: ffffffff8bc703c3
R10: ffffffff817ae39d R11: 0000000000000000 R12: ffffffff8bc703c0
R13: 000000000000dee5 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005622c9273cd8 CR3: 00000000137ea000 CR4: 0000000000350ee0
Call Trace:
 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:366
 local_bh_enable include/linux/bottom_half.h:32 [inline]
 get_next_corpse net/netfilter/nf_conntrack_core.c:2237 [inline]
 nf_ct_iterate_cleanup+0x15a/0x450 net/netfilter/nf_conntrack_core.c:2260
 nf_conntrack_cleanup_net_list+0x184/0x4f0 net/netfilter/nf_conntrack_core.c:2454
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:178
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

