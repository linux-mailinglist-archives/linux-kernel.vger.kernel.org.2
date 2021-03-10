Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CCF3344EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhCJRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhCJRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:16:37 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34AC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:16:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id t16so1130078qvr.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PE9e5r7r4OZKtELp4lLPAYR8o+l784C8Hnnr7StF8Oo=;
        b=M9F/M9CtdFLG72yUgNoHBrgCVJXGyjjTTUlE1Jp0/XFBawk0NymRHXFt6kG3daxWgZ
         cQJyIYPNKZTpTnj263WHyHlyr+/Mg9c1O8bOsn0+KKNuC5QUNXc1GgWxIX20/rsSMU4+
         fClQQyEhdzs/pZgdI9SGLxmdhWLsb5NTD7w3rkyaaBVtLf84vK5bgfa0Kc0RSyW9Z/tn
         /aoBs+OTKQ9JcmPDf93lBjY5Iw/8CYFfDDT3UT4n6kVbjJxQzx+ytsPQ8GoekO+GE9k3
         fWvF1J8AtInA4J7aUqxyneRgBFnIkSz/WAOALfF+wHYuofkNtc7Fdrh73lT5dK6YmPgh
         bYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PE9e5r7r4OZKtELp4lLPAYR8o+l784C8Hnnr7StF8Oo=;
        b=cP4qXZbIjn5wFRajwdiBfg4loJGZpOmlqx0IOkE2o+nHfm/UwrdE+UH5AgVFzSHFUz
         SR2imushw69T9SHqBe05F79AEETh2Bea2kgwIoex0O2CflTvoezsoG7aGiGRwBFSSi4w
         MQ9M+Mfhjl5sBy2e3pYxaR6cvCj2BnyV/TL0WZkdER/OlzElcYKID71dhRvv5nTKcb59
         8AFkA0KGa1NP9doIVDGEGkFdI9Mvg+qFeAWCMd5wLeBxw2pPJDPYraRdHe2qq05DzcPn
         lfUrZeJib5BWprkx8lWNmcXwWee4aGY21pio0WTxf0RgbOM3wPBRIWQUXVUsWI4vUtJk
         zjOQ==
X-Gm-Message-State: AOAM533kT5EAkZQiXlTb6rkx2qRf4skUX9hqo2lA94QBeOWJ+C6leN1l
        nV+9FJtpySYXn4bC/wmLIZckW3YRw921e10gMUw/6w==
X-Google-Smtp-Source: ABdhPJxcs/PTbq2AZ5JVJpnHnDCbM6bcHSMhk1OFQl5dNkKfLQen3aBGZz5TWxWUxs+gml9o62NFyJpfXB+qyvjZYM0=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr3880623qvb.23.1615396584965;
 Wed, 10 Mar 2021 09:16:24 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com>
In-Reply-To: <000000000000b74f1b05bd316729@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Mar 2021 18:16:11 +0100
Message-ID: <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 5:46 PM syzbot
<syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> dashboard link: https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com

+riscv maintainers

This is riscv64-specific.
I've seen similar crashes in put_user in other places. It looks like
put_user crashes in the user address is not mapped/protected (?).


> Unable to handle kernel access to user memory without uaccess routines at virtual address 000000002749f0d0
> Oops [#1]
> Modules linked in:
> CPU: 1 PID: 4875 Comm: syz-executor.0 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
>  ra : task_pid_vnr include/linux/sched.h:1421 [inline]
>  ra : schedule_tail+0x70/0xb2 kernel/sched/core.c:4264
> epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp : ffffffe025d17ec0
>  gp : ffffffe005d25378 tp : ffffffe00f0d0000 t0 : 0000000000000000
>  t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe025d17ee0
>  s1 : 000000002749f0d0 a0 : 000000000000002a a1 : 0000000000000003
>  a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4 : 5ae9db91c19bbe00
>  a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
>  s2 : 0000000000040000 s3 : ffffffe00eef96c0 s4 : ffffffe022c77fe0
>  s5 : 0000000000004000 s6 : ffffffe067d74e00 s7 : ffffffe067d74850
>  s8 : ffffffe067d73e18 s9 : ffffffe067d74e00 s10: ffffffe00eef96e8
>  s11: 000000ae6cdf8368 t3 : 5ae9db91c19bbe00 t4 : ffffffc4043cafb2
>  t5 : ffffffc4043cafba t6 : 0000000000040000
> status: 0000000000000120 badaddr: 000000002749f0d0 cause: 000000000000000f
> Call Trace:
> [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
> [<ffffffe000005570>] ret_from_exception+0x0/0x14
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace b5f8f9231dc87dda ]---
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b74f1b05bd316729%40google.com.
