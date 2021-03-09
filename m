Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E9331F91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhCIG6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCIG6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:58:09 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D24C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 22:58:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t4so12092818qkp.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74v4ZwFIa2+YsjHhYEmz5yIQgt7Lpwh13pAilG5dCcY=;
        b=BVWcPOfvNQcxDNnom8fNNgFvFKbxYcczh1MMdnCO8aD2IGMrI68pIlRG/7WALA2rYX
         L8WNVpbP8eZcmKF0YqaQEVrRaUEAI03sC3JsZ2j0E/wFZG6TtZ8tmhqdGB47tpSX/nyr
         1BQDXnMyu+FxKMQ+4+WR5RCCnwHfQGuuajGPDXUJRFW639Jtp6utXnX5p57eGrucGl9P
         k4hcjVO/JX0MiwhaG1HT6Nf1f+g/p5HOuqj8Jd/zW/2F00QRyS7seoevzAVfSMAbl1JX
         mq95AzA/eqZ6bNpmd4adMfQlk2Nbg4BOsJgZiFYoCP7ljwHXeQ+gpTntXhOQCjDp1qAv
         Ep6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74v4ZwFIa2+YsjHhYEmz5yIQgt7Lpwh13pAilG5dCcY=;
        b=O7TfLyO1ecxBV3nA+UfwCITqtar7ylmlbvr1hh6O3QWBpKeQ3LdJbAO0hrxk81UExq
         VlkASnGb/Veve7oBE3Ug8n/1/sedYVQL8muEHNI9ippGAvYakiL9QPEN9kS2p4nQ7d93
         7TtD+5adX5I8Fq8E0wWlr+GcMRPExI0yb6+qfcq2RWI3cUddHup/u49hBk6FNhu2J551
         WPynrDvrJF+BYfRrPtnUq/7Ub9H6xVzAM58jPMUx+L1FQLuUUvzgQa6Ev3rgJhfvuJui
         l0kZsiPLXC70wbItmi9xLRDbj3JTRX0coo2VjiMbtDmUqg6zURGBfEphyf/EWBcwaBX9
         ZF/Q==
X-Gm-Message-State: AOAM530POuLSvXTOEdS9UFiTTc8UU7OdH8hiPI/bYXD00RjpcKo/d9fS
        AUnf/fyDq4OQ1EAbk1NgjqDH/2u4jSPamYIdj8rSjw==
X-Google-Smtp-Source: ABdhPJxJxuKkjJ/RxuniJdi7jxwTf1TyAl3iTriUMfEXmSNvcOX1igxOOFewlMtPCMuZa3uVLDfODHsMJo5b+f4KBnY=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr23615844qkx.501.1615273088584;
 Mon, 08 Mar 2021 22:58:08 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004094ff05bcdc7ffb@google.com>
In-Reply-To: <0000000000004094ff05bcdc7ffb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 07:57:57 +0100
Message-ID: <CACT4Y+ZiXu_M6z0pfK7=KmBgGe3pJtqvn3sGyMNAVujV823yyg@mail.gmail.com>
Subject: Re: [syzbot] bpf boot error: WARNING in kvm_wait
To:     syzbot <syzbot+46fc491326a456ff8127@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 12:28 PM syzbot
<syzbot+46fc491326a456ff8127@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    edbea922 veth: Store queue_mapping independently of XDP pr..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=113ae02ad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=402784bff477e1ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=46fc491326a456ff8127
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+46fc491326a456ff8127@syzkaller.appspotmail.com

#syz dup: upstream boot error: WARNING in kvm_wait

> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 0 PID: 4787 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 0 PID: 4787 Comm: systemd-getty-g Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 1e 62 b0 04 00 74 01 c3 48 c7 c7 a0 8e 6b 89 c6 05 0d 62 b0 04 01 e8 57 da be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> RSP: 0018:ffffc900012efc40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffff8be28b80 RCX: 0000000000000000
> RDX: ffff888023de5340 RSI: ffffffff815bea35 RDI: fffff5200025df7a
> RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff815b77be R11: 0000000000000000 R12: 0000000000000003
> R13: fffffbfff17c5170 R14: 0000000000000001 R15: ffff8880b9c35f40
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa257bcaab4 CR3: 000000000bc8e000 CR4: 00000000001506f0
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
> RIP: 0033:0x7fa2592a3618
> Code: Unable to access opcode bytes at RIP 0x7fa2592a35ee.
> RSP: 002b:00007ffc579980b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa2592a3618
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00007fa2595808e0 R08: 00000000000000e7 R09: fffffffffffffee8
> R10: 00007fa25775e158 R11: 0000000000000246 R12: 00007fa2595808e0
> R13: 00007fa259585c20 R14: 0000000000000000 R15: 0000000000000000
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004094ff05bcdc7ffb%40google.com.
