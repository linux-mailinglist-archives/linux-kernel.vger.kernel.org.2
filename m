Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E277C3761C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhEGIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:20:26 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43731 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhEGIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:20:23 -0400
Received: by mail-il1-f197.google.com with SMTP id l7-20020a9229070000b0290164314f61f5so6575560ilg.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 01:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kx5RSPSfQAxCmD61R1YE9JbB4uCOZtM9hzCQAwktjKY=;
        b=NjVlyb6OfOlHNZGJKTq/MRSUi54uyv7xri4X5tpDfDbw31+jlka20vtwQXjaGtfx/u
         Wjl4nJu+SYEqHavqxicoMdpywWCi4nJA7TqidgoHdSeKoJmKiXrspqYaYmODTS04HchX
         CMoGLdPpv0TIHRNW8+WezMw+T2++UDHX+hKhs6d3JKOMTwVuJi/rmhqzb8zCXPWNSkVH
         vfehoOPEqisON4gWloiH4CUodcMun/pA05rpasqWwKlewhbUfVWXF6R2KmUSmZcfszbs
         h2TKy7/wy4VryzQvUuWcnbw7AucgWwwoZNxqifUgR27li553dpRszVr81yYWEcjtBKOr
         N+Ug==
X-Gm-Message-State: AOAM531s/S5N0iVp9HgWPyU8VcegQD+ylAjXmoB4zZwijcPxkmN9fuU7
        V/I/QKlyKsYFIOC/y8OUJx4WjNQ4TqleyQGj1qGyAGcLs8sn
X-Google-Smtp-Source: ABdhPJxXOr6kpGDTxVra/qaz94Rlhp7VfVUAYD5XZ7qblaV/42CPiO8zZE2PMJHe386/XZa8SNnsgwZXgANTc2/Oq6Zk3QlPYzO4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d7:: with SMTP id w23mr8064433jao.14.1620375563755;
 Fri, 07 May 2021 01:19:23 -0700 (PDT)
Date:   Fri, 07 May 2021 01:19:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1652405c1b9154a@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in wdm_disconnect
From:   syzbot <syzbot+7da71853830ac3289474@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8404c9fb Merge branch 'akpm' (patches from Andrew)
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11fffd2dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a73b8d06863cd18d
dashboard link: https://syzkaller.appspot.com/bug?extid=7da71853830ac3289474

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7da71853830ac3289474@syzkaller.appspotmail.com

usb 6-1: USB disconnect, device number 39
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: service_interrupt_work+0x0/0x110 arch/x86/include/asm/bitops.h:207
WARNING: CPU: 0 PID: 9431 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 0 PID: 9431 Comm: kworker/0:7 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 eb 1f 86 4c 89 ee 48 c7 c7 40 df 1f 86 e8 69 d1 89 03 <0f> 0b 83 05 b5 8e ce 06 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc9001264f650 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812a3e73 RDI: fffff520024c9ebc
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b72cb R11: 0000000000000000 R12: ffffffff860687c0
R13: ffffffff861fe580 R14: ffffffff811a2280 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4be635d000 CR3: 0000000117b90000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1556 [inline]
 slab_free_freelist_hook+0x13b/0x1b0 mm/slub.c:1606
 slab_free mm/slub.c:3166 [inline]
 kfree+0xdb/0x3b0 mm/slub.c:4225
 wdm_disconnect+0x3bd/0x450 drivers/usb/class/cdc-wdm.c:1052
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1181
 device_release_driver_internal drivers/base/dd.c:1212 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1235
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xd40 drivers/base/core.c:3507
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1413
 usb_disconnect.cold+0x27d/0x791 drivers/usb/core/hub.c:2219
 hub_port_connect drivers/usb/core/hub.c:5127 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x1c9c/0x4320 drivers/usb/core/hub.c:5644
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
