Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D445610F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhKRRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:04:27 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47945 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhKRREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:04:25 -0500
Received: by mail-il1-f199.google.com with SMTP id g10-20020a92cdaa000000b00260fbb604easo4501427ild.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AcEQ5AyPDXAvRBlZrRoMQauSLu6R4MYiaS+FBuAr3Ck=;
        b=DAaSEQ89/wwvhnaxAUYMELJIq2H5SG6L06t7zWAov7QoU+TKFRKjSsuJ6HSrHbGYo3
         tdQ3lU7yZ8UiiBwpL9+KDER5gO72lXltav6BWPoGZswuR8jNAjn5pJ4uCJJRLkKTAKBl
         5bccCavdtQkHHa6iomTGmY6tGkORgUxKWg2kP1WTxQ+kn+fZc4lYgY8xPJS1MUwOQ395
         fYQ5IJGcTaShn9xG9AWINw6bmy4VA0Mt6poqe1cp3263mBvImDKbC0Skg8sKPYu1+SO9
         HrfIdmMy865gH/Dubz2kzwEidG3iP5vBx+Q39yx2YfcSyroQbcTeXtGQLFFiGKAhZZHt
         I3iw==
X-Gm-Message-State: AOAM532LEI3qfRgpHZ6FeL0md4rcZZyBLOVrDYLVU6JS0HRSUL4NFJF1
        CTA4Ix3njKLtaozFHh1MoLr+yd0hk2GnETt8NHMfH6WN3sSI
X-Google-Smtp-Source: ABdhPJz3pYu0fNXBC+ch96afAk1p4GEt0LoPIhRo0LwaTr6/09S/sXp60LRoIBz7OGCSpWQQLJ7MRof0Tg2q8VlaCxIZblNUFAf8
MIME-Version: 1.0
X-Received: by 2002:a92:d24e:: with SMTP id v14mr365927ilg.55.1637254884388;
 Thu, 18 Nov 2021 09:01:24 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:01:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca75a205d1131b87@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in copy_urb_data_to_user
From:   syzbot <syzbot+6dc37929ddaf9d677b2b@syzkaller.appspotmail.com>
To:     g@b4.vu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c8c109546a19 Merge tag 'zstd-for-linus-v5.16' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17745dd6b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a262045c4c15a9e0
dashboard link: https://syzkaller.appspot.com/bug?extid=6dc37929ddaf9d677b2b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6dc37929ddaf9d677b2b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user include/linux/instrumented.h:118 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user lib/usercopy.c:32 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0xc7/0x150 lib/usercopy.c:26
Read of size 2 at addr ffff88803545b460 by task syz-executor.0/6756

CPU: 0 PID: 6756 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_copy_to_user include/linux/instrumented.h:118 [inline]
 _copy_to_user lib/usercopy.c:32 [inline]
 _copy_to_user+0xc7/0x150 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:200 [inline]
 copy_urb_data_to_user+0x34c/0x400 drivers/usb/core/devio.c:544
 processcompl+0x5ab/0x680 drivers/usb/core/devio.c:2024
 proc_reapurbnonblock drivers/usb/core/devio.c:2101 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2594 [inline]
 usbdev_ioctl+0x2d7/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1326280ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13237d5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1326394020 RCX: 00007f1326280ae9
RDX: 0000000020000080 RSI: 000000004008550d RDI: 0000000000000004
RBP: 00007f13262daf6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f13268c7b2f R14: 00007f13237d5300 R15: 0000000000022000
 </TASK>

Allocated by task 6748:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:595 [inline]
 proc_do_submiturb+0x2a7d/0x3630 drivers/usb/core/devio.c:1816
 proc_submiturb drivers/usb/core/devio.c:1975 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2671 [inline]
 usbdev_ioctl+0x692/0x36c0 drivers/usb/core/devio.c:2791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803545b460
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88803545b460, ffff88803545b468)
The buggy address belongs to the page:
page:ffffea0000d516c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3545b
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000221b6c0 dead000000000002 ffff888010c41280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 25813, ts 1988498379208, free_ts 1988486053407
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc_track_caller+0x2e7/0x320 mm/slub.c:4925
 kmemdup+0x23/0x50 mm/util.c:128
 kmemdup include/linux/fortify-string.h:304 [inline]
 ip6_opt_dup net/ipv6/ip6_output.c:1318 [inline]
 ip6_setup_cork+0x686/0x1780 net/ipv6/ip6_output.c:1384
 ip6_make_skb+0x22d/0x550 net/ipv6/ip6_output.c:1983
 udpv6_sendmsg+0x22d6/0x2c40 net/ipv6/udp.c:1541
 inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:644
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x331/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmmsg+0x195/0x470 net/socket.c:2549
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 mm_free_pgd kernel/fork.c:647 [inline]
 __mmdrop+0xcb/0x3f0 kernel/fork.c:698
 mmdrop include/linux/sched/mm.h:49 [inline]
 __mmput+0x3f1/0x4b0 kernel/fork.c:1123
 mmput+0x56/0x60 kernel/fork.c:1134
 free_bprm+0x65/0x2e0 fs/exec.c:1481
 kernel_execve+0x380/0x460 fs/exec.c:1978
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88803545b300: fc fc fc fc fa fc fc fc fc fb fc fc fc fc 00 fc
 ffff88803545b380: fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc
>ffff88803545b400: fc fc fb fc fc fc fc fa fc fc fc fc 01 fc fc fc
                                                       ^
 ffff88803545b480: fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
 ffff88803545b500: fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
