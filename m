Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C03835C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbhEQPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:25:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42923 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbhEQPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:11:36 -0400
Received: by mail-il1-f200.google.com with SMTP id d3-20020a9287430000b0290181f7671fa1so6606732ilm.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=paHP61lJ84JP3WacH60Q8YQ0YgQtVGcUINkKDn/f6ZU=;
        b=X0nPXAvIJt9OgT/c2SJq8sQnUyqv2LM4GdsHf+6+kkiGccFKFHw/u8OiLM7sgYWdrA
         ACXtoouZcUPsO9a2Vq8rNNqfKTO5mro+qp+Fae8kbl230MUwTrGZ9WEQhVbbAL10Kq6W
         zJo4lloGJYvvSUa9pcRARLJ7rdiYd6CjBN+RXxU6oTtoeEjHot7hjc8OfJHOWZ7zNHLT
         ACCLo/cV0mE9CIfofCk8CFnqVeCNhwdQ8laAvuYxzL16AO/mK4c46wCM44mi/irmMwjr
         gMZex/VBLRa3FXQs17W0m8y4WdDzyPVO4RJ6EyCmmwhog2ONJ26B9j0lIxxOr8mxDaek
         uaTg==
X-Gm-Message-State: AOAM533CFqyBKSpZA3936WqbeNNgotnOOmEWOB7DTUzlye7EOuN2W6th
        d9KG5qNUCKoHUicnaM6dkN5ZMEPiu/WN/o+91+8H9V6dTkwC
X-Google-Smtp-Source: ABdhPJzSGChRie+S1/USTMB7gOKoQsOexNB6LdwmG8Z51W4SoOHY4RcaDdBvmmktRyBgJ9O1dYNLgjforPgQrFwv3g07+0sGg8R0
MIME-Version: 1.0
X-Received: by 2002:a92:c564:: with SMTP id b4mr119266ilj.257.1621264219656;
 Mon, 17 May 2021 08:10:19 -0700 (PDT)
Date:   Mon, 17 May 2021 08:10:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e65b5d05c287fddc@google.com>
Subject: [syzbot] WARNING in task_ctx_sched_out
From:   syzbot <syzbot+30189c98403be62bc05a@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, jolsa@redhat.com,
        kafai@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18a3c5f7 Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1569c027d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8ac1fe5995f69d7
dashboard link: https://syzkaller.appspot.com/bug?extid=30189c98403be62bc05a
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30189c98403be62bc05a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8711 at kernel/events/core.c:2668 task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
Modules linked in:
CPU: 0 PID: 8711 Comm: syz-executor.0 Not tainted 5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
Hardware name: riscv-virtio,qemu (DT)
epc : task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
 ra : task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
epc : ffffffe00027ccf0 ra : ffffffe00027ccf0 sp : ffffffe0067abb80
 gp : ffffffe0045883c0 tp : ffffffe00db797c0 t0 : ffffffc400b23834
 t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe0067abbb0
 s1 : ffffffe066d59e00 a0 : ffffffe066d59fa8 a1 : 00000000000f0000
 a2 : 0000000000000002 a3 : ffffffe00027ccf0 a4 : ffffffe00db7a7c0
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe00028fc4c
 s2 : ffffffe00877e400 s3 : 0000000000000003 s4 : ffffffe00df38800
 s5 : ffffffe00db7ab48 s6 : ffffffe00db7aab8 s7 : ffffffe00877e408
 s8 : 0000000000000000 s9 : 0000000000000025 s10: ffffffe00db797c0
 s11: ffffffe0067abe30 t3 : 1ef9635ec2383300 t4 : ffffffc404c957b2
 t5 : ffffffc404c957ba t6 : 0000000000040000
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe00027ccf0>] task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
[<ffffffe00028fc98>] perf_event_exit_task_context kernel/events/core.c:12483 [inline]
[<ffffffe00028fc98>] perf_event_exit_task+0x214/0x708 kernel/events/core.c:12541
[<ffffffe000031fc4>] do_exit+0x77a/0x1846 kernel/exit.c:834
[<ffffffe00003319a>] do_group_exit+0xa0/0x198 kernel/exit.c:922
[<ffffffe00004c558>] get_signal+0x31e/0x14ba kernel/signal.c:2781
[<ffffffe000007e06>] do_signal arch/riscv/kernel/signal.c:271 [inline]
[<ffffffe000007e06>] do_notify_resume+0xa8/0x930 arch/riscv/kernel/signal.c:317
[<ffffffe000005586>] ret_from_exception+0x0/0x14
irq event stamp: 3704
hardirqs last  enabled at (3703): [<ffffffe002a9a784>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (3703): [<ffffffe002a9a784>] _raw_spin_unlock_irqrestore+0x68/0x98 kernel/locking/spinlock.c:191
hardirqs last disabled at (3704): [<ffffffe002a9a41c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (3704): [<ffffffe002a9a41c>] _raw_spin_lock_irq+0x5c/0x5e kernel/locking/spinlock.c:167
softirqs last  enabled at (3672): [<ffffffe002a9b578>] __do_softirq+0x5e0/0x8c4 kernel/softirq.c:372
softirqs last disabled at (3667): [<ffffffe00003507e>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (3667): [<ffffffe00003507e>] invoke_softirq kernel/softirq.c:228 [inline]
softirqs last disabled at (3667): [<ffffffe00003507e>] __irq_exit_rcu kernel/softirq.c:422 [inline]
softirqs last disabled at (3667): [<ffffffe00003507e>] irq_exit+0x1a0/0x1b6 kernel/softirq.c:446
---[ end trace 2de0fbf815e6ece8 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
