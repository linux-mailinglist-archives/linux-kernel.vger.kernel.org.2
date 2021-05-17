Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E509382A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhEQK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:57:47 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52997 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbhEQK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:57:40 -0400
Received: by mail-il1-f197.google.com with SMTP id b7-20020a056e020487b02901bb31b56af8so5926367ils.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5iIoTlWmHOI2C29PmRlvFB6YEj33u2SIMrpUVwF/jMM=;
        b=uTAqj+o1O9LK1UbVgM+zSrnrEV97SKotrbhIO+lww4KwScSp4SYWQe911un/0L0XBc
         i/pG3FcK3r6uCB/3w5Wog8OAR+DEg7q4yHKkDfwCotDdxYVZakP6aNIJi5pIAjyn+YkJ
         TFGkMWK3v97u6hf7axgcYC+cUwCNHZ9eHp/d61Gl0BvGEf1Un3miAFTFJOlVH13WZ+KH
         g7qu2UnXIS6Y18OGjaeD7zB1t+JCTmwzRhOjA8lYBY9LdBQKIRzIO3EH7zUoz1qmgazC
         xRW+hUfMJdtocwXxlFin1LLoL1Rd9Rl4PhjcqDXPDliJoFBhE6BO187CVMro/hexMvEz
         ktYw==
X-Gm-Message-State: AOAM53214NV0Lktv+YaG6qi+rRqCyvoUPLlK4KVMO84l+pz8seos+sNs
        YbVVmoiKLVqGQ3SzHD8ECoj3zeJazkJKSLKdoFZ0ID/ErldQ
X-Google-Smtp-Source: ABdhPJzoIrNNbHx/OG3cWTzepju2sQ9MGkhjikNOEKFOW0RGNu6VXw2cwktthHzkoC58cveAdi07n7pD1vfLaXaOGfcl8zAeZmON
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1002:: with SMTP id n2mr49711952ilj.260.1621248982875;
 Mon, 17 May 2021 03:56:22 -0700 (PDT)
Date:   Mon, 17 May 2021 03:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b782b505c2847180@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ntfs_test_inode
From:   syzbot <syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9cdbf646 Merge tag 'io_uring-5.12-2021-04-16' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11684629d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=330c6a2c09278509
dashboard link: https://syzkaller.appspot.com/bug?extid=2751da923b5eb8307b0b
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2751da923b5eb8307b0b@syzkaller.appspotmail.com

ntfs: volume version 3.1.
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: use-after-free in NInoAttr fs/ntfs/inode.h:200 [inline]
BUG: KASAN: use-after-free in ntfs_test_inode+0x7b/0x2d0 fs/ntfs/inode.c:55
Read of size 8 at addr ffff8880974790f0 by task syz-executor.3/12887

CPU: 1 PID: 12887 Comm: syz-executor.3 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 print_address_description+0x5f/0x3a0 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report+0x15c/0x200 mm/kasan/report.c:416
 check_region_inline mm/kasan/generic.c:135 [inline]
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:186
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 NInoAttr fs/ntfs/inode.h:200 [inline]
 ntfs_test_inode+0x7b/0x2d0 fs/ntfs/inode.c:55
 find_inode+0x10c/0x3e0 fs/inode.c:825
 ilookup5_nowait fs/inode.c:1335 [inline]
 ilookup5+0x9d/0x1f0 fs/inode.c:1364
 iget5_locked+0x30/0x3d0 fs/inode.c:1145
 ntfs_iget+0x73/0x130 fs/ntfs/inode.c:168
 load_and_check_logfile fs/ntfs/super.c:1208 [inline]
 load_system_files fs/ntfs/super.c:1941 [inline]
 ntfs_fill_super+0x58f2/0x88e0 fs/ntfs/super.c:2893
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x188a/0x29a0 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46797a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50a372bfa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 000000000046797a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f50a372c000
RBP: 00007f50a372c040 R08: 00007f50a372c040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f50a372c000 R15: 000000002007dc00

Allocated by task 11540:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 __kasan_slab_alloc+0x8f/0xc0 mm/kasan/common.c:460
 kasan_slab_alloc include/linux/kasan.h:223 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 kmem_cache_alloc+0x1c3/0x350 mm/slub.c:2920
 reiserfs_alloc_inode+0x19/0xb0 fs/reiserfs/super.c:642
 alloc_inode fs/inode.c:234 [inline]
 new_inode_pseudo+0x61/0x220 fs/inode.c:928
 new_inode+0x25/0x1d0 fs/inode.c:957
 reiserfs_mkdir+0x129/0x800 fs/reiserfs/namei.c:812
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:889 [inline]
 reiserfs_xattr_init+0x34b/0x730 fs/reiserfs/xattr.c:1012
 reiserfs_fill_super+0x2aac/0x3160 fs/reiserfs/super.c:2177
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x188a/0x29a0 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0x130/0x8e0 kernel/rcu/tree.c:3114
 reiserfs_new_inode+0x690/0x2660 fs/reiserfs/inode.c:2164
 reiserfs_mkdir+0x4a0/0x800 fs/reiserfs/namei.c:842
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:889 [inline]
 reiserfs_xattr_init+0x34b/0x730 fs/reiserfs/xattr.c:1012
 reiserfs_fill_super+0x2aac/0x3160 fs/reiserfs/super.c:2177
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x188a/0x29a0 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888097478c20
 which belongs to the cache reiser_inode_cache of size 1424
The buggy address is located 1232 bytes inside of
 1424-byte region [ffff888097478c20, ffff8880974791b0)
The buggy address belongs to the page:
page:ffffea00025d1e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888097479840 pfn:0x97478
head:ffffea00025d1e00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888018116500
raw: ffff888097479840 0000000080150014 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097478f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097479000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888097479080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888097479100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097479180: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
