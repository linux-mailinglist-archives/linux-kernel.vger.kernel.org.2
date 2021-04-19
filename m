Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF0364096
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhDSLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:32:01 -0400
Received: from foss.arm.com ([217.140.110.172]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhDSLb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:31:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B4931B;
        Mon, 19 Apr 2021 04:31:25 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C053F792;
        Mon, 19 Apr 2021 04:31:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
In-Reply-To: <000000000000a61f7705c050e601@google.com>
References: <000000000000a61f7705c050e601@google.com>
Date:   Mon, 19 Apr 2021 12:31:22 +0100
Message-ID: <87im4ilddh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/21 03:36, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1216f02e Add linux-next specific files for 20210415
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1032ba29d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3491b04113499f81
> dashboard link: https://syzkaller.appspot.com/bug?extid=9362b31a2e0cad8b749d
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 to_kthread kernel/kthread.c:83 [inline]
> WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
> Modules linked in:
> CPU: 1 PID: 23550 Comm: syz-executor.3 Not tainted 5.12.0-rc7-next-20210415-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:to_kthread kernel/kthread.c:83 [inline]
> RIP: 0010:kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
> Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 2e 4c 8b 23 41 83 e4 01 e8 89 d3 27 00 44 89 e0 5b 5d 41 5c c3 e8 7c d3 27 00 <0f> 0b eb 88 e8 33 90 6c 00 e9 68 ff ff ff e8 39 90 6c 00 eb 9a 48
> RSP: 0018:ffffc90000dc0c08 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff88802533d580 RCX: 0000000000000100
> RDX: ffff8880549bb900 RSI: ffffffff814ca4c4 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88802533d580
> R10: ffffffff814ca44c R11: 00000000018a3b90 R12: 0000000000000001
> R13: ffffc90000dc0d90 R14: 0000000000000001 R15: ffff88802533d580
> FS:  00007f4be57d3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2cd24000 CR3: 0000000024626000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  can_migrate_task+0x124/0x1630 kernel/sched/fair.c:7610
>  detach_tasks kernel/sched/fair.c:7774 [inline]
>  load_balance+0xc72/0x2730 kernel/sched/fair.c:9696
>  rebalance_domains+0x668/0xda0 kernel/sched/fair.c:10075
>  __do_softirq+0x29b/0x9fe kernel/softirq.c:559
>  invoke_softirq kernel/softirq.c:433 [inline]
>  __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>  </IRQ>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
> arch/x86/include/asm/idtentry.h:632


  if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
                                 `\
                                   to_kthread(p);
                                    `\
                                      WARN_ON(!(p->flags & PF_KTHREAD));

... Huh?
