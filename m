Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5A3BEA21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhGGO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:59:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51751 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhGGO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:59:18 -0400
Received: by mail-io1-f72.google.com with SMTP id x21-20020a5d99150000b02904e00bb129f0so1798954iol.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pf6VZ22fSZR5ROkaZ00fSm1pK8614Mu21PT8tzHS51c=;
        b=kcYEFrdztetr7GXSSfS4JQxVxppOY4MTUV9fpoQ1uaNuS3wn1t++nAL+o0nw4tLIpI
         H0AJVsfU5TlVYR0hCvTQhfq9OA2b5RINRRFY8e3l8JoMI6sutsPV3HZphR99AFclNpQJ
         PLm0TcJpsZEIsi7VTyJ3c9rLCIZZbUdVHAhhg7rrWn6hmcv6Je4ISe6oSRxCLNB0qPK2
         eQpJ21A4aivUl0XtPtmmVXfXmW2RebkJ0A7kPTW//SCp+Yz8u2Hj+mc7W1tpPlCcI6kL
         EedTxOv74lEKnmFy1Rh6VGj5Csz5qeb0iKUXD098XIsd0SLawnVXRIg0B44PwURibPiQ
         lXmg==
X-Gm-Message-State: AOAM533BwRytFpc8zK7FIniMKs9lxhVbKo7zGt+/5EZwrRLTnz1N9GW+
        /ni5Bqaf3DnT9XQVkY+3eM9rr5i5aiH41RvYoHkhow/1c2Tx
X-Google-Smtp-Source: ABdhPJwTevBzQct6vPdTFoJasDvrx+dANqbV6mTP6CDcfkapYC3Jgi/V2uh5snABDApVmOAA3qTzKl84WyFTHDG72V1O3q9gCiiG
MIME-Version: 1.0
X-Received: by 2002:a6b:c707:: with SMTP id x7mr19924666iof.160.1625669602195;
 Wed, 07 Jul 2021 07:53:22 -0700 (PDT)
Date:   Wed, 07 Jul 2021 07:53:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029401005c689b36c@google.com>
Subject: [syzbot] memory leak in ext4_mb_new_blocks
From:   syzbot <syzbot+d00808b55445133eca1e@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f472e4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55ac6a927d7e3fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=d00808b55445133eca1e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1258bdfc300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d00808b55445133eca1e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888113d82958 (size 104):
  comm "kworker/u4:0", pid 8, jiffies 4294943328 (age 340.640s)
  hex dump (first 32 bytes):
    c0 33 c0 13 81 88 ff ff 22 01 00 00 00 00 ad de  .3......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff8176822b>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff8176822b>] ext4_mb_pa_alloc fs/ext4/mballoc.c:4974 [inline]
    [<ffffffff8176822b>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5509
    [<ffffffff817238ed>] ext4_ext_map_blocks+0xdfd/0x28f0 fs/ext4/extents.c:4245
    [<ffffffff81746633>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:638
    [<ffffffff8174d632>] mpage_map_one_extent fs/ext4/inode.c:2395 [inline]
    [<ffffffff8174d632>] mpage_map_and_submit_extent fs/ext4/inode.c:2448 [inline]
    [<ffffffff8174d632>] ext4_writepages+0xc82/0x19c0 fs/ext4/inode.c:2800
    [<ffffffff81451c5a>] do_writepages+0x4a/0x120 mm/page-writeback.c:2355
    [<ffffffff815bd0be>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1610
    [<ffffffff815bdc34>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1875
    [<ffffffff815be0cb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1944
    [<ffffffff815be5f3>] wb_writeback+0x433/0x4a0 fs/fs-writeback.c:2050
    [<ffffffff815c007a>] wb_check_old_data_flush fs/fs-writeback.c:2152 [inline]
    [<ffffffff815c007a>] wb_do_writeback fs/fs-writeback.c:2205 [inline]
    [<ffffffff815c007a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2234
    [<ffffffff812627d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff812630c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126c528>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888113d82a28 (size 104):
  comm "kworker/u4:0", pid 8, jiffies 4294943328 (age 340.640s)
  hex dump (first 32 bytes):
    d8 08 c1 13 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff8176822b>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff8176822b>] ext4_mb_pa_alloc fs/ext4/mballoc.c:4974 [inline]
    [<ffffffff8176822b>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5509
    [<ffffffff817238ed>] ext4_ext_map_blocks+0xdfd/0x28f0 fs/ext4/extents.c:4245
    [<ffffffff81746633>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:638
    [<ffffffff8174d632>] mpage_map_one_extent fs/ext4/inode.c:2395 [inline]
    [<ffffffff8174d632>] mpage_map_and_submit_extent fs/ext4/inode.c:2448 [inline]
    [<ffffffff8174d632>] ext4_writepages+0xc82/0x19c0 fs/ext4/inode.c:2800
    [<ffffffff81451c5a>] do_writepages+0x4a/0x120 mm/page-writeback.c:2355
    [<ffffffff815bd0be>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1610
    [<ffffffff815bdc34>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1875
    [<ffffffff815be0cb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1944
    [<ffffffff815be5f3>] wb_writeback+0x433/0x4a0 fs/fs-writeback.c:2050
    [<ffffffff815c007a>] wb_check_old_data_flush fs/fs-writeback.c:2152 [inline]
    [<ffffffff815c007a>] wb_do_writeback fs/fs-writeback.c:2205 [inline]
    [<ffffffff815c007a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2234
    [<ffffffff812627d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff812630c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126c528>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888113d82a90 (size 104):
  comm "kworker/u4:0", pid 8, jiffies 4294943328 (age 340.640s)
  hex dump (first 32 bytes):
    b0 1d c1 13 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff8176822b>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff8176822b>] ext4_mb_pa_alloc fs/ext4/mballoc.c:4974 [inline]
    [<ffffffff8176822b>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5509
    [<ffffffff817238ed>] ext4_ext_map_blocks+0xdfd/0x28f0 fs/ext4/extents.c:4245
    [<ffffffff81746633>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:638
    [<ffffffff8174d632>] mpage_map_one_extent fs/ext4/inode.c:2395 [inline]
    [<ffffffff8174d632>] mpage_map_and_submit_extent fs/ext4/inode.c:2448 [inline]
    [<ffffffff8174d632>] ext4_writepages+0xc82/0x19c0 fs/ext4/inode.c:2800
    [<ffffffff81451c5a>] do_writepages+0x4a/0x120 mm/page-writeback.c:2355
    [<ffffffff815bd0be>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1610
    [<ffffffff815bdc34>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1875
    [<ffffffff815be0cb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1944
    [<ffffffff815be5f3>] wb_writeback+0x433/0x4a0 fs/fs-writeback.c:2050
    [<ffffffff815c007a>] wb_check_old_data_flush fs/fs-writeback.c:2152 [inline]
    [<ffffffff815c007a>] wb_do_writeback fs/fs-writeback.c:2205 [inline]
    [<ffffffff815c007a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2234
    [<ffffffff812627d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff812630c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126c528>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888123294558 (size 1176):
  comm "syz-executor.1", pid 8467, jiffies 4294969731 (age 76.670s)
  hex dump (first 32 bytes):
    0a f3 00 00 04 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81794e19>] ext4_alloc_inode+0x19/0x1a0 fs/ext4/super.c:1281
    [<ffffffff81598827>] alloc_inode+0x27/0x100 fs/inode.c:233
    [<ffffffff81598923>] new_inode_pseudo fs/inode.c:934 [inline]
    [<ffffffff81598923>] new_inode+0x23/0x100 fs/inode.c:963
    [<ffffffff81735ce7>] __ext4_new_inode+0x127/0x26d0 fs/ext4/ialloc.c:958
    [<ffffffff8177c2bf>] ext4_mkdir+0x1ef/0x550 fs/ext4/namei.c:2921
    [<ffffffff8157b7a8>] vfs_mkdir+0x258/0x330 fs/namei.c:3813
    [<ffffffff81582155>] do_mkdirat+0x1a5/0x1f0 fs/namei.c:3838
    [<ffffffff8439b235>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8439b235>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

[  401.478399][    C


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
