Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082430A0CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhBAESp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:18:45 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:38701 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhBAEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:16:59 -0500
Received: by mail-il1-f199.google.com with SMTP id p14so12646200ilb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DtQQR1w/AABQYV2X4rjhgyiumALB0eGQxi+ItPyJCDM=;
        b=AurQhj7Tj4fiK09fBnLuSAtMOMIdkmGoRTEDj8ci6Kab9aZRNlhPWQci9AmNIymIjZ
         MrzMCqGWhyomGJBZkW7yBo94Z2S1Ma4+yL0bRSOW/e24m0BDGC0xyQO6O14eTRHOo4o7
         Nu5d8BO8JFEFWaZCjC6A8Ic8wfWlY8EYt35urBZ+Fvai3JEWvYXhxskpuSahNk0HPKzw
         NEMilMrCo5GjWQUxBIzUyn1FkFaEw5UauuFCdCd8GzsjIc3Rbm6khK7p2RuMMZ30qlxs
         4KjST6939IXcnSAoi6ovdZI8GkTCuofNUvRClX1IMNAjSek7UwbL4URWc04Brds/FQnA
         +XFQ==
X-Gm-Message-State: AOAM532ELP3S98S6mxVPUS0ifxjuSpKt0o9YflOUg9+G5oOiKQDqBinI
        9DagDxuUyhr+2oSzSTLMIaB8myybtTT+0QuACSx0NkaFNC1i
X-Google-Smtp-Source: ABdhPJxGyZsQ0jN9IC7ZcZJ/1IIQs6rvRVgGwaIMldtp1JssoNMxNCEJ9RjvToQAe4CIZyGCw+WZa8kZaRlvTyhnxFQ/C5rnypjk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:: with SMTP id g5mr11824716ile.2.1612152973821;
 Sun, 31 Jan 2021 20:16:13 -0800 (PST)
Date:   Sun, 31 Jan 2021 20:16:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000540c0405ba3e9dff@google.com>
Subject: KASAN: use-after-free Read in firmware_fallback_sysfs
From:   syzbot <syzbot+de271708674e2093097b@syzkaller.appspotmail.com>
To:     broonie@kernel.org, catalin.marinas@arm.com,
        kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, mbenes@suse.cz,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6642d600 Merge tag '5.11-rc5-smb3' of git://git.samba.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fd5978d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff2405705496bcf0
dashboard link: https://syzkaller.appspot.com/bug?extid=de271708674e2093097b
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com

platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x8c/0x100 lib/list_debug.c:23
Read of size 8 at addr ffff0000172c50c8 by task syz-executor.0/8280

CPU: 1 PID: 8280 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00328-g6642d600b541 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x3e0 arch/arm64/include/asm/pointer_auth.h:76
 show_stack+0x1c/0x70 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x110/0x188 lib/dump_stack.c:120
 print_address_description.constprop.0+0x2c/0x300 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report+0x1e8/0x200 mm/kasan/report.c:413
 __asan_report_load8_noabort+0x38/0x6c mm/kasan/report_generic.c:309
 __list_add_valid+0x8c/0x100 lib/list_debug.c:23
 __list_add include/linux/list.h:67 [inline]
 list_add include/linux/list.h:86 [inline]
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:516 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x350/0xaa0 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0xa1c/0x1130 drivers/base/firmware_loader/main.c:831
 request_firmware+0x4c/0x70 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x90/0x1dc net/wireless/reg.c:1088
 nl80211_reload_regdb+0x14/0x20 net/wireless/nl80211.c:7144
 genl_family_rcv_msg_doit+0x1b8/0x2a0 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x24c/0x42c net/netlink/genetlink.c:800
 netlink_rcv_skb+0x198/0x34c net/netlink/af_netlink.c:2494
 genl_rcv+0x3c/0x54 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x3e0/0x670 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x610/0xa20 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xc4/0x100 net/socket.c:672
 ____sys_sendmsg+0x548/0x6d0 net/socket.c:2345
 ___sys_sendmsg+0xf4/0x170 net/socket.c:2399
 __sys_sendmsg+0xbc/0x150 net/socket.c:2432
 __compat_sys_sendmsg net/compat.c:347 [inline]
 __do_compat_sys_sendmsg net/compat.c:354 [inline]
 __se_compat_sys_sendmsg net/compat.c:351 [inline]
 __arm64_compat_sys_sendmsg+0x78/0xac net/compat.c:351
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x44/0x7c arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x94/0x150 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708

Allocated by task 6750:
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:121
 kasan_save_stack+0x2c/0x5c mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x8c/0xb4 mm/kasan/common.c:429
 __kasan_kmalloc+0x14/0x20 mm/kasan/common.c:443
 kasan_kmalloc include/linux/kasan.h:219 [inline]
 kmem_cache_alloc_trace+0x248/0x460 mm/slub.c:2919
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 loopback_open+0x124/0xb5c sound/drivers/aloop.c:1193
 snd_pcm_open_substream+0x840/0x12f4 sound/core/pcm_native.c:2659
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2420 [inline]
 snd_pcm_oss_open.part.0+0x4fc/0xd70 sound/core/oss/pcm_oss.c:2501
 snd_pcm_oss_open+0x34/0x44 sound/core/oss/pcm_oss.c:2465
 soundcore_open+0x318/0x4d0 sound/sound_core.c:593
 chrdev_open+0x1c0/0x544 fs/char_dev.c:414
 do_dentry_open+0x3b8/0xd9c fs/open.c:817
 vfs_open+0x94/0xcc fs/open.c:931
 do_open fs/namei.c:3254 [inline]
 path_openat+0xf28/0x1da0 fs/namei.c:3371
 do_filp_open+0x138/0x30c fs/namei.c:3398
 do_sys_openat2+0x124/0x320 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_compat_sys_openat fs/open.c:1246 [inline]
 __se_compat_sys_openat fs/open.c:1244 [inline]
 __arm64_compat_sys_openat+0x12c/0x1c0 fs/open.c:1244
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x44/0x7c arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x94/0x150 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708

Last potentially related work creation:
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:121
 kasan_save_stack+0x2c/0x5c mm/kasan/common.c:38
 kasan_record_aux_stack+0xfc/0x134 mm/kasan/generic.c:344
 insert_work+0x50/0x2a0 kernel/workqueue.c:1331
 __queue_work+0x4d0/0x11ac kernel/workqueue.c:1497
 queue_work_on+0xbc/0x100 kernel/workqueue.c:1524
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x268/0x430 kernel/umh.c:433
 kobject_uevent_env+0xafc/0x10d4 lib/kobject_uevent.c:617
 kobject_uevent+0x18/0x2c lib/kobject_uevent.c:641
 netdev_queue_add_kobject net/core/net-sysfs.c:1605 [inline]
 netdev_queue_update_kobjects+0x2d4/0x3b0 net/core/net-sysfs.c:1639
 register_queue_kobjects net/core/net-sysfs.c:1700 [inline]
 netdev_register_kobject+0x2a8/0x360 net/core/net-sysfs.c:1943
 register_netdevice+0x8c0/0x120c net/core/dev.c:10057
 ieee80211_if_add+0xba8/0x1550 net/mac80211/iface.c:1974
 ieee80211_register_hw+0x222c/0x2fd0 net/mac80211/main.c:1281
 mac80211_hwsim_new_radio+0x173c/0x349c drivers/net/wireless/mac80211_hwsim.c:3261
 hwsim_new_radio_nl+0x6b8/0xd10 drivers/net/wireless/mac80211_hwsim.c:3822
 genl_family_rcv_msg_doit+0x1b8/0x2a0 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x24c/0x42c net/netlink/genetlink.c:800
 netlink_rcv_skb+0x198/0x34c net/netlink/af_netlink.c:2494
 genl_rcv+0x3c/0x54 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x3e0/0x670 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x610/0xa20 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xc4/0x100 net/socket.c:672
 __sys_sendto+0x16c/0x230 net/socket.c:1975
 __do_sys_sendto net/socket.c:1987 [inline]
 __se_sys_sendto net/socket.c:1983 [inline]
 __arm64_sys_sendto+0xc4/0x140 net/socket.c:1983
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x44/0x7c arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x94/0x150 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708

Second to last potentially related work creation:
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:121
 kasan_save_stack+0x2c/0x5c mm/kasan/common.c:38
 kasan_record_aux_stack+0xfc/0x134 mm/kasan/generic.c:344
 insert_work+0x50/0x2a0 kernel/workqueue.c:1331
 __queue_work+0x4d0/0x11ac kernel/workqueue.c:1497
 queue_work_on+0xbc/0x100 kernel/workqueue.c:1524
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x268/0x430 kernel/umh.c:433
 kobject_uevent_env+0xafc/0x10d4 lib/kobject_uevent.c:617
 kobject_uevent+0x18/0x2c lib/kobject_uevent.c:641
 rx_queue_add_kobject net/core/net-sysfs.c:980 [inline]
 net_rx_queue_update_kobjects+0x1d4/0x3ec net/core/net-sysfs.c:1020
 register_queue_kobjects net/core/net-sysfs.c:1695 [inline]
 netdev_register_kobject+0x1ec/0x360 net/core/net-sysfs.c:1943
 register_netdevice+0x8c0/0x120c net/core/dev.c:10057
 wg_newlink+0x3f4/0x740 drivers/net/wireguard/device.c:353
 __rtnl_newlink+0xaac/0xfc0 net/core/rtnetlink.c:3443
 rtnl_newlink+0x70/0xb0 net/core/rtnetlink.c:3491
 rtnetlink_rcv_msg+0x300/0x744 net/core/rtnetlink.c:5553
 netlink_rcv_skb+0x198/0x34c net/netlink/af_netlink.c:2494
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:5571
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x3e0/0x670 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x610/0xa20 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xc4/0x100 net/socket.c:672
 __sys_sendto+0x16c/0x230 net/socket.c:1975
 __do_sys_sendto net/socket.c:1987 [inline]
 __se_sys_sendto net/socket.c:1983 [inline]
 __arm64_sys_sendto+0xc4/0x140 net/socket.c:1983
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x44/0x7c arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x94/0x150 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708

The buggy address belongs to the object at ffff0000172c5000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 200 bytes inside of
 256-byte region [ffff0000172c5000, ffff0000172c5100)
The buggy address belongs to the page:
page:0000000036801226 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000172c5000 pfn:0x572c5
flags: 0x1ffc00000000200(slab)
raw: 01ffc00000000200 fffffc00004f1f08 fffffc00004dee08 ffff00000c401a80
raw: ffff0000172c5000 0000000000080007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000172c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000172c5000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000172c5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff0000172c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000172c5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
