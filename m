Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E640353C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhDEHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:48:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38056 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhDEHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:48:24 -0400
Received: by mail-io1-f72.google.com with SMTP id x9so10479487iob.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 00:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/LTxzgxJy1cFna6xQ4aQwuZ2sdTSUuU1tDzCItaDitI=;
        b=cKJ6Nfp7fOJD+7fbgjM6QBsaUV96C6tVHgXul3f4On8Yk4p4rytMLa2v/HcJvgOefg
         C2HeAwMRc2CI6fUce1HQJ2olIJSFJ5OONBQI7H/RJwSRK16GJRpCHz9n0somnrB5n5yt
         jQGSCMOi6TSc2ryBnufWjtSjTn/MQ38LYRLgcznl9LzB4ez/DpGnS3SOU/7Wn9KX1vmV
         c9OoDPcWdfKkqhyd4F0++u34ziDH/jGMmZrNJtmL80IQEr5mzTV3DQwx+LMxKsreDNAe
         c3z2WRqkdubt70nbfYlk6u5ko5n/UrMgI/T/R1kgXSPbu+EKbNEUZjV3DpBYNNi4PW3h
         64Mw==
X-Gm-Message-State: AOAM532uGR53k1CxR8TF6MUvtehq1WcaaJczqYdXHA5kdp/HH4APs72C
        8dKY2gIJqUjyIkb4LylGL0ekskOI5Dd+XgUtYVf3vPmMG66E
X-Google-Smtp-Source: ABdhPJy2MyWV/EK/AkmLvGsbg+qKZ6VHew0DnGxXVMvuco0fpqvj7z5jWMUuj0lEQICJRkTPgC5jqI+2O/XKFOPEhO/PrfD3tyRE
MIME-Version: 1.0
X-Received: by 2002:a6b:fa09:: with SMTP id p9mr18902141ioh.14.1617608897150;
 Mon, 05 Apr 2021 00:48:17 -0700 (PDT)
Date:   Mon, 05 Apr 2021 00:48:17 -0700
In-Reply-To: <00000000000093e52e05bc00fdcb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3462405bf34ebb7@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in detach_tasks
From:   syzbot <syzbot+f9131489729201445f66@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, dwmw@amazon.co.uk,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e49d033b Linux 5.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f7cc6ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f91155ccddaf919c
dashboard link: https://syzkaller.appspot.com/bug?extid=f9131489729201445f66
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dc5786d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9131489729201445f66@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7712:14
shift exponent 77 is too large for 64-bit type 'unsigned long'
CPU: 1 PID: 8407 Comm: syz-executor.4 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_shift_out_of_bounds+0x42e/0x4d0 lib/ubsan.c:327
 detach_tasks+0xd04/0x1110 kernel/sched/fair.c:7712
 load_balance+0x39f6/0x5a80 kernel/sched/fair.c:9641
 rebalance_domains+0x4ca/0x9c0 kernel/sched/fair.c:10029
 __do_softirq+0x318/0x714 kernel/softirq.c:345
 invoke_softirq kernel/softirq.c:221 [inline]
 __irq_exit_rcu+0x1d8/0x200 kernel/softirq.c:422
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:434
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:199
Code: b2 fd ff 66 90 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 0e 54 08 f8 48 89 df e8 56 29 0a f8 e8 f1 a4 2a f8 fb bf 01 00 00 00 <e8> 26 39 fe f7 65 8b 05 f7 7c ad 76 85 c0 74 02 5b c3 e8 ab d8 ab
RSP: 0018:ffffc9000187fc70 EFLAGS: 00000282
RAX: eded0b76c3f98d00 RBX: ffff8880b9d34c80 RCX: ffffffff8ff89b03
RDX: 0000000040000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc9000187fcd0 R08: ffffffff817f17a0 R09: ffffed10173a6991
R10: ffffed10173a6991 R11: 0000000000000000 R12: ffff8880b9d34c80
R13: ffff88801caeb880 R14: dffffc0000000000 R15: 0000000000000000
 finish_task_switch+0x145/0x620 kernel/sched/core.c:4191
 context_switch kernel/sched/core.c:4325 [inline]
 __schedule+0x9a1/0xe70 kernel/sched/core.c:5073
 schedule+0x14b/0x200 kernel/sched/core.c:5152
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x1cd/0x740 kernel/time/hrtimer.c:1896
 hrtimer_nanosleep+0x1b9/0x3a0 kernel/time/hrtimer.c:1949
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1267 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x2f6/0x340 kernel/time/posix-timers.c:1245
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x48a621
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007ffd2ecab5c0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 000000000048a621
RDX: 00007ffd2ecab600 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffd2ecab69c R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000006640a R14: 000000000000000d R15: 00007ffd2ecab700
================================================================================

