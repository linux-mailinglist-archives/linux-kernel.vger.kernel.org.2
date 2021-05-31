Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D84395685
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhEaHzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:55:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36661 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEaHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:55:02 -0400
Received: by mail-il1-f198.google.com with SMTP id w10-20020a056e021c8ab02901bb7c1adfa1so7615561ill.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EgiaXci6eJq+ZRh12qkaGAM8/xieX4YfRCbdrEPwN4I=;
        b=QCuPbsJ5uUxDyj2MXrSj7biZJtg/ImvIAjo95ppZLNKfEkvE9PPFCXW7oiSM4EMYEj
         dBVTC7gi7uPyLe+ySIaG6oQPNhk0ftxoogzUzl2F89mPnr7EzYJAU/vp6LEW5AMabRRy
         8GFFU9pprlJyxsN3jlHkTmu16E63xZ8f4+iFDbLV9eLQn3ArEncdQQ3P1XQ/uSk7TDgl
         Se/6nC60Ari7/21WHNvyy/lreiYaKkNV9CvajmIRz/Ovg/sOp78Txf4va4tELgFZPfDE
         YPRBX9dBPO4boAR7CxsRXyDJsWJhan33Un9ipI8p/XnSn3S8oFsuvVYAMADAYpXIoAmi
         zDtw==
X-Gm-Message-State: AOAM532Q3myhckPQMZ4KO1fhvITUvm1UKS78OWsiLvNylQtJ+fj2iE1g
        UH2FPEO4PiLMZYy7SMcHjpP+y9QVUd5gwhIAx25sl0Hspnu2
X-Google-Smtp-Source: ABdhPJz8kiJrOUM8DXQB7fMfK1FYOmlzfp8+V4lp0wITkK+41VYJ2j2MpCyFJO8RJP64WvtTXq6LHlzbnC6MYxzqTvF5MSCLR6Dm
MIME-Version: 1.0
X-Received: by 2002:a92:c906:: with SMTP id t6mr11871237ilp.10.1622447601815;
 Mon, 31 May 2021 00:53:21 -0700 (PDT)
Date:   Mon, 31 May 2021 00:53:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9136f05c39b84e4@google.com>
Subject: [syzbot] kernel BUG in assertfail
From:   syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162843f3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
dashboard link: https://syzkaller.appspot.com/bug?extid=a6bf271c02e4fe66b4e4

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com

assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3419!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23125 Comm: syz-executor.5 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3419
Code: 3c 54 fa 41 54 41 89 f4 55 48 89 fd e8 d5 90 94 f8 44 89 e1 48 89 ee 48 c7 c2 00 92 b1 89 48 c7 c7 40 92 b1 89 e8 ab 1f f6 ff <0f> 0b 41 56 41 55 41 54 55 53 48 89 fb e8 aa 90 94 f8 48 8d 7b 48
RSP: 0018:ffffc9000e8b7848 EFLAGS: 00010286
RAX: 000000000000007c RBX: 0000000000000027 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815c1445 RDI: fffff52001d16efb
RBP: ffffffff89b1bf40 R08: 000000000000007c R09: 0000000000000000
R10: ffffffff815bb27e R11: 0000000000000000 R12: 0000000000000cd2
R13: ffff888035849000 R14: 0000000000000001 R15: ffff88803b8e0000
FS:  00007fde076e9700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000568000 CR3: 000000008c97f000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 open_ctree+0xdae/0x411f fs/btrfs/disk-io.c:3282
 btrfs_fill_super fs/btrfs/super.c:1382 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1749
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 fc_mount fs/namespace.c:993 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1023
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1010
 btrfs_mount+0x234/0xa20 fs/btrfs/super.c:1809
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x132a/0x1fa0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde076e8fa8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fde076e9000
RBP: 00007fde076e9040 R08: 00007fde076e9040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fde076e9000 R15: 0000000020000040
Modules linked in:
---[ end trace 5e4a13f31c27e3bb ]---
RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3419
Code: 3c 54 fa 41 54 41 89 f4 55 48 89 fd e8 d5 90 94 f8 44 89 e1 48 89 ee 48 c7 c2 00 92 b1 89 48 c7 c7 40 92 b1 89 e8 ab 1f f6 ff <0f> 0b 41 56 41 55 41 54 55 53 48 89 fb e8 aa 90 94 f8 48 8d 7b 48
RSP: 0018:ffffc9000e8b7848 EFLAGS: 00010286
RAX: 000000000000007c RBX: 0000000000000027 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815c1445 RDI: fffff52001d16efb
RBP: ffffffff89b1bf40 R08: 000000000000007c R09: 0000000000000000
R10: ffffffff815bb27e R11: 0000000000000000 R12: 0000000000000cd2
R13: ffff888035849000 R14: 0000000000000001 R15: ffff88803b8e0000
FS:  00007fde076e9700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb2751c7000 CR3: 000000008c97f000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
