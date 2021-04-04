Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30C9353972
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhDDTF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 15:05:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37288 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhDDTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 15:05:24 -0400
Received: by mail-io1-f72.google.com with SMTP id u23so9831735ioc.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 12:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KLIrUMBKcH46q6YhYDoMJUmRhuRypsq/SfprdhhyAt4=;
        b=hSZvAG7uLVcT1n5fxHx6AneakICA/CJoOe82hzWuqXMs2zxfY77/oNDHF31v6DA75q
         +ZLt5lJp3AF3P3pvTx2J44dh117L2oIPAm7YAxvH1bvImmCGXiDKEVe5akknTXvDaPxX
         2ZpSBZMWeGvphpIDxa+5H8ighLPT8h1hIg5RFmrSpaF4U3IuSdprHwtW1VG8h2yqO08l
         9VyCzxa1ZWsgLR03ZK0wH2ZouFPxDOKrhJ0WwnmsVoPgoh0Dqm4tuEMkYeL3L6vGnCl3
         lXUSIGBNGUIhOWYIMg8RLQiv81gGRWrowEM1k8ypswMsSBIiQ318unHFWrzDkLyATy97
         0STg==
X-Gm-Message-State: AOAM532BrVXV2dr6aKoxgi9K4nq2ErFwiaWAuvLPCsKUZyvS0gSXSgkg
        OKtpkdQb0SqUjJs2itUro8sNHvD3ZzatbAIicmr4BOqgXcNz
X-Google-Smtp-Source: ABdhPJzxoFc14sk+omBKLDEvsriKplxm9NzKHcOstizQF1V9kC1bH6iKWSBJZTdbxGYJvEYWKrIuWzIPca0fb6XaFNbtfXCldJDy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d95:: with SMTP id k21mr17387988iow.123.1617563118075;
 Sun, 04 Apr 2021 12:05:18 -0700 (PDT)
Date:   Sun, 04 Apr 2021 12:05:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e025b05bf2a430b@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in get_timespec64
From:   syzbot <syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com>
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e46d1b7 reiserfs: update reiserfs_xattrs_initialized() co..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1125f831d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
dashboard link: https://syzkaller.appspot.com/bug?extid=88e4f02896967fe1ab0d

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
3 locks held by syz-executor.4/8418:
 #0: 
ffff8880751d2b28
 (
&p->pi_lock
){-.-.}-{2:2}
, at: try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
 #1: 
ffff8880b9d35258
 (
&rq->lock
){-.-.}-{2:2}
, at: rq_lock kernel/sched/sched.h:1321 [inline]
, at: ttwu_queue kernel/sched/core.c:3184 [inline]
, at: try_to_wake_up+0x5e6/0x14a0 kernel/sched/core.c:3464
 #2: ffff8880b9d1f948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x142/0x220 kernel/sched/psi.c:807

stack backtrace:
CPU: 0 PID: 8418 Comm: syz-executor.4 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8294
 __might_fault+0x6e/0x180 mm/memory.c:5018
 _copy_from_user+0x27/0x180 lib/usercopy.c:13
 copy_from_user include/linux/uaccess.h:192 [inline]
 get_timespec64+0x75/0x220 kernel/time/time.c:787
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1257 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1245 [inline]
 __x64_sys_clock_nanosleep+0x1bb/0x430 kernel/time/posix-timers.c:1245
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x48a621
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 aa e7 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 e3 e7 ff ff 48 8b 04 24 eb 97 66 2e 0f 1f
RSP: 002b:00007fffe59fbd50 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000294 RCX: 000000000048a621
RDX: 00007fffe59fbd90 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fffe59fbe2c R08: 0000000000000000 R09: 00007fffe5b8a090
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000005717a R14: 0000000000000003 R15: 00007fffe59fbe90


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
