Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249E23FB421
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhH3Kwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhH3Kwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:52:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F803C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:51:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RSN32Fc68vnUkBjhF7yk4nL6Ecg28CKvWg6fH1Afb8=;
        b=DgC8APdWcPdyCu5Ldzu8bfCy59RdZ61gBbCJI65WTqqDRaBbTwpJJOCxiRCeVX97f/IIQH
        dFwJKlhjLR4qhSheT81COEvjCYcOSaFnOvZZ9D+Yo6iq1U0ajFvqbF7R3mfrftcY0shCPh
        2w/WoTnU2UaFRulJ6s1OgpIuylWlPbjqsmugALh8lhPM6Ab1aR1Gn/iEIhue3CE6Kl42Vf
        DpWrl5RqwNYrdHgy8WpDfJ5TBuDqzVuUt87+BPuwwxL+XLfjLzkukI90pYaKUOoDHRUsWt
        7yRFf6ZPOOB0b3FqmH5NKEHkoVAzyyMRkFrbEHCWN8YDPJJQCKWSjtgpFr5uMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RSN32Fc68vnUkBjhF7yk4nL6Ecg28CKvWg6fH1Afb8=;
        b=fbCcLlRd4ULBNGXuXvWkAg2PEiFfQyBULPr5a0UBMO5KUiHZ+ilvuLs7aYJs3O8GsNOyUD
        hBKoV+oS/fnb/TBA==
To:     syzbot <syzbot+f2ceae48bb0c0ab08b9d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [syzbot] WARNING in rcu_core
In-Reply-To: <000000000000d4ba6405cac3b065@google.com>
References: <000000000000d4ba6405cac3b065@google.com>
Date:   Mon, 30 Aug 2021 12:51:39 +0200
Message-ID: <87eeabgq84.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 02:45, syzbot wrote:

Cc+ Paul

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    77dd11439b86 Merge tag 'drm-fixes-2021-08-27' of git://ano..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12018abd300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
> dashboard link: https://syzkaller.appspot.com/bug?extid=f2ceae48bb0c0ab08b9d
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f2ceae48bb0c0ab08b9d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ODEBUG: active_state not available (active state 0) object type: rcu_head hint: 0x0
> WARNING: CPU: 0 PID: 8442 at lib/debugobjects.c:508 debug_print_object lib/debugobjects.c:505 [inline]
> WARNING: CPU: 0 PID: 8442 at lib/debugobjects.c:508 debug_object_active_state+0x28a/0x410 lib/debugobjects.c:946
> Modules linked in:
> CPU: 0 PID: 8442 Comm: syz-executor.2 Not tainted 5.14.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:debug_print_object lib/debugobjects.c:505 [inline]
> RIP: 0010:debug_object_active_state+0x28a/0x410 lib/debugobjects.c:946
> Code: e8 fb c6 be fd 4c 8b 45 00 48 c7 c7 c0 a2 93 8a 48 c7 c6 60 9f 93 8a 48 c7 c2 00 a5 93 8a 31 c9 49 89 d9 31 c0 e8 16 58 41 fd <0f> 0b e9 9f 00 00 00 45 31 f6 ff 05 66 bd 9d 0c 43 8a 04 2f 84 c0
> RSP: 0018:ffffc90000007ba0 EFLAGS: 00010246
> RAX: b9c220867f01ad00 RBX: 0000000000000000 RCX: ffff88801b5b0000
> RDX: 0000000080000101 RSI: 0000000080000101 RDI: 0000000000000000
> RBP: ffffffff8a304d00 R08: ffffffff81664f72 R09: ffffed1017383f2c
> R10: ffffed1017383f2c R11: 0000000000000000 R12: ffff888000137e18
> R13: dffffc0000000000 R14: 1ffff11000026fc3 R15: ffff88805ec97ba0
> FS:  0000000002131400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000001ffffc00 CR3: 00000000505bb000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  debug_rcu_head_unqueue kernel/rcu/rcu.h:185 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2543 [inline]
>  rcu_core+0x8a6/0x14b0 kernel/rcu/tree.c:2785
>  __do_softirq+0x372/0x783 kernel/softirq.c:558
>  invoke_softirq kernel/softirq.c:432 [inline]
>  __irq_exit_rcu+0x21b/0x260 kernel/softirq.c:636
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>  sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
>  </IRQ>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:finish_lock_switch+0xf0/0x1c0 kernel/sched/core.c:4436
> Code: 61 0c 00 74 11 48 89 df be ff ff ff ff e8 18 33 80 08 85 c0 74 27 4d 85 ff 75 44 4c 89 f7 e8 a7 dd 82 08 e8 f2 40 2d 00 fb 5b <41> 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 4d 85 ff 75 92 eb a8 0f 0b 4d
> RSP: 0018:ffffc9000167fa30 EFLAGS: 00000282
> RAX: b9c220867f01ad00 RBX: ffff8880902a54f4 RCX: ffffffff9070c703
> RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 1ffff1101738a400 R08: ffffffff8186a520 R09: ffffed101738a2a9
> R10: ffffed101738a2a9 R11: 0000000000000000 R12: ffff8880b9c52000
> R13: dffffc0000000000 R14: ffff8880b9c51540 R15: 0000000000000000
>  finish_task_switch+0x140/0x630 kernel/sched/core.c:4553
>  context_switch kernel/sched/core.c:4684 [inline]
>  __schedule+0xc0f/0x11f0 kernel/sched/core.c:5938
>  schedule+0x14b/0x210 kernel/sched/core.c:6017
>  freezable_schedule include/linux/freezer.h:172 [inline]
>  do_nanosleep+0x1b6/0x7b0 kernel/time/hrtimer.c:1896
>  hrtimer_nanosleep+0x239/0x470 kernel/time/hrtimer.c:1949
>  __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
>  __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
>  __x64_sys_clock_nanosleep+0x344/0x3d0 kernel/time/posix-timers.c:1245
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x48a7c1
> Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
> RSP: 002b:00007ffe3a1cf3e0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
> RAX: ffffffffffffffda RBX: 00000000000019ce RCX: 000000000048a7c1
> RDX: 00007ffe3a1cf420 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007ffe3a1cf4bc R08: 0000000000000000 R09: 0000000000000010
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
> R13: 00000000001f8f0a R14: 000000000000000b R15: 00007ffe3a1cf520
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:	0c 00                	or     $0x0,%al
>    2:	74 11                	je     0x15
>    4:	48 89 df             	mov    %rbx,%rdi
>    7:	be ff ff ff ff       	mov    $0xffffffff,%esi
>    c:	e8 18 33 80 08       	callq  0x8803329
>   11:	85 c0                	test   %eax,%eax
>   13:	74 27                	je     0x3c
>   15:	4d 85 ff             	test   %r15,%r15
>   18:	75 44                	jne    0x5e
>   1a:	4c 89 f7             	mov    %r14,%rdi
>   1d:	e8 a7 dd 82 08       	callq  0x882ddc9
>   22:	e8 f2 40 2d 00       	callq  0x2d4119
>   27:	fb                   	sti
>   28:	5b                   	pop    %rbx
> * 29:	41 5c                	pop    %r12 <-- trapping instruction
>   2b:	41 5d                	pop    %r13
>   2d:	41 5e                	pop    %r14
>   2f:	41 5f                	pop    %r15
>   31:	5d                   	pop    %rbp
>   32:	c3                   	retq
>   33:	0f 0b                	ud2
>   35:	4d 85 ff             	test   %r15,%r15
>   38:	75 92                	jne    0xffffffcc
>   3a:	eb a8                	jmp    0xffffffe4
>   3c:	0f 0b                	ud2
>   3e:	4d                   	rex.WRB
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
