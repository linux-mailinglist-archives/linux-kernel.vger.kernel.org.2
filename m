Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F26375CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhEFVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:35:27 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:41900 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:35:26 -0400
Received: by mail-il1-f198.google.com with SMTP id m4-20020a9287040000b0290166e96ff634so5575722ild.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 14:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3CQRv1MMPidxolkoeD/DeJhyOO/QRFAG2V1l4//lqmY=;
        b=JN1K8aMTcWxJlkWLNAebpxd/5eEAhUC1rw86n4GHMboDLTOG+RPQAeIMN5Ur3pCXq/
         bPRpIquGw+vQZ4qPg2REBU/sf/Xii/z5NrP+s0AyIcNAB56P8jtpeiqp0FOlBbXhpyZe
         INolksH83M0SdxlfXtSRtCPluw1tUkT9RCYx2VY9F9k6kRHFQoAI/FaYzlmYYVEyvc/i
         qvx9Y8Hj2ozZ9UhI7T/zGNwSYRNYo/C59NN8OVVcJwU8/46XZDLo8DwFZScUlK1E/BXK
         /zJI1NbmCpWX5bD5/Ldk6FNHUyzwrE08GWgSPUtV9w5/vn/N/9zlKBLqXnOLiPkaYaQR
         7YRg==
X-Gm-Message-State: AOAM530vQPyd801m7ajjgQrCDvddItN8NKL/ZcZ6OLDBDAmSCQerm1Yc
        JsWXCFAu64xgyLmBMadfGCCFK++PF5dwnA6bgkVlyul31k5w
X-Google-Smtp-Source: ABdhPJyG+CbnNxvx/6LeI3Xen/G9xegmZj5fWM+Is4+k315XAJY8YiTtc4aQFwCny0v3mxI6WXQrNGjHAAftEQqKL1IwtOYamBwT
MIME-Version: 1.0
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr6478220ilq.81.1620336867359;
 Thu, 06 May 2021 14:34:27 -0700 (PDT)
Date:   Thu, 06 May 2021 14:34:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006540d705c1b013b5@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in get_signal
From:   syzbot <syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com, pcc@google.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123a56a5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=37fc8b84ffa2279d636d
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37fc8b84ffa2279d636d@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
no locks held by syz-executor.4/10430.

stack backtrace:
CPU: 0 PID: 10430 Comm: syz-executor.4 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8304
 try_to_freeze_unsafe include/linux/freezer.h:57 [inline]
 try_to_freeze include/linux/freezer.h:67 [inline]
 get_signal+0x14a/0x2150 kernel/signal.c:2613
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x171/0x280 kernel/entry/common.c:208
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:314
 exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1534
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0023:0x8052207
Code: 0c 50 e8 ac 5a 01 00 83 c4 10 85 c0 0f 84 b9 01 00 00 65 f0 83 2d d8 ff ff ff 01 8b 5c 24 08 e8 6f f7 00 00 8b 4c 24 0c 8b 00 <8b> 71 50 89 41 54 85 c0 75 05 83 fe ff 74 19 6b 44 24 1c 34 8b 4c
RSP: 002b:00000000f5514640 EFLAGS: 00010283
RAX: 000000000000000e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000080521e4 RSI: 0000000000000005 RDI: 00000000080ea51d
RBP: 000000000819afc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
