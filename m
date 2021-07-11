Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175283C3C45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhGKM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:27:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53170 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:27:03 -0400
Received: by mail-il1-f199.google.com with SMTP id a7-20020a9233070000b02901edc50cdfdcso9833378ilf.19
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 05:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CLbGI7UkfbxLcnvn5/PVcxj3iqrwRfUbR/u6hvGyPHw=;
        b=n2JkirWvAtNFkThYTUS8p8gVlf3KcIaMPfQjj40g5jd2e6BIjW4OXnujkH6TELySj4
         ln37SW+F8lLNqE9mmAaQbPAZgy9yckfNC+wIwu07UuMmP1u74kLkcBCs79+WG98eHhs8
         XjTRrurbuzQEXDXC+g1Yc5d3SZCLNeAQVdhY/2Jq/UJIfxGL8uF5+/p//Rp/z8m1h7AP
         RYKKsYMc8sJJ094qZyM4idHFVme3kiXkj94ydUe2pLBokDjBGIwoxJH4dSTje8HCmxiT
         4By/LplIhOsLLVkP9AASumgdhKSGUbwQSB817f7ovMID/nTxC5+ncknBp/FOSYSzDdeM
         gcSA==
X-Gm-Message-State: AOAM530g0+x3LRFI8NWzsrURzH/LkTuhS1Gtg5SQ+8x7E+tjrsnL9K+4
        P8PmfATzKypBG6BvjxqFf5rHJL4+fOfTumFaw3Buw3HzdEbs
X-Google-Smtp-Source: ABdhPJzrfCNPWGCQUPqweJmxs97VxuJWg+ZMI5qRCs0PQmwsKbFm7S4uojcjSkgxprgoaafagHn8KMEpOyrswojgMznGXL+9EPHH
MIME-Version: 1.0
X-Received: by 2002:a02:380b:: with SMTP id b11mr4836839jaa.83.1626006256570;
 Sun, 11 Jul 2021 05:24:16 -0700 (PDT)
Date:   Sun, 11 Jul 2021 05:24:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053572d05c6d81503@google.com>
Subject: [syzbot] INFO: task hung in io_uring_cancel_generic
From:   syzbot <syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd9efbd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=ba6fcd859210f4e9e109
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bbf280300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1111ec9c300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba6fcd859210f4e9e109@syzkaller.appspotmail.com

INFO: task syz-executor015:8439 blocked for more than 143 seconds.
      Tainted: G        W         5.13.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor015 state:D stack:28184 pid: 8439 ppid:  8438 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x934/0x2710 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 io_uring_cancel_generic+0x54d/0x890 fs/io_uring.c:9203
 io_uring_files_cancel include/linux/io_uring.h:16 [inline]
 do_exit+0x28b/0x2a50 kernel/exit.c:780
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43eac9
RSP: 002b:00007ffc2d1b6378 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004b02f0 RCX: 000000000043eac9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00000000f0ffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004b02f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 1650 Comm: khungtaskd Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd4b/0xfb0 kernel/hung_task.c:294
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
