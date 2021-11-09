Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D958D44AC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbhKILAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:00:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36574 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbhKILAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:00:08 -0500
Received: by mail-io1-f72.google.com with SMTP id w16-20020a5d8a10000000b005e241c13c7bso3237787iod.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fALnprAPiqIXXl0iNdd7RNLRDMbHV6Qz/HnWvIHcZ0I=;
        b=vMTv715Hf2R4/FcuhC0QITObtesd9FByU4pr3qkBM+pqyi7K56YksINUs+bIlFD01A
         XUJlsJJKkpzVItLDrR124mWnUkXP57R7KhDDrTtsRnC6luSZGiX7vU+yWGtTPca6ZujJ
         7cnDnhBXOBhplBEQQH3x835Ixs1hh2q3DWt1V+rwg0bD81TtJkxCNvku7Mf/0vJI1K6D
         UnPs9kQM4+EFyiorthHr86loQjEHdBNlh0mx3bY3+rYfShEZYtywtQfVfMIu5VhKpBPi
         qBPXDeBU/rTB8rQz/3Ju65nvltgOBcoPeZLF51FNIGLJ5tHpF5Yvtx0Zc+gbEaDeAbc3
         p0GQ==
X-Gm-Message-State: AOAM532c/utDUW2Aj13S7gMML6JfC5WS2DgUWyZR4y724SK/6EUCYO0m
        0+GBKKTrwqrl0JKIhDq6bLBdH3MVlPxFtXrheCD+08reRlmG
X-Google-Smtp-Source: ABdhPJz1BNvD+tkWEhXiia39zpzghQ0pxb3ewMCdZCwAUbID8lGxzeN0SaQ+dT4NyORWtPliKIWJ76AED/STMqVn0zPiI5ZU/nP2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2244:: with SMTP id o4mr4356125ioo.13.1636455442329;
 Tue, 09 Nov 2021 02:57:22 -0800 (PST)
Date:   Tue, 09 Nov 2021 02:57:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054b25505d058f931@google.com>
Subject: [syzbot] WARNING in usb_read/usb_submit_urb
From:   syzbot <syzbot+7d81bf1d56b9b1ae1f5c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4439a1189f9 Merge tag 'hsi-for-5.16' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b28aeab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f2760850058fbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=7d81bf1d56b9b1ae1f5c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d81bf1d56b9b1ae1f5c@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 2-1: BOGUS control dir, pipe 80004a80 doesn't match bRequestType c1
WARNING: CPU: 1 PID: 19836 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 19836 Comm: syz-executor.2 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 95 e0 1b fc 48 8b 7c 24 40 e8 3b 85 0a ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 00 63 29 8a e8 ca ac 99 03 <0f> 0b e9 a5 ee ff ff e8 67 e0 1b fc 0f b6 1d cb 13 ff 07 31 ff 41
RSP: 0018:ffffc9000520f748 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88801b8e1058 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815f39c8 RDI: fffff52000a41edb
RBP: ffff8880755fd5f0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ed7ae R11: 0000000000000000 R12: ffff8881417d0780
R13: 00000000000000c1 R14: 0000000080004a80 R15: ffff88801bb32500
FS:  00007f978962f700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31721000 CR3: 000000007215f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usb_read.isra.0+0xab/0x110 drivers/i2c/busses/i2c-tiny-usb.c:184
 usb_xfer+0x108/0x5c0 drivers/i2c/busses/i2c-tiny-usb.c:82
 __i2c_transfer+0x52b/0x17c0 drivers/i2c/i2c-core-base.c:2207
 i2c_smbus_xfer_emulated+0x1b5/0xfe0 drivers/i2c/i2c-core-smbus.c:468
 __i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:606 [inline]
 __i2c_smbus_xfer+0x4b9/0x10c0 drivers/i2c/i2c-core-smbus.c:552
 i2c_smbus_xfer drivers/i2c/i2c-core-smbus.c:544 [inline]
 i2c_smbus_xfer+0x100/0x380 drivers/i2c/i2c-core-smbus.c:534
 i2cdev_ioctl_smbus+0x3ca/0x970 drivers/i2c/i2c-dev.c:348
 i2cdev_ioctl+0x3ca/0x7a0 drivers/i2c/i2c-dev.c:467
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f978c0b9ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f978962f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f978c1ccf60 RCX: 00007f978c0b9ae9
RDX: 0000000020000100 RSI: 0000000000000720 RDI: 0000000000000003
RBP: 00007f978c113f25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f978c700b2f R14: 00007f978962f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
