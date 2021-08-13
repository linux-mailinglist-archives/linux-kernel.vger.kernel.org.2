Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68A3EBB70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhHMR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:27:52 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43927 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHMR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:27:51 -0400
Received: by mail-il1-f200.google.com with SMTP id v5-20020a92ab050000b02902223cc2accaso5421234ilh.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=x0/zA1TfU0sHitKtyApcgF+b90rNNi/b2gMLGL+dFmU=;
        b=fQr6kSZ9G4LVKeE++d40oLHFEwtxYHCwQBkZZZO4LUjA0S4VFlqtX+LOTavZtXukyE
         eA0DPalRWlYYh811j7Arz7edXL6BgclzK3JVE1/361xv5JaSl/VdV8BcPChSmqH4dZy5
         NxZ7DAW0VW0dqVhITonVESd8y7Rse7rOvt2QxEVtz8rUEvYJsoWXR4ls8Ax7FXGIrlzD
         QhQdbwMdXd70xHWorkw6gwGXiICpzbkS8vQ2wmc/K4NsZswXZEaVX3skPdC4xlhGZW70
         ybqUi2QXRQmOtuACqV7ia8sVzngU4AkSVb6+ITH7h+7dBeW3faWyWe1YLc6SaurBSzuy
         6a8Q==
X-Gm-Message-State: AOAM533yqmYecd5GQpgNUZTetgIwj2eP+AEjw2ixtZaPH2tZ18cF5rhd
        MPcu7nSBf89tvNtbRf9uxfVB27V6eSvtMA+KG1lu0320UKTx
X-Google-Smtp-Source: ABdhPJypitwQUgUvEHQA04ayc0qmncaXAM9bAKrv5bCuMjHI6MeajDPZzQIG/EFelh/EzeCigCqj7mOdKS67JyuVJGKTIL8KgFqh
MIME-Version: 1.0
X-Received: by 2002:a02:c6c3:: with SMTP id r3mr3376303jan.7.1628875644321;
 Fri, 13 Aug 2021 10:27:24 -0700 (PDT)
Date:   Fri, 13 Aug 2021 10:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029c95905c9742a31@google.com>
Subject: [syzbot] WARNING in static_key_slow_try_dec (2)
From:   syzbot <syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com>
To:     ardb@kernel.org, jbaron@akamai.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da454ebf578f Add linux-next specific files for 20210809
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b246f6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c37951c17eb89b18
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc046ab2b0cf295a063
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128d6d81300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169e5431300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com

------------[ cut here ]------------
jump label: negative count!
WARNING: CPU: 1 PID: 10689 at kernel/jump_label.c:235 static_key_slow_try_dec+0xca/0xe0 kernel/jump_label.c:235
Modules linked in:
CPU: 1 PID: 10689 Comm: syz-executor251 Not tainted 5.14.0-rc5-next-20210809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:static_key_slow_try_dec+0xca/0xe0 kernel/jump_label.c:235
Code: 5d c3 e8 a9 e7 dc ff 45 31 ed 5b 44 89 e8 5d 41 5c 41 5d c3 44 89 e5 eb 8e e8 92 e7 dc ff 48 c7 c7 c0 ce 94 89 e8 22 f3 52 07 <0f> 0b eb c5 48 89 df e8 ca 8a 22 00 e9 6a ff ff ff 0f 1f 44 00 00
RSP: 0018:ffffc90005b77ac0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8d6d70e0 RCX: 0000000000000000
RDX: ffff88801e923900 RSI: ffffffff815d7628 RDI: fffff52000b6ef4a
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d13ce R11: 0000000000000000 R12: 00000000ffffffff
R13: 0000000000000001 R14: ffff888077341100 R15: 0000000000000040
FS:  00007f154119d700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560538236198 CR3: 000000006fc65000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __static_key_slow_dec_deferred+0x60/0x100 kernel/jump_label.c:286
 kvm_free_lapic+0x144/0x1a0 arch/x86/kvm/lapic.c:2211
 kvm_arch_vcpu_create+0x890/0xbf0 arch/x86/kvm/x86.c:10737
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3557 [inline]
 kvm_vm_ioctl+0x137f/0x23d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4279
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x44faf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f154119d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004ce4d8 RCX: 000000000044faf9
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000004ce4d0 R08: 00007f154119d700 R09: 0000000000000000
R10: 00007f154119d700 R11: 0000000000000246 R12: 00000000004ce4dc
R13: 00007ffdb527176f R14: 00007f154119d300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
