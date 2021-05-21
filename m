Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0871E38C067
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhEUHJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:09:49 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39458 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhEUHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:09:47 -0400
Received: by mail-io1-f71.google.com with SMTP id w1-20020a6bd6010000b029042308b21fb9so15089530ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2pAUuYQ0IQpS3vNliC6Wd69tB9Ez2XpLXJJtlZPD89o=;
        b=NuSI7/Jd/HB525eZUBe6LsEeDppRtunjf5xSNqGD8K9YYGitYv4jpE+D30XDJjd/P3
         F39SiFjuFDkL4N699jmt4HPo85C/rxO+f6uGantqGvImo4W++T0aItloteDLUTGiKO12
         AKzCTemjlp5HxUiZxZ+Np2ASH2uGr9M5j8x7wxyneK9I+WUbk/UU1jJ/GuJlS+78Uf6V
         pcYivBh6tb6PqmMu3HYS8pLYaMhIuXkPuqPtl2cwXzTpxpC0PXF0WvDaaeQGOVyA0jnQ
         uD5ZVpaVHLov62/Q4S24Ze8gWnxYCXFU3QrATeFqWNKGI/WmU/iIGXxHxitHX0mCua7s
         VaLQ==
X-Gm-Message-State: AOAM533Bep/8FzflYnn4BGHbftzd38F7INCgPkCBsrsuesAoNh6ojPr6
        NrfrIJDxwuExGcLSYAbYt7JesO6hK/hMzHLSBK5kVg1HAsBO
X-Google-Smtp-Source: ABdhPJwayFmI4GirsGzJtpWgfd0U5avw/6g4dYJWpQvVtxkU32t6k4h/XS5SBHGVypPuGzgC0yvgj5GYjiTkisgwkz7/nkOr9l8j
MIME-Version: 1.0
X-Received: by 2002:a92:c607:: with SMTP id p7mr9927370ilm.97.1621580904251;
 Fri, 21 May 2021 00:08:24 -0700 (PDT)
Date:   Fri, 21 May 2021 00:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5c9f905c2d1b902@google.com>
Subject: [syzbot] WARNING in kernfs_remove_by_name_ns (2)
From:   syzbot <syzbot+415759e3b545070f5de3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d07f6ca9 Linux 5.13-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13313bc7d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dddb87edd6431081
dashboard link: https://syzkaller.appspot.com/bug?extid=415759e3b545070f5de3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+415759e3b545070f5de3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 0 PID: 13503 at fs/kernfs/dir.c:1508 kernfs_remove_by_name_ns+0x98/0xb0 fs/kernfs/dir.c:1508
Modules linked in:
CPU: 0 PID: 13503 Comm: syz-executor.5 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kernfs_remove_by_name_ns+0x98/0xb0 fs/kernfs/dir.c:1508
Code: 84 ff 48 c7 c7 80 49 14 8c 41 bc fe ff ff ff e8 2e 2b 27 07 eb d9 e8 47 37 84 ff 4c 89 e6 48 c7 c7 60 97 7c 89 e8 9b 33 e4 06 <0f> 0b 41 bc fe ff ff ff eb bb 66 66 2e 0f 1f 84 00 00 00 00 00 0f
RSP: 0018:ffffc90009d4fa38 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8c7ddb08 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815cda35 RDI: fffff520013a9f39
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815c789e R11: 0000000000000000 R12: ffffffff89c12040
R13: 0000000000000000 R14: ffffffff89c11f60 R15: dffffc0000000000
FS:  00007f736e995700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd8b06a9030 CR3: 00000000282c4000 CR4: 0000000000350ef0
Call Trace:
 kernfs_remove_by_name include/linux/kernfs.h:593 [inline]
 remove_files+0x96/0x1c0 fs/sysfs/group.c:28
 sysfs_remove_group+0x87/0x170 fs/sysfs/group.c:289
 sysfs_remove_groups fs/sysfs/group.c:313 [inline]
 sysfs_remove_groups+0x5c/0xa0 fs/sysfs/group.c:305
 __kobject_del+0x89/0x200 lib/kobject.c:611
 kobject_del lib/kobject.c:643 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:635
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:238 [inline]
 blk_mq_unregister_hctx block/blk-mq-sysfs.c:227 [inline]
 blk_mq_sysfs_unregister+0x227/0x300 block/blk-mq-sysfs.c:357
 __blk_mq_update_nr_hw_queues block/blk-mq.c:3685 [inline]
 blk_mq_update_nr_hw_queues+0x48f/0xd30 block/blk-mq.c:3725
 nbd_start_device+0x1e3/0xd50 drivers/block/nbd.c:1270
 nbd_start_device_ioctl drivers/block/nbd.c:1320 [inline]
 __nbd_ioctl drivers/block/nbd.c:1392 [inline]
 nbd_ioctl+0x527/0xa50 drivers/block/nbd.c:1432
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:585
 block_ioctl+0xf9/0x140 fs/block_dev.c:1664
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f736e995188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000007
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffe01d6a66f R14: 00007f736e995300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
