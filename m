Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD62440FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJaRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:22:59 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51839 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhJaRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:22:58 -0400
Received: by mail-il1-f198.google.com with SMTP id a14-20020a927f0e000000b002597075cb35so8602870ild.18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zfmA5h0MBcstWFsyPfQBb+1QXu+PmY8xmc/hyimFVCk=;
        b=w6MP9GhU6XjB0P4Na7Q04hLSN9BZXBffJyBHTtHRCV8BYQGPE2bhLdaZYaTY8HwdNd
         ywNka23Kn16cQMa4s5eaYmP1GwsYiiNMFislVg8hBLXBr9hU9lk/D8LZIAQEPFMxAhs3
         HSPr0mYEwVYyFY0Q2z+fEiYAFGcoBoKtUqeoJj+SvhbIOMFQdWfqlf+NYO/G+1cM7oQd
         9iIgc13jipcbsiHgazHXBMHPZCGVciddQPuWxS5BaEY2xpAuc9TxOH9y8EhKFU1GZENk
         jEnms9RrkVoIPh4oD62Fw4fj9S4muaS6+tUg9wROzdOoLhSa+idqMs8dFdX25WnEyucb
         Onug==
X-Gm-Message-State: AOAM533qwpAgAC5vxUiQqCps9cdcg0EaSdyk9sC1pkjRBNGLjGVkSxF1
        vOJ1mMBS0id6KORF+WdiYX9nDdCQ6P9pJJBFZiTVUzB4jQWA
X-Google-Smtp-Source: ABdhPJxrrbbgzjkkMvJl3ESsi2WYvzbq5ZbiXtewy0mav/gV0U3z/sjVhSSn7AiYzlc0LMk3u1m41TD2fIMekP2XeqP3IIPONoZ1
MIME-Version: 1.0
X-Received: by 2002:a5d:87c8:: with SMTP id q8mr17088159ios.117.1635700826206;
 Sun, 31 Oct 2021 10:20:26 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:20:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4786c05cfa94612@google.com>
Subject: [syzbot] INFO: rcu detected stall in snd_seq_write (2)
From:   syzbot <syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bdcc9f6a5682 Add linux-next specific files for 20211029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e542a6b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b504bcb4c507265
dashboard link: https://syzkaller.appspot.com/bug?extid=bb950e68b400ab4f65f8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e913bab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=9f5/1/0x4000000000000000 softirq=16474/16475 fqs=4916 
	(t=10500 jiffies g=19249 q=192515)
NMI backtrace for cpu 1
CPU: 1 PID: 13283 Comm: syz-executor.4 Not tainted 5.15.0-rc7-next-20211029-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:604 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:688 [inline]
 rcu_pending kernel/rcu/tree.c:3922 [inline]
 rcu_sched_clock_irq.cold+0x9d/0x746 kernel/rcu/tree.c:2620
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 fa 8e 42 f8 48 89 ef e8 42 05 43 f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> e3 cd 35 f8 65 8b 05 5c 26 e8 76 85 c0 74 0a 5b 5d c3 e8 40 c8
RSP: 0018:ffffc9000d36faf0 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1f54946
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888061a6c498 R08: 0000000000000001 R09: ffffffff8fa48af7
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000293 R14: ffff888061a6c498 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:422 [inline]
 snd_seq_prioq_cell_out+0x1dc/0x360 sound/core/seq/seq_prioq.c:238
 snd_seq_check_queue+0x1a6/0x3f0 sound/core/seq/seq_queue.c:262
 snd_seq_enqueue_event+0x1ed/0x3e0 sound/core/seq/seq_queue.c:334
 snd_seq_client_enqueue_event.constprop.0+0x230/0x440 sound/core/seq/seq_clientmgr.c:976
 snd_seq_write+0x388/0x690 sound/core/seq/seq_clientmgr.c:1096
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4c1777bae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c16ed0188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4c1788f020 RCX: 00007f4c1777bae9
RDX: 00000000fffffee4 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f4c177d5f25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0d94d1bf R14: 00007f4c16ed0300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	fa                   	cli
   5:	8e 42 f8             	mov    -0x8(%rdx),%es
   8:	48 89 ef             	mov    %rbp,%rdi
   b:	e8 42 05 43 f8       	callq  0xf8430552
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 e3 cd 35 f8       	callq  0xf835ce12 <-- trapping instruction
  2f:	65 8b 05 5c 26 e8 76 	mov    %gs:0x76e8265c(%rip),%eax        # 0x76e82692
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	40                   	rex
  3f:	c8                   	.byte 0xc8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
