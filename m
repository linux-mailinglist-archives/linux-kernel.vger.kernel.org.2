Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1B4380C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhJVX4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:56:54 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:56128 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhJVX4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:56:42 -0400
Received: by mail-il1-f200.google.com with SMTP id o8-20020a056e02068800b0025999dab84fso3421304ils.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 16:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vdkW0hhANDDJA+JCyK9vJjex91cQAkOvKz7Fs8k2X84=;
        b=IbvyBKFz1UCAHYs/uP4rA1GPWSai81HUKZPVY9l15pKEXYzW2x6TEfdmU5g9MG1kYP
         tGKfUoBK8lKhVM9BSu0F0sFQFHqkjOc+AJx7EutfZJYPFgV2bKfOhZ8QL0gkxQS4Vz19
         9NKC86nOry0dvJcL7LyHgeqPwBS7NN9rfSMkfE5HLRb1XvKkFZTbgrmlFjU4QN9OJOLx
         iqn3L4sGODPMza5kMUIvIR+aSNPLprFnw5E/DulQU2xtg57BZa3oVqdvRfesBohkNKRT
         akqDE2cHR1lbuzShCuXEfELeAC6gNyjmX3/LGD9mg5NhX5GSLuNMrn22j6G5i5Zbqc+k
         P+2g==
X-Gm-Message-State: AOAM531Uo2I300lciLaBW6Nig4oCdfWq9eh6uf3rWiJMiDLi6yKQ5NKh
        nS0XFg07zvNskbVkFdrVGVnXcKjsJuADCt+Sc1W3nJS9i9No
X-Google-Smtp-Source: ABdhPJw+MzeliCQ+7b7Hsq4zAj3tgiuHUSJLddUiPwYX/7FCDi4MDxi4Nr4LmLh6x1mT37uSjpyTlkNwaCoUgyYTB02VcvskXxmQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198e:: with SMTP id g14mr1776541ilf.280.1634946864523;
 Fri, 22 Oct 2021 16:54:24 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000162f5005cef9bbf7@google.com>
Subject: [syzbot] INFO: trying to register non-static key in
 hci_uart_tty_receive (3)
From:   syzbot <syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    519d81956ee2 Linux 5.15-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16787178b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
dashboard link: https://syzkaller.appspot.com/bug?extid=f2725165900304ec97b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 24628 Comm: syz-executor.5 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:939 [inline]
 register_lock_class+0xf79/0x10c0 kernel/locking/lockdep.c:1251
 __lock_acquire+0x105/0x54a0 kernel/locking/lockdep.c:4894
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 hci_uart_tty_receive+0xc4/0x710 drivers/bluetooth/hci_ldisc.c:603
 tiocsti drivers/tty/tty_io.c:2310 [inline]
 tty_ioctl+0x909/0x1670 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff49c1bfa39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff4996b1188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff49c2c3260 RCX: 00007ff49c1bfa39
RDX: 0000000020000000 RSI: 0000000000005412 RDI: 0000000000000005
RBP: 00007ff49c219c5f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffa845426f R14: 00007ff4996b1300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
