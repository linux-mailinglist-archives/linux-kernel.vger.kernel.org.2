Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD430847F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 05:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhA2EMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 23:12:00 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45712 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhA2EL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:11:58 -0500
Received: by mail-il1-f197.google.com with SMTP id h17so6587328ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 20:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M5M3YzHPCAGAqtaruCAEC8IMMPdUQpzTxI40cnJIAO8=;
        b=Mpa3vgMrlnEcB8YGwhLwjYBZ8F1JWuxs7L56/fi6aJqV/AZiZ52Yyup+KNTCZmSOhj
         bdJc2k8nAsDAlUOylBvD6K469KHXvzcIQfRI8nsnqbDxbi/OYcfoiWkewKXKIAjt2v8o
         6c+H0C4sZ+X0rSYvQ/XdCI5UZkU/J1jAP6GRhQDTQCMLTgkoMTVpUZjISqUpbU4sHACQ
         +a1MOdU2X5lS0jLrCX9SpSEzw020Bs+Eg13C5lz4H2oYiDYiE+HkjbMVHmFVUF7ebwRN
         0Is4ymLsNAsGL3xseI25+TTzPGQYCGMvw4rEdBtHxpvARIqxJo1sNbi17boKiMXXsIWs
         gPtw==
X-Gm-Message-State: AOAM533yahcaOIt185y9rssgErRTdtMHZRyy6Nl5FAGfwlXQh+gp6ges
        +YJCpiYWN5zjM7crMIYNcfxoMPB+pOwap89yU3D9qvzq6fcG
X-Google-Smtp-Source: ABdhPJxmLUFJlBuZko7pmlwkZPKedP5GcuYACUoUa2Zy2H0cXNmiEli+WfH/8GB+zWBdUJFs2osBwlHGxzDzBgSDOLWzIf9p/7hQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164f:: with SMTP id a15mr2077564jat.75.1611893477790;
 Thu, 28 Jan 2021 20:11:17 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:11:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028d7d005ba0232b8@google.com>
Subject: INFO: rcu detected stall in wg_packet_handshake_receive_worker
From:   syzbot <syzbot+dbb6a05624cf5064858c@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e6806137 Merge tag 'irq_urgent_for_v5.11_rc5' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1744f4e8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be33d8015c9de024
dashboard link: https://syzkaller.appspot.com/bug?extid=dbb6a05624cf5064858c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1335df9f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125c2ab4d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbb6a05624cf5064858c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...0: (1 GPs behind) idle=c9a/1/0x4000000000000000 softirq=12635/12642 fqs=2 
	(t=18523 jiffies g=12681 q=487)
rcu: rcu_preempt kthread starved for 8264 jiffies! g12681 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:29176 pid:   13 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5078
 schedule+0xcf/0x270 kernel/sched/core.c:5157
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1878
 rcu_gp_fqs_loop kernel/rcu/tree.c:1940 [inline]
 rcu_gp_kthread+0xbbe/0x1d70 kernel/rcu/tree.c:2113
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
NMI backtrace for cpu 0
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.11.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1f4/0x230 kernel/rcu/tree_stall.h:337
 print_cpu_stall kernel/rcu/tree_stall.h:569 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:643 [inline]
 rcu_pending kernel/rcu/tree.c:3751 [inline]
 rcu_sched_clock_irq.cold+0x48e/0xedf kernel/rcu/tree.c:2580
 update_process_times+0x16d/0x200 kernel/time/timer.c:1782
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1369
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1085 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1102
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_sysvec_on_irqstack arch/x86/include/asm/irq_stack.h:37 [inline]
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:89 [inline]
 sysvec_apic_timer_interrupt+0xbd/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:queue_work_on+0x83/0xd0 kernel/workqueue.c:1530
Code: 31 ff 89 ee e8 1e fe 28 00 40 84 ed 74 46 e8 94 f7 28 00 31 ff 48 89 de e8 7a ff 28 00 48 85 db 75 26 e8 80 f7 28 00 41 56 9d <48> 83 c4 08 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 66 f7 28
RSP: 0018:ffffc90000ca7a78 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff888010d18000 RSI: ffffffff8149c970 RDI: 0000000000000000
RBP: ffff888033f9a000 R08: 0000000000000001 R09: ffffffff8ed3287f
R10: fffffbfff1da650f R11: 0000000000000000 R12: ffffe8ffffd4bcf0
R13: ffff8880149b3c00 R14: 0000000000000293 R15: 0000000000000001
 wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:156 [inline]
 wg_packet_create_data drivers/net/wireguard/send.c:326 [inline]
 wg_packet_send_staged_packets+0xf42/0x1840 drivers/net/wireguard/send.c:396
 wg_packet_send_keepalive+0x4a/0x310 drivers/net/wireguard/send.c:239
 wg_receive_handshake_packet+0x930/0xb40 drivers/net/wireguard/receive.c:193
 wg_packet_handshake_receive_worker+0x45/0x90 drivers/net/wireguard/receive.c:220
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
