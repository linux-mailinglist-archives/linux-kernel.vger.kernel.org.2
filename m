Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014743212C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBVJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:07:04 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38431 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBVJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:06:04 -0500
Received: by mail-io1-f72.google.com with SMTP id a12so8904128ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8i7ef9mdZEz8Dc+R8e8QwH0oS5yU5a2BOPEpeW6o6e0=;
        b=cbGJl5kAl+xkHsmXerLyT9NKmm/6Zpibh+fhJhk78wseADxeptA+COcLKkigRghuB/
         XrHiNK628p2bnH/DXxhS/i5TV7fzVKyJUMZdG2TZ1cT48B4yb07VOU58wKxZcXicifCo
         48Q39kRPp1JgNYqvKwMYjDfSeMV0DTwLW5j1goc5ZZSs8xeyJdFsSCi9fGTdFsE/Ez6w
         bKjDrfsqhhFfVzW2HN4Eh+gVlwCtULz8eeU3ATis2MUrvK671m4d1hnc5F9LzxLOkrwt
         gUrzKTg5xACFF7PdDaLcDgo+/7EVt/GsMKDcgTcmeQqhXR6kmlDoVEDuR3j6JbmAOQsI
         1JGQ==
X-Gm-Message-State: AOAM532KSvlcyLGka5EmabZ564v/Nobs2oqxTsF3Vwvc1FqkG/FaMIRc
        ERIUKZDX40mEQbU4/R+pVvPOsY4UT1HQAHNZ7M921al7DsBg
X-Google-Smtp-Source: ABdhPJwGgAOvJUe1Q6FMdHe4ViTUsyrTLvEbwfsMrB1J+WrFYV/I/R2vA0dWD1QtpGeIq+Knk1BUcqNXynGbhKvtBeVJpLoWd0aW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:96c:: with SMTP id o12mr21406318jaj.24.1613984720377;
 Mon, 22 Feb 2021 01:05:20 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:05:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee58d305bbe9197a@google.com>
Subject: memory leak in con_do_clear_unimap
From:   syzbot <syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, efremov@linux.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e767b353 Merge tag 'arm-drivers-v5.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150add22d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dda858c0a83826
dashboard link: https://syzkaller.appspot.com/bug?extid=bcc922b19ccc64240b42
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a12446d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154e6d22d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com

write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.130s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.130s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.130s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.140s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.140s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.140s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.200s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.260s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.320s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.380s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.440s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.500s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115b08e00 (size 512):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    00 7d f6 14 81 88 ff ff 00 72 f6 14 81 88 ff ff  .}.......r......
    00 71 f6 14 81 88 ff ff 00 ba b2 15 81 88 ff ff  .q..............
  backtrace:
    [<00000000949419ca>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000949419ca>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000949419ca>] con_do_clear_unimap+0xa6/0x140 drivers/tty/vt/consolemap.c:510
    [<00000000be05b978>] con_set_unimap+0x1ae/0x350 drivers/tty/vt/consolemap.c:564
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114f67d00 (size 256):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    80 91 87 14 81 88 ff ff 00 ae de 14 81 88 ff ff  ................
    80 af de 14 81 88 ff ff 00 af de 14 81 88 ff ff  ................
  backtrace:
    [<000000004f6cc060>] kmalloc include/linux/slab.h:552 [inline]
    [<000000004f6cc060>] kmalloc_array include/linux/slab.h:591 [inline]
    [<000000004f6cc060>] con_insert_unipair+0x9b/0x1a0 drivers/tty/vt/consolemap.c:482
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114879180 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deae00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    40 00 41 00 42 00 43 00 44 00 45 00 46 00 47 00  @.A.B.C.D.E.F.G.
    48 00 49 00 4a 00 4b 00 4c 00 4d 00 4e 00 4f 00  H.I.J.K.L.M.N.O.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf80 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888114deaf00 (size 128):
  comm "syz-executor181", pid 8852, jiffies 4295096812 (age 158.560s)
  hex dump (first 32 bytes):
    41 00 41 00 41 00 41 00 8e 00 8f 00 92 00 80 00  A.A.A.A.........
    45 00 90 00 45 00 45 00 49 00 49 00 49 00 49 00  E...E.E.I.I.I.I.
  backtrace:
    [<00000000586d43ff>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000586d43ff>] kmalloc_array include/linux/slab.h:591 [inline]
    [<00000000586d43ff>] con_insert_unipair+0xf5/0x1a0 drivers/tty/vt/consolemap.c:491
    [<00000000a258f6e6>] con_set_unimap+0x2e4/0x350 drivers/tty/vt/consolemap.c:595
    [<000000007184d814>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:562 [inline]
    [<000000007184d814>] vt_io_ioctl drivers/tty/vt/vt_ioctl.c:644 [inline]
    [<000000007184d814>] vt_ioctl+0x2b1/0x19d0 drivers/tty/vt/vt_ioctl.c:817
    [<00000000e3ea544f>] tty_ioctl+0x713/0xcb0 drivers/tty/tty_io.c:2675
    [<000000004efd2c65>] vfs_ioctl fs/ioctl.c:48 [inline]
    [<000000004efd2c65>] __do_sys_ioctl fs/ioctl.c:753 [inline]
    [<000000004efd2c65>] __se_sys_ioctl fs/ioctl.c:739 [inline]
    [<000000004efd2c65>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
    [<00000000ef611fc3>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000039ee10fc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
