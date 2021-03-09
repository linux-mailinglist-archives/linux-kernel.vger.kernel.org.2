Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A173A331F95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCIG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCIG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:58:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:58:57 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j3so9505662qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWP0mTwKLxYQupBKOOdDqpvxmjpPeZcH7T0wzCqcyos=;
        b=OXj11V1rTjcz3xZmQxaWo7ql1LlH26PAEGsKzhT4B9BqW+uq4AqykpyUUmsYOUC4Ob
         UCQmiyBo3WYo9DRIcGi5ep72l14+xfsjki/hGeDJRcoMzOjT/a/HLt9fRHbzuNeIxGAn
         42C+wQ7X9eX8j0RLa9g+9Ia5ym2tzhe5EsX4IHsqRyztUm42oaH6zPoDf7/ISCOOFylU
         WLsYrwd90tKqviBCqxWjFnvyyBIRZtmh4GYTKu/a22leVCVIBusII2cqymOYkJWniGRC
         WY0SaIYnCskVb3lY4C3Sn1+kkAHGvHVSls2mo46bw1rBHUos4Nyqx3c22MvUov2ybWjb
         72NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWP0mTwKLxYQupBKOOdDqpvxmjpPeZcH7T0wzCqcyos=;
        b=I+pOOXoFR04XiEgANLnHiOgmFQsuaEqbHl+NqHHt2dCdJLSCC97EAP0uttbS5x7n2K
         qQAQ3F1y4ySHsnbdC/yYdyKyBpWZiRoYUngdeOZKGLAcG56AOFdJoQR/tCt88DOvpQ26
         SUPPU8gcUvWR6g5+D24aewHCpBGTYldO2qbCfMs3As7fhkGypoU049Pa/aXKSxiDoXx3
         seNDRWISWNk6gcbIrXzvzw1ngfwxCm/E/iMjlYBIhd6MGrkTsteVX/hqcAkxTCi/pd3i
         4aAwngJ6WNJDbGzngP0l9ihv0w2qCwgkAJ0jWQWeRWhNfNh7BUq2lfQE10yWDilG7tcu
         Zg1A==
X-Gm-Message-State: AOAM533hwquePphUWnq3FbbOaL5MjCiikwZRXeLdu4GJF4deiIUy5Na/
        d/v4ojuTg/W1UQ2XLNsobYGzm1TYr0sH6aFjiHfPt1EE65Dbqw==
X-Google-Smtp-Source: ABdhPJzNmjDGT5HnCxXw9GB9SlT6PVsLaDUe81XNqIMqu1MvRRekIbfBWGTmzoy6eFqFDXx8a+Lpdl8izpSNnOvR7MY=
X-Received: by 2002:a05:622a:c9:: with SMTP id p9mr23596061qtw.337.1615273136348;
 Mon, 08 Mar 2021 22:58:56 -0800 (PST)
MIME-Version: 1.0
References: <00000000000067a89205bcd94527@google.com>
In-Reply-To: <00000000000067a89205bcd94527@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 07:58:45 +0100
Message-ID: <CACT4Y+Zi0P2wgz_zvSyPHrjSf2moCdOkxO8fVC+iumxvJ-WD8w@mail.gmail.com>
Subject: Re: [syzbot] bpf-next boot error: WARNING in kvm_wait
To:     syzbot <syzbot+72d60f48cda58f46375a@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 8:37 AM syzbot
<syzbot+72d60f48cda58f46375a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d01b59c9 bpf: Add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1592bd66d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66df2ca4f2dd3022
> dashboard link: https://syzkaller.appspot.com/bug?extid=72d60f48cda58f46375a
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+72d60f48cda58f46375a@syzkaller.appspotmail.com

#syz dup: upstream boot error: WARNING in kvm_wait

> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 0 PID: 4813 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 0 PID: 4813 Comm: systemd-cryptse Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: bf ff cc cc cc cc cc cc cc cc cc cc cc 80 3d ca 72 b1 04 00 74 01 c3 48 c7 c7 40 a2 6b 89 c6 05 b9 72 b1 04 01 e8 b8 37 bf ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0018:ffffc900012dfc40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffff8be287a0 RCX: 0000000000000000
> RDX: ffff888023830000 RSI: ffffffff815b6895 RDI: fffff5200025bf7a
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815af76e R11: 0000000000000000 R12: 0000000000000003
> R13: fffffbfff17c50f4 R14: 0000000000000001 R15: ffff8880b9c35f40
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1b759e04b0 CR3: 000000000bc8e000 CR4: 00000000001506f0
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
> RIP: 0033:0x7fed7b5d0618
> Code: Unable to access opcode bytes at RIP 0x7fed7b5d05ee.
> RSP: 002b:00007fff094428a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fed7b5d0618
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00007fed7b8ad8e0 R08: 00000000000000e7 R09: fffffffffffffee8
> R10: 00007fed79a8b158 R11: 0000000000000246 R12: 00007fed7b8ad8e0
> R13: 00007fed7b8b2c20 R14: 0000000000000000 R15: 0000000000000000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000067a89205bcd94527%40google.com.
