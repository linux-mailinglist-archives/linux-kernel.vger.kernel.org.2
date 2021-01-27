Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9C306178
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhA0RBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:01:19 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38215 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhA0Q7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:59:01 -0500
Received: by mail-il1-f197.google.com with SMTP id p14so2195767ilb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1VeXRXUgyoTJpvS7nTXyHATKESPsjJmQOl89mqXj9NU=;
        b=RIsHhEZkUr2iV2sfCPtYzR908SdsVFusJjH4Fjrw+GUScB9zcpHDq90tOf6OUKUHeW
         2NQB5HN2LxzOQHCI+P1guoMl0dcHDPyUFhohRU94cx3UBEDCAqGi1AzRqk1KpXY5DfCM
         JzplBCFzKw1L2Do1pxNzKg5ueuwk+ghQ27x822g9TIgVmIw3a74JnF+1udDk77L41bhN
         y5qI5UdFICIoefp3eLEWZidWF176GZN++djmOmTS825zVDvG22yupESFPD62C8RCrkSc
         Jal68v3fq7+asNJVRvIN9E9VTuhLoJexZWptPnKuqbvRSyljw8K+GGSPF+LSudpsyvsS
         O+yg==
X-Gm-Message-State: AOAM5331efoy/SI/Op72DVcyP7z4CM8w4U06vqHzIpBLCljI1c5NP+G4
        k4/oeMUSy5AOjmOoNVm7zlavzhVSA6WILnsqWpobxoTZJqj+
X-Google-Smtp-Source: ABdhPJy2zef1Ub0CxcyqIH/l7vnQ7xBPcROxJDbjn2cvqI6LX22tt1gGLwqVTlau8ZiGXN4dsLsya3qFTGc6mG4ILb8PQZg7+M7D
MIME-Version: 1.0
X-Received: by 2002:a6b:c949:: with SMTP id z70mr8310526iof.80.1611766698946;
 Wed, 27 Jan 2021 08:58:18 -0800 (PST)
Date:   Wed, 27 Jan 2021 08:58:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d396205b9e4adee@google.com>
Subject: KASAN: invalid-access Read in kmem_cache_destroy
From:   syzbot <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com>
To:     amit.kachhap@arm.com, broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com

loop0: detected capacity change from 131072 to 0
F2FS-fs (loop0): Found nat_bits in checkpoint
==================================================================
BUG: KASAN: invalid-access in kmem_cache_destroy+0x34/0x174 mm/slab_common.c:492
Read at addr fbff00000cd1ef40 by task syz-executor.0/8859
Pointer tag: [fb], memory tag: [fe]

CPU: 0 PID: 8859 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00037-g2ab38c17aac1 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x1b0 arch/arm64/kernel/stacktrace.c:117
 show_stack+0x1c/0x70 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xd0/0x12c lib/dump_stack.c:120
 print_address_description+0x70/0x29c mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report+0x104/0x200 mm/kasan/report.c:413
 report_tag_fault arch/arm64/mm/fault.c:311 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:325 [inline]
 __do_kernel_fault+0x17c/0x1c0 arch/arm64/mm/fault.c:369
 do_bad_area arch/arm64/mm/fault.c:462 [inline]
 do_tag_check_fault+0x78/0x8c arch/arm64/mm/fault.c:717
 do_mem_abort+0x44/0xbc arch/arm64/mm/fault.c:793
 el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
 el1_sync_handler+0xb0/0xcc arch/arm64/kernel/entry-common.c:209
 el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
 kmem_cache_destroy+0x34/0x174 mm/slab_common.c:492
 f2fs_recover_fsync_data+0x60c/0x1cc0 fs/f2fs/recovery.c:869
 f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
 mount_bdev+0x1c4/0x1f0 fs/super.c:1366
 f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
 legacy_get_tree+0x34/0x64 fs/fs_context.c:592
 vfs_get_tree+0x2c/0xf0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x3e8/0xaf0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699

Allocated by task 8858:
 stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
 kasan_save_stack+0x2c/0x60 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc+0xe8/0x160 mm/kasan/common.c:429
 __kasan_slab_alloc+0x20/0x30 mm/kasan/common.c:437
 kasan_slab_alloc include/linux/kasan.h:209 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2892 [inline]
 slab_alloc mm/slub.c:2900 [inline]
 kmem_cache_alloc+0x1b0/0x310 mm/slub.c:2905
 kmem_cache_zalloc include/linux/slab.h:672 [inline]
 create_cache mm/slab_common.c:246 [inline]
 kmem_cache_create_usercopy+0x148/0x2ac mm/slab_common.c:352
 kmem_cache_create+0x20/0x30 mm/slab_common.c:410
 f2fs_kmem_cache_create fs/f2fs/f2fs.h:2411 [inline]
 f2fs_recover_fsync_data+0x7c/0x1cc0 fs/f2fs/recovery.c:790
 f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
 mount_bdev+0x1c4/0x1f0 fs/super.c:1366
 f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
 legacy_get_tree+0x34/0x64 fs/fs_context.c:592
 vfs_get_tree+0x2c/0xf0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x3e8/0xaf0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699

Freed by task 8858:
 stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
 kasan_save_stack+0x2c/0x60 mm/kasan/common.c:38
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:46
 kasan_set_free_info+0x24/0x30 mm/kasan/hw_tags.c:178
 ____kasan_slab_free.constprop.0+0x184/0x1c0 mm/kasan/common.c:362
 __kasan_slab_free+0x14/0x20 mm/kasan/common.c:369
 kasan_slab_free include/linux/kasan.h:192 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0x9c/0x190 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kmem_cache_free+0xa0/0x460 mm/slub.c:3159
 slab_kmem_cache_release+0x34/0x4c mm/slab_common.c:479
 kmem_cache_release+0x18/0x24 mm/slub.c:5535
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x74/0x11c lib/kobject.c:753
 sysfs_slab_release+0x2c/0x40 mm/slub.c:5659
 shutdown_cache mm/slab_common.c:466 [inline]
 kmem_cache_destroy+0x134/0x174 mm/slab_common.c:498
 f2fs_recover_fsync_data+0x60c/0x1cc0 fs/f2fs/recovery.c:869
 f2fs_fill_super+0x174c/0x1e8c fs/f2fs/super.c:3804
 mount_bdev+0x1c4/0x1f0 fs/super.c:1366
 f2fs_mount+0x1c/0x30 fs/f2fs/super.c:3962
 legacy_get_tree+0x34/0x64 fs/fs_context.c:592
 vfs_get_tree+0x2c/0xf0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x3e8/0xaf0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699

The buggy address belongs to the object at ffff00000cd1ef00
 which belongs to the cache kmem_cache of size 216
The buggy address is located 64 bytes inside of
 216-byte region [ffff00000cd1ef00, ffff00000cd1efd8)
The buggy address belongs to the page:
page:0000000028de1119 refcount:1 mapcount:0 mapping:0000000000000000 index:0xf0ff00000cd1ec00 pfn:0x4cd1e
flags: 0x1ffffc000000200(slab)
raw: 01ffffc000000200 dead000000000100 dead000000000122 f1ff000004001000
raw: f0ff00000cd1ec00 000000008010000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00000cd1ed00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff00000cd1ee00: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 fe fe
>ffff00000cd1ef00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                               ^
 ffff00000cd1f000: f4 f4 f4 f4 fe fe fe fe f9 f9 f9 f9 fe fe fe fe
 ffff00000cd1f100: f9 f9 f9 f9 fe fe fe fe f1 f1 f1 f1 fe fe fe fe
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
