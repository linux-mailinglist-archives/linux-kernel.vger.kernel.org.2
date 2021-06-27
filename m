Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5A3B5227
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 07:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhF0FSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 01:18:46 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:36670 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhF0FSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 01:18:42 -0400
Received: by mail-il1-f200.google.com with SMTP id v4-20020a92cd440000b02901ee67a35b12so5328470ilq.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 22:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OQds5E2QfvRDVqiT6Ljh8e7LXt2GkB2t6m4pO2rhwOE=;
        b=Pb4I2sGbm8kvMqpKQPBQ3ZBZxW/yrS+qcjC6co2r64F09mg5G4GYcmPVNs3hdnrJ1a
         LOsWpnGOLdD1/+xxcdVjgQ8L3po3Vj2drZpa6Ed1RS5M3c3NWy5Y0rxSEKbZlM30Idcy
         Ag5tusmRaoK2Q4ZAnS/DeARqYumTb5Tw2EKDbaIGone0YHzAI8A7pKmXJfOBQJV8oZIs
         9on5ZTwLPcdtTNvNtWqXJ1oPcEP0Y8T08YcF8kinbkJeY7r2mlOzulKQA5hHP5qH7V9O
         eDbpQF1TPufta4IdCOu6U+zkxkIw9ororYPVN8nhH7+a8da7SclNDYNsbnzWhwUq310W
         r38Q==
X-Gm-Message-State: AOAM530J2/StwpHLSKArHr/bqwxC9fcAKd8SEljhvOgeEK1p2/2HhgT8
        ZC1FKLSa6bYFSNfpOBI54frRnPAZgE6lg3aeoGpFdVud+b77
X-Google-Smtp-Source: ABdhPJzjRWaOFG8CkqDjlXKrdZfnmM00SfymKPOLsFvBMCmmecuZ+xOrFiE80mik1bakilDLO6G96v0OKXV2Utydj6nmGHsCVKQz
MIME-Version: 1.0
X-Received: by 2002:a92:a002:: with SMTP id e2mr13120702ili.98.1624770977745;
 Sat, 26 Jun 2021 22:16:17 -0700 (PDT)
Date:   Sat, 26 Jun 2021 22:16:17 -0700
In-Reply-To: <000000000000a324c305bfd446c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8500d05c5b8785a@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 __lookup_slow (2)
From:   syzbot <syzbot+11c49ce9d4e7896f3406@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a1f92694 Add linux-next specific files for 20210518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16935e94300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
dashboard link: https://syzkaller.appspot.com/bug?extid=11c49ce9d4e7896f3406
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1477f5bfd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bded84300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11c49ce9d4e7896f3406@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 15748, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using tea hash to sort names
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 1d164067 P4D 1d164067 PUD 143aa067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8454 Comm: syz-executor105 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000163f908 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff920002c7f24 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8880353f85e0 RDI: ffff888039770190
RBP: ffffffff899e4880 R08: 0000000000000000 R09: ffffffff909ffbff
R10: ffffffff81c99241 R11: 0000000000000000 R12: ffff8880353f85e0
R13: ffff888039770190 R14: ffffc9000163fa98 R15: ffffc9000163f940
FS:  000000000231e300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000169ad000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lookup_slow+0x24c/0x480 fs/namei.c:1629
 lookup_one_len+0x163/0x190 fs/namei.c:2650
 reiserfs_lookup_privroot+0x92/0x280 fs/reiserfs/xattr.c:980
 reiserfs_fill_super+0x2124/0x2e00 fs/reiserfs/super.c:2176
 mount_bdev+0x34d/0x410 fs/super.c:1368
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x132a/0x1fa0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
 do_syscall_64+0x31/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445b6a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfe200cf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdfe200d50 RCX: 0000000000445b6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffdfe200d10
RBP: 00007ffdfe200d10 R08: 00007ffdfe200d50 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200002a8
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000007
Modules linked in:
CR2: 0000000000000000
---[ end trace 23e9a8ddc3d2104a ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000163f908 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff920002c7f24 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8880353f85e0 RDI: ffff888039770190
RBP: ffffffff899e4880 R08: 0000000000000000 R09: ffffffff909ffbff
R10: ffffffff81c99241 R11: 0000000000000000 R12: ffff8880353f85e0
R13: ffff888039770190 R14: ffffc9000163fa98 R15: ffffc9000163f940
FS:  000000000231e300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000169ad000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

