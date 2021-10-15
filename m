Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F542EA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhJOHme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:42:34 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41916 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJOHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:42:32 -0400
Received: by mail-il1-f199.google.com with SMTP id c4-20020a92b744000000b002592dabe954so3713150ilm.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wKCmOJPGRkqPr96lWFY5UcFy5xtZCM1Kney0GS9/bhY=;
        b=1AoYx7hk7Vv3gER6Fg6RcrUREsWv8g4P6+hkHX6A93k7kYkNGGt/aHKeaICCJEDoaK
         u6BrGU9dh5bim9uje5lk/6gGtiiFL3iaxmzyxMMJR9ycGdNOf9An8bAqOK8SqPdiR5iO
         0scEArVlq6Z11MVpK7lJWpOCe9x4HIYhnfJunBLkCNQOl2bvS5dVBJQvdFCPbtBRG68F
         L4KS/qdVwoUeHFTK0noVcPV/ot1V/dJuUjIRZMZAPF8pZCQFL/G44JKj5lwJ2SV2Ls/f
         U+rSeCvWxebrSkNFveSuQKf0fdQ3xOl29NRJzgMuyFLaVNEgbHKRFBbaoKPT9GXjDCeJ
         QadA==
X-Gm-Message-State: AOAM533XnxkbOpApUn+e5jPGKkGwz/23xwT7nIWhdUKuTDUh+mQiVdHB
        AGVaI01XSF/X6n45LJz+jYlcVWKcJcJIILnkjipF2sNFr/fv
X-Google-Smtp-Source: ABdhPJzjSsXcVI3WpJAV/3HE1d/FL4XCrYKriTjzYfh5eGA7LqUcJWnJm3Sbnk9dMpPDwrDVdj7QU6pq/Ion14dvaQ65eS4EMTdb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411f:: with SMTP id ay31mr7435713jab.120.1634283626676;
 Fri, 15 Oct 2021 00:40:26 -0700 (PDT)
Date:   Fri, 15 Oct 2021 00:40:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007c68b05ce5f4fca@google.com>
Subject: [syzbot] KASAN: use-after-free Read in usb_anchor_resume_wakeups (3)
From:   syzbot <syzbot+85a77e0b4ff5f6de9418@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, andreyknvl@gmail.com,
        gregkh@linuxfoundation.org, jun.li@nxp.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fd2bf83d59a Merge branch 'i2c/for-current-fixed' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb10a0b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e6048063923b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=85a77e0b4ff5f6de9418
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85a77e0b4ff5f6de9418@syzkaller.appspotmail.com

xpad 3-1:0.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 3-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff88807cbe985c by task syz-executor.5/30618

CPU: 0 PID: 30618 Comm: syz-executor.5 Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
 usb_anchor_resume_wakeups drivers/usb/core/urb.c:946 [inline]
 usb_anchor_resume_wakeups+0xbe/0xe0 drivers/usb/core/urb.c:939
 __usb_hcd_giveback_urb+0x2df/0x5c0 drivers/usb/core/hcd.c:1659
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:197
Code: fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 65 8b 05 79 f1 8b 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 40 f0 01 00 a9
RSP: 0018:ffffc900051ff8f8 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 000000000000000e RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88801c483900 RDI: 0000000000000003
RBP: ffff88801a974200 R08: 0000000000000000 R09: 000000000000000e
R10: ffffffff83a22427 R11: 0000000000000010 R12: 0000000000000100
R13: 00000000000002b5 R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_domain_quota_is_ok+0x31a/0x550 security/tomoyo/util.c:1092
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x39e/0x400 security/tomoyo/file.c:838
 tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:199
 security_path_symlink+0xdf/0x150 security/security.c:1164
 do_symlinkat+0x106/0x2e0 fs/namei.c:4274
 __do_sys_symlink fs/namei.c:4301 [inline]
 __se_sys_symlink fs/namei.c:4299 [inline]
 __x64_sys_symlink+0x75/0x90 fs/namei.c:4299
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fefbc1d11e7
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefbc809d78 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fefbc1d11e7
RDX: 00007fefbc809e57 RSI: 00007fefbc22bd55 RDI: 00007fefbc809e40
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fefbc809c10
R10: 00007fefbc809ac7 R11: 0000000000000206 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000001 R15: 00007fefbc809e40

Allocated by task 8493:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 xpad_probe+0x26c/0x1c20 drivers/input/joystick/xpad.c:1755
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3395
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc17/0x1ee0 drivers/base/core.c:3395
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5348 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 1860:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x81/0x190 mm/slub.c:1725
 slab_free mm/slub.c:3483 [inline]
 kfree+0xe4/0x530 mm/slub.c:4543
 xpad_disconnect+0x1cb/0x530 drivers/input/joystick/xpad.c:1903
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3582
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe9/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3067
 sctp_transport_destroy net/sctp/transport.c:171 [inline]
 sctp_transport_put+0x11d/0x180 net/sctp/transport.c:486
 sctp_association_free+0x4d4/0x7d0 net/sctp/associola.c:382
 sctp_cmd_delete_tcb net/sctp/sm_sideeffect.c:940 [inline]
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1324 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1195 [inline]
 sctp_do_sm+0x3665/0x4ed0 net/sctp/sm_sideeffect.c:1166
 sctp_assoc_bh_rcv+0x386/0x6c0 net/sctp/associola.c:1054
 sctp_inq_push+0x1da/0x270 net/sctp/inqueue.c:80
 sctp_backlog_rcv+0x19e/0x5c0 net/sctp/input.c:344
 sk_backlog_rcv include/net/sock.h:1027 [inline]
 __release_sock+0x134/0x3b0 net/core/sock.c:2686
 release_sock+0x54/0x1b0 net/core/sock.c:3218
 sctp_wait_for_connect+0x1cb/0x5d0 net/sctp/socket.c:9306
 __sctp_connect+0x9a6/0xc30 net/sctp/socket.c:1244
 sctp_connect net/sctp/socket.c:4808 [inline]
 sctp_inet_connect+0x15e/0x200 net/sctp/socket.c:4823
 __sys_connect_file+0x155/0x1a0 net/socket.c:1896
 __sys_connect+0x161/0x190 net/socket.c:1913
 __do_sys_connect net/socket.c:1923 [inline]
 __se_sys_connect net/socket.c:1920 [inline]
 __x64_sys_connect+0x6f/0xb0 net/socket.c:1920
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807cbe9800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 92 bytes inside of
 1024-byte region [ffff88807cbe9800, ffff88807cbe9c00)
The buggy address belongs to the page:
page:ffffea0001f2fa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7cbe8
head:ffffea0001f2fa00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c41dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6464, ts 62036298242, free_ts 62023368534
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
 __kmalloc+0x305/0x320 mm/slub.c:4387
 kmalloc include/linux/slab.h:596 [inline]
 do_tty_write drivers/tty/tty_io.c:1017 [inline]
 file_tty_write.constprop.0+0x700/0x910 drivers/tty/tty_io.c:1110
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:507
 vfs_write+0x7cf/0xae0 fs/read_write.c:594
 ksys_write+0x12d/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 __unfreeze_partials+0x340/0x360 mm/slub.c:2495
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x95/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc+0x1e7/0x320 mm/slub.c:4387
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1d5/0x590 security/tomoyo/file.c:723
 security_file_ioctl+0x50/0xb0 security/security.c:1540
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88807cbe9700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807cbe9780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807cbe9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807cbe9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807cbe9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   5:	ba 08 00 00 00       	mov    $0x8,%edx
   a:	4d 8b 03             	mov    (%r11),%r8
   d:	48 0f bd ca          	bsr    %rdx,%rcx
  11:	49 8b 45 00          	mov    0x0(%r13),%rax
  15:	48 63 c9             	movslq %ecx,%rcx
  18:	e9 64 ff ff ff       	jmpq   0xffffff81
  1d:	0f 1f 00             	nopl   (%rax)
  20:	65 8b 05 79 f1 8b 7e 	mov    %gs:0x7e8bf179(%rip),%eax        # 0x7e8bf1a0
* 27:	89 c1                	mov    %eax,%ecx <-- trapping instruction
  29:	48 8b 34 24          	mov    (%rsp),%rsi
  2d:	81 e1 00 01 00 00    	and    $0x100,%ecx
  33:	65 48 8b 14 25 40 f0 	mov    %gs:0x1f040,%rdx
  3a:	01 00
  3c:	a9                   	.byte 0xa9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
