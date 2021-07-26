Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205793D52FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZFTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:19:51 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35598 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGZFTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:19:50 -0400
Received: by mail-io1-f72.google.com with SMTP id i10-20020a5e850a0000b029053ee90daa50so7883724ioj.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=D9EM5VKKwyO99BKa5dlPRxFcPsOweSEsX2CuHpyOt3k=;
        b=kyqmShP4YE5OY9dRa+LrGF80le3DKo6eNBGd3FWQcVVNo5VHcMRPB5EBwUrSifPRru
         tQtQqI3PrwVvUtUmPwt5Xd8VsZTmP+DDBof1YNjJO49AxgKxCZcyCCHH3vh6zvfKFM6g
         HZ3Qyazd6E674vVr7ABgkcr6hwdmBZseuCfbH7AQmeNhhrtGjcukYTMujtqCjlUFORfW
         VWmKVzjbEzNf+7lIS3TkRA6z0yHfyx8uRXrtG2U0cw0lkfjrIrcrXd20EXIsIAG8quyo
         8bTBh1P3hio5CZZzX3Sm8NPL2JyrepW5TkqT/kyaOda0PjmX1TnCPUE+O8CERzdLR7k1
         PFAA==
X-Gm-Message-State: AOAM532pKSy8co2zZqF2MlujUEOYeSGUjMwiRaPu69fwLcHNQmwL/2E7
        G/7X7EfJj6emdc5gZ4nxh/ajyZrHEVjhFLYUJeT5HV/ShuRL
X-Google-Smtp-Source: ABdhPJzp8uI94op9J7iPvgJYLchzvC6Sj4Enx/SbpfKifmxDM74uSRJzcLC3eur6RX9/Cr8fiAG5rfrh2mkSPBl1XIzUoRYNEl9S
MIME-Version: 1.0
X-Received: by 2002:a92:3207:: with SMTP id z7mr11971928ile.288.1627279219581;
 Sun, 25 Jul 2021 23:00:19 -0700 (PDT)
Date:   Sun, 25 Jul 2021 23:00:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5677605c8007723@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in f2fs_update_meta_page
From:   syzbot <syzbot+07ff38c9c93ca170de07@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6498f6151825 Merge tag 'riscv-for-linus-5.14-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bbce46300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dc0e3202ae2f574
dashboard link: https://syzkaller.appspot.com/bug?extid=07ff38c9c93ca170de07
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07ff38c9c93ca170de07@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 7395a067 P4D 7395a067 PUD 7395b067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 14793 Comm: syz-executor.3 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000158f858 EFLAGS: 00010286
RAX: 1ffffffff147d97b RBX: 00000000000005ff RCX: ffffffff8a3ecbd8
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00027e9540
RBP: ffffc9000158fad0 R08: ffffffff81aa846c R09: fffff940004fd2a9
R10: fffff940004fd2a9 R11: 0000000000000000 R12: ffff888081491310
R13: 0000000000000001 R14: ffff88807fa0e000 R15: ffffea00027e9540
FS:  0000000002a84400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000073959000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 f2fs_update_meta_page+0x4b/0x380 fs/f2fs/segment.c:2422
 do_checkpoint fs/f2fs/checkpoint.c:1492 [inline]
 f2fs_write_checkpoint+0x2f1b/0x5060 fs/f2fs/checkpoint.c:1650
 f2fs_issue_checkpoint+0x308/0x4a0 fs/f2fs/checkpoint.c:1718
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem+0x19e/0x200 fs/sync.c:67
 generic_shutdown_super+0x6e/0x2b0 fs/super.c:448
 kill_block_super+0x79/0xd0 fs/super.c:1395
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4329
 deactivate_locked_super+0xa7/0xf0 fs/super.c:335
 cleanup_mnt+0x462/0x510 fs/namespace.c:1136
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x201/0x220 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:302
 do_syscall_64+0x4c/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467a47
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa4976ab8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000467a47
RDX: 00007fffa4976b8b RSI: 0000000000000002 RDI: 00007fffa4976b80
RBP: 00007fffa4976b80 R08: 00000000ffffffff R09: 00007fffa4976950
R10: 0000000002a858e3 R11: 0000000000000246 R12: 00000000004bee90
R13: 00007fffa4977c50 R14: 0000000002a85810 R15: 00007fffa4977c90
Modules linked in:
CR2: 0000000000000000
---[ end trace dff6785899946653 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000158f858 EFLAGS: 00010286
RAX: 1ffffffff147d97b RBX: 00000000000005ff RCX: ffffffff8a3ecbd8
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea00027e9540
RBP: ffffc9000158fad0 R08: ffffffff81aa846c R09: fffff940004fd2a9
R10: fffff940004fd2a9 R11: 0000000000000000 R12: ffff888081491310
R13: 0000000000000001 R14: ffff88807fa0e000 R15: ffffea00027e9540
FS:  0000000002a84400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000073959000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
