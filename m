Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5965D433A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhJSPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:31:38 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54790 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhJSPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:31:36 -0400
Received: by mail-io1-f72.google.com with SMTP id f3-20020a5d8603000000b005dbf6d911e4so13599542iol.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K1HutfgURzvvD5hyC0nHEmKEekjLe2BfBHvMni2B8aE=;
        b=Au7eE5OuVHbjOdxH103ZPV7if7kJeV0wns2+UnEy0YG7bNqvu9MVMIc7bX7YaJYCEc
         6a90hQ+yK/qdSlHwhSkrDPuNppgzFKfzssJwmX+D/eDOi6LOUs5Vmb2HzJ4lX07W45bi
         Bph+R+Lc3jArekugzOwIbUBxUt433YJbDYxmlhasyrA4LOv4GapkUaqQC6+o7vugRqeh
         N6Qv3K+6OwMLEG1d+PfjLcGIyqecuMigRjyR7NyUjBrIhxyPzJ3ynNaWoinjm1QIhDnu
         BEtx+/xOBWNMyzJHhVFQ5qaVIycY7lGnUp79fSRqgfTvhN2szuYAVmF4YUikbLCCy1tt
         vtSw==
X-Gm-Message-State: AOAM532gtxOxzqMcHuixi9dQx/lUHGdUHuXUsg0rjM2GlTXmk7vGi8gQ
        CCvryOAm6it6D0Wp9YycvrFTSd0RezoDVrdsVQ0jcWplz/Em
X-Google-Smtp-Source: ABdhPJwYq3yHE78JsV2t2FkWdrQmQC0uwyE44V+cuUFK16jXRSlxzkVxVrNpZl2SNYu6h/FlHR9tNxfToJuoz45OfxRvAExgUZCD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2724:: with SMTP id m36mr4735996jav.49.1634657363269;
 Tue, 19 Oct 2021 08:29:23 -0700 (PDT)
Date:   Tue, 19 Oct 2021 08:29:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000779cb105ceb65376@google.com>
Subject: [syzbot] KASAN: use-after-free Read in rtl8712_dl_fw
From:   syzbot <syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, agamkohli9@gmail.com,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ef1e58783b9 usb: typec: STUSB160X should select REGMAP_I2C
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1106dcfb300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c27d285bdb7457e2
dashboard link: https://syzkaller.appspot.com/bug?extid=c55162be492189fb4f51
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12725770b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1168c158b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in rtl871x_open_fw drivers/staging/rtl8712/hal_init.c:83 [inline]
BUG: KASAN: use-after-free in rtl8712_dl_fw+0xd95/0xe10 drivers/staging/rtl8712/hal_init.c:170
Read of size 8 at addr ffff88810e25c9c0 by task dhcpcd/1204

CPU: 0 PID: 1204 Comm: dhcpcd Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 rtl871x_open_fw drivers/staging/rtl8712/hal_init.c:83 [inline]
 rtl8712_dl_fw+0xd95/0xe10 drivers/staging/rtl8712/hal_init.c:170
 rtl8712_hal_init drivers/staging/rtl8712/hal_init.c:330 [inline]
 rtl871x_hal_init+0xae/0x180 drivers/staging/rtl8712/hal_init.c:394
 netdev_open+0xe6/0x6c0 drivers/staging/rtl8712/os_intfs.c:380
 __dev_open+0x2bc/0x4d0 net/core/dev.c:1484
 __dev_change_flags+0x583/0x750 net/core/dev.c:8761
 dev_change_flags+0x93/0x170 net/core/dev.c:8832
 devinet_ioctl+0x15d1/0x1ca0 net/ipv4/devinet.c:1142
 inet_ioctl+0x1e6/0x320 net/ipv4/af_inet.c:971
 sock_do_ioctl+0xcc/0x230 net/socket.c:1118
 sock_ioctl+0x2f1/0x640 net/socket.c:1235
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff4004a20e7
Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 9d 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fffba0f8738 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff4003b46c8 RCX: 00007ff4004a20e7
RDX: 00007fffba108928 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007fffba118ad8 R08: 00007fffba1088e8 R09: 00007fffba108898
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffba108928 R14: 0000000000000028 R15: 0000000000008914

Allocated by task 1128:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc+0x7c/0x90 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 _request_firmware_prepare drivers/base/firmware_loader/main.c:732 [inline]
 _request_firmware+0x192/0x1440 drivers/base/firmware_loader/main.c:808
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x1620 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3c2/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 1306:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xe0/0x110 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook mm/slub.c:1725 [inline]
 slab_free mm/slub.c:3483 [inline]
 kfree+0xd9/0x460 mm/slub.c:4543
 release_firmware+0x1b/0x30 drivers/base/firmware_loader/main.c:1053
 r871xu_dev_remove+0xcc/0x2c0 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1205
 device_release_driver_internal drivers/base/dd.c:1236 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1259
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd60 drivers/base/core.c:3583
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2225
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9bf/0x1620 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3c2/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff88810e25c9c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff88810e25c9c0, ffff88810e25c9e0)
The buggy address belongs to the page:
page:ffffea0004389700 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810e25c900 pfn:0x10e25c
flags: 0x200000000000200(slab|node=0|zone=2)
raw: 0200000000000200 ffffea000418e000 0000000c0000000c ffff888100041500
raw: ffff88810e25c900 000000008040003f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 1165, ts 7264636375, free_ts 7245803911
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0x11d2/0x28b0 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x4e0 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0xa4b/0x1170 mm/slub.c:2994
 __slab_alloc mm/slub.c:3081 [inline]
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc+0x303/0x320 mm/slub.c:4387
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2031 [inline]
 tomoyo_supervisor+0xce8/0xf00 security/tomoyo/common.c:2103
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x33e/0x380 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:306
 security_file_open+0x45/0xb0 security/security.c:1634
 do_dentry_open+0x34e/0x1110 fs/open.c:809
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1227
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2b3/0x670 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x490 mm/page_alloc.c:3394
 __vunmap+0x783/0xb70 mm/vmalloc.c:2621
 free_work+0x58/0x70 mm/vmalloc.c:95
 process_one_work+0x9bf/0x1620 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3c2/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88810e25c880: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88810e25c900: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88810e25c980: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff88810e25ca00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88810e25ca80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
