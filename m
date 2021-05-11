Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44C837A4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEKKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:44:21 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43904 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhEKKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:44:20 -0400
Received: by mail-io1-f71.google.com with SMTP id r2-20020a5e95020000b0290435b891bacbso12581595ioj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=COpkcbc4tsn4BsAybQi0AotbbwVNE+lIfJJM2BJUhSw=;
        b=X6PR295ygub1ViFgQOn+2oLO50UXI1qvS1ixjgPvevj05Yegv6YToULIpU70X6QX+O
         KVFIboGt/nAaA3iMrprBJTeRfyK4MCVcLqHfqVo1oXdoZmwhJiLrrYGfl35ODMaAjTyH
         3NTBLJu4luUo4rwu5corfWvN4cxX8cr4GBdgD718/9x6GoJf2FimXb/qs+xu18i6hOMl
         ydAIlNDV46EB8xsywhTgtwqKyPQAJLeyCt4mPoadHtaA2tnujCBQOmhSxg2vtejZtaNT
         2HWJIjKumfSM0+mmuqql9P9SLjFjg0idOmve2IaBbiTfMd/4rsCUEarjwyOZppBos8M2
         sfsA==
X-Gm-Message-State: AOAM533AKmiLw4unaCu5QccU+RFxMtvgLxqMnvOf8kURDn9lWPg1zK/S
        j+DGPO3NrfDoLPxQYicCoApFl8QL13KPSiDrXqm2p02qyRR8
X-Google-Smtp-Source: ABdhPJzgN4KvmhGG1pPkaFSfUuR6gNcB6bePlAC9DE5o7XKEwDUBOocFKCpN4lNOWtqxn+LwBHdhdvpoRS4olhP86nING7WLhObI
MIME-Version: 1.0
X-Received: by 2002:a6b:6905:: with SMTP id e5mr21972403ioc.100.1620729794152;
 Tue, 11 May 2021 03:43:14 -0700 (PDT)
Date:   Tue, 11 May 2021 03:43:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a84c4c05c20b8f12@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in wdm_release
From:   syzbot <syzbot+3e04448a4d634f32306d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4676be28 usb: xhci-mtk: use first-fit for LS/FS
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=123857c3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5308902274df0f54
dashboard link: https://syzkaller.appspot.com/bug?extid=3e04448a4d634f32306d

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e04448a4d634f32306d@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: service_interrupt_work+0x0/0x110 arch/x86/include/asm/bitops.h:207
WARNING: CPU: 1 PID: 7231 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 7231 Comm: syz-executor.0 Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 80 f2 1f 86 4c 89 ee 48 c7 c7 80 e6 1f 86 e8 44 01 8a 03 <0f> 0b 83 05 95 43 ce 06 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90012c3fcd8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88811438d1c0 RSI: ffffffff812a5f73 RDI: fffff52002587f8d
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b963b R11: 0000000000000000 R12: ffffffff86068800
R13: ffffffff861fecc0 R14: ffffffff811a26a0 R15: dffffc0000000000
FS:  0000000003408400(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a7dd6ea998 CR3: 000000014d27d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1556 [inline]
 slab_free_freelist_hook+0x13b/0x1b0 mm/slub.c:1606
 slab_free mm/slub.c:3166 [inline]
 kfree+0xdb/0x3b0 mm/slub.c:4225
 wdm_release+0x288/0x370 drivers/usb/class/cdc-wdm.c:752
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x218/0x220 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41940b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd5a6f57a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffed RBX: 0000000000000007 RCX: 000000000041940b
RDX: 0000000000570d98 RSI: 000000000b35c238 RDI: 0000000000000006
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b2d32b6e4
R10: 00007ffd5a6f5890 R11: 0000000000000293 R12: 0000000000259050
R13: 00000000000003e8 R14: 000000000056bf60 R15: 00000000002587eb


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
