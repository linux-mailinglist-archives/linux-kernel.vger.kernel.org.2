Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2833C3449
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhGJLOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 07:14:02 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37675 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGJLOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 07:14:00 -0400
Received: by mail-il1-f199.google.com with SMTP id o18-20020a92d3920000b02901ee901c30f3so7812114ilo.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 04:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MjVb2qevWv+Zz4PtXKE8Lt51T2OZQJa0IGNt4A5bfyA=;
        b=DNzFy3Vg0vyl1j65xdI0mnXUKoE8wUFDg8FIEaXLH0gPf2Qs0ft5ccf50PA2qBhHgf
         gb2TaY3wzVSmbPZn3MD3d8WzAIjdxHUOSjb8RrQF87VPI9VEJ87BNJdoQv3ba3U4cC1x
         a03A/A3djkLpMyZTafj1gcLTAO9b4ZDyN8vvQyAacE/brUDn6fukb1AoJzgVEZdD2Gec
         8e2xqlnnupg1D0988W7dP3luPJxFhug69OLU2ZUzOab5dKarkYpXM0oPoFctVSz1UspM
         1Fy3aXzDkEsAEvcDB5jpSeJFvk5k1cr/q6UGhQLGrYBjEtu42lNFr44+IoLfdJahOBGn
         UgpQ==
X-Gm-Message-State: AOAM530YPrP3Uqt/b5li9Q5x2s0rX+Ml8BLLxlFVh4HSXP6fQBnv/HXF
        SvyPdGFzkHLeG/MJwHJ375dPjtOrc5Zg3AY2N6wD096Pg/u6
X-Google-Smtp-Source: ABdhPJxeqFGoirTTLltfjnBDIDPzUCCffeXTsY0rtfsNNmg3Rcrp3Mk1nrupedob9axPPql2vJuA57OFHUrqPPrL4goOTSdFcS8E
MIME-Version: 1.0
X-Received: by 2002:a02:9f89:: with SMTP id a9mr4124656jam.51.1625915475726;
 Sat, 10 Jul 2021 04:11:15 -0700 (PDT)
Date:   Sat, 10 Jul 2021 04:11:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d93c405c6c2f20d@google.com>
Subject: [syzbot] WARNING in do_proc_control/usb_submit_urb
From:   syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee268dee Add linux-next specific files for 20210707
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1067ddb4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116443fc300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102541c4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com

------------[ cut here ]------------
usb usb2: BOGUS control dir, pipe 80000180 doesn't match bRequestType 80
WARNING: CPU: 0 PID: 8442 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 8442 Comm: syz-executor261 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 45 1e 20 fc 48 8b 7c 24 40 e8 6b 40 0c ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 99 27 8a e8 5a a4 91 03 <0f> 0b e9 a5 ee ff ff e8 17 1e 20 fc 0f b6 1d 21 86 02 08 31 ff 41
RSP: 0018:ffffc90002f5f9a8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888146fee058 RCX: 0000000000000000
RDX: ffff88801891b900 RSI: ffffffff815d7735 RDI: fffff520005ebf27
RBP: ffff88801f4523e8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d156e R11: 0000000000000000 R12: ffff88801c6aa8c0
R13: 0000000000000080 R14: 0000000080000180 R15: ffff8880205f3a00
FS:  0000000000977300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf91ee0000 CR3: 0000000016427000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 do_proc_control+0x6c4/0x920 drivers/usb/core/devio.c:1141
 proc_control drivers/usb/core/devio.c:1191 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2540 [inline]
 usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2713
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443489
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf9b3e838 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443489
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 0000000000403030 R08: 0000000000000000 R09: 00000000004004a0
R10: 000000000000000f R11: 0000000000000246 R12: 00000000004030c0
R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
