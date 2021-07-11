Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD673C3DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhGKQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 12:09:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37472 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 12:09:56 -0400
Received: by mail-io1-f69.google.com with SMTP id p7-20020a6b63070000b029050017e563a6so9922863iog.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TtrQNtrKpfTZETCk/MtLAd7VMSf7/rHn12CLyW1+bOY=;
        b=rZAGCDyGs9z+lLamjw8VXaSHyXjsYtNvj7JSOe4HRWHa7xxmATOpQaXABTUwbjJttS
         u1Yile8OaEISyfA+5epUKN3B8SM1tN1VTYJuRWekHiFAIQIKAOcv8IgLYIHevsocVYsC
         NqRrnE4lhDkIlEWTR6t2OuqY/hiyI4Y+nT5JvkHzAgjvD28yX+alqof5fN7qTsK7CyQB
         X3NiBlrOCHIoCO9CVu1Xg2NQKNHo7oG8PEOx2iq7bWm9uGXCNOxCzKvO9YRAEMpNpBbd
         QczgiEbcv4QJPZ4alM143UuY3ARQPpXqgJCcFoZmrMnJIuRNLIttiZry7T+EppxnZJEJ
         ev2Q==
X-Gm-Message-State: AOAM533L+ZX3pXzHP0YW2wJIoWL2oW3t96emHBqitFHgYrRQWQ+EnluY
        wqZoo9itC9A2xGH6UWcOiCQg9y44dx+xRpAr5Zx9cSt8yKFg
X-Google-Smtp-Source: ABdhPJxD31LB3TxRn4SX/4l5WrsJf/MuagqZiFLhmBwwzru4pVyNv7v44FQgZg7ZkY0vt7+16JLztafQom7cslxha7cs1UkAShn7
MIME-Version: 1.0
X-Received: by 2002:a6b:cf15:: with SMTP id o21mr36847302ioa.9.1626019629410;
 Sun, 11 Jul 2021 09:07:09 -0700 (PDT)
Date:   Sun, 11 Jul 2021 09:07:09 -0700
In-Reply-To: <20210711155345.GB293743@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068b24405c6db3249@google.com>
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in do_proc_control/usb_submit_urb

------------[ cut here ]------------
usb usb2: BOGUS control dir, pipe 80000180 doesn't match bRequestType 80
WARNING: CPU: 0 PID: 10164 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 10164 Comm: syz-executor.2 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 45 1e 20 fc 48 8b 7c 24 40 e8 6b 40 0c ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 99 27 8a e8 5a a4 91 03 <0f> 0b e9 a5 ee ff ff e8 17 1e 20 fc 0f b6 1d 21 86 02 08 31 ff 41
RSP: 0018:ffffc9000a33f9a8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881468f1058 RCX: 0000000000000000
RDX: ffff88802a830000 RSI: ffffffff815d7735 RDI: fffff52001467f27
RBP: ffff888142fe0578 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d156e R11: 0000000000000000 R12: ffff888146811500
R13: 0000000000000080 R14: 0000000080000180 R15: ffff8880135f2700
FS:  00007f1b9bc83700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcfa7f3720 CR3: 000000003de67000 CR4: 00000000001506e0
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
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1b9bc83188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffed6acd58f R14: 00007f1b9bc83300 R15: 0000000000022000


Tested on:

commit:         ee268dee Add linux-next specific files for 20210707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13f337b4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
compiler:       

