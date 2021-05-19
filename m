Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E24388FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbhESODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:03:37 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55205 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhESODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:03:35 -0400
Received: by mail-il1-f200.google.com with SMTP id h1-20020a056e021d81b02901bb694b89faso12319616ila.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lal3/tKMtazEhUHfuImVZ2YUGJYVN1EU9s1K0h98qkM=;
        b=EeiX+ulIzZnTUjBtDSy2JTeSI5Rivo2OTns91QrkL20UlRCsW6MtwPeTL7KCFK53tM
         P3K4CpKcqK/LaLS3kOV4/rgGwGKIZI2JSnedPc3X93z2o8yGtGNi2Z37ZK+4Xcr2ZB8d
         gPjhU3fuIIprexC3nCt/PIx5b0bUF/VuLxbRFmBqbJlq7phFo/9Y9P9rVKPEBB0I84R4
         RItS/rl7s2BYeIv4UvMy7lk2JWHG0QY7UnHiAqj7UXj7U0DK+czJDeBNmyO/O/Sdps3K
         HCfy2fLNMCWx5xTFGub1sxYaZEy+ukTwT509juX+wGIEEmYrOJQxbZE+YUFltbE++gdx
         pdAA==
X-Gm-Message-State: AOAM530m+X3UOuuUJSH1PywNvrzcU0lDfUuFn1iSzQ+/7Gd8DPfEnpwk
        fMhkQwQAD+Cj0WIzLAwgcV8b0W9QqREKhP6HbgFGiorp1dmK
X-Google-Smtp-Source: ABdhPJx68/imrEk8Fcy60c6Jcvo06HohCne8PwT1U+gOUUdAcrqetRjvEcdTf2J/ISwqscCdaxAs1v7d4mwvWsc2SSLm28qFgjA3
MIME-Version: 1.0
X-Received: by 2002:a5e:a806:: with SMTP id c6mr9378305ioa.180.1621432935818;
 Wed, 19 May 2021 07:02:15 -0700 (PDT)
Date:   Wed, 19 May 2021 07:02:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aad2505c2af46c2@google.com>
Subject: [syzbot] WARNING: locking bug in complete_all
From:   syzbot <syzbot+0a94f55b21945de250e6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25a12987 Merge tag 'trace-v5.13-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b425fdd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec0e727d62342a37
dashboard link: https://syzkaller.appspot.com/bug?extid=0a94f55b21945de250e6
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a94f55b21945de250e6@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 1 PID: 14609 at kernel/locking/lockdep.c:4872 __lock_acquire+0x2741/0x6040 kernel/locking/lockdep.c:4872
Modules linked in:
CPU: 1 PID: 14609 Comm: syz-executor.1 Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0x2741/0x6040 kernel/locking/lockdep.c:4872
Code: 1c 00 00 c7 44 24 28 00 00 00 00 48 c7 c7 20 94 2e 8a 48 c7 c6 00 c5 2e 8a 31 c0 e8 29 16 ea ff 49 b8 00 00 00 00 00 fc ff df <0f> 0b e9 d5 1b 00 00 0f 0b e9 e4 ec ff ff e8 2c 8c 5e 08 c7 44 24
RSP: 0018:ffffc9000217efe0 EFLAGS: 00010046
RAX: 81e596e45e282400 RBX: ffffffffab400119 RCX: 0000000000040000
RDX: ffffc900095c9000 RSI: 0000000000002fee RDI: 0000000000002fef
RBP: ffffc9000217f370 R08: dffffc0000000000 R09: ffffed1017363f24
R10: ffffed1017363f24 R11: 0000000000000000 R12: ffff88802ab6df58
R13: ffffc9000217f300 R14: ffff88802ab6d4c0 R15: ffff88802ab6df78
FS:  00007fd2642f3700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000568000 CR3: 0000000099e41000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
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
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd2642f3188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffcd0d0c31f R14: 00007fd2642f3300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
