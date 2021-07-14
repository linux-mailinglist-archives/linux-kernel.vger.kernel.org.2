Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563603C84A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhGNMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:50:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37818 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhGNMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:50:13 -0400
Received: by mail-io1-f71.google.com with SMTP id p7-20020a6b63070000b029050017e563a6so1158862iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 05:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+s3n4qWrtDMRm0uF1xF47boitAjAuz09jDtLN5Z2zUQ=;
        b=kCYGT9CfCILCTcRd+E2fFVm2XU71RVAAmJoFFRAXfA2spxR9j8zktcFxH9zmGUiAek
         7zAWCuD4p1xmobXG3ckevaciKBgw43Smiy9i6fZfVdpoaGG24IfkLHHI2gHi7hfBWyTW
         3J2F7PWSPeFlw9/c3AN/THNbpXaLRmwoWkW7E/2F8B2GMLvctdbC+zWC8qarhPHG4ko2
         me92LsgTZdMdfKtSBxgpKLrIByBCEQ5w+EjTVuokz2Easv3Y4JK3gvV1TDemcWKShS8M
         07z+l1TUhYj/+TR0GP3/81o67ywKCVQVTKZAI9e3XPnaX4N2a55DZdP0/kG6/MLY84K3
         tFoQ==
X-Gm-Message-State: AOAM533ByF1qb1tKQbhd0tVLLH1vmH6CSs/wqwBarwsK2/kTfr8nGmlc
        qlWB0r/h/CFsalnDEklycB0r4x5FOZ/E0tg+X4xIC3w+JKmA
X-Google-Smtp-Source: ABdhPJww5+rallpvcS9/lG7WRwlzFcraa+5AzdSR4KRClUM8zU2hapspipP7BW22uGMMmHzL//i5p3xxzYE8GgV+DYLiBMC1LIaJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2204:: with SMTP id n4mr7092213ion.181.1626266841187;
 Wed, 14 Jul 2021 05:47:21 -0700 (PDT)
Date:   Wed, 14 Jul 2021 05:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000610af005c714c1d1@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in profile_init
From:   syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11342328300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=e68c89a9510c159d9684
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149a96d2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114e5bc4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com

kernel profiling enabled (shift: 1000000)
================================================================================
UBSAN: shift-out-of-bounds in kernel/profile.c:110:31
shift exponent 1000000 is too large for 64-bit type 'long int'
CPU: 0 PID: 8453 Comm: syz-executor969 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 profile_init+0xfc/0x110 kernel/profile.c:110
 profiling_store+0x5e/0xd0 kernel/ksysfs.c:80
 kobj_attr_store+0x50/0x80 lib/kobject.c:856
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ee69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee8801868 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee69
RDX: 00000000ffffff82 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000402e50 R08: 0000000000000000 R09: 0000000000400488
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402ee0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
