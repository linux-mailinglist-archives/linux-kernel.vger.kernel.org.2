Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF833A440
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhCNKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhCNKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:47:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFEBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:47:57 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g24so7219865qts.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APzrxQX+FzPfXXkGr8hxSnz1WxlxJpxhKBOC7gjL59s=;
        b=o4BZB17HMe9OwEw3R+O2FYyHfo21hw2ByOEvDboFlIl/bHGLCJBKNDDVqlRd2w4rp1
         AbfSjfrO3mqnHQcv+QTo6KCjJNVgm245cij5RDHzncvTkYhpLQ1SidEYXlggF1BP8+YL
         AV8uyiz+DUo9Wo0uy+Wa6LUt5l05SK/izc703gVy6MjhQ9RlBjIew+sckQrY9MwPspaP
         eGBYpwUmjt8Uz61Ok1Ps2hHLl1W0OlUuIfs4b9UtlWr7TDFaaSXLhTWQYkXA+gRyCv2O
         P5/Wp0d9G9RPOFIJRo4GZLFcg/Ts95O7BBvKEECCJIrAnWhMurikz6TkHp/rhRWD1ADV
         NDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APzrxQX+FzPfXXkGr8hxSnz1WxlxJpxhKBOC7gjL59s=;
        b=BhNtdqfVmkzx9tf3m8sybAyrTw9LCZIikuYxIEzE16jRK29CiZ1G3DxrEQJgDQLpzm
         B13xemahz2Jt1KVKC7GWtYjtrAPKrijjB/SQx0SMbdw7Ty3VvZylddALA8kK+sNlUF9z
         38r8VtOmrXYi5kUTTzkrssaF7+I8LzUDiPNLAyvmLRpLWLbwtmpBU70Wt2hIDdh3v1r5
         jdXT9xf3D7yhSwlPF7dAjOARgO523V2gFhsj5zp3lF5EOZANWssFPtA+00cXxCPHk1wZ
         cyVJ08H0jGQEnwm/nPqt+G5pTmX4TDUcXABH+DyPAQEhT7GzqVyV1kluiWyIa87hW+hp
         nUsw==
X-Gm-Message-State: AOAM530G3sHnd6cqsQyG+le6eihUaw1pIvdfjf77BE09PZVNfQIuEMeC
        +9teQEt1Pz/wW345fWxwn3j+6zu6PWXCHPh+20mcNw==
X-Google-Smtp-Source: ABdhPJyRX04yIsh90Cq8nnQ+xPWdMKERp7iAtizAgFy4UBnpsOWgsD0hvVNg2jtDnf7KLH0SCK0Z+tkAo5zMCoPBh6g=
X-Received: by 2002:ac8:5847:: with SMTP id h7mr18274879qth.43.1615718875783;
 Sun, 14 Mar 2021 03:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056b18b05bd7c6511@google.com>
In-Reply-To: <00000000000056b18b05bd7c6511@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 14 Mar 2021 11:47:44 +0100
Message-ID: <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in riscv_intc_irq
To:     syzbot <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
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

On Sun, Mar 14, 2021 at 11:14 AM syzbot
<syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a35756d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
> dashboard link: https://syzkaller.appspot.com/bug?extid=005654dd9b8f26bd4c07
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in riscv_intc_irq+0x24/0xcc drivers/irqchip/irq-riscv-intc.c:24
> Read of size 8 at addr ffffffe00c963bd0 by task kworker/1:1/4388
>
> CPU: 1 PID: 4388 Comm: kworker/1:1 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> Hardware name: riscv-virtio,qemu (DT)
> Workqueue: events nsim_dev_trap_report_work
> Call Trace:
> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
>
> Allocated by task 76347056:
> (stack is not available)
>
> Last potentially related work creation:

There seems to be some issue with riscv stack unwinder.
This does not have stacks.
"BUG: unable to handle kernel access to user memory in schedule_tail"
does not have proper stacks:
https://syzkaller.appspot.com/bug?id=9de8c24d24004fd5e482555f5ad8314da2fb1cee

I also found 2 riscv reports in "KASAN: use-after-free Read in
idr_for_each (2)":
https://syzkaller.appspot.com/bug?id=7f84dfc3902878befc22e52eb5c7298d0ad70cf3

both don't have any stacks:

==================================================================
BUG: KASAN: use-after-free in radix_tree_next_slot
include/linux/radix-tree.h:422 [inline]
BUG: KASAN: use-after-free in idr_for_each+0xf4/0x160 lib/idr.c:202
Read of size 8 at addr ffffffe010c00878 by task syz-executor.1/4828

CPU: 0 PID: 4828 Comm: syz-executor.1 Not tainted
5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201

Allocated by task 4828:
(stack is not available)

Freed by task 4473:
(stack is not available)


> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
