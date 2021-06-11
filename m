Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23A73A4192
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhFKMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:03:32 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39453 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhFKMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:03:31 -0400
Received: by mail-io1-f72.google.com with SMTP id n1-20020a6b8b010000b02904be419d64eeso8863113iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3h3zYX7S/XU1pNnyF7wjc3S3Ti3iJgcXhX6UDGf6V8M=;
        b=BjqK43AlW6+zEJL4WrJ7FiluV/eojBtZHFXfVcJl9A9m1rn9mjDUlGKZ21yoaqZvVK
         79g9jc2QkeG/MPbXhx2g99aEVn2PCx5EnuAECIuLMBBrHZEP5xEatHCIX0X8xlco9VSA
         A/fnNbMnPSPyp4nypYnDIGNEk49z+leKtoiMgtjOZQmopu5Ed5MgkB/sXjuR2t//qp/4
         D1o6rcJN4uwXGar5M0d5FmjqQrD7ZrhDcukswWgEkEfRZ61lFuaunJn0SuSy6cs7BXR/
         ABJFI7Q2xIqYaL1aEsk2Wv41MAD2ItbmLQOW11MWGPkNT7A+gZs0R8Zvl5hzRnr2WDm3
         GS/Q==
X-Gm-Message-State: AOAM532FeEybUSg5Rjhl25DflPisXWRBeC3Y+zdJgbulbDJJtn++vCtF
        P86hdsAl3IcCIciW9t0IO4nkd3GWQITkrI+yv9bhtQEU8gD/
X-Google-Smtp-Source: ABdhPJw4UJ7yns8oXn/uH/8mm0acq+gRxMXvWTotY8C21asQzDdGsoZ6dibrP2HT7+KWX0GR29/uSNB9tpX5d8f4zMjDRRV5bEig
MIME-Version: 1.0
X-Received: by 2002:a92:7c02:: with SMTP id x2mr2979702ilc.8.1623412878113;
 Fri, 11 Jun 2021 05:01:18 -0700 (PDT)
Date:   Fri, 11 Jun 2021 05:01:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec812705c47c4342@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in kernfs_iop_get_link
From:   syzbot <syzbot+9fa589353c6e1587c6b3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614124be Linux 5.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6cdbbd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=9fa589353c6e1587c6b3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fa589353c6e1587c6b3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.13.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
no locks held by systemd-udevd/13755.

stack backtrace:
CPU: 0 PID: 13755 Comm: systemd-udevd Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8304
 might_alloc include/linux/sched/mm.h:201 [inline]
 slab_pre_alloc_hook mm/slab.h:497 [inline]
 slab_alloc_node mm/slub.c:2834 [inline]
 slab_alloc mm/slub.c:2921 [inline]
 kmem_cache_alloc_trace+0x277/0x2c0 mm/slub.c:2938
 kmalloc include/linux/slab.h:556 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 kernfs_iop_get_link fs/kernfs/symlink.c:135 [inline]
 kernfs_iop_get_link+0x61/0x6e0 fs/kernfs/symlink.c:126
 pick_link fs/namei.c:1741 [inline]
 step_into+0x168e/0x1c80 fs/namei.c:1798
 open_last_lookups fs/namei.c:3308 [inline]
 path_openat+0x491/0x27e0 fs/namei.c:3491
 do_filp_open+0x190/0x3d0 fs/namei.c:3521
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1207
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0ff9316840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffeb81b55a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000701 RCX: 00007f0ff9316840
RDX: 0000000000000001 RSI: 0000000000080000 RDI: 00007ffeb81b55b0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000012
R10: 0000000000000064 R11: 0000000000000246 R12: 00007ffeb81b6600
R13: 00007ffeb81b7690 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
