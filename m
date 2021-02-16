Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1131CDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBPQS7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Feb 2021 11:18:59 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34497 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:18:56 -0500
Received: by mail-io1-f72.google.com with SMTP id c3so9549348ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=a8hUNa4Ix/LDbsilB9jQGmZUOKeE8lSIMFKanIi/0k0=;
        b=BaQhDCW3wkoaBK3+Md6+9UsW6WjHFytFuSDkHP+WuvT8fgZBdc0p8KMlE8OSgUs4l1
         LCPRxLaDm1lR0GC3pq3Ynz3hfb6XJw0EaEeBCvog8GgaMxP7wUowZKAX6NLCfaH1DaG2
         Q8HvxbYvlMjbwDoZ5mIclqS2sefHWC8c6hf34VFObsbuMZrn9zNUbMzqv08ZCbRQOVJm
         v+32DAlX6nzUCxouIo9XXH7CRg8/vPZSI5tsAjGfGhQE3P6RGBE6YCyOCzPKhx2soiWE
         eP4pkP/VJhelEpwQBnr2oQZnNmeJuAEQkA/yxLWpMyAcytqytT24SpvWoY9jC80JaXJY
         kPbA==
X-Gm-Message-State: AOAM531Lu69xfxJ8a+D1W5o4Vc3pXEi7Harw2gv5HY3ErTO2EArPVeoY
        7Mbyvy/QT85nB13Y13LX9m1EO/wTg2ntJhNuwUFr9eUvVk+/
X-Google-Smtp-Source: ABdhPJyYUD24vdN/+Gdjj9LCM+0IBAtIJBJXzjEE0b5B1N/KxVyXSh8tqmYi1yOjckM2LQKUansmMJCWdsuqQj+4V74azkZdqL1E
MIME-Version: 1.0
X-Received: by 2002:a05:6602:24cb:: with SMTP id h11mr17729134ioe.79.1613492295537;
 Tue, 16 Feb 2021 08:18:15 -0800 (PST)
Date:   Tue, 16 Feb 2021 08:18:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fb73f05bb767334@google.com>
Subject: WARNING in iov_iter_revert (2)
From:   syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcc0b490 Merge tag 'powerpc-5.11-8' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162f2d02d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1106b4b91e8dfab8
dashboard link: https://syzkaller.appspot.com/bug?extid=3d2c27c2b7dc2a94814d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1346ac60d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123eae4cd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com

[U] 
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8461 at lib/iov_iter.c:1090 iov_iter_revert+0x2e3/0x8e0 lib/iov_iter.c:1090
Modules linked in:
CPU: 1 PID: 8461 Comm: syz-executor778 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:iov_iter_revert+0x2e3/0x8e0 lib/iov_iter.c:1090
Code: 05 00 00 45 8b 74 24 08 48 89 de 4c 89 6d 20 49 83 c5 01 4c 89 f7 e8 bc eb b4 fd 49 39 de 72 ba e9 2c ff ff ff e8 9d e5 b4 fd <0f> 0b e9 30 ff ff ff e8 91 e5 b4 fd 48 8d 7d 18 48 b8 00 00 00 00
RSP: 0018:ffffc9000168fc30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 0000000000000000
RDX: ffff88801b6c1bc0 RSI: ffffffff83bdef03 RDI: 0000000000000003
RBP: ffffc9000168fd68 R08: 000000007ffff000 R09: ffffffff8f86683f
R10: ffffffff83bdec5e R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffc9000168fd68 R15: ffff88801b6c1bc0
FS:  00000000016f5300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5d4c03d0d8 CR3: 0000000013adc000 CR4: 0000000000350ef0
Call Trace:
 do_tty_write drivers/tty/tty_io.c:967 [inline]
 file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43ee99
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc3cb0628 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000402e80 R08: 0000000000400488 R09: 0000000000400488
R10: 0000000000400488 R11: 0000000000000246 R12: 0000000000402f10
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
