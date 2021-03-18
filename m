Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361F34076B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCROLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCROLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:11:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28626C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:11:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id dc12so2316854qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEx9o4c2jWWVchbL2AkKVWv1VcFgkP2+bgAk/sGCWD4=;
        b=JQ162sdoGuFTE+QF9UcdIDnpdC7nkNI1UetAhcbrkPL1a+Jhn5bEV8JcjV0AUxa5ux
         gU+ZAtXOUI6pIxClTVNK7tXsr1uGVzfWGm646EUUIqDz2S9zmIyXCI5U8rK1Ak9Pl687
         TiZ7R6m5oO93WPTa91FTv0qZVEjFHf1ZVPRPRWIfrDwCDbn+mHUQLl0d3l4IHCeJ9iaJ
         loIEwx0/TDNuQIk3RDjP7UXFAFCjGJ3WuX411nxaFUWikDJNf2YScDR/C8uwu4W3HswT
         Y7R6aQ0ZmKGRrKEXOWMbAvOaEjxwgtD+GXaFFjSAq0VY8F6Q1ppCCbmzNb34C5V/gvwR
         CMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEx9o4c2jWWVchbL2AkKVWv1VcFgkP2+bgAk/sGCWD4=;
        b=cArTA4yOl7bEdxg1j0Q6pPbCoCmJ3Tc7spI6OLc7Yf2/lqOP18KOZDyacCPjuJ5hPT
         pxc0+k44lJLzdUaQVSqeigWdZ0//K4l2zn867l1YvwPCmip3q7c9L3wjaVqXMakhOaSw
         pVQSCsReuR6iKdaH277NMG/unEVaxhRy9tzXNqPTEM0OxI64U0mdNFfKAa6p6BSD9ZHT
         wEesMnCFzshxTYG7kpeKokyWcbRnohDNpj6RgSDCuXB+W8KRFna19sX8e+8+IMuX9y5Q
         Vg0+orP7DWXyY9CKPVFeL4M5eMaPYYTmBMYiOg5JHUjBFStf2P8LN2GD2keLw4RqnAPX
         nVCQ==
X-Gm-Message-State: AOAM5326H4pDpC5fyo+S3oiCC+5MxjSU7odaFZ/+sH07dUqmYJCHOA12
        PFYGfCZnWgAgo5zPrrnCVa2HFfhW7HYTUZYxNKeo2g==
X-Google-Smtp-Source: ABdhPJxj14kq/t5j4tmmrlTeySSXI1kh5zll/tbCuXiwWUDWY4WHq08TGj8USqzoT2acp4GD5/yCXcHErUVNKtQzYjU=
X-Received: by 2002:a05:6214:326:: with SMTP id j6mr4498301qvu.13.1616076674645;
 Thu, 18 Mar 2021 07:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056b18b05bd7c6511@google.com> <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
 <c82390e5-33f6-75f6-6b93-c618537413e5@huawei.com>
In-Reply-To: <c82390e5-33f6-75f6-6b93-c618537413e5@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 15:11:03 +0100
Message-ID: <CACT4Y+ZpfAiQKagp5xr0HY85SRr2h6pe10emm4_B5RLfVraN9A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in riscv_intc_irq
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     syzbot <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 1:21 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> On 2021/3/14 18:47, Dmitry Vyukov wrote:
> > On Sun, Mar 14, 2021 at 11:14 AM syzbot
> > <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=15a35756d00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=005654dd9b8f26bd4c07
> >> userspace arch: riscv64
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com
> >>
> >> ==================================================================
> >> BUG: KASAN: slab-out-of-bounds in riscv_intc_irq+0x24/0xcc drivers/irqchip/irq-riscv-intc.c:24
> >> Read of size 8 at addr ffffffe00c963bd0 by task kworker/1:1/4388
> >>
> >> CPU: 1 PID: 4388 Comm: kworker/1:1 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> >> Hardware name: riscv-virtio,qemu (DT)
> >> Workqueue: events nsim_dev_trap_report_work
> >> Call Trace:
> >> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
> >>
> >> Allocated by task 76347056:
> >> (stack is not available)
> >>
> >> Last potentially related work creation:
> > There seems to be some issue with riscv stack unwinder.
> > This does not have stacks.
>
> Hi, could you test with the following  patch about the no stack
> issue(from v5.11-rc4), I made a mistake when do some cleanup...
>
> https://lore.kernel.org/linux-riscv/ce5b3533-b75d-c31c-4319-9d29769bbbd5@huawei.com/T/#t

Hi Kefeng,

Please see:
http://bit.do/syzbot#no-custom-patches

Is a unit-test for this possible? Fuzzing is not a replacement for unit testing.

> > "BUG: unable to handle kernel access to user memory in schedule_tail"
> > does not have proper stacks:
> > https://syzkaller.appspot.com/bug?id=9de8c24d24004fd5e482555f5ad8314da2fb1cee
> >
> > I also found 2 riscv reports in "KASAN: use-after-free Read in
> > idr_for_each (2)":
> > https://syzkaller.appspot.com/bug?id=7f84dfc3902878befc22e52eb5c7298d0ad70cf3
> >
> > both don't have any stacks:
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in radix_tree_next_slot
> > include/linux/radix-tree.h:422 [inline]
> > BUG: KASAN: use-after-free in idr_for_each+0xf4/0x160 lib/idr.c:202
> > Read of size 8 at addr ffffffe010c00878 by task syz-executor.1/4828
> >
> > CPU: 0 PID: 4828 Comm: syz-executor.1 Not tainted
> > 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> > Hardware name: riscv-virtio,qemu (DT)
> > Call Trace:
> > [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
> >
> > Allocated by task 4828:
> > (stack is not available)
> >
> > Freed by task 4473:
> > (stack is not available)
> >
> >
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
