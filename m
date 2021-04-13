Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80E35E605
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347534AbhDMSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhDMSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:11:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c123so13963326qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP1yZTQwOtiqVSS9i6sWp1c/yU9rYxNAzNbGrmEt0E4=;
        b=O99pOisvrXihRCyF25FzuvCNjnpt7uwox3cvgEbbO3eyL3YgU1oI5auyn0FP+9+BnO
         pz1uyshGwNHqhKYgAwd9JavcOLnWf+QdGluUd9ouOJBXn4FmFuAJXnrckY8dhDHeXjoe
         Ge6MPmUjX70keUCE+C7TMK4uvM8+ep7LQWjUNfWUePXMHsw4u/hMSD26MhhqoBIRnsRk
         YDaZ23r3IapEHtw8nGTGHOTU7dT5+rOE0vZi7jEVrrWpNtz9tFrpHqEaqUtM5+p/YebF
         NL89SOJ1YOmcdAo5gc74md1TQLgDtg9707Ul5y/tJ/jpXw6e//QFPk+d/3X68XHka8rn
         JqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP1yZTQwOtiqVSS9i6sWp1c/yU9rYxNAzNbGrmEt0E4=;
        b=uHUO119a4ylLJHaHTCFprz2lo/+17iZs57+qxDKD0HIJO6EMeGo24kARQznO+1yNyr
         6/7YR6rGS9o2zF4rMrBeaWMFRs4aIXOOXwJd7+kS+3LjFeUjto08K8Jc++1u1vQMu00f
         dYOTUvKpmZqo7stm16iZsZ6atN3W8xvSDvef5s/GD9673NzWFH+nMdU4v6SBcfkflE7V
         cY30iw4HnCRFFdnErykZMAt0XfCIKuAgO6U/rS4BN/tUsO+glqjmitwXisluQkZ25kP1
         NmKwqWcdwE00QVL4KnHpwetJUQzhJhJpDYqaZKu4cuLHbk9vaVAekxXiiCFwW8thqd9x
         xuEw==
X-Gm-Message-State: AOAM530MggKsvtsraW7vLTM+Vh5J1fjT7svwWy/W+KwDNx6vs+oD9Pzu
        FBqlWtem5YDVTGxR+nLTprz3iNIcitKhWXmuSeK6QQ==
X-Google-Smtp-Source: ABdhPJzp3P2TkGIWOF+5MkddfdRlvtoKFnlmTx6gm09J2EWdjg2DwxYbwlFRKdQlf1lAkvmXTGG1sqR/qGOhFRBx1jI=
X-Received: by 2002:a05:620a:a47:: with SMTP id j7mr11046809qka.350.1618337492194;
 Tue, 13 Apr 2021 11:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ea3ddb05bf15fdf8@google.com>
In-Reply-To: <000000000000ea3ddb05bf15fdf8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 20:11:21 +0200
Message-ID: <CACT4Y+ZrYn9GU0JT+2NkujT5f9ESPA4cDbs4_0NbkraCtkPOVQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in copy_pte_range
To:     syzbot <syzbot+c2d2a6e2af34adb88749@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 8:54 PM syzbot
<syzbot+c2d2a6e2af34adb88749@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15604986d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
> dashboard link: https://syzkaller.appspot.com/bug?extid=c2d2a6e2af34adb88749
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c2d2a6e2af34adb88749@syzkaller.appspotmail.com

#syz dup: WARNING: suspicious RCU usage in getname_flags

> =============================
> WARNING: suspicious RCU usage
> 5.12.0-rc5-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 3 locks held by syz-executor.2/8400:
>  #0: ffffffff8c796770 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap+0x73/0xde0 kernel/fork.c:479
>  #1: ffff8880286c0158 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
>  #1: ffff8880286c0158 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap+0x87/0xde0 kernel/fork.c:480
>  #2: ffff8880286c2458 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
>  #2: ffff8880286c2458 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap+0xd1/0xde0 kernel/fork.c:489
>
> stack backtrace:
> CPU: 1 PID: 8400 Comm: syz-executor.2 Not tainted 5.12.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x176/0x24e lib/dump_stack.c:120
>  ___might_sleep+0xb4/0x530 kernel/sched/core.c:8294
>  copy_pte_range+0x255b/0x2a20 mm/memory.c:1010
>  copy_pmd_range mm/memory.c:1064 [inline]
>  copy_pud_range mm/memory.c:1101 [inline]
>  copy_p4d_range mm/memory.c:1125 [inline]
>  copy_page_range+0xba9/0xff0 mm/memory.c:1198
>  dup_mmap+0x9aa/0xde0 kernel/fork.c:594
>  dup_mm+0x8c/0x310 kernel/fork.c:1368
>  copy_mm kernel/fork.c:1424 [inline]
>  copy_process+0x24c1/0x5690 kernel/fork.c:2113
>  kernel_clone+0x1a6/0x6c0 kernel/fork.c:2500
>  __do_sys_clone kernel/fork.c:2617 [inline]
>  __se_sys_clone kernel/fork.c:2601 [inline]
>  __x64_sys_clone+0x1d5/0x220 kernel/fork.c:2601
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x464a4b
> Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
> RSP: 002b:00007ffc64260880 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000464a4b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000003070400
> R10: 00000000030706d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffc64260970
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ea3ddb05bf15fdf8%40google.com.
