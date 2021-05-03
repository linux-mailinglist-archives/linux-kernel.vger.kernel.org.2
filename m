Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8E3710EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhECEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 00:31:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44988 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECEbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 00:31:17 -0400
Received: by mail-io1-f70.google.com with SMTP id z25-20020a05660200d9b02903de90ff885fso2440500ioe.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 21:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qhTWpfL3z8v6czLxO0LScU6mbAkDF8Up/p/3HeH4yxU=;
        b=Cm9ggz+m/Hhgn3pvRcdNVSO+0+yAeCqP0DNK+6LLRijhXWJVQXhCqVaiXp3Lm2+P43
         JyE5JmJWPxVPFksr2eUAQXhqOTnzD7J7Qbpw55TCtg50my0Pt+Cy9iFCVcW57rGQ9FLi
         uVN8E/abb6ag/xf34P0R0O+dP9hyMCG4xv1xh4klOWlctF0k/e8dhe9PJsb4/6LfQWub
         xBv0p3YQzC2BmCA2x3bLQE6IiYUQbNahgWPWqokGdAnpzvcDNHFq2tHr1A/fX0Kryjxn
         GgHHWfkvJ3xVeutYo0ym/F+PkDf63I6fIaxoahYQ1Jhqz+L+/i8ms8K7+J7jBY7c8xcY
         fb3g==
X-Gm-Message-State: AOAM531zDmzCIfrvXRbBbRh+halGZCkvbofDV8sfLT04PSwlLKZ+Rje3
        dEO+XcF5euTCEUUUAm3xpwAucamFOecw4uPtCYyeWtg7HvBK
X-Google-Smtp-Source: ABdhPJz2Wk/CR0fTMSMBITvQD/taL+mLWYWdz2jKRBiXvAeek73fyphg+aB87ZX1FbEu8GOmiY0ow58obrQBlvJlSfztZAbsRRhx
MIME-Version: 1.0
X-Received: by 2002:a5e:a604:: with SMTP id q4mr2134727ioi.178.1620016224423;
 Sun, 02 May 2021 21:30:24 -0700 (PDT)
Date:   Sun, 02 May 2021 21:30:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009653db05c1656b9b@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in kernfs_iop_getattr
From:   syzbot <syzbot+c26b2cb5301be7de9efc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d72cd4ad Merge tag 'scsi-misc' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123fbb85d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
dashboard link: https://syzkaller.appspot.com/bug?extid=c26b2cb5301be7de9efc
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c26b2cb5301be7de9efc@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
no locks held by systemd-udevd/4826.

stack backtrace:
CPU: 1 PID: 4826 Comm: systemd-udevd Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 ___might_sleep+0x114/0x6b0 kernel/sched/core.c:8304
 __mutex_lock_common+0xce/0x2e50 kernel/locking/mutex.c:928
 __mutex_lock kernel/locking/mutex.c:1096 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1111
 kernfs_iop_getattr+0x89/0x310 fs/kernfs/inode.c:194
 vfs_getattr fs/stat.c:134 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:199
 vfs_fstatat fs/stat.c:217 [inline]
 vfs_lstat include/linux/fs.h:3384 [inline]
 __do_sys_newlstat fs/stat.c:372 [inline]
 __se_sys_newlstat fs/stat.c:366 [inline]
 __x64_sys_newlstat+0xd3/0x150 fs/stat.c:366
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f41b6750335
Code: 69 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 31 db 2b 00 f7 d8 64 89
RSP: 002b:00007ffe4d8d3b08 EFLAGS: 00000246
 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 00005601243f1120 RCX: 00007f41b6750335
RDX: 00007ffe4d8d3b40 RSI: 00007ffe4d8d3b40 RDI: 00005601243f0120
RBP: 00007ffe4d8d3c00 R08: 00007f41b6a0f228 R09: 0000000000001010
R10: 00007f41b6a0eb58 R11: 0000000000000246 R12: 00005601243f0120
R13: 00005601243f0134 R14: 000056012440253d R15: 0000560124402544


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
