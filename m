Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166A143DB84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1Gwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:52:51 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:37650 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhJ1Gwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:52:47 -0400
Received: by mail-il1-f198.google.com with SMTP id x5-20020a056e021bc500b0025a9bf89937so3429803ilv.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9IOQueOs0l5y9Mce/jggTMg0HEDlO9ktlzNzjIB20JI=;
        b=4jJ98tnrU6g49rtDSBFJHb4pJ7Z1rkgQwlDwTIrlh0yuEusQuppt0mr3HKcId4xrhI
         wVR2BiHaAd4C111vOUq5cX3ggCuzy2sHrXIhSo8IlJTZ5xFK6Qe8zq8lVsshGyVupJgz
         j634xy6xZLFUFnu8ND2N7TPtnKDsw1CmwGb/TSb2UIlkAcuhzhmcVFENjMPk805FerIX
         HRx4SKozwrub6X7lqRHsHHP4BCFm+Jr+ODQruwMUG6rEeYXzCkhLqzAO5se198eGq2bs
         RW6G2FTUAh/AryPHuHXOervvSRJtkae4iYn4402hf1NtUDbscDhRR2iTzTrOY+3IXGhR
         J3Zg==
X-Gm-Message-State: AOAM533rItNNAeBkrm480QwsjexeuV5bqPkrQcLqCQu2ee9t80+C9J8+
        BxUaVepvkRyJkBnbQh1ZyJSFlDWgX5MDYXUjJyPhjzU9nruy
X-Google-Smtp-Source: ABdhPJwCNWh2hmEW5DYKLzmLxMCaXZow++Zg6Brh9p1Td9PbcUhTecynEi2MVHD0IKCPquN3Rz/fecN8fSoXXNO6/zsOHncBrbo/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr1987527ilu.198.1635403820543;
 Wed, 27 Oct 2021 23:50:20 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:50:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9b4c805cf641f0c@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Read in do_journal_end
From:   syzbot <syzbot+f0a07c0d7dae72a221d5@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiantao6@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130d1b0cb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
dashboard link: https://syzkaller.appspot.com/bug?extid=f0a07c0d7dae72a221d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0a07c0d7dae72a221d5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in set_buffer_uptodate include/linux/buffer_head.h:120 [inline]
BUG: KASAN: null-ptr-deref in do_journal_end+0x12da/0x4950 fs/reiserfs/journal.c:4077
Read of size 8 at addr 0000000000000000 by task syz-executor.0/3707

CPU: 1 PID: 3707 Comm: syz-executor.0 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 set_buffer_uptodate include/linux/buffer_head.h:120 [inline]
 do_journal_end+0x12da/0x4950 fs/reiserfs/journal.c:4077
 reiserfs_sync_fs+0xf8/0x120 fs/reiserfs/super.c:78
 __sync_filesystem fs/sync.c:39 [inline]
 sync_filesystem fs/sync.c:64 [inline]
 sync_filesystem+0x105/0x260 fs/sync.c:48
 generic_shutdown_super+0x70/0x370 fs/super.c:448
 kill_block_super+0x97/0xf0 fs/super.c:1395
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0ba0b36ea7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff63b1eb68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0ba0b36ea7
RDX: 00007fff63b1ec3b RSI: 0000000000000002 RDI: 00007fff63b1ec30
RBP: 00007fff63b1ec30 R08: 00000000ffffffff R09: 00007fff63b1ea00
R10: 0000555556184893 R11: 0000000000000246 R12: 00007f0ba0b8f035
R13: 00007fff63b1fcf0 R14: 0000555556184810 R15: 00007fff63b1fd30
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
