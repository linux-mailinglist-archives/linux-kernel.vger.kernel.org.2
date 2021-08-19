Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F93F11FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhHSDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:39:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56247 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhHSDix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:38:53 -0400
Received: by mail-il1-f197.google.com with SMTP id c16-20020a92cf500000b02902243aec7e27so2478281ilr.22
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sD3IhI8I8F4GfojL6Xztt7W86JHJ8XJr6Z6lHwY+hCY=;
        b=ANWrmJOx/KwQjH7q2zYSNvRvBMxu/vtZg2A28kv5K8IKcw/WTRb5epl6E4Sd6XtqjG
         qw3vT/Eum6yZV6HUwmDPPn1g/Gs+bS8bsDnnycwm2esYcRIqQ43TK9Bh74CWmEiBmuHr
         AoLy2r4KXntjNoM/mdAO6Uonq21aY/Rey0uHGS0WpWXQm2hvg/glYHKQRh5AdpazWcxM
         npsNQwRmBfBDd6GTb0IwCTf9L9jpX0ZMgwNvAOUYzrXEOi/J8xarheqbmi4NT2mVusev
         QmUE5xA6MesNkk2ipEKkhgg9N+jHNyTDWzEu1Lh3p4bc2xk3MBLxVFRv9+aBcH1Hbkey
         ouEg==
X-Gm-Message-State: AOAM531hipzjAHN8P99YdqBHW3PhGPNsZy6LLXDspp6k78WxXsnaTSbN
        WlaZZuInHMzx9mWl88vjSJlrDEh2aVFTL6JZtTF69gXu/ozs
X-Google-Smtp-Source: ABdhPJyMcCyTO7dY5juU2DxcQYstRl+SOyB01csyV2KWRNOhuMgW9a7jrwlhZdcq4oNIzxoZvpdIrqy/p9to0eIHGz6B424VyVd5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:419a:: with SMTP id az26mr10984368jab.70.1629344297310;
 Wed, 18 Aug 2021 20:38:17 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:38:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ee20205c9e14847@google.com>
Subject: [syzbot] INFO: task hung in paste_selection (2)
From:   syzbot <syzbot+275e275bd3f536725dd8@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ba31f97d43be Merge tag 'for-linus-5.14-rc6-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164e6029300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4c14ee9417b86
dashboard link: https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1748d5e9300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1224480e300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1124480e300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1624480e300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+275e275bd3f536725dd8@syzkaller.appspotmail.com

INFO: task syz-executor.2:11296 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26608 pid:11296 ppid:  8460 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007f44ea906188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc35f8d6ef R14: 00007f44ea906300 R15: 0000000000022000
INFO: task syz-executor.0:11318 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26192 pid:11318 ppid:  8465 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007ff4c2f66188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd9ef4a9ff R14: 00007ff4c2f66300 R15: 0000000000022000
INFO: task syz-executor.5:11319 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26192 pid:11319 ppid:  8467 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007f5ce9504188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffea01cd2ff R14: 00007f5ce9504300 R15: 0000000000022000
INFO: task syz-executor.3:11320 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:26192 pid:11320 ppid:  8463 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007fa643e44188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007fff63831fff R14: 00007fa643e44300 R15: 0000000000022000
INFO: task syz-executor.1:11323 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26192 pid:11323 ppid:  8466 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007f873e729188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc8233192f R14: 00007f873e729300 R15: 0000000000022000
INFO: task syz-executor.5:11341 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26192 pid:11341 ppid:  8467 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007f5ce9504188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffea01cd2ff R14: 00007f5ce9504300 R15: 0000000000022000
INFO: task syz-executor.4:11343 blocked for more than 146 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:26192 pid:11343 ppid:  8458 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007feaaac8d188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc26e9f25f R14: 00007feaaac8d300 R15: 0000000000022000
INFO: task syz-executor.0:11347 blocked for more than 146 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26192 pid:11347 ppid:  8465 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007ff4c2f66188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd9ef4a9ff R14: 00007ff4c2f66300 R15: 0000000000022000
INFO: task syz-executor.3:11348 blocked for more than 147 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:26192 pid:11348 ppid:  8463 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007fa643e44188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007fff63831fff R14: 00007fa643e44300 R15: 0000000000022000
INFO: task syz-executor.1:11349 blocked for more than 147 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26192 pid:11349 ppid:  8466 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5938
 schedule+0x14b/0x210 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common+0x116f/0x3770 kernel/locking/mutex.c:1036
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
 vt_ioctl+0x455/0x37b0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
RSP: 002b:00007f873e729188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc8233192f R14: 00007f873e729300 R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1631:
 #0: ffffffff8c717e80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30 arch/x86/pci/mmconfig_64.c:151
1 lock held by in:imklog/8110:
 #0: ffff888017ab4d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:974
2 locks held by login/8116:
 #0: ffff88801eaa41c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: __tty_hangup+0xc3/0x730 drivers/tty/tty_io.c:599
 #1: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:300 [inline]
 #1: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:324
2 locks held by syz-executor.2/11296:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.4/11303:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.0/11318:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.5/11319:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.3/11320:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.1/11323:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.5/11341:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.4/11343:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.0/11347:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.3/11348:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.1/11349:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390
2 locks held by syz-executor.4/11364:
 #0: ffff88801eaa4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880110790b8 (&buf->lock){+.+.}-{3:3}, at: paste_selection+0x155/0x500 drivers/tty/vt/selection.c:390

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1631 Comm: khungtaskd Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1d3/0x29f lib/dump_stack.c:105
 nmi_cpu_backtrace+0x16c/0x190 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x191/0x2f0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd06/0xd50 kernel/hung_task.c:295
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10 Comm: kworker/u4:1 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:kasan_check_range+0x9/0x2f0 mm/kasan/generic.c:188
Code: 08 31 c0 c3 0f 0b b8 ea ff ff ff c3 0f 0b b8 ea ff ff ff c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41 55 41 54 53 <b0> 01 48 85 f6 0f 84 0d 02 00 00 48 89 fb 48 01 f3 0f 82 8d 02 00
RSP: 0018:ffffc90000cf7a08 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff816212eb
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8dba66a8
RBP: ffffc90000cf7bd8 R08: 0000000000000000 R09: 0000000000000000
R10: fffffbfff1b74cd6 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff9200019ef58 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb74f018000 CR3: 000000000c48e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
 cpu_online include/linux/cpumask.h:895 [inline]
 trace_lock_acquire+0x3b/0x190 include/trace/events/lock.h:13
 lock_acquire+0xa4/0x4a0 kernel/locking/lockdep.c:5596
 rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:267
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:404 [inline]
 batadv_nc_worker+0xc8/0x5b0 net/batman-adv/network-coding.c:715
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess):
   0:	08 31                	or     %dh,(%rcx)
   2:	c0 c3 0f             	rol    $0xf,%bl
   5:	0b b8 ea ff ff ff    	or     -0x16(%rax),%edi
   b:	c3                   	retq   
   c:	0f 0b                	ud2    
   e:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  13:	c3                   	retq   
  14:	cc                   	int3   
  15:	cc                   	int3   
  16:	cc                   	int3   
  17:	cc                   	int3   
  18:	cc                   	int3   
  19:	cc                   	int3   
  1a:	cc                   	int3   
  1b:	cc                   	int3   
  1c:	cc                   	int3   
  1d:	cc                   	int3   
  1e:	cc                   	int3   
  1f:	cc                   	int3   
  20:	cc                   	int3   
  21:	41 57                	push   %r15
  23:	41 56                	push   %r14
  25:	41 55                	push   %r13
  27:	41 54                	push   %r12
  29:	53                   	push   %rbx
  2a:	b0 01                	mov    $0x1,%al <-- trapping instruction
  2c:	48 85 f6             	test   %rsi,%rsi
  2f:	0f 84 0d 02 00 00    	je     0x242
  35:	48 89 fb             	mov    %rdi,%rbx
  38:	48 01 f3             	add    %rsi,%rbx
  3b:	0f                   	.byte 0xf
  3c:	82                   	(bad)  
  3d:	8d 02                	lea    (%rdx),%eax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
