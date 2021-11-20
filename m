Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B772457FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhKTRUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:20:22 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:37580 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbhKTRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:20:20 -0500
Received: by mail-il1-f198.google.com with SMTP id l5-20020a056e0212e500b0026b231dfd46so8191835iln.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 09:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AAuw6DYnNuT5kGynq+Z3OS5Zc/huVEbpekGBKTmWTd4=;
        b=yzBXqw9rTp/+wzWcJgQG6dIKAMB1tBPUBLm2IXe6ZN3EnfCZhIPe+Dngg3Cc2Zmxtk
         QhoZpjIMsdSqLJvq/U7KccFExGcRoi7PUqsNWQpSqHcVDSRq9ZnkOp2INLI6+nP6E9Mr
         dyoDf4Kx1EBwvia8TtHK2lecghduZNz0FOPcV9f1nt+MLYclRkkyIl19DmHld515S5+e
         S2OoxPjG2D/2URgF1WLO6UefqmuJ3o0ZaXnfAphXpVorrxOSOYDOPpSVONd4MxhXbKYY
         k/sm7L5JqgsokUspWRQophoS6f9W9xCiGg8ehev9ZtXW/Jt+6LzgQwDxUoeoFRrc1uvZ
         k5vw==
X-Gm-Message-State: AOAM532KfWr7lS1yRbW2wEhUewR26XNSPEqYmEkRV4DvRmkcCWO6+zl5
        u8sTAKneo1cngbHxAuG0Cozwi+OFJL3WkLZF+xK4oCCtYeHT
X-Google-Smtp-Source: ABdhPJxrM9FCNAvkF6nBH9JhZ2kROpJE05UpT9DvHjdkqSqITll3rOqk1ayfTLtNcg6XOQpMpjXGrQB9NgQhlLEVJ+vwJ2IDoh46
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:: with SMTP id q21mr35261854jat.48.1637428636361;
 Sat, 20 Nov 2021 09:17:16 -0800 (PST)
Date:   Sat, 20 Nov 2021 09:17:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003728d105d13b90c7@google.com>
Subject: [syzbot] INFO: task hung in blk_mq_freeze_queue (2)
From:   syzbot <syzbot+8ea6cf15ac5b5bb2f600@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        pcc@google.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a90af8f15bdc Merge tag 'libata-5.16-rc2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d9e6deb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b128da186442e627
dashboard link: https://syzkaller.appspot.com/bug?extid=8ea6cf15ac5b5bb2f600
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ea6cf15ac5b5bb2f600@syzkaller.appspotmail.com

INFO: task syz-executor.0:11597 blocked for more than 430 seconds.
      Not tainted 5.16.0-rc1-syzkaller-00313-ga90af8f15bdc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:    0 pid:11597 ppid:  2194 flags:0x00400001
Call trace:
 __switch_to+0x274/0x3b4 arch/arm64/kernel/process.c:526
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0x818/0x1be0 kernel/sched/core.c:6253
 schedule+0xb8/0x224 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0xf4/0x130 block/blk-mq.c:178
 blk_freeze_queue block/blk-mq.c:205 [inline]
 blk_mq_freeze_queue+0x20/0x30 block/blk-mq.c:214
 nbd_add_socket+0x134/0x690 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x42c/0x8f0 drivers/block/nbd.c:1511
 compat_blkdev_ioctl+0x774/0x9a0 block/ioctl.c:674
 __do_compat_sys_ioctl fs/ioctl.c:972 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:914 [inline]
 __arm64_compat_sys_ioctl+0x1d0/0x220 fs/ioctl.c:914
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:187
 el0_svc_compat+0x64/0x290 arch/arm64/kernel/entry-common.c:736
 el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:746
 el0t_32_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:577
INFO: task syz-executor.0:11605 blocked for more than 430 seconds.
      Not tainted 5.16.0-rc1-syzkaller-00313-ga90af8f15bdc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:    0 pid:11605 ppid:  2194 flags:0x00400001
Call trace:
 __switch_to+0x274/0x3b4 arch/arm64/kernel/process.c:526
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0x818/0x1be0 kernel/sched/core.c:6253
 schedule+0xb8/0x224 kernel/sched/core.c:6326
 schedule_preempt_disabled+0x18/0x30 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0x3c0/0x7ec kernel/locking/mutex.c:740
 mutex_lock_nested+0x78/0x100 kernel/locking/mutex.c:792
 nbd_ioctl+0x108/0x8f0 drivers/block/nbd.c:1504
 compat_blkdev_ioctl+0x774/0x9a0 block/ioctl.c:674
 __do_compat_sys_ioctl fs/ioctl.c:972 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:914 [inline]
 __arm64_compat_sys_ioctl+0x1d0/0x220 fs/ioctl.c:914
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:187
 el0_svc_compat+0x64/0x290 arch/arm64/kernel/entry-common.c:736
 el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:746
 el0t_32_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:577

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffff800015e18f20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x74/0x25c kernel/locking/lockdep.c:6460
1 lock held by syslogd/1983:
1 lock held by klogd/1987:
2 locks held by getty/2147:
 #0: ffff000013dc7098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x50 drivers/tty/tty_ldsem.c:340
 #1: ffff80001886b2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x810/0xbe0 drivers/tty/n_tty.c:2113
3 locks held by kworker/0:1/5652:
2 locks held by kworker/u4:0/8438:
1 lock held by syz-executor.0/11597:
 #0: ffff0000105d4198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x108/0x8f0 drivers/block/nbd.c:1504
1 lock held by syz-executor.0/11605:
 #0: ffff0000105d4198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x108/0x8f0 drivers/block/nbd.c:1504
3 locks held by kworker/1:0/11606:

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
