Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C814E3B90EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhGALCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:02:50 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48070 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhGALCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:02:48 -0400
Received: by mail-il1-f198.google.com with SMTP id q2-20020a92d4020000b02901effd8a8dbdso3763871ilm.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9c2b6EZqVSgPovP0ldDl5Q0+VuIyN7KqLDPJPk7apAQ=;
        b=Lc5KlDITfhB6Zp3xX08bCLqB94szOPtiSssoEujfeqomj5nSg7KztfyezuF+jqDrKx
         bsBEiXoyXjnIwBF8fKKS/l3U4f9nrj4/KaikG+X/tev3YXWk1HjdENwB3ycKDQ+9Mc0S
         OG9bqdxmfB40eF+5OTFVG9gUndJUL5cAX3kTJm6HrDURrGovpNuk2/umoHe7pppkiuxU
         853QAL4yJq4pjyXO+Qd6lWWtQosS7eiyLkWs5qzIbRff+2+qm1zy7YjBgZsK5UfJErpU
         H+zF5IhA5SPix3MbXVRnW4Qst//93DQOfbjVUbbzR3ZKwlT0mD65Earv1dTd6Zm0ug9/
         VhNw==
X-Gm-Message-State: AOAM532fj8EJJPPhSC7ZiPHmbIjAlidQQ2/VbQVvOvaxqgAU+5S2Gi+d
        skmMqKFjoiV1fEcodAT6zROMzLQyBzQv+zR999BXwJ1JGnX1
X-Google-Smtp-Source: ABdhPJz+h1+DziMAADmtmdNQVKeuz3EcGt5iyJdSiVrE/kwIjNMfy2pF42YctA5Pi2EARisXXYHsb3DMe/OdhM7ERRQM2R3N3gdJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:19:: with SMTP id b25mr4190322ioa.93.1625137218484;
 Thu, 01 Jul 2021 04:00:18 -0700 (PDT)
Date:   Thu, 01 Jul 2021 04:00:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e7f6405c60dbe3b@google.com>
Subject: [syzbot] upstream test error: BUG: sleeping function called from
 invalid context in stack_depot_save
From:   syzbot <syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dbe69e43 Merge tag 'net-next-5.14' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216d478300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47e4697be2f5b985
dashboard link: https://syzkaller.appspot.com/bug?extid=e45919db2eab5e837646

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8436, name: syz-fuzzer
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff814406db>] copy_process+0x1e1b/0x74c0 kernel/fork.c:2061
softirqs last  enabled at (0): [<ffffffff8144071c>] copy_process+0x1e5c/0x74c0 kernel/fork.c:2065
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 1 PID: 8436 Comm: syz-fuzzer Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3066
 n_tty_open+0x16/0x170 drivers/tty/n_tty.c:1914
 tty_ldisc_open+0x9b/0x110 drivers/tty/tty_ldisc.c:464
 tty_ldisc_setup+0x43/0x100 drivers/tty/tty_ldisc.c:781
 tty_init_dev.part.0+0x1f4/0x610 drivers/tty/tty_io.c:1461
 tty_init_dev include/linux/err.h:36 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
 tty_open+0xb16/0x1000 drivers/tty/tty_io.c:2150
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4c8/0x11c0 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x1c0e/0x27e0 fs/namei.c:3494
 do_filp_open+0x190/0x3d0 fs/namei.c:3521
 do_sys_openat2+0x16d/0x420 fs/open.c:1195
 do_sys_open fs/open.c:1211 [inline]
 __do_sys_openat fs/open.c:1227 [inline]
 __se_sys_openat fs/open.c:1222 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1222
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4af20a
Code: e8 3b 82 fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
RSP: 002b:000000c0003293f8 EFLAGS: 00000216 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000c00001e800 RCX: 00000000004af20a
RDX: 0000000000000000 RSI: 000000c0001a5a50 RDI: ffffffffffffff9c
RBP: 000000c000329470 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: 00000000000001a6
R13: 00000000000001a5 R14: 0000000000000200 R15: 000000c00029c280
can: request_module (can-proto-0) failed.
can: request_module (can-proto-0) failed.
can: request_module (can-proto-0) failed.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
