Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D5407CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhILKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 06:01:40 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42596 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhILKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 06:01:39 -0400
Received: by mail-il1-f199.google.com with SMTP id p10-20020a92d28a000000b0022b5f9140f7so13263817ilp.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 03:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=37fWN0G/4HK8xmkPsdQbAX2VRqns8WP+Gio4bv9hq2M=;
        b=59ahno1WWPZINPYy7U9lqhlB4kf/6or9ll36UeqDWzfFV7SahXywDfH2/PNrA6Fd0z
         s8HdAnyeParTH1ovSiIwhjP3hf5vt4ox3pZtRJTXSf1Oy3Fy9hLE00K10aCHjgCfOPnV
         7pVM09C7NrnsTrsJDw9EDqPmJ5R9Z4rcUZ0n8UuM/0qmPtCeouJPhkFXRUVcYIWJDruq
         We2DwVoY3DReFGAgRag/VH2QlnCCiNKrncE0Bc+hYKtyBvfj2BBF8iW0rdwi3UHdy102
         7lpDGTPmSgvMjiPT2teotkVPDM2yPz/z1Z+MyHMWq+npK67yHy+/YGm46ZEF5S9OzLQl
         uzjw==
X-Gm-Message-State: AOAM533p+GByyH3qlTmx99iRBKXoN1ISeSNuFZ+mCCoPQ7q/h5VJgED9
        4F4mKDQ5t6sdIx3DZ5ArYKaWKdq1sN3dyCooasEJsm499NN5
X-Google-Smtp-Source: ABdhPJyGovn8sIuOL2NuTQMTsh3raCZFTvD2LYAgiZNiSx1pCsKJqogmAdsMRMnv+J7iC47sQFNUedt2T97OeqILEyhiojHV3Bm2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:: with SMTP id k10mr4102082ilv.1.1631440825555;
 Sun, 12 Sep 2021 03:00:25 -0700 (PDT)
Date:   Sun, 12 Sep 2021 03:00:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e123b605cbc96a09@google.com>
Subject: [syzbot] WARNING in __static_key_slow_dec_deferred
From:   syzbot <syzbot+3571c93ad7602c02dd81@syzkaller.appspotmail.com>
To:     ardb@kernel.org, jbaron@akamai.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb02ed300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7be4cf759c0440a
dashboard link: https://syzkaller.appspot.com/bug?extid=3571c93ad7602c02dd81
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14610b15300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10148bdb300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3571c93ad7602c02dd81@syzkaller.appspotmail.com

------------[ cut here ]------------
jump label: negative count!
WARNING: CPU: 0 PID: 12137 at kernel/jump_label.c:235 static_key_slow_try_dec kernel/jump_label.c:235 [inline]
WARNING: CPU: 0 PID: 12137 at kernel/jump_label.c:235 __static_key_slow_dec_deferred+0x15c/0x1c0 kernel/jump_label.c:286
Modules linked in:
CPU: 1 PID: 12137 Comm: syz-executor068 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:static_key_slow_try_dec kernel/jump_label.c:235 [inline]
RIP: 0010:__static_key_slow_dec_deferred+0x15c/0x1c0 kernel/jump_label.c:286
Code: 00 00 4c 89 ea 4c 89 f9 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b7 7d aa ff e8 92 6e d8 ff 48 c7 c7 40 94 59 8a 31 c0 e8 c4 a2 a3 ff <0f> 0b e9 74 ff ff ff 48 c7 c1 44 c3 db 8d 80 e1 07 38 c1 0f 8c c3
RSP: 0018:ffffc9000918f980 EFLAGS: 00010246
RAX: 7cd782d8373e9e00 RBX: 00000000ffffffff RCX: ffff888016b49c80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff81681fc2 R09: ffffed10173857a8
R10: ffffed10173857a8 R11: 0000000000000000 R12: ffffffff8ddbe2b8
R13: ffffffff8ddbe2d0 R14: ffff8880205ef601 R15: 0000000000000064
FS:  00007f78f9b46700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d0600 CR3: 0000000073b4f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvm_free_lapic+0x9f/0x170 arch/x86/kvm/lapic.c:2211
 kvm_arch_vcpu_create+0x844/0x970 arch/x86/kvm/x86.c:10751
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3592 [inline]
 kvm_vm_ioctl+0x1400/0x2910 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4314
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445849
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78f9b46308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004ca438 RCX: 0000000000445849
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000004ca430 R08: 00007f78f9b46700 R09: 0000000000000000
R10: 00007f78f9b46700 R11: 0000000000000246 R12: 00000000004ca43c
R13: 000000000049a074 R14: 6d766b2f7665642f R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
