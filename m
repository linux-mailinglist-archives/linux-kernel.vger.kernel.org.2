Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2013A41B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFKMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:10:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:08:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j62so16845839qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWhjzL0BG20Osqqmg9CC5WGHi9p2+vsRIl8X8Fgwv+8=;
        b=h/eFZ/cnGDoz9K/breCBdgCyfDwfYqTzMPgzOnAHsw6GbuncKmhlq7BMEpj2WsYFf9
         DbqOqPFpEravP1SuQzp0TACrruKqXqC090vzSKbJuivwJxDbzwWSJLyAoYzKIGQxVl/d
         YSe8sx2LuZdrSQx9+azvJ+h4U+pi1c0Lg77gpiIsfxORz7xB03YqCyaWRX1R84z/Dlx4
         bfh2wMudieGAZI55hWT/8b1wXt6I0j/cJ6YXq9T68aaU78v85+hNkAtG9Fc+hK7Ls1uF
         J5IkDeI7P7qRXJgMbqtzaIa6tPAYBa83gyECg4FoUKGhNKHJxApR8F9PBwjstDvhkL/F
         rI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWhjzL0BG20Osqqmg9CC5WGHi9p2+vsRIl8X8Fgwv+8=;
        b=sqnmSjaffVYtOYgd4ZtzesK6jBnvoP6s3jdBmA7v8Vhc2cnJ2b4nzx1lED7pFpya5v
         XZxm9++sGueFJpD0YCObykwuzxmA++XoFiEgFojFvnHtKl6bhbnMe7J89G67JN4t6pl6
         Ix8xwm4WO4a0Jux/pZh8OOxk/dfNZh/pWgKAzzjnwuIjsubjED7aT3kzchjf3millY5v
         axtp2HA/O0Z+yGRrgctM768w4l+3x8/y3Es9AMJD8/GmUSWt824MnrkS3sA4R9LvKnmd
         eFFDDNi8vDqFO3EV61Qhduj71jaZAcZe22rbBuRgqAYD6TdTuLqt9ZDX8rO3JvKClGVd
         aD0w==
X-Gm-Message-State: AOAM533A+oDVSwnMVb/uPVaGR00p/5wtUhktffORS5ERIJ3Wgs0F2SeN
        QnlL191DJNj7373gnXBdLlKK8Xcncm/Cyqx8EU51Tw==
X-Google-Smtp-Source: ABdhPJysT88unyQLkqYH4hrBVhtDdbpYtRtug7KRXS4jYmhwh1qIeP6ChT4myX5Dpm+rzU7ObzrjVOD34tooozE0GVg=
X-Received: by 2002:ae9:f010:: with SMTP id l16mr3516800qkg.424.1623413317627;
 Fri, 11 Jun 2021 05:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ec812705c47c4342@google.com>
In-Reply-To: <000000000000ec812705c47c4342@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 11 Jun 2021 14:08:26 +0200
Message-ID: <CACT4Y+YPNkppHK90RZF8TEgycKXzHDqD7x+2q9W5FtiNHRdVQw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in kernfs_iop_get_link
To:     syzbot <syzbot+9fa589353c6e1587c6b3@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 2:01 PM syzbot
<syzbot+9fa589353c6e1587c6b3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    614124be Linux 5.13-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a6cdbbd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
> dashboard link: https://syzkaller.appspot.com/bug?extid=9fa589353c6e1587c6b3
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9fa589353c6e1587c6b3@syzkaller.appspotmail.com

Concurrent reports, looks like another case of:

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives

> =============================
> WARNING: suspicious RCU usage
> 5.13.0-rc5-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-sched read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by systemd-udevd/13755.
>
> stack backtrace:
> CPU: 0 PID: 13755 Comm: systemd-udevd Not tainted 5.13.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8304
>  might_alloc include/linux/sched/mm.h:201 [inline]
>  slab_pre_alloc_hook mm/slab.h:497 [inline]
>  slab_alloc_node mm/slub.c:2834 [inline]
>  slab_alloc mm/slub.c:2921 [inline]
>  kmem_cache_alloc_trace+0x277/0x2c0 mm/slub.c:2938
>  kmalloc include/linux/slab.h:556 [inline]
>  kzalloc include/linux/slab.h:686 [inline]
>  kernfs_iop_get_link fs/kernfs/symlink.c:135 [inline]
>  kernfs_iop_get_link+0x61/0x6e0 fs/kernfs/symlink.c:126
>  pick_link fs/namei.c:1741 [inline]
>  step_into+0x168e/0x1c80 fs/namei.c:1798
>  open_last_lookups fs/namei.c:3308 [inline]
>  path_openat+0x491/0x27e0 fs/namei.c:3491
>  do_filp_open+0x190/0x3d0 fs/namei.c:3521
>  do_sys_openat2+0x16d/0x420 fs/open.c:1187
>  do_sys_open fs/open.c:1203 [inline]
>  __do_sys_open fs/open.c:1211 [inline]
>  __se_sys_open fs/open.c:1207 [inline]
>  __x64_sys_open+0x119/0x1c0 fs/open.c:1207
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f0ff9316840
> Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
> RSP: 002b:00007ffeb81b55a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000701 RCX: 00007f0ff9316840
> RDX: 0000000000000001 RSI: 0000000000080000 RDI: 00007ffeb81b55b0
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000012
> R10: 0000000000000064 R11: 0000000000000246 R12: 00007ffeb81b6600
> R13: 00007ffeb81b7690 R14: 0000000000000000 R15: 0000000000000000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ec812705c47c4342%40google.com.
