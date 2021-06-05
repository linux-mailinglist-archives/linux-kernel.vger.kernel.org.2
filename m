Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D839C85B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFENMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:12:41 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38847 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFENMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:12:40 -0400
Received: by mail-qt1-f179.google.com with SMTP id l7so9180436qtk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtkKhZvdaFNDI+ieOEDZCMEJigMySJk/sgLOuf0G8PI=;
        b=qlwB+EX8uzWN3V9m1nnRA7JtEIwKENBdUejE/u2+n8zUbBj8wfYZmQgVeAgZm8Sv19
         gjQIR37AtnzkHRNDng4yBEa1mY948xaenfcweaswf0pNK/E+0/QEjIOCLrlrR1M4q8mu
         dkkvIY5Z2W00RPJpNvIyfG79bvOgafi+sDRMU+SKZCJOY4MM+C09qR0XltUZk9BxY4RP
         FBrDacLzr93g5EWFvHl1gTfTsE22WL5nnW0tMXt+KHEI7f7D0U2mZ8H6+d/x0kxTaDw0
         vj4umz5gUxxRN1D4F5V+F2iSvaiQgo4WJjD+e2PnFWzfDCRADH8v3pdhtz/G3OoQFLAy
         HyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtkKhZvdaFNDI+ieOEDZCMEJigMySJk/sgLOuf0G8PI=;
        b=bdoTIU/acOlagMa914LqHgzszp3cYALzFOS7VBF5+L86ypZ7/3rz8i6ZP/PBcbxZv+
         +FHYFLc4oz0FveOUYrqqyNcZmXH6IEhpKKWcatVbEt6UPUjDUhWa+Tzgbbi9fQZapzFq
         luKXso6D0Vqe8OX/qa/tdNH94M7OvQ3URNvlDGOW4DuAt6MI8EsJ5VhmQpW61HhMD4vo
         v6Oj7sDieIBFG658e3WXtgxJKhmpCuvfFRmTDZPUs00K1/BiZIJXPBOhwOwncjJh6gwQ
         3k/4vJ0HH16C8kLTJVZo2hFLfM7YKb7wChpV7pur05+9Yp2c8W2P4hHhZj3kSg85zvg9
         3tKQ==
X-Gm-Message-State: AOAM530hERqkjqB4WOZkwTrRaEIYtg72yVL+evsImQLiDquhccXe2u96
        BfN24qpc9OnZtHY+NbI2Wu/qnm4m7Bkac6fRZ51TQQ==
X-Google-Smtp-Source: ABdhPJwoSnumvx2fkCHjPmNZKgeyie8cPEu3N83cb6j+EBW/Ljl1//YqzmmI7NNvPyMWBRrwf3U+3+CqqJVhjecJqWg=
X-Received: by 2002:ac8:7776:: with SMTP id h22mr1599872qtu.66.1622898591691;
 Sat, 05 Jun 2021 06:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000009a40d05c3ff2ebc@google.com>
In-Reply-To: <00000000000009a40d05c3ff2ebc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 5 Jun 2021 15:09:40 +0200
Message-ID: <CACT4Y+YyaKNDjuX7R7Q2XS-_HJHFVvdJY8MoqNfvU3DAOenMrg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in __ext4_mark_inode_dirty
To:     syzbot <syzbot+290af4ba353cd50ec3d3@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, sh_def@163.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 8:47 AM syzbot
<syzbot+290af4ba353cd50ec3d3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f88cd3fb Merge tag 'vfio-v5.13-rc5' of git://github.com/aw..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1187ac33d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
> dashboard link: https://syzkaller.appspot.com/bug?extid=290af4ba353cd50ec3d3
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+290af4ba353cd50ec3d3@syzkaller.appspotmail.com

Another rcu/lockdep false positive:

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives


> Process accounting resumed
> Process accounting resumed
> =============================
> WARNING: suspicious RCU usage
> 5.13.0-rc4-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-bh read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 3 locks held by syz-executor.1/20572:
>  #0:
> ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: acct_get kernel/acct.c:161 [inline]
> ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: slow_acct_process kernel/acct.c:576 [inline]
> ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: acct_process+0x213/0x4f0 kernel/acct.c:602
>  #1: ffff8880290ca460 (sb_writers#5){.+.+}-{0:0}, at: slow_acct_process kernel/acct.c:578 [inline]
>  #1: ffff8880290ca460 (sb_writers#5){.+.+}-{0:0}, at: acct_process+0x3b7/0x4f0 kernel/acct.c:602
>  #2: ffff8880752da270 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
>  #2: ffff8880752da270 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at: ext4_buffered_write_iter+0xb6/0x4d0 fs/ext4/file.c:263
>
> stack backtrace:
> CPU: 1 PID: 20572 Comm: syz-executor.1 Not tainted 5.13.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8304
>  __ext4_mark_inode_dirty+0xea/0x8d0 fs/ext4/inode.c:5908
>  ext4_dirty_inode+0xd4/0x110 fs/ext4/inode.c:5947
>  __mark_inode_dirty+0x6e3/0x10f0 fs/fs-writeback.c:2274
>  mark_inode_dirty include/linux/fs.h:2404 [inline]
>  generic_write_end+0x316/0x4f0 fs/buffer.c:2223
>  ext4_da_write_end+0x20f/0xb50 fs/ext4/inode.c:3110
>  generic_perform_write+0x2c0/0x4f0 mm/filemap.c:3671
>  ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:269
>  ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:680
>  __kernel_write+0x58d/0xa90 fs/read_write.c:550
>  do_acct_process+0xd0a/0x1420 kernel/acct.c:519
>  slow_acct_process kernel/acct.c:578 [inline]
>  acct_process+0x3b7/0x4f0 kernel/acct.c:602
>  do_exit+0x1979/0x2a60 kernel/exit.c:816
>  do_group_exit+0x125/0x310 kernel/exit.c:923
>  get_signal+0x47f/0x2150 kernel/signal.c:2835
>  arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
>  handle_signal_work kernel/entry/common.c:147 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x171/0x280 kernel/entry/common.c:208
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
>  do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: Unable to access opcode bytes at RIP 0x4665af.
> RSP: 002b:00007effc6b68218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000056c040 RCX: 00000000004665d9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056c040
> RBP: 000000000056c038 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c044
> R13: 00007fff3643907f R14: 00007effc6b68300 R15: 0000000000022000
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000009a40d05c3ff2ebc%40google.com.
