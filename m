Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA73412D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhIUDb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 23:31:59 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47090 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhIUDOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 23:14:44 -0400
Received: by mail-il1-f197.google.com with SMTP id o5-20020a92c685000000b0023832088b13so46182183ilg.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 20:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FoMjj9x1b7xRh3tjIQSuOrHN7zv+x7JHpjy0oNos388=;
        b=BVhOJpv0UBiTMjh5z1q9tuWcclrEqlYV5RIOW1kTkow45Rg7j0H9tKuUYc00PbChUG
         3+usJUm6gS3jO9rBZdMW8NAUAhITcQ0TB3C3XUzVPoVBjQ/g1lsXyIFaF7XuD9RhQCTy
         sVlCCh98v0HVQk1LR/cCRJzM5uCoJUW82K+a92BCqMO5hE7C8eCZ4BUwrOdxsd2y9Gv/
         8j1H4w22h8a6/4JuqojQ41Y0S6AdXjVjYn1gW3UqpLSQMQaIWQ8X1FVY16VSpD6Her8U
         MNpMlHUA0HS116ebjcZsPX/L0Q8iKULReYkg82EZwbkN6E8re85ir6Fv9dcJMxIzZdhT
         BuCA==
X-Gm-Message-State: AOAM532nAV7AJXwpbIdtWEeii3vO5wXc5m+63tAmCKHp/d3kWRHWYaPN
        wQccO3vm/fKuaU86AazRiTmCs4v74MuqwHSIcakw9QtDX6m5
X-Google-Smtp-Source: ABdhPJwG9jdMY/jARxewwQepv2UVSfGdAQrQ47REzLEbMobLfbFsBYwJOxKF+qAsCrpPGSYRPeICvUadd0w8qNz3bq7HAlLQ/CBS
MIME-Version: 1.0
X-Received: by 2002:a02:601f:: with SMTP id i31mr13833201jac.80.1632193996117;
 Mon, 20 Sep 2021 20:13:16 -0700 (PDT)
Date:   Mon, 20 Sep 2021 20:13:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057e05c05cc78c7be@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in v4l2_compat_put_array_args
From:   syzbot <syzbot+414020f76775cfa73bd5@syzkaller.appspotmail.com>
To:     arnd@arndb.de, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1460b72d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=414020f76775cfa73bd5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+414020f76775cfa73bd5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user include/linux/instrumented.h:118 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user lib/usercopy.c:32 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0xc7/0x150 lib/usercopy.c:26
Read of size 16 at addr ffff88807df42418 by task syz-executor.4/4509

CPU: 0 PID: 4509 Comm: syz-executor.4 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_copy_to_user include/linux/instrumented.h:118 [inline]
 _copy_to_user lib/usercopy.c:32 [inline]
 _copy_to_user+0xc7/0x150 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:200 [inline]
 v4l2_compat_put_array_args+0x480/0x830 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1152
 video_usercopy+0xc65/0x16b0 drivers/media/v4l2-core/v4l2-ioctl.c:3317
 v4l2_ioctl+0x1b3/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x216/0x2c0 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1251
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf6f5a549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f45545fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c0cc5604
RDX: 0000000020000180 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 4509:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc_node include/linux/slab.h:614 [inline]
 kvmalloc_node+0x61/0x120 mm/util.c:587
 kvmalloc include/linux/mm.h:805 [inline]
 video_usercopy+0x72b/0x16b0 drivers/media/v4l2-core/v4l2-ioctl.c:3281
 v4l2_ioctl+0x1b3/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x216/0x2c0 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1251
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

The buggy address belongs to the object at ffff88807df42400
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
 32-byte region [ffff88807df42400, ffff88807df42420)
The buggy address belongs to the page:
page:ffffea0001f7d080 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807df429c0 pfn:0x7df42
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000079e580 0000000f0000000f ffff888010c41500
raw: ffff88807df429c0 000000008040002f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 17452416960, free_ts 13762209776
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0x921/0xfe0 mm/slub.c:2994
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc_track_caller+0x2f1/0x310 mm/slub.c:4905
 kstrdup+0x36/0x70 mm/util.c:60
 kstrdup_const+0x53/0x80 mm/util.c:83
 __kernfs_new_node+0x9d/0x8b0 fs/kernfs/dir.c:581
 kernfs_new_node fs/kernfs/dir.c:647 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:984
 kernfs_create_dir include/linux/kernfs.h:566 [inline]
 cgroup_create kernel/cgroup/cgroup.c:5307 [inline]
 cgroup_mkdir+0x43e/0x10f0 kernel/cgroup/cgroup.c:5440
 kernfs_iop_mkdir+0x146/0x1d0 fs/kernfs/dir.c:1142
 vfs_mkdir+0x1ce/0x3f0 fs/namei.c:3885
 do_mkdirat+0x285/0x300 fs/namei.c:3911
 __do_sys_mkdir fs/namei.c:3931 [inline]
 __se_sys_mkdir fs/namei.c:3929 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:3929
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 free_contig_range+0xa8/0xf0 mm/page_alloc.c:9254
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1016
 debug_vm_pgtable+0x295b/0x29ed mm/debug_vm_pgtable.c:1329
 do_one_initcall+0x103/0x650 init/main.c:1303
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1614
 kernel_init+0x1a/0x1d0 init/main.c:1505
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88807df42300: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88807df42380: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff88807df42400: 00 00 00 fc fc fc fc fc fa fb fb fb fc fc fc fc
                            ^
 ffff88807df42480: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
 ffff88807df42500: 00 00 00 fc fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
