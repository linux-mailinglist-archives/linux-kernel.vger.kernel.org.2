Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8D3BB6C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGEFZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:25:59 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:52893 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEFZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:25:58 -0400
Received: by mail-il1-f200.google.com with SMTP id a7-20020a9233070000b02901edc50cdfdcso9929910ilf.19
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tyfQNB6SSPzskYSDnco0Rcgu6IuvkwOyAzYfqKqIqWU=;
        b=lU3vDPVUe5PkMHt6caDjmKySAoQv3MY9OeNeFtc55y6LR0XfPvG4/y/fXXYKSjflSt
         UgNgNbux6ASExXbcFTue0ni/Z0Lhmr6tnDmTZFAgkAgCj+dGabG1H82lyAOdX2h+7GIP
         On0fcCBF2Ms5Uc6+IEk03GKpMEpoG4SXXmQbZupZy1IVKOTMLHunNuqdhvl5Pu6aB6OU
         cKh89YzQy76lvppLUeEJKiSyQaPdnZJ0mrEIsuxAkvcDQ5wcJsI1lnd7rT1HYYdDWxUH
         edauHIkY0Ea2AAomo31UfSPkGUlEPrd2gYVAjU/x2LO1GXrOXHViLXIRGk3d2Qp+Zu0T
         g3QQ==
X-Gm-Message-State: AOAM533Y0uGgyi3ZYWnd919Epwj9lV+aZsQh9X0Q4FjG4CbX6gSzfyIz
        znuCXxtifQyrsDmDeneDWpj7Sh1gfb8lf48CFwklpRD7yQZH
X-Google-Smtp-Source: ABdhPJzd34FyCxhBIh7pCUXjnXKfTCzzDn83vhfazMGCAV6/p/uVXwBnI5ZmYmX6c1zfEslTu3IHjOrrJEOvIA56UvjrvaE7Ti0o
MIME-Version: 1.0
X-Received: by 2002:a02:a310:: with SMTP id q16mr11129621jai.8.1625462602289;
 Sun, 04 Jul 2021 22:23:22 -0700 (PDT)
Date:   Sun, 04 Jul 2021 22:23:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001562305c6598113@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in complete_all
From:   syzbot <syzbot+33b3d0101e32bc3620fa@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c54b245d Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bf831c300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf67b65fb52b173a
dashboard link: https://syzkaller.appspot.com/bug?extid=33b3d0101e32bc3620fa
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33b3d0101e32bc3620fa@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff35c9873
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe5067 P4D 23ffe5067 PUD 23ffe4067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 17267 Comm: syz-executor.0 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:177 [inline]
RIP: 0010:kasan_check_range+0x80/0x2f0 mm/kasan/generic.c:186
Code: 00 00 fc ff df 4d 01 ea 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 ae 01 00 00 4c 89 cb 4c 29 d3 0f 1f 80 00 00 00 00 <45> 0f b6 19 45 84 db 0f 85 f3 01 00 00 49 ff c1 48 ff c3 75 eb e9
RSP: 0018:ffffc900068defd0 EFLAGS: 00010097
RAX: 000000000157aa01 RBX: ffffffffffffffff RCX: ffffffff8162c4be
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9ae4c398
RBP: ffffc900068df390 R08: dffffc0000000000 R09: fffffbfff35c9873
R10: fffffbfff35c9874 R11: 0000000000000000 R12: 1ffffffff35c9873
R13: dffffc0000000001 R14: 0000000000000001 R15: ffff888024965580
FS:  00007f1f7a0b4700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff35c9873 CR3: 000000002c2d2000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 __lock_acquire+0xdee/0x6100 kernel/locking/lockdep.c:4985
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
 complete_all+0x14/0x70 kernel/sched/completion.c:63
 __fw_state_set drivers/base/firmware_loader/firmware.h:121 [inline]
 fw_state_aborted drivers/base/firmware_loader/firmware.h:126 [inline]
 __fw_load_abort drivers/base/firmware_loader/fallback.c:98 [inline]
 kill_pending_fw_fallback_reqs+0x1e8/0x290 drivers/base/firmware_loader/fallback.c:119
 fw_pm_notify+0x5d/0xe0 drivers/base/firmware_loader/main.c:1450
 notifier_call_chain kernel/notifier.c:83 [inline]
 notifier_call_chain_robust kernel/notifier.c:118 [inline]
 blocking_notifier_call_chain_robust+0x13b/0x380 kernel/notifier.c:302
 pm_notifier_call_chain_robust+0x27/0x50 kernel/power/main.c:87
 snapshot_open+0x18a/0x260 kernel/power/user.c:75
 misc_open+0x346/0x3c0 drivers/char/misc.c:141
 chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x28e6/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_openat fs/open.c:1219 [inline]
 __se_sys_openat fs/open.c:1214 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1214
 do_syscall_64+0x39/0xa0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f7a0b4188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000020000400 RDI: ffffffffffffff9c
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007fff6b483a3f R14: 00007f1f7a0b4300 R15: 0000000000022000
Modules linked in:
CR2: fffffbfff35c9873
---[ end trace fe0e0b7a0a00e11d ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:177 [inline]
RIP: 0010:kasan_check_range+0x80/0x2f0 mm/kasan/generic.c:186
Code: 00 00 fc ff df 4d 01 ea 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 ae 01 00 00 4c 89 cb 4c 29 d3 0f 1f 80 00 00 00 00 <45> 0f b6 19 45 84 db 0f 85 f3 01 00 00 49 ff c1 48 ff c3 75 eb e9
RSP: 0018:ffffc900068defd0 EFLAGS: 00010097
RAX: 000000000157aa01 RBX: ffffffffffffffff RCX: ffffffff8162c4be
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9ae4c398
RBP: ffffc900068df390 R08: dffffc0000000000 R09: fffffbfff35c9873
R10: fffffbfff35c9874 R11: 0000000000000000 R12: 1ffffffff35c9873
R13: dffffc0000000001 R14: 0000000000000001 R15: ffff888024965580
FS:  00007f1f7a0b4700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff35c9873 CR3: 000000002c2d2000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
