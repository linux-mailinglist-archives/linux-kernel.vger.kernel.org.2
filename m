Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A915342D656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJNJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:46:29 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39727 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:46:28 -0400
Received: by mail-io1-f72.google.com with SMTP id r15-20020a6b600f000000b005dde03edc0cso318291iog.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 02:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6zW2xAbXKwM1NUyLELlRDegz98DV/EkQfjFooEN7pLM=;
        b=bqN67FjOwIhnqm/Y1uEsf/CxTNay93c2Ui4HZsXLdu/5//OSEWE64W6AgnplXwmJ67
         nE25kkYo4rd3ufT/eUj8ty/FmzNNEmCCu2WJ1ipiwkW/5Kya3UaeJ2Z4p//A8SIX9FH7
         2VglNqkvTEZwe6k/V29ewqfwEuqV5uMbX6mu/AnKwbRkLetYKcOcwYqtApTEzvQmJNt1
         tGj0/vQx5vz9ilHsQARf8qhN+aTtAnuBqnOUzqIYgqLid11JXhX8jGjU+swBWZuncCIF
         sQCXfdzGhOAZryeNLm8CORWXHzE1z6qcBGEahJCI8USfwruTFADdQzBTxQBKAXmRlXlH
         2A4A==
X-Gm-Message-State: AOAM531UzHTL45Mxi/kXQREPH6luhAwOasREKZvgNy43c5cwlBO2tMH5
        XQgD8O+30cLgzC2Bvj0o1XmFxL5SkBdbqowULiHId5ptfw7B
X-Google-Smtp-Source: ABdhPJyLasGx+B4k+yn49GmFQPGDeTcpuHo0C9cWQFuElIHkJJmW66B6WyqNqrj0UD5BIq+qVUndHujWxh9XLjgGk71Wq5dFIgOA
MIME-Version: 1.0
X-Received: by 2002:a02:93c1:: with SMTP id z59mr3314570jah.124.1634204663339;
 Thu, 14 Oct 2021 02:44:23 -0700 (PDT)
Date:   Thu, 14 Oct 2021 02:44:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072e14705ce4cec3c@google.com>
Subject: [syzbot] INFO: task hung in tty_ioctl (2)
From:   syzbot <syzbot+9a1e55b8c30bfecdf654@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fd2bf83d59a Merge branch 'i2c/for-current-fixed' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168af2bf300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2f08ce63e886513
dashboard link: https://syzkaller.appspot.com/bug?extid=9a1e55b8c30bfecdf654
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ccb48b00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16069398b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15069398b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11069398b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a1e55b8c30bfecdf654@syzkaller.appspotmail.com

INFO: task agetty:6480 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:agetty          state:D stack:26928 pid: 6480 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 tiocsti drivers/tty/tty_io.c:2308 [inline]
 tty_ioctl+0x89f/0x1670 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f370e793017
RSP: 002b:00007ffc2fb15648 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc2fb157c9 RCX: 00007f370e793017
RDX: 00007ffc2fb157c8 RSI: 0000000000005412 RDI: 0000000000000000
RBP: 00007ffc2fb1584a R08: ffffffffffffff98 R09: 00007ffc2fb156c0
R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc2fb15664
R13: 00007ffc2fb157c0 R14: 00007ffc2fb156c0 R15: 0000000000000000
INFO: task syz-executor.5:9293 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29336 pid: 9293 ppid:  6590 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4f594628d9
RSP: 002b:00007f4f58bb8188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4f59567020 RCX: 00007f4f594628d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00007f4f594bccb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff5e83be4f R14: 00007f4f58bb8300 R15: 0000000000022000
INFO: task syz-executor.1:9292 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:29336 pid: 9292 ppid:  6588 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f20379cf8d9
RSP: 002b:00007f2037125188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2037ad4020 RCX: 00007f20379cf8d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00007f2037a29cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff4390537f R14: 00007f2037125300 R15: 0000000000022000
INFO: task syz-executor.2:9299 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28616 pid: 9299 ppid:  6593 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0b484b88d9
RSP: 002b:00007f0b47c2f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0b485bcf60 RCX: 00007f0b484b88d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000005
RBP: 00007f0b48512cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7adc8f6f R14: 00007f0b47c2f300 R15: 0000000000022000
INFO: task syz-executor.3:9303 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28616 pid: 9303 ppid:  6591 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9fb31e58d9
RSP: 002b:00007f9fb295c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9fb32e9f60 RCX: 00007f9fb31e58d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000005
RBP: 00007f9fb323fcb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd18960fcf R14: 00007f9fb295c300 R15: 0000000000022000
INFO: task syz-executor.4:9329 blocked for more than 144 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28616 pid: 9329 ppid:  6592 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5d0bacc8d9
RSP: 002b:00007f5d0b243188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5d0bbd0f60 RCX: 00007f5d0bacc8d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00007f5d0bb26cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd9bf0fff R14: 00007f5d0b243300 R15: 0000000000022000
INFO: task syz-executor.4:9338 blocked for more than 145 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29336 pid: 9338 ppid:  6592 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5d0bacc8d9
RSP: 002b:00007f5d0b222188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5d0bbd1020 RCX: 00007f5d0bacc8d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00007f5d0bb26cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd9bf0fff R14: 00007f5d0b222300 R15: 0000000000022000
INFO: task syz-executor.3:9325 blocked for more than 145 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28616 pid: 9325 ppid:  6591 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9fb31e58d9
RSP: 002b:00007f9fb295c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9fb32e9f60 RCX: 00007f9fb31e58d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000005
RBP: 00007f9fb323fcb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd18960fcf R14: 00007f9fb295c300 R15: 0000000000022000
INFO: task syz-executor.2:9332 blocked for more than 145 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28616 pid: 9332 ppid:  6593 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0b484b88d9
RSP: 002b:00007f0b47c2f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0b485bcf60 RCX: 00007f0b484b88d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000005
RBP: 00007f0b48512cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7adc8f6f R14: 00007f0b47c2f300 R15: 0000000000022000
INFO: task syz-executor.0:9341 blocked for more than 146 seconds.
      Not tainted 5.15.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28536 pid: 9341 ppid:  6589 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x940/0x26f0 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xa34/0x12f0 kernel/locking/mutex.c:729
 paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
 vt_ioctl+0x229c/0x2b10 drivers/tty/vt/vt_ioctl.c:762
 tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f355179e8d9
RSP: 002b:00007f3550f15188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f35518a2f60 RCX: 00007f355179e8d9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00007f35517f8cb4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe86dbe6af R14: 00007f3550f15300 R15: 0000000000022000

Showing all locks held in the system:
3 locks held by kworker/u4:1/10:
 #0: ffff8880b9d31ad8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:474 [inline]
 #0: ffff8880b9d31ad8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1317 [inline]
 #0: ffff8880b9d31ad8 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1620 [inline]
 #0: ffff8880b9d31ad8 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x236/0x26f0 kernel/sched/core.c:6201
 #1: ffffc90000f0fdb0 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x8d7/0x16b0 kernel/workqueue.c:2272
 #2: ffff8880b9d20258 (&base->lock){..-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:946
1 lock held by khungtaskd/27:
 #0: ffffffff8b97d3e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/6241:
 #0: ffff88802758a930 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
2 locks held by agetty/6480:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: tiocsti drivers/tty/tty_io.c:2308 [inline]
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: tty_ioctl+0x89f/0x1670 drivers/tty/tty_io.c:2719
2 locks held by syz-executor.5/9293:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.1/9292:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.3/9281:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.2/9299:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.3/9303:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.4/9329:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.4/9338:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.3/9325:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.2/9332:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.0/9341:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.0/9342:
 #0: ffff8880213fe098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88801142e0b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x110/0x4c0 drivers/tty/vt/selection.c:390

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 7520 Comm: kworker/u4:3 Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:kasan_check_range+0x16/0x180 mm/kasan/generic.c:188
Code: 02 0f 1f 00 48 89 f2 be f8 00 00 00 e9 63 b3 3c 02 0f 1f 00 48 85 f6 0f 84 70 01 00 00 49 89 f9 41 54 44 0f b6 c2 49 01 f1 55 <53> 0f 82 18 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 c7 0f 86
RSP: 0018:ffffc900060d7888 EFLAGS: 00000086
RAX: 0000000000000000 RBX: 1ffff92000c1af1b RCX: ffffffff815a05bf
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8fd01920
RBP: 0000000000000200 R08: 0000000000000000 R09: ffffffff8fd01928
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000009
R13: ffff88807ddd4cc8 R14: 000000000000002d R15: ffff88807ddd4ce8
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f73f677f000 CR3: 000000007ea32000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 hlock_class kernel/locking/lockdep.c:199 [inline]
 mark_lock+0xef/0x17b0 kernel/locking/lockdep.c:4571
 mark_usage kernel/locking/lockdep.c:4514 [inline]
 __lock_acquire+0x8a7/0x54a0 kernel/locking/lockdep.c:4969
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 batadv_nc_process_nc_paths.part.0+0xec/0x3c0 net/batman-adv/network-coding.c:689
 batadv_nc_process_nc_paths net/batman-adv/network-coding.c:681 [inline]
 batadv_nc_worker+0xce4/0xfa0 net/batman-adv/network-coding.c:737
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	0f 1f 00             	nopl   (%rax)
   3:	48 89 f2             	mov    %rsi,%rdx
   6:	be f8 00 00 00       	mov    $0xf8,%esi
   b:	e9 63 b3 3c 02       	jmpq   0x23cb373
  10:	0f 1f 00             	nopl   (%rax)
  13:	48 85 f6             	test   %rsi,%rsi
  16:	0f 84 70 01 00 00    	je     0x18c
  1c:	49 89 f9             	mov    %rdi,%r9
  1f:	41 54                	push   %r12
  21:	44 0f b6 c2          	movzbl %dl,%r8d
  25:	49 01 f1             	add    %rsi,%r9
  28:	55                   	push   %rbp
* 29:	53                   	push   %rbx <-- trapping instruction
  2a:	0f 82 18 01 00 00    	jb     0x148
  30:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
  37:	7f ff ff
  3a:	48 39 c7             	cmp    %rax,%rdi
  3d:	0f                   	.byte 0xf
  3e:	86                   	.byte 0x86


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
