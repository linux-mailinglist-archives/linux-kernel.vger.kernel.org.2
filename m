Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74B331F99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCIG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCIG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:59:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB25C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:59:13 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id x13so5918615qvj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2Gh0omnL6qCDttd8RSZQBgGmzhZ9ZGyEGJCcSDM0XY=;
        b=tN8WpN5RfmOupeG9IcM6BWlPZ3qCfIB9UqbR3EIax+e+hG+ZBjjS+zm/AD+9zVuI6c
         hPEa77xWhmPi9JFs+VVnYBjgPAjO/fwORXANEWL9b6bLycGJ4eYIl/LtDbf32Y73Ov6N
         HilHForL0pqDDqcLSb2SmPG7v5P+jznLla9v1pViJoVqM8LZuBnWHgpIFmeFnhqL8of6
         cddf9+yayRT62a1je+g7uAhQ+N51BRNgpZeqsJJqzkZb+jSiTt0nlaOaq9xT6HE/Z6Im
         33zB4xZNdQ7PX+rzqmCcLhp1tPoKXRGyLNTuPb3oXokyZIJjqQCiZ3oMig5NaINtBj39
         DbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2Gh0omnL6qCDttd8RSZQBgGmzhZ9ZGyEGJCcSDM0XY=;
        b=K7IuQzIvHXpzDHEzwMaIlmMEfRCZ7zaZfL9Qol36kMz5T6epFMErGxyfG7gSOdMk16
         3M+lbyMyPBXBKyB8DAdpraTRg2PFjP1DKANtaHx4qyQUjzFE8MQGcDEsPlbP36kNJcwb
         J5AaRjMsogc7rUT7/EwGY6h56I1CIb6PaiCE+qZc/I9/XQAaE9WNSsQAyHxyY3tr6qCX
         nWJQ8OgMI5e/x1IRZodCK93XscHdWEAx51/3BPQTbv3JlXRev1Fd+SjU+ICgcLon5Q1R
         dYmplBYYC0nvqK3Cf7aJoYRUX4hm49zRl15NA7mQf19AErO0bG4/q/eFk7tVsckL9J2E
         LKPA==
X-Gm-Message-State: AOAM530HEaWIjnswhZwboesI0gAGmXoXHYVBEy7hgKJTizCHVnV6t4S6
        4dNzZJjW2rW5+eCnTGa0fprV5eAVqUHHsoHEsEAl4w==
X-Google-Smtp-Source: ABdhPJw5jMJRwqBq6TAG8VYv7RFn0n6mU8bJN6a5nYScE1/qujuIEId5IBzWtIsr8XSTmP3uNqA81uop/FYxOgZattQ=
X-Received: by 2002:ad4:410d:: with SMTP id i13mr23836105qvp.44.1615273152969;
 Mon, 08 Mar 2021 22:59:12 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004b43a605bcd0545c@google.com>
In-Reply-To: <0000000000004b43a605bcd0545c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 07:59:02 +0100
Message-ID: <CACT4Y+ZaN=zFxG6xRwUNeVicEdCRKj0f+Jo55RQtHYw5=BA+gg@mail.gmail.com>
Subject: Re: [syzbot] net-next boot error: WARNING in kvm_wait
To:     syzbot <syzbot+05a8c6cb8281f23c8915@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 9:57 PM syzbot
<syzbot+05a8c6cb8281f23c8915@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d310ec03 Merge tag 'perf-core-2021-02-17' of git://git.ker..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1532e4c6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66df2ca4f2dd3022
> dashboard link: https://syzkaller.appspot.com/bug?extid=05a8c6cb8281f23c8915
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+05a8c6cb8281f23c8915@syzkaller.appspotmail.com

#syz dup: upstream boot error: WARNING in kvm_wait

> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 0 PID: 4818 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 0 PID: 4818 Comm: selinux-autorel Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: bf ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 8a 88 b1 04 00 74 01 c3 48 c7 c7 40 a2 6b 89 c6 05 79 88 b1 04 01 e8 b8 37 bf ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0018:ffffc900015cfc40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffff8be287a0 RCX: 0000000000000000
> RDX: ffff888022b31bc0 RSI: ffffffff815b6845 RDI: fffff520002b9f7a
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815af71e R11: 0000000000000000 R12: 0000000000000003
> R13: fffffbfff17c50f4 R14: 0000000000000001 R15: ffff8880b9c35f40
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff7c1ccab04 CR3: 000000000bc8e000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  kvm_wait arch/x86/kernel/kvm.c:860 [inline]
>  kvm_wait+0xc9/0xe0 arch/x86/kernel/kvm.c:837
>  pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
>  __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
>  do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
>  spin_lock include/linux/spinlock.h:354 [inline]
>  check_stack_usage kernel/exit.c:715 [inline]
>  do_exit+0x1d6a/0x2ae0 kernel/exit.c:868
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  __do_sys_exit_group kernel/exit.c:933 [inline]
>  __se_sys_exit_group kernel/exit.c:931 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7ff7c19e9618
> Code: Unable to access opcode bytes at RIP 0x7ff7c19e95ee.
> RSP: 002b:00007fff88573528 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff7c19e9618
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 000055658b8146e0 R08: 00000000000000e7 R09: ffffffffffffff98
> R10: 000055658bead6c0 R11: 0000000000000246 R12: 000055658b8037a0
> R13: 00007fff88573810 R14: 0000000000000000 R15: 0000000000000000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004b43a605bcd0545c%40google.com.
