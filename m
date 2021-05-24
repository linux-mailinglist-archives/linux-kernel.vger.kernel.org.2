Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DB38E2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhEXIwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:52:50 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47045 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:52:46 -0400
Received: by mail-io1-f70.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so20990485ios.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6Ouj4Y5Eht61zrTOGHtvxfobykLW23I6tDobOaf4+pg=;
        b=pPG7fwJCzgc3obkZUIjTr+jvBueognc7t+r8qlFrYXz7XDZo/7mf1nuWQyVcqvKzMn
         DtdNSWiCL0Ajlbigqo2bk8gGarGAkMWl+19hVOWgBfehw8Hl7bWD70sIEZ5ucd71NdAU
         5Q3BS4i1cs7eRcVy5Pq6fNFV/c3J0cNkn7fgOr35EBFTOZ+SkNFZIoxTMBV6h6WIDWLD
         z4FR7kOWHo/+RFQCNTfatB07ND92AsUHKbwPDnsjI0g+AWiZunElHgVeaFmmD8IucXt4
         mig36pN94Xkjm4Y9S+b6d9XlJ4aZRyXPCvMYZmixdtWjKBJGGvt28gw5MpetrsE1CATl
         6+CQ==
X-Gm-Message-State: AOAM532zDRESS9IT9fzIVl5vWjKPGO2LXzkTGAFFMcY+D9dlm/S+3fAB
        z/LY7R1Op1ecw/HGMnK35wlEIzfxmlRpWce/1G5+f25YWtju
X-Google-Smtp-Source: ABdhPJzwwWcXHdJzbyLd3vcGEfgBXCzHKChRxoD9SFkd0aDIG2Bmjer6h43/QoZ1AeyQh9MAIhmdIU1AT71b7J/lUQrQMtGf/huf
MIME-Version: 1.0
X-Received: by 2002:a02:54c1:: with SMTP id t184mr23247470jaa.79.1621846278290;
 Mon, 24 May 2021 01:51:18 -0700 (PDT)
Date:   Mon, 24 May 2021 01:51:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c453905c30f8334@google.com>
Subject: [syzbot] WARNING in ex_handler_fprestore
From:   syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>
To:     bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    45af60e7 Merge tag 'for-5.13-rc2-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1591e9f7d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
dashboard link: https://syzkaller.appspot.com/bug?extid=2067e764dbcd10721e2e
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be6bd1d00000

The issue was bisected to:

commit b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
Author: Fenghua Yu <fenghua.yu@intel.com>
Date:   Tue May 12 14:54:39 2020 +0000

    x86/fpu/xstate: Define new functions for clearing fpregs and xstates

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c2c723d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1422c723d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1022c723d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com
Fixes: b860eb8dce59 ("x86/fpu/xstate: Define new functions for clearing fpregs and xstates")

------------[ cut here ]------------
Bad FPU state detected at copy_kernel_to_xregs arch/x86/include/asm/fpu/internal.h:344 [inline], reinitializing FPU registers.
Bad FPU state detected at __copy_kernel_to_fpregs arch/x86/include/asm/fpu/internal.h:419 [inline], reinitializing FPU registers.
Bad FPU state detected at copy_kernel_to_fpregs arch/x86/include/asm/fpu/internal.h:443 [inline], reinitializing FPU registers.
Bad FPU state detected at __fpregs_load_activate+0x1a1/0x290 arch/x86/include/asm/fpu/internal.h:514, reinitializing FPU registers.
WARNING: CPU: 0 PID: 8847 at arch/x86/mm/extable.c:66 ex_handler_fprestore+0xaf/0xe0 arch/x86/mm/extable.c:65
Modules linked in:
CPU: 0 PID: 8847 Comm: syz-executor.0 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ex_handler_fprestore+0xaf/0xe0 arch/x86/mm/extable.c:65
Code: 0f ae 2f b0 01 5b 41 5c 41 5e 41 5f c3 e8 a9 82 46 00 c6 05 70 65 ec 0c 01 48 c7 c7 60 58 2b 8a 4c 89 fe 31 c0 e8 31 cc 12 00 <0f> 0b eb b1 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff 48 89
RSP: 0000:ffffc90002757be0 EFLAGS: 00010046
RAX: 73b00bd88b4ed600 RBX: ffffffff8c28fb34 RCX: ffff88802e86b880
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffff8c28fb30 R08: ffffffff816552b2 R09: ffffed1017343f24
R10: ffffed1017343f24 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90002757d78 R14: ffffc90002757df8 R15: ffffffff812e3061
FS:  00007f4e04656700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd7a623b88 CR3: 00000000190f1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fixup_exception+0x92/0xd0 arch/x86/mm/extable.c:183
 __exc_general_protection arch/x86/kernel/traps.c:567 [inline]
 exc_general_protection+0x112/0x370 arch/x86/kernel/traps.c:531
 asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:571
RIP: 0010:fpregs_activate arch/x86/include/asm/fpu/internal.h:498 [inline]
RIP: 0010:__fpregs_load_activate+0x1a1/0x290 arch/x86/include/asm/fpu/internal.h:515
Code: e8 14 c3 98 00 48 8b 5c 24 40 0f 1f 44 00 00 e8 25 d7 50 00 e8 20 d7 50 00 48 89 df b8 ff ff ff ff ba ff ff ff ff 48 0f ae 2f <65> 4c 89 2d e7 be d3 7e 4c 89 ef e8 6f 07 00 00 4c 89 e8 48 c1 e8
RSP: 0000:ffffc90002757e20 EFLAGS: 00010093
RAX: 00000000ffffffff RBX: ffff88802e86d080 RCX: ffff88802e86b880
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffff88802e86d080
RBP: ffffc90002757ee0 R08: ffffffff812e2f67 R09: ffffed1005d0d711
R10: ffffed1005d0d711 R11: 0000000000000000 R12: ffffc90002757e60
R13: ffff88802e86d040 R14: 1ffff920004eafc8 R15: dffffc0000000000
 arch_exit_to_user_mode_prepare arch/x86/include/asm/entry-common.h:58 [inline]
 exit_to_user_mode_prepare+0x1a0/0x200 kernel/entry/common.c:210
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x26/0x70 kernel/entry/common.c:301
 do_syscall_64+0x4b/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e04656218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 000000000056bf88 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf88
RBP: 000000000056bf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf8c
R13: 00007ffdd6442f5f R14: 00007f4e04656300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
