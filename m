Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE0447ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbhKHL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:27:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52140 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbhKHL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:27:10 -0500
Received: by mail-io1-f71.google.com with SMTP id b1-20020a05660214c100b005e241049240so797356iow.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 03:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u4Nas3Zn38qiQ9agL4PyP89RCLjUpvxe2IODh2Piv74=;
        b=V6ie/UPHAt7lAf0yQ3Tj02nxd4SdQUpbVUmTG/gu01XjAcomPtU9Sl3IkOjfQw9faV
         D8W+PbMl/3QdYlwkjyKL2vRHVT3XUYgIr1QbLV+URkdpTXBR/B47dgHIN3OpgfvrRbTA
         t4sm8D8D/cm2XsXb9ETFc8vl1XPQSR/z4B19tjkzyHJrX6IewwdFQHk+lAYCO+omrlv3
         C/3L89k4twLBOb0K8B2K6vWCYHwzlvYjukY4o/C9qNrVoVTBkaaT4Mc1OkhMdZkpadlI
         jXub1M1QYoqcOFuQPG3qCUtHxcJRZ66cwOSuMDOKeQP03lWYPR1zH9lyPZvOM9vENpYw
         maAQ==
X-Gm-Message-State: AOAM530kDcr+VvqnwGLD+Mx4Fk9PZuzaH7n+Yfh4MRzTFSsXNtWQCJwJ
        Dh9l4KgkLg51Jbdc2HdO4uO8A5wm9x5UuwYO4VEZfH009Kc3
X-Google-Smtp-Source: ABdhPJx/Z2etqw590MGVGK2j+aVhebSZQXAKzujs8LmCZabVmHOJ+SCRIzmKcH/0J8brmSwc9uEGQFJbdaqefrVNAbABom1ZNu9+
MIME-Version: 1.0
X-Received: by 2002:a5e:da09:: with SMTP id x9mr1557155ioj.171.1636370666183;
 Mon, 08 Nov 2021 03:24:26 -0800 (PST)
Date:   Mon, 08 Nov 2021 03:24:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047624505d0453c58@google.com>
Subject: [syzbot] WARNING in kernfs_remove_by_name_ns (3)
From:   syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce840177930f Merge tag 'defconfig-5.16' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1516eb12b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=647adc5a101c9bf3
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 0 PID: 352 at fs/kernfs/dir.c:1535 kernfs_remove_by_name_ns+0x96/0xa0 fs/kernfs/dir.c:1535
Modules linked in:
CPU: 0 PID: 352 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kernfs_remove_by_name_ns+0x96/0xa0 fs/kernfs/dir.c:1535
Code: 83 ff 48 c7 c7 20 7a b5 8b 41 bc fe ff ff ff e8 f0 d9 67 ff eb d9 e8 49 f9 83 ff 4c 89 e6 48 c7 c7 a0 64 9d 89 e8 a1 35 01 07 <0f> 0b 41 bc fe ff ff ff eb bb 41 57 41 56 41 55 49 89 d5 41 54 49
RSP: 0018:ffffc90004c8fa68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8c206628 RCX: 0000000000000000
RDX: ffff88806f28ba00 RSI: ffffffff815f39c8 RDI: fffff52000991f3f
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000037c24
R10: ffffffff815ed7ae R11: 0000000000000000 R12: ffffffff89e2ae80
R13: 0000000000000000 R14: ffffffff89e2ada0 R15: dffffc0000000000
FS:  00007fe5eef0f700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b90e723a4 CR3: 00000001e5ed8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kernfs_remove_by_name include/linux/kernfs.h:598 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:289
 sysfs_remove_groups fs/sysfs/group.c:313 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:305
 __kobject_del+0x89/0x200 lib/kobject.c:611
 kobject_del lib/kobject.c:643 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:635
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:183 [inline]
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:172 [inline]
 blk_mq_sysfs_unregister+0x227/0x300 block/blk-mq-sysfs.c:302
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4102 [inline]
 blk_mq_update_nr_hw_queues+0x48c/0xd30 block/blk-mq.c:4142
 nbd_start_device+0x1f2/0xdd0 drivers/block/nbd.c:1357
 nbd_start_device_ioctl drivers/block/nbd.c:1407 [inline]
 __nbd_ioctl drivers/block/nbd.c:1481 [inline]
 nbd_ioctl+0x5f3/0xb10 drivers/block/nbd.c:1521
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:597
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe5f19baae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe5eef0f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe5f1ace020 RCX: 00007fe5f19baae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007fe5f1a14f25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd3b00747f R14: 00007fe5eef0f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
