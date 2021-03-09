Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C338331F94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCIG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCIG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:58:38 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51151C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:58:38 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 2so5944800qvd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDRu5bKyV8khRjLftXf9vZbsjcdEi7ALfscd87ISlWc=;
        b=oshnapiooSoGPo5jxE5fsJPRh5NVb8zlLqOgMFpehl15qJ9RuF0GvXXlgRM4RowkH7
         lGma3n+HGHJrdhOa7YDJnwvS+X7ZW+jYioimitLh+WF1caJbuYmeiR3rgw0R2dy2BWKr
         9Z3uWO0OBmiwcmFw/j0ZtFTlTJ+1z4kYxL2LR0lQFCWOGGyrTi4QBSIE4hWEOq05KONY
         GTMELfL+sm4x5OY9zr+iO0k4Gvq7yNnhePC6JPDKEgMLOe4Z9ykO1HMwI/afgaMZ1Jdp
         b2g99l/L70gJFEhZ+EL1RF6vrZBWNeDNhYs0tiWA6DsXplhEUIyK+Kvn/HfNWQEj0JMd
         VBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDRu5bKyV8khRjLftXf9vZbsjcdEi7ALfscd87ISlWc=;
        b=jexAV9ha6hjOhIMBAlBQoRq7HFH3tdorgkz7fYN7NozhYfQ0Qyfmyd0Zl34gbbgmnY
         Juq8FfkaEiC3Ee4CugK5a2Lt7ok3qVbjWVZNsW0qiIBDM0vcYIp2kEPvRfiiY9kNaGSm
         WgDuDxvwA7obEmuuCF4MUW5PMmDixfWYM0VKrwNmvf2VRVuV7+OLO5IEdd4DoTpTp8Gz
         2i2L5HN9eKANFC+vGILLE1f3TjlDvodrJD+qtp41EabvJMBXxL9hMz7AbRORQDFIa9z0
         oHCT5ot44vb3h+I7Vlp932Fi5CyStHGuKTtVW/TahZ2JRIS3blJJitJ2bJZBEdVUsEqN
         3gOQ==
X-Gm-Message-State: AOAM531RodxLrATpGiP9L1A0GbnoN0E3C3p2M5KVLw0y7/4v+wuUkAeD
        FFU0m1nR4VNte7jGFyE00lxZs/v2uxPGqXNG1J5IWS5eujG9OQ==
X-Google-Smtp-Source: ABdhPJzv3/Hjo3iJNPSsixYaIWjXZXXpll3nqSGuGXkJlxKXgN76Ock/101Oq+MPQj8BwtL10nYSkutRxfX8nwSThDo=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr24527057qva.18.1615273117334;
 Mon, 08 Mar 2021 22:58:37 -0800 (PST)
MIME-Version: 1.0
References: <00000000000064c71f05bcd94585@google.com>
In-Reply-To: <00000000000064c71f05bcd94585@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 07:58:26 +0100
Message-ID: <CACT4Y+bqHSGEMxD+gnmN=SbNOGzfzSZjjkibKjve-3ekaeVA=A@mail.gmail.com>
Subject: Re: [syzbot] net boot error: WARNING in kvm_wait
To:     syzbot <syzbot+9e58a3a510889fa4af50@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 8:37 AM syzbot
<syzbot+9e58a3a510889fa4af50@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ad5d07f4 cipso,calipso: resolve a number of problems with ..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=12aca7cad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=402784bff477e1ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e58a3a510889fa4af50
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9e58a3a510889fa4af50@syzkaller.appspotmail.com

#syz dup: upstream boot error: WARNING in kvm_wait


> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 0 PID: 4788 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 0 PID: 4788 Comm: systemd-cryptse Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 1e 61 b0 04 00 74 01 c3 48 c7 c7 a0 8e 6b 89 c6 05 0d 61 b0 04 01 e8 57 da be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0018:ffffc90000edfc40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffff8be28b80 RCX: 0000000000000000
> RDX: ffff888023441bc0 RSI: ffffffff815bea35 RDI: fffff520001dbf7a
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815b77be R11: 0000000000000000 R12: 0000000000000003
> R13: fffffbfff17c5170 R14: 0000000000000001 R15: ffff8880b9c35f40
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95c090fab4 CR3: 000000000bc8e000 CR4: 00000000001506f0
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
> RIP: 0033:0x7f95c1fe8618
> Code: Unable to access opcode bytes at RIP 0x7f95c1fe85ee.
> RSP: 002b:00007fff576bc048 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f95c1fe8618
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00007f95c22c58e0 R08: 00000000000000e7 R09: fffffffffffffee8
> R10: 00007f95c04a3158 R11: 0000000000000246 R12: 00007f95c22c58e0
> R13: 00007f95c22cac20 R14: 0000000000000000 R15: 0000000000000000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000064c71f05bcd94585%40google.com.
